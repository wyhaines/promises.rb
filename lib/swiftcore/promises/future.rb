require 'swiftcore/promises/callback'

module Swiftcore

  class Future

    def initialize(lazy: true, args: nil, async: false, &blk)
      setup(lazy: lazy, args: args, async: async, &blk)
    end

    def determine_resolution
      @resolved = true if ! @value.respond_to? :call
    end

    def value(*args)
      _call(*args) unless @resolved
      @value
    end

    alias call value

    def reset
      @resolved = false

      setup(lazy: @lazy, args: @args, async: @async, &@block)
    end

    def lazy?
      @lazy
    end

    def lazy=(val)
      @lazy = vale
    end

    def args=(val)
      @args = val
    end

    def async?
      @async
    end

    def async=(val)
      @async = val
    end

    private

    def setup(lazy: true, args: nil, async: false, &blk)
      @lazy = lazy
      @block = blk
      @resolved = false
      @async = async
      @args = args

      if lazy
        @value = blk
      elsif block_given?
        @value = yield( *args.respond_to?( :to_a ) ? args : [args] )
        determine_resolution
        call unless @resolved
      end
    end

    def _call(*new_args)
      if @value.respond_to? :call
        @args = new_args if new_args.any?
        @value,*new_args = ( Future === @value ? @block : @value ).call( *@args.respond_to?( :to_a ) ? @args : [@args], self )
        determine_resolution
      else
        determine_resolution
      end

      unless @resolved || @async
        loop do
          @args = new_args if new_args && new_args.any?
          @value,*new_args = ( Future === @value ? @block : @value ).call( *@args.respond_to?( :to_a ) ? @args : [@args], self )
          determine_resolution
          break if @resolved
        end
      end
    end

  end

end
