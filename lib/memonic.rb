require "memonic/version"

module Memonic
  def self.included(base)
    base.extend(ClassMethods)
  end

  private

  def memoize(variable, &block)
    instance_variable_get(variable) || begin
      if instance_variable_defined?(variable)
        instance_variable_get(variable)
      else
        instance_variable_set(variable, instance_exec(&block))
      end
    end
  end

  module ClassMethods
    def memoize(name, &block)
      define_method(name) do
        singleton_class.class_eval { attr_reader name }
        instance_variable_set("@#{name}", instance_exec(&block))
      end
    end
  end
end
