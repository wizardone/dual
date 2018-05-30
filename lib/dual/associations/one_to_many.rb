module Dual
  module Associations
    class OneToMany < Base

      def run
        # TODO: We probably need to duplicate each of the elements in the 
        # collection, not the collection(array) itself
        #dupped_assoc = original_object.public_send(association_name).dup
        dual_object.public_send("remove_all_#{association_name}")
        original_object.public_send(association_name).each do |association|
          dup_association = association.dup
          dual_object.public_send("add_#{singularize(association_name)}", dup_association)
        end
      end

      private

      # TODO: What do we do?
      def singularize(name)
        name[0, name.length - 1]
      end
    end
  end
end
