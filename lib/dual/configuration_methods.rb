module Dual
  module ConfigurationMethods

    def excludes(*properties)
      properties.each { |prop| excludes << prop }
    end

    def includes(*properties)
      properties.each { |prop| includes << prop}
    end
  end
end
