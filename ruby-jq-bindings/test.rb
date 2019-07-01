
require "test/unit"
require_relative 'foobar'

class TestSimple < Test::Unit::TestCase

  def setup
    @output = Foobar.try_libjq
  end

  def test_scan_with_grouping
    assert_equal('["bar"]', @output)
  end

end
