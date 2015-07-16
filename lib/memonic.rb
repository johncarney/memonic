require "memonic/version"

module Memonic
  if defined?(ActiveSupport::Concern)
    extend ActiveSupport::Concern
  else
    def self.included(base)
      base.extend(ClassMethods)
    end
  end

  private

  def memoize(variable)
    if instance_variable_defined?(variable)
      instance_variable_get(variable)
    else
      instance_variable_set(variable, yield)
    end
  end

  module ClassMethods
    def memoize(name, &block)
      variable = "@#{name}"
      define_method(name) { memoize(variable, &block) }
    end
  end
end
