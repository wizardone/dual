module Dual
  module Associations
    class OneToOne < Base

      def initialize(dual_object, name)
        puts "Working on one to one"
      end
    end
  end
end
