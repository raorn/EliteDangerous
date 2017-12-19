require 'sequel'

module EliteDangerous
  module Db
    def self.init
      [:governments,
       :allegiances,
       :states,
       :securities,
       :primary_economies,
       :station_types,
      ].each do |t|
        DB.create_table t do
          primary_key :id
          String :name
        end
      end

      DB.create_table :systems do
        primary_key :id
        column :name, String
        column :x, Float
        column :y, Float
        column :z, Float
        column :population, :bigint
        column :is_populated, TrueClass
        column :power, String
        column :needs_permit, TrueClass
        foreign_key :government_id, :governments
        foreign_key :allegiance_id, :allegiances
        foreign_key :state_id, :states
        foreign_key :security_id, :securities
        foreign_key :primary_economy_id, :primary_economies
        index :name
        index :population
      end

      DB.create_table :stations do
        primary_key :id
        column :name, String
        column :max_landing_pad_size, String
        column :distance_to_star, :bigint
        [
          :has_blackmarket,
          :has_market,
          :has_refuel,
          :has_repair,
          :has_rearm,
          :has_outfitting,
          :has_shipyard,
          :has_docking,
          :has_commodities,
          :is_planetary,
        ].each do |p|
          column p, TrueClass
        end
        foreign_key :government_id, :governments
        foreign_key :allegiance_id, :allegiances
        foreign_key :state_id, :states
        foreign_key :station_type_id, :station_types
        foreign_key :system_id, :systems
        index :name
        index :distance_to_star
      end
    end
  end
end
