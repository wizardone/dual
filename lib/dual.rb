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

      @dual_config = Configuration.new(self)
      @dual_config.instance_eval(&block)
    end

    def dual_config
      @dual_config
    end
  end

  def dual_copy
    # dup or clone, strategy maybe?
    dual_object = dup
    Dual::Runner.(dual_object, self.class.dual_config)
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
