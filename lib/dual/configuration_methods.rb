module Dual
  module ConfigurationMethods

    def excludes(*properties)
      properties.each { |prop| excluded << prop }
    end

    def includes(*properties)
      properties.each { |prop| included << prop}
    end
  end
end
