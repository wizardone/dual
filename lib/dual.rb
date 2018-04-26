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

      @dual_config = Configuration.new
      @dual_config_block = block
    end

    def dual_config
      @dual_config
    end

    def dual_config_block
      @dual_config_block
    end
  end

  def dual_copy
    # dup or clone, strategy maybe?
    dual_config = self.class.dual_config
    # What to do in case of missing dual config? Raise error?
    return dup unless dual_config

    dual_config.dual_object = dup
    dual_config.instance_eval(&self.class.dual_config_block)

    Dual::Runner.(dual_config)
  end

  class Configuration
    include ConfigurationMethods

    attr_reader :excluded,
                :included,
                :associations
    attr_accessor :dual_object, :finalization

    def initialize
      @included = []
      @excluded = []
      @associations = []
    end
  end
end
