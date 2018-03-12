require 'dual/version'
require 'dual/configuration_methods'

module Dual

  include ConfigurationMethods

  def self.included(base)
    @config = Configuration.new
  end

  def dual(&block)
    @config.instance_eval(&block)
  end

  def dual_copy

  end

  class Configuration
    def initialize

    end
  end
end
