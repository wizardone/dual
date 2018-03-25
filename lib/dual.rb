require 'dual/version'
require 'dual/configuration_methods'

module Dual

  def self.included(base)
    # Set an instance variable in the base class to hold the config?
    base.extend ClassMethods
  end

  module ClassMethods
    def dual(&block)
      raise 'Configuration block required' unless block_given?
      @config = Configuration.new(self)
      @config.instance_eval(&block)
    end
  end

  def dual_copy
    object = dup
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
