require 'sequel'
db_name = ENV['dual_db_name'] || 'dual'
DB = Sequel.sqlite

DB.create_table :items do
  primary_key :id
  String :name
  Float :price
end

class Item < Sequel::Model
end
