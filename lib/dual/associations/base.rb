module Dual
  module Associations
    class Base

      ALLOWED = %w[
        one_to_one
        one_to_many
        many_to_one
      ].freeze

      attr_reader :dual_object, :original_object, :association_reflection

      def initialize(original_object, dual_object, association_reflection)
        @original_object = original_object
        @dual_object = dual_object
        @association_reflection = association_reflection
      end

      def copy
        raise NotImplementedError
      end

      def remove
        raise NotImplementedError
      end

      protected

      def association_name
        association_reflection[:name]
      end
    end
  end
end
