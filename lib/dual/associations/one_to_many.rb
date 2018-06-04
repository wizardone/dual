module Dual
  module Associations
    class OneToMany < Base

      def copy
        # TODO: Rework all the dynamic method invokations
        dual_object.public_send("remove_all_#{association_name}")
        original_object.public_send(association_name).each do |association|
          dup_association = association.dup
          if dual_object.respond_to?("add_#{singularize(association_name)}")
            dual_object.public_send("add_#{singularize(association_name)}", dup_association)
          else
            # ungessable association name, use the class name?
            association_name = association_reflection[:class_name].to_s.downcase
            dual_object.public_send("add_#{association_name}", dup_association)
          end
        end
      end

      def remove
        dual_object.public_send("remove_all_#{association_name}")
      end

      private

      # TODO: What do we do?
      def singularize(name)
        name[0, name.length - 1]
      end
    end
  end
end
