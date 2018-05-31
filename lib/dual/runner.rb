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
      return unless dual_config.finalization

      dual_config.finalization.call(dual_object)
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

        reflection = dual_object.class.association_reflection(association)
        association_type = extract_association(reflection[:type])

        copy_association(association_type, reflection)
      end
    end

    def copy_association(association_type, reflection)
      Object
        .const_get("Dual::Associations::#{association_type}")
        .new(original_object, dual_object, reflection)
        .run
    end

    def add_excluded_associations; end

    def extract_association(type)
      type
        .to_s
        .gsub(/one/, 'One')
        .gsub(/to/, 'To')
        .gsub(/many/, 'Many')
        .gsub(/_/, '')
    end
  end
end
