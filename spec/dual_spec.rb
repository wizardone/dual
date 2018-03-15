RSpec.describe Dual do
  it "has a version number" do
    expect(Dual::VERSION).not_to be nil
  end

  it 'includes dual configuration' do
    order = Order.new

  end

  describe '#dual_copy' do
    it 'dual copies an object' do
      order = Order.new(name: 'Test', type: 'Clone', address: '13 March')
      order_dup = order.dual_copy

      expect(order.name).to eq order_dup.name
      expect(order.type).to eq order_dup.type
      expect(order.address).to eq order_dup.address
    end
  end
end
