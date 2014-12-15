require 'test/unit'
require 'swiftcore/promises'

class TestCallback < Test::Unit::TestCase

  def test_callback_object_method
    callback = Swiftcore::Callback.new(object: "", method: :<<)

    r = nil
    r = callback.call("abc")
    assert_equal("abc", r)

    r = callback.call("123")
    assert_equal("abc123", r)
  end

  def test_callback_object_method_args
    callback = Swiftcore::Callback.new(object: "", method: :<<, args: "[ no additional data ]")

    r = nil
    r = callback.call("abc")
    assert_equal("abc", r)

    r = callback.call("123")
    assert_equal("abc123", r)

    r = callback.call
    assert_equal("abc123[ no additional data ]", r)
  end

  def test_callback_block
    callback = Swiftcore::Callback.new do |string, data|
      string << data
    end

    r = callback.call("", "abc")
    assert_equal("abc", r)

    r = callback.call(r, "123")
    assert_equal("abc123", r)
  end

  def test_callback_block_args
    r = ""
    callback = Swiftcore::Callback.new(args: [r, "[ no additional data ]"]) do |string, data|
      string << data
    end

    r = callback.call(r, "abc")
    assert_equal("abc", r)

    r = callback.call(r, "123")
    assert_equal("abc123", r)

    r = callback.call
    assert_equal("abc123[ no additional data ]", r)
  end

  def test_callback_object_only
    cb = lambda {|string, data| string << data}
    callback = Swiftcore::Callback.new(object: cb)

    r = callback.call("", "abc")
    assert_equal("abc", r)

    r = callback.call(r, "123")
    assert_equal("abc123", r)
  end

  def test_callback_object_only_args
    cb = lambda {|string, data| string << data}

    r = ""
    callback = Swiftcore::Callback.new(object: cb, args: [r, "[ no additional data ]"] )

    r = callback.call(r, "abc")
    assert_equal("abc", r)

    r = callback.call(r, "123")
    assert_equal("abc123", r)

    r = callback.call
    assert_equal("abc123[ no additional data ]", r)
  end

  def test_class_method_sugar
    callback = Swiftcore.callback do |string, data|
      string << data
    end

    r = callback.call("", "abc")
    assert_equal("abc", r)

    r = callback.call(r, "123")
    assert_equal("abc123", r)
  end

end
