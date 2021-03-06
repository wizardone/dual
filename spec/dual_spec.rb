RSpec.describe Dual do
  it "has a version number" do
    expect(Dual::VERSION).not_to be nil
  end

  it 'includes dual configuration' do
    #order = Order.new
  end

  describe '#dual_copy' do
    context 'regular objects' do
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

      it 'dual copies an object and finalizes the process' do
        order = OrderFinalization.new(name: 'Test', type: 'Clone', address: '13 March')
        order_dup = order.dual_copy

        expect(order_dup.name).to eq 'Been finalized'
        expect(order_dup.type).to eq order.type
        expect(order_dup.address).to eq order.address
      end

      it 'accepts only callable objects for finalization' do
        skip
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

      it 'performs an ordinary dup if there is no configuration' do
        klass = Class.new do
          include Dual
          dual {}
        end.new
        expect(klass).to receive(:dup)

        klass.dual_copy
      end
    end

    context 'sequel' do

      it 'dual copies a sequel model with one to one relation' do
        user = User.create(email: 'test@test.com')
        user.contact = Contact.create(address: 'Test 24')

        dupped = user.dual_copy

        expect(dupped.contact).to eq user.contact
        
        dupped.contact.address = 'WAT'
        dupped.contact.save

        expect(user.contact.address).not_to eq(dupped.contact.address)
      end

      it 'dual copies a sequel model with one to many relation' do
        item = ShoppingItem.create(name: 'Test', price: 10)
        cart = ShoppingCart.create(client: 'Stefan')

        cart.shopping_items << item
        cart_dup = cart.dual_copy

        expect(cart.shopping_items.count).to eq(cart_dup.shopping_items.count)
        item = cart.shopping_items.first
        item.name = 'New Test'
        item.save

        expect(cart.shopping_items.first.name).not_to eq(cart_dup.shopping_items.first.name)
      end

      it 'dual copies a sequel model with many to one relation' do
        user = User.create(email: 'test@test.com')
        cart = ShoppingCart.create(client: 'Stefan')
        cart.user = user

        dupped = cart.dual_copy

        expect(cart.user).to eq(dupped.user)
        dupped.user.email = "foo@bar.com"
        dupped.user.save

        expect(cart.user.email).not_to eq(dupped.user.email)
      end

      it 'dual copies a sequel model with an ungessable association name' do
        person = Person.create(name: 'Test')
        contact = Contact.create(address: 'foobar')
        contact.people << person

        dupped = contact.dual_copy

        expect(contact.people.first).not_to eq(dupped.people.first)
      end
    end
  end
end
