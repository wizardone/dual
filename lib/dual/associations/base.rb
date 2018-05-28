module Dual
  module Associations
    class Base

      ALLOWED = %w[
        one_to_one
        one_to_many
      ].freeze

      attr_reader :dual_object, :original_object, :association_name

      def initialize(original_object, dual_object, association_name)
        @original_object = original_object
        @dual_object = dual_object
        @association_name = association_name
      end
    end
  end
end
