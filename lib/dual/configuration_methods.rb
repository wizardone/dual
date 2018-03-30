module Dual
  module ConfigurationMethods

    def excludes(*properties)
      properties.each { |prop| excluded << prop }
    end

    def includes(property, value:)
      included << { property: property, value: value }
    end

    def add_association(*properties)
      properties.each { |prop| associations << prop }
    end
  end
end
