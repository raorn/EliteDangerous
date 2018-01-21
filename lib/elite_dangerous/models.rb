require 'sequel'

module EliteDangerous
  module Db
    module Models
      Sequel::Model.instance_variable_set(:@restrict_primary_key, false)

      class Government < Sequel::Model
        one_to_many :systems
        one_to_many :stations
      end

      class Allegiance < Sequel::Model
        one_to_many :systems
        one_to_many :stations
      end

      class PowerState < Sequel::Model
        one_to_many :systems
      end

      class State < Sequel::Model
        one_to_many :systems
        one_to_many :stations
      end

      class Security < Sequel::Model
        one_to_many :systems
      end

      class PrimaryEconomy < Sequel::Model
        one_to_many :systems
      end

      class StationType < Sequel::Model
        one_to_many :stations
      end

      class System < Sequel::Model
        many_to_one :government
        many_to_one :allegiance
        many_to_one :power_state
        many_to_one :state
        many_to_one :security
        many_to_one :primary_economy
        one_to_many :stations

        def format(ident: 0, ref: nil, header: nil)
          pfx = '  ' * ident
          str = ''
          str << pfx << "[ " << header << " ]\n" unless header.nil?
          str << pfx << "System: #{name} (#{id})#{", #{dist(self, ref)} Ly" unless ref.nil?}#{" [PERMIT REQUIRED]" if needs_permit}\n"
          str << pfx << "  Minor Factions: #{minor_faction_count}\n"
          str << pfx << "  Allegiance: #{allegiance.name} (#{government.name})\n" unless allegiance.nil? or government.nil?
          str << pfx << "  Power: #{power} (#{power_state.name})\n" unless power.nil?
          str << pfx << "  Primary Economy: #{primary_economy.name}\n" unless primary_economy.nil?
          stations.sort{|a,b| (a.distance_to_star || 1_000_000_000) <=> (b.distance_to_star || 1_000_000_000)}.each do |s|
            str << s.format(ident: ident+1, include_system: false) if ['L', 'M'].include?(s.max_landing_pad_size)
          end
          str
        end

        dataset_module do
          def around_system(tgt, max_dist)
            where(Sequel.lit('|/((x-(?))^2+(y-(?))^2+(z-(?))^2) < ?', tgt.x, tgt.y, tgt.z, max_dist))
          end
        end
      end

      class Station < Sequel::Model
        many_to_one :government
        many_to_one :allegiance
        many_to_one :state
        many_to_one :station_type
        many_to_one :system

        def format(ident: 0, include_system: true, header: nil)
          pfx = '  ' * ident
          str = ''
          str << pfx << "[ " << header << " ]\n" unless header.nil?
          str << pfx << "Station: #{name} (#{id}), #{distance_to_star || "???"} Ls\n"
          str << pfx << "  Type: #{station_type&.name || "???"}\n"
          str << pfx << "  Landing Pad: #{max_landing_pad_size || "???"}\n"
          str << pfx << "  System: #{system.name} (#{system_id})#{" [PERMIT REQUIRED]" if system.needs_permit}\n" if include_system
          str
        end

        dataset_module do
          def with_landing_pad(allow_medium: false)
            where(max_landing_pad_size: (allow_medium ? ['L', 'M'] : 'L'))
          end
        end
      end
    end
  end
end
