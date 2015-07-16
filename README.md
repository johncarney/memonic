# Memonic

## Introduction

Memonic is a very simple, lightweight memoization helper. The simplest way to
use it is with the `memoize` class method.

    class MyClass
      include Memonic

      memoize :value do
        an_expensive_computation
      end
    end

This defines an instance method named `value` on `MyClass` that is the
equivalent of:

    def value
      unless defined? @value
        @value = an_expensive_computation
      end
      @value
    end

Note that unlike the more usual `@value ||= computation` pattern, Memonic
guarantees that the computation is only executed once, even if it returns
`nil` or `false`.

`memoize` is also available as an instance method. I'm not entirely sure why
you would want to use it, but if you do, here's how:

    class MyClass
      include Memonic

      def value
        memoize(:@value) { an_expensive_computation }
      end
    end

Note that the '@' prefix **is** necessary.

## Background

Memoization is a common optimization technique in which the result of a
potentially expensive computation is captured the first time a function is
invoked and the cached result is used for subsequent invocations. In Ruby it's
usually expressed as follows:

    class MyClass
      def value
        @value ||= an_expensive_computation
      end
    end

This is simple and well-understood, but suffers from a fairly serious flaw: if
the computation result is `nil` or `false`, then the full computation will be
performed on every call to `value`. In most cases this is not an issue -
either the computation in question never yields a "falsey" result, or it's not
so expensive that it matters if it's repeated a few times. For cases where
these issues are a concern, the usual solution is to first check whether the
cached result actually exists:

    def value
      unless defined?(@value)
        @value = an_expensive_computation
      end
      @value
    end

This does the job, but it's verbose and not very idiomatic. Memonic does
pretty much exactly this internally, but dresses it in a convenient, idiomatic
syntax.

## Alternatives

There are a couple of gems that offer similar functionality. Most of these
are intended to replace `ActiveSupport::Memoizable`, which was deprecated
way back in Rails 3.2 for being an overly complex solution to a relatively
simple problem. The Memoizable-style gems use a slightly different syntax from
Memonic. You define your method, then mark it for memoization:

    class MyClass
      extend Memoist

      def value
        an_expensive_computation
      end
      memoize :value
    end

If you prefer this approach, then you should totally use something like
[Memoist][memoist] or [Memoizable][memoizable].

## Installation

Add this line to your application's Gemfile:

    gem 'memonic'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install memonic

## Contributing

1. Fork it ([http://github.com/johncarney/memonic/fork][fork])
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[memoist]:    https://github.com/matthewrudy/memoist
[memoizable]: https://github.com/dkubb/memoizable

[gem-badge]:        https://badge.fury.io/rb/memonic.svg
[gem]:              http://badge.fury.io/rb/memonic
[build-badge]:      https://travis-ci.org/johncarney/memonic.svg?branch=master
[build]:            https://travis-ci.org/johncarney/memonic
[coverage-badge]:   https://img.shields.io/coveralls/johncarney/memonic.svg
[coverage]:         https://coveralls.io/r/johncarney/memonic?branch=master
[fork]:             http://github.com/johncarney/memonic/fork
