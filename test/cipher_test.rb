require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/cipher'
require 'date'

class CipherTest < Minitest::Test
  def setup
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @cipher = Cipher.new

  end

  def test_it_exists
    assert_instance_of Cipher, @cipher
  end

  # def test_it_can_generate_random_number
  #   #5 digit pad with leading 0s as needed
  # end

  def test_it_can_create_characters_set
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
      "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]

    assert_equal expected, @cipher.character_set
  end

  def test_it_can_return_date
    assert_equal "040895", @cipher.date
  end
end
