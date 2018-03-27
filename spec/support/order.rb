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
