require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/enigma'
require './lib/cipher'
require 'date'

class EnigmaTest < Minitest::Test
  def test_it_exists
    enigma = Enigma.new
    assert_instance_of Enigma, enigma
  end

  def test_it_can_encrypt
    enigma = Enigma.new
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }
    assert_equal expected, enigma.encrypt("hello world", "02715", "040895")
  end

  def test_it_can_decrypt
    enigma = Enigma.new
    expected =
            {
               decryption: "hello world",
               key: "02715",
               date: "040895"
             }
     assert_equal expected, enigma.decrypt("keder ohulw", "02715", "040895")
  end

  def test_it_can_encrypt_key
    enigma = Enigma.new
    expected = {
      A: 2,
      B: 27,
      C: 71,
      D: 15
    }
    assert_equal expected, enigma.encrypted_key("02715")
  end

  def test_it_can_encrypt_date
    enigma = Enigma.new
    expected = {
      A: 1,
      B: 0,
      C: 2,
      D: 5
    }
    assert_equal expected, enigma.encrypted_date("040895")
  end

  def test_it_can_generate_shifts
    enigma = Enigma.new
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
    assert_equal expected, enigma.generate_shifts(key_hash, date_hash)
  end

  def test_it_can_shift_characters
    enigma = Enigma.new
    message = "hello world"
    shifts = {
      A: 3,
      B: 27,
      C: 73,
      D: 20
    }
    assert_equal "keder ohulw", enigma.shift_message(message, shifts)
  end

  def test_it_can_shift_characters_leaving_specials
    enigma = Enigma.new
    message = "hello!"
    shifts = {
      A: 3,
      B: 27,
      C: 73,
      D: 20
    }
    assert_equal "keder!", enigma.shift_message(message, shifts)
  end

  def test_it_can_shift_message
    enigma = Enigma.new
    message = "h"
    shifts = {
      A: 3,
      B: 27,
      C: 73,
      D: 20
    }
    assert_equal "k", enigma.shift_message(message, shifts)
  end

  def test_it_can_shift_character
    enigma = Enigma.new
    assert_equal "d", enigma.shift_character(73, "l")
    assert_equal "!", enigma.shift_character(3, "!")
    assert_equal "k", enigma.shift_character(3, "h")
  end

  def test_it_can_find_index
    enigma = Enigma.new
    assert_equal 1, enigma.find_index("b")
    assert_equal 26, enigma.find_index(" ")
  end

  def test_it_can_reverse_shift_message
    enigma = Enigma.new
    message = "k"
    shifts = {
      A: 3,
      B: 27,
      C: 73,
      D: 20
    }
    assert_equal "h", enigma.reverse_shift_message(message, shifts)
  end

  def test_it_can_reverse_shift_character
    enigma = Enigma.new
    assert_equal "l", enigma.reverse_shift_character(73, "d")
    assert_equal "!", enigma.reverse_shift_character(3, "!")
    assert_equal "h", enigma.reverse_shift_character(3, "k")
  end

end
