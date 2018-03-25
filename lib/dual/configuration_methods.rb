module Dual
  module ConfigurationMethods

    def excludes(*properties)
      properties.each { |prop| excluded << prop }
    end

    def includes(*properties)
      properties.each { |prop| included << prop}
    end

    def add_association(*properties)
      properties.each { |prop| associations << prop }
    end

    # Think about whether we need this
    #%w[excludes includes add_association].each do |method|
    #  define_method(method.to_sym) do |*properties|
    #
    #  end
    #end
  end
end
