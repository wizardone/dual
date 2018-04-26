require 'sequel'
db_name = ENV['dual_db_name'] || 'dual'
DB = Sequel.sqlite

DB.create_table :items do
  primary_key :id
  String :name
  Float :price
end

DB.create_table :shopping_carts do
  primary_key :id
  String :client
  Float :total_price
  Integer :item_id
end

class Item < Sequel::Model
  include Dual
  many_to_one :shopping_carts
end

class ShoppingCart < Sequel::Model
  include Dual
  one_to_many :items

  dual do
    
  end
end
