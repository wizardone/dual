RSpec.describe Dual do
  it "has a version number" do
    expect(Dual::VERSION).not_to be nil
  end

  it 'includes dual configuration' do
    #order = Order.new
  end

  describe '#dual_copy' do
    it 'raises an error if no block is provided to dual' do
      # Change to custom error
      expect {
        Order.new.instance_eval do
          dual
        end
      }.to raise_error(NameError)
    end

    it 'dual copies an object without options' do
      order = Order.new(name: 'Test', type: 'Clone', address: '13 March')
      order_dup = order.dual_copy

      expect(order_dup.name).to eq order.name
      expect(order_dup.type).to eq order.type
      expect(order_dup.address).to eq order.address
    end

    it 'dual copies an object excluding some properties' do
      order = ExcludedOrder.new(name: 'Test', type: 'Clone', address: '13 March')
      order_dup = order.dual_copy

      expect(order_dup.name).to eq order.name
      expect(order_dup.type).to eq order.type
      expect(order_dup.address).to eq nil
    end

    it 'dual copies an object including some new properties' do
      order = IncludedOrder.new(name: 'Test', type: 'Clone', address: '13 March')
      order_dup = order.dual_copy

      expect(order_dup.name).to eq order.name
      expect(order_dup.type).to eq order.type
      expect(order_dup.quantity).to eq 8
    end

    it 'dual copies an object excluding some properties if a condition is met' do
      order = ExcludedOrderIf.new(name: 'Test', type: 'Clone', address: '13 March')
      order_dup = order.dual_copy

      expect(order_dup.name).to eq order.name
      expect(order_dup.type).to eq order.type
      expect(order_dup.address).to eq order.address
    end

    it 'dual copies an object including some new properties if a condition is met' do
      order = IncludedOrderIf.new(name: 'Test', type: 'Clone', address: '13 March')
      order_dup = order.dual_copy

      expect(order_dup.name).to eq order.name
      expect(order_dup.type).to eq order.type
      expect {
        order_dup.quantity
      }.to raise_error(NoMethodError)
    end
  end
end
