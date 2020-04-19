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

  def test_it_can_breakdown_a_message
    enigma = Enigma.new

    assert_equal [["h", "e", "l", "l"],["o", " ", "w", "o"],["r", "l", "d"]], enigma.breakdown_message("hello WORLD")

    # assert_equal [["k", "e", "d", "e"],["r"," ", "o", "h"], ["u", "l", "w"]],
    # enigma.breakdown_message("keder ohulw")   will use for decrypt
  end

  def test_it_can_shift_characters
    enigma = Enigma.new
    broken_message = [["h", "e", "l", "l"],["o", " ", "w", "o"],["r", "l", "d"]]
    assert_equal "keder ohulw", enigma.shift_characters(broken_message)
  end

end

#
# # encrypt a message with a key and date
# pry(main)> enigma.encrypt("hello world", "02715", "040895")
# #=>
# #   {
# #     encryption: "keder ohulw",
# #     key: "02715",
# #     date: "040895"
# #   }
#
# # decrypt a message with a key and date
# pry(main) > enigma.decrypt("keder ohulw", "02715", "040895")
# #=>
# #   {
# #     decryption: "hello world",
# #     key: "02715",
# #     date: "040895"
# #   }
#
# # encrypt a message with a key (uses today's date)
# pry(main)> encrypted = enigma.encrypt("hello world", "02715")
# #=> # encryption hash here
#
# #decrypt a message with a key (uses today's date)
# pry(main) > enigma.decrypt(encrypted[:encryption], "02715")
# #=> # decryption hash here
#
# # encrypt a message (generates random key and uses today's date)
# pry(main)> enigma.encrypt("hello world")
# #=> # encryption hash here
