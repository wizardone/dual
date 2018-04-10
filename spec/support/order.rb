class Order
  include Dual
  attr_accessor :name, :type, :address

  def initialize(**params)
    @name = params[:name]
    @type = params[:type]
    @address = params[:address]
  end
  dual {}
end

class ExcludedOrder < Order
  dual do
    excludes :address
  end
end

class ExcludedOrderIf < Order
  dual do
    excludes :address, if: :address_available?
  end

  def address_available?
    false
  end
end

class IncludedOrder < Order
  dual do
    includes :quantity, value: 8
  end
end
