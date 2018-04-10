module Dual
  module ConfigurationMethods

    def excludes(*properties, **options)
      byebug
      return if (options[:if] && object.public_send(options[:if]) == false)
      properties.each { |prop| excluded << prop }
    end

    def includes(property, value:, **options)
      included << { property: property, value: value }
    end

    def add_association(*properties)
      properties.each { |prop| associations << prop }
    end
  end
end
