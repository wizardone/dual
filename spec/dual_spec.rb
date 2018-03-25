RSpec.describe Dual do
  it "has a version number" do
    expect(Dual::VERSION).not_to be nil
  end

  it 'includes dual configuration' do
    #order = Order.new
  end

  describe '#dual_copy' do
    it 'dual copies an object without options' do
      order = Order.new(name: 'Test', type: 'Clone', address: '13 March')
      order_dup = order.dual_copy

      expect(order_dup.name).to eq order.name
      expect(order_dup.type).to eq order.type
      expect(order_dup.address).to eq order.address
    end

    it 'dial copies an object excluding some properties' do
      order = ExcludedOrder.new(name: 'Test', type: 'Clone', address: '13 March')
      order_dup = order.dual_copy

      expect(order_dup.name).to eq order.name
      expect(order_dup.type).to eq order.type
      expect(order_dup.address).to eq nil
    end
  end
end
