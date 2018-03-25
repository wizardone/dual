require 'dual/version'
require 'dual/configuration_methods'
require 'byebug'
module Dual

  def self.included(base)
    @config = Configuration.new(base)
  end

  def dual(&block)
    @config.instance_eval(&block)
  end

  def dual_copy
    dup
  end

  class Configuration
    include ConfigurationMethods

    attr_reader :object,
                :excluded,
                :included,
                :association

    def initialize(object)
      @object = object
      @included = []
      @excluded = []
    end
  end
end
