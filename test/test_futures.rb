require 'test/unit'
require 'swiftcore/promises/future'

class TestFuture < Test::Unit::TestCase

  def test_future_syncronous_lazy
    future = Swiftcore::Future.new do |string, length, f|
      string << ( rand(26) + 65 ).chr
      if string.length < length
        [ f,string,length ]
      else
        string
      end
    end

    r = future.value('',10)
    assert(r.length == 10, "The length of the string was #{r.length}, but 10 was expected.")

    future.reset
    r = future.value('',10000)
    assert(r.length == 10000, "The length of the string was #{r.length}, but 10000 was expected.")

  end

  def test_future_asyncronous_lazy
    future = Swiftcore::Future.new(async: true) do |string, length, f|
      string << ( rand(26) + 65 ).chr
      if string.length < length
        [ f,string,length ]
      else
        string
      end
    end

    r, *args = future.value('',10)
    assert(Swiftcore::Future === r, "Expected the return value to still be a future, but it was #{r.inspect}")

    while Swiftcore::Future === r
      r, *args = r.value(*args)
    end
    assert(r.length == 10, "The length of the string was #{r.length}, but 10 was expected.")

    future.reset
    r = future
    args = ['',10000]
    loop do
      r, *args = r.value(*args)
      break unless Swiftcore::Future === r
    end
    assert(r.length == 10000, "The length of the string was #{r.length}, but 10000 was expected.")
  end

end
