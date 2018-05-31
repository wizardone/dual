module Dual
  module Associations
    class OneToOne < Base

      def run
        association_name = association_reflection[:name]
        dupped_assoc = original_object.public_send(association_name).dup

        # sequal validation probably? The object is stored in the db
        # and it seems you cannot duplicate it and reassign it again?
        # It works if you do: Contact.create(address: 'KUR')
        dual_object.public_send("#{association_name}=", nil)
        dual_object.public_send("#{association_name}=", dupped_assoc)
      end
    end
  end
end
