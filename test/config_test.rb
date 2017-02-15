require 'test_helper'

# Tests
class ConfigTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Config::VERSION
  end
end
