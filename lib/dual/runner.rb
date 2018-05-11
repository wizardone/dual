module Dual
  class Runner

    attr_reader :original_object,
                :dual_object,
                :dual_config

    class << self
      def call(dual_config)
        new(dual_config).perform
      end
    end

    def initialize(dual_config)
      @dual_config = dual_config
      @dual_object = dual_config.dual_object
      @original_object = dual_config.original_object
    end

    def perform
      # Consider doing something like:
      # [Dual::Excluded, Dual::Included, Dual::Associations, Dual::Finalization].each { |klass| klass.run }
      # rescue Dual::RunnerException
      # puts "Duplicating process halted at: ....#{e.error}"
      add_excluded_methods
      add_included_methods
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

    def add_excluded_methods
      dual_config.excluded.each do |attribute|
        dual_object.public_send("#{attribute}=", nil)
      end
    end

    def add_included_methods
      dual_config.included.each do |attribute|
        dual_object.class.attr_accessor attribute[:property]
        dual_object.public_send("#{attribute[:property]}=", attribute[:value])
      end
    end

    def add_associations
      add_included_associations
      add_excluded_associations
    end

    def add_included_associations
      dual_config.included_associations.each do |association|
        next unless dual_object.class.associations.include?(association.to_sym)
        #dupped_assoc = original_object.public_send(association).dup
        #dual_object.public_send("#{association}=", dupped_assoc)
        dupped_assoc = original_object.contact.dup
        dual_object.contact = dupped_assoc
      end
    end

    def add_excluded_associations

    end
  end
end
