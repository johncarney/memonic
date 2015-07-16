require "memonic/version"

module Memonic
  def self.included(base)
    base.extend(ClassMethods)
  end

  private

  def memoize(variable, &block)
    if instance_variable_defined?(variable)
      instance_variable_get(variable)
    else
      instance_variable_set(variable, instance_exec(&block))
    end
  end

  module ClassMethods
    def memoize(name, &block)
      variable = "@#{name}".to_sym
      define_method(name) { memoize(variable, &block) }
    end
  end
end
