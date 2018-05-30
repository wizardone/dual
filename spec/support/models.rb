require 'sequel'
db_name = ENV['dual_db_name'] || 'dual'
DB = Sequel.sqlite

DB.create_table :shopping_items do
  primary_key :id
  String :name
  Float :price
  Integer :shopping_cart_id
end

DB.create_table :shopping_carts do
  primary_key :id
  Integer :user_id
  String :client
  Float :total_price
end

DB.create_table :users do
  primary_key :id
  String :email
end

DB.create_table :contacts do
  primary_key :id
  Integer :user_id
  String :address
end


class ShoppingItem < Sequel::Model
  include Dual
  dual do
    add_association :shopping_carts
  end

  many_to_one :shopping_carts
end

class ShoppingCart < Sequel::Model
  include Dual
  dual do
    add_association :shopping_items, :user
  end

  one_to_many :shopping_items
  many_to_one :user

  def items_price
    shopping_items.sum(&:price)
  end
end

class User < Sequel::Model
  include Dual
  one_to_many :shopping_carts
  one_to_one :contact

  dual do
    add_association :contact
  end
end

class Contact < Sequel::Model
  include Dual
  one_to_one :user
end
