module Dual

  class Configuration
    include ConfigurationMethods

    attr_reader :excluded,
                :included,
                :included_associations,
                :excluded_associations
    attr_accessor :original_object,
                  :dual_object,
                  :finalization

    def initialize
      @included = []
      @excluded = []
      @included_associations = []
      @excluded_associations = []
    end

    def apply_objects(original)
      self.original_object = original
      self.dual_object = original.dup
    end

    def apply_config(&block)
      instance_eval(&block)
    end
  end
end
