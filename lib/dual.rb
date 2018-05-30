require 'dual/version'
require 'dual/configuration_methods'
require 'dual/configuration'
require 'dual/associations/base'
require 'dual/associations/one_to_one'
require 'dual/associations/one_to_many'
require 'dual/associations/many_to_one'
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
end
