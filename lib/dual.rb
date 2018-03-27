require 'dual/version'
require 'dual/configuration_methods'
require 'byebug'
module Dual

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def dual(&block)
      raise 'Configuration block required' unless block_given?

      @dual_config = Configuration.new(self)
      @dual_config.instance_eval(&block)
    end

    def dual_config
      @dual_config
    end
  end

  def dual_copy
    config = self.class.dual_config
    # dup or clone, strategy maybe?
    object = dup
    config.excluded.each do |attribute|
      object.public_send("#{attribute}=", nil)
    end

    config.included.each do |attribute|
      object.class.attr_accessor attribute[:property]
      object.public_send("#{attribute[:property]}=", attribute[:value])
    end
    object
  end

  class Configuration
    include ConfigurationMethods

    attr_reader :object,
                :excluded,
                :included,
                :associations

    def initialize(object)
      @object = object
      @included = []
      @excluded = []
      @associations = []
    end
  end
end
