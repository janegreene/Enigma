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

  def test_it_can_generate_random_number
    assert_equal 5, @cipher.key.length
  end

  def test_it_can_create_characters_set
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
      "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]

    assert_equal expected, @cipher.character_set
  end

  def test_it_can_return_date
    assert_equal "040895", @cipher.date
  end

  def test_it_can_encrypt_key
    expected = {
      A: 2,
      B: 27,
      C: 71,
      D: 15
    }
    assert_equal expected, @cipher.encrypted_key("02715")
  end

  def test_it_can_create_offsets
    expected = {
      A: 1,
      B: 0,
      C: 2,
      D: 5
    }
    assert_equal expected, @cipher.offsets("040895")
  end

  def test_it_can_generate_shifts
    date_hash = {
      A: 2,
      B: 27,
      C: 71,
      D: 15
    }
    key_hash = {
      A: 1,
      B: 0,
      C: 2,
      D: 5
    }
    expected = {
      A: 3,
      B: 27,
      C: 73,
      D: 20
    }
    assert_equal expected, @cipher.generate_shifts(key_hash, date_hash)
  end

  def test_it_can_shift_characters
    message = "hello world"
    shifts = {
      A: 3,
      B: 27,
      C: 73,
      D: 20
    }
    assert_equal "keder ohulw", @cipher.shift_message(message, shifts)
  end

  def test_it_can_shift_characters_leaving_specials
    message = "hello!"
    shifts = {
      A: 3,
      B: 27,
      C: 73,
      D: 20
    }
    assert_equal "keder!", @cipher.shift_message(message, shifts)
  end

  def test_it_can_shift_message
    message = "h"
    shifts = {
      A: 3,
      B: 27,
      C: 73,
      D: 20
    }
    assert_equal "k", @cipher.shift_message(message, shifts)
  end

  def test_it_can_shift_character
    assert_equal "d", @cipher.shift_character(73, "l")
    assert_equal "!", @cipher.shift_character(3, "!")
    assert_equal "k", @cipher.shift_character(3, "h")
  end

  def test_it_can_find_index
    assert_equal 1, @cipher.find_index("b")
    assert_equal 26, @cipher.find_index(" ")
  end

end
