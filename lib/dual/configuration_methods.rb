module Dual
  module ConfigurationMethods

    def excludes(*properties, **options)
      return if (options[:if] && dual_object.public_send(options[:if]) == false)
      properties.each { |prop| excluded << prop }
    end

    def includes(property, value:, **options)
      return if (options[:if] && dual_object.public_send(options[:if]) == false)
      included << { property: property, value: value }
    end

    def add_association(*properties)
      properties.each { |prop| included_associations << prop }
    end

    def remove_association(*properties)
      properties.each { |prop| excluded_associations << prop}
    end

    def finalize(lambda)
      return unless lambda.respond_to?(:call)

      @finalization = lambda
    end
  end
end
