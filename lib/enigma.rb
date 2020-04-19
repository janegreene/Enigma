require_relative './cipher'
require 'date'

class Enigma < Cipher

  def encrypt(message, key = @key, date = @date)
    shifts = generate_shifts(encrypted_key(key), encrypted_date(date))
    encrypted_string = shift_message(message, shifts)
      {
        encryption: encrypted_string,
        key: key,
        date: date
      }
  end

  def encrypted_key(key)
    {
      A: key[0..1].to_i,
      B: key[1..2].to_i,
      C: key[2..3].to_i,
      D: key[3..4].to_i
    }
  end

  def encrypted_date(date)
    squared_date = date.to_i ** 2
    last_four = squared_date.to_s.split("").last(4)
    {
      A: last_four[0].to_i,
      B: last_four[1].to_i,
      C: last_four[2].to_i,
      D: last_four[3].to_i
    }
  end

  def generate_shifts(key_hash, date_hash)
    key_hash.merge!(date_hash) { |k, o, n| o + n }
  end

  # def breakdown_message(message)
  #   message_breakdown = []
  #   message_downcase = message.downcase.split("")
  #     message_downcase.each_slice(4) do |set|
  #       message_breakdown << set
  #     end
  #   message_breakdown
  # end

  def find_index(character)
     @character_set.index(character)
  end

  def shift_character(shift_number, character)
    character_index = find_index(character)
      if character_index
        new_index = character_index + shift_number
        @character_set[(new_index % 27)]
      else
        character
      end
  end

  def shift_message(message, shifts)
    split_message = message.downcase.split("")
      split_message.map.with_index do |character, index|
        if index % 4 == 0
          shift_character(shifts[:A], character)
        elsif index % 4 == 1
          shift_character(shifts[:B], character)
        elsif index % 4 == 2
          shift_character(shifts[:C], character)
        elsif index % 4 == 3
          shift_character(shifts[:D], character)
        end
      end.join

  end

end


#notes for whiteboarding
#must require 'date'
#@date = Date.today.strftime("%d/%m/%Y") require ‘date’
