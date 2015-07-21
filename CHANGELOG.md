## 1.0.3

- More performance improvements (details below).
- Calling `memoize(:value) { ... }` now defines a `__value___` method as well
  as a `value` method.

### Performance improvements

1. The instance version of `memoize` now only checks with the variable is
   defined if `instance_variable_get` returns a false value. This yields a
   modest improvement in performance.
2. The class version of `memoize` no longer piggy-backs on the instance
   version. Instead it defines a `__value__` method using the provided block,
   then defines a `value` method using `class_eval`. This yields a dramatic
   improvement in performance, making the class version almost as fast as
   doing it yourself.

## 1.0.2

Performance improvement.

## 1.0.1

Stopped using `ActiveSupport::Concern` even when available.

## 1.0.0

Initial release.
