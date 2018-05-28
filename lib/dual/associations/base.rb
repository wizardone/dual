module Dual
  module Associations
    class Base

      ALLOWED = %w[
        one_to_one
        one_to_many
      ].freeze

      attr_reader :dual_object, :original_object

      def initialize
        raise NotImplementedError
      end
    end
  end
end
