module Dual
  module Associations
    class OneToMany < Base

      def run
        dupped_assoc = original_object.public_send(association_name).dup
        #dual_object.public_send(association_name, dupped_assoc)
        dual_object.public_send("remove_all_#{association_name}")
        #dual_object.public_send("#{association_name}").push(dupped_assoc)
      end

      private

      # TODO: What do we do?
      def singularize(name)
        name[0, name.length - 1]
      end
    end
  end
end
