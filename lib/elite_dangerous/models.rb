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
        many_to_one :state
        many_to_one :security
        many_to_one :primary_economy
        one_to_many :stations

        def to_s
          "id: #{id}, name: #{name}, stations: #{stations.sort{|a,b| (a.distance_to_star || 0) <=> (b.distance_to_star || 0)}.map{|s| "#{s.name} (#{s.distance_to_star || "???"} Ls)"}.join(", ")}"
        end
      end

      class Station < Sequel::Model
        many_to_one :government
        many_to_one :allegiance
        many_to_one :state
        many_to_one :station_type
        many_to_one :system

        def to_s
          "id: #{id}, name: #{name} (#{distance_to_star || "???"} Ls), system: #{system.name} (#{system_id})"
        end
      end
    end
  end
end
