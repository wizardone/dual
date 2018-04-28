module Dual
  class Runner

    attr_reader :dual_object, :dual_config

    class << self
      def call(dual_config)
        new(dual_config).perform
      end
    end

    def initialize(dual_config)
      @dual_config = dual_config
      @dual_object = dual_config.dual_object
    end

    def perform
      add_excluded
      add_included
      add_associations
      add_finalization

      dual_object
    end

    private

    def add_finalization
      if dual_config.finalization
        dual_config.finalization.call(dual_object)
      end
    end

    def add_excluded
      dual_config.excluded.each do |attribute|
        dual_object.public_send("#{attribute}=", nil)
      end
    end

    def add_included
      dual_config.included.each do |attribute|
        dual_object.class.attr_accessor attribute[:property]
        dual_object.public_send("#{attribute[:property]}=", attribute[:value])
      end
    end

    def add_associations

    end
  end
end
