module Swiftcore

  # This is a little helper class. A callback is, ultimately, something which
  # responds to #call. This class lets one be constructed by passing it an
  # object,and a method to call on that object, with an optional set of default
  # arguments. If a method is not provided, then the object must respond to
  # the #call method. One may also simply pass a block.
  #
  # The callback is invoked when the #call method is invoked on the Callback
  # object.
 
  class Callback
    def initialize(object: nil, method: nil, args: nil, &blk)
      @args = (args.respond_to? :to_a) ? args : [args]
      if object
        if method
          @callback = ->(*arguments) do
            object.__send__ method, *arguments
          end
        elsif object.respond_to? :call
          @callback = object
        else
          raise ArgumentError("An object (#{object} was provided, but the object doesn't respond to :call and no methods is specified")
        end
      elsif blk
        @callback = blk
      else
        raise ArgumentError("An object and an optional method to call, or a block must be provided.")
      end
    end

    def call(*args)
      @callback.call(*(args.any? ? args : @args))
    end
  end

  def self.callback(object: nil, method: nil, args: nil, &blk)
    Callback.new(object: object, method: method, args: args, &blk)
  end

end
