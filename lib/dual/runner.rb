module Dual
  class Runner

    attr_reader :dual_object, :dual_config

    class << self
      def call(dual_object, dual_config)
        new(dual_object, dual_config).perform
      end
    end

    def initialize(dual_object, dual_config)
      @dual_object = dual_object
      @dual_config = dual_config
    end

    def perform
      add_excluded
      add_included

      dual_object
    end

    private

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
  end
end
