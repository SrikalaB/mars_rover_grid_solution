require './validation_errors'

module Validate
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend(ClassMethods)
  end

  module InstanceMethods
    attr_reader :object, :errors

    def initialize(object)
      @object = object
      @errors = ValidationErrors.new
    end

    def valid?
      self.class.validators.each { |args| validate(args) }
      @errors.all.empty?
    end

    private

    def validate(args)
      with_validator(*args)
    end

    def with_validator(name, options)
      result = options[:with].call(@object) if options[:with].is_a? Proc
      result = @object.instance_variable_get(:@validator).method(options[:with]).call if options[:with].is_a?(Symbol)
      fail unless result == true
    rescue
      @errors.add(name, options[:msg])
    end
  end

  module ClassMethods
    def validates(*args)
      create_validation(args)
    end

    def validators
      @validators
    end

    private

    def create_validation(args)
      @validators = [] unless defined?(@validators)
      @validators << args
    end
  end
end
