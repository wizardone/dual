require 'dual/version'
require 'dual/configuration_methods'
require 'dual/runner'
require 'byebug'
module Dual

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def dual(&block)
      raise 'Configuration block required' unless block_given?

      @config = Configuration.new
      @config_block = block
    end

    def config
      @config
    end

    def config_block
      @config_block
    end
  end

  def dual_copy
    dual_config = self.class.config
    return dup unless dual_config

    dual_config.apply_objects(self)
    dual_config.apply_config(&self.class.config_block)

    Dual::Runner.(dual_config)
  end

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
