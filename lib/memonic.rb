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
      define_method("__#{name}__", &block)
      class_eval <<-RUBY
        def #{name}
          @#{name} || begin
            if defined?(@#{name})
              @#{name}
            else
              @#{name} = __#{name}__
            end
          end
        end
      RUBY
    end
  end
end
