require_relative './cipher'
require 'date'

class Enigma < Cipher

  def encrypt(message, key = @key, date = @date)

    shifts = generate_shifts(encrypted_key(key), encrypted_date(date))
    shifts[:A]
    shifts[:B]
    shifts[:C]
    shifts[:D]
    breakdown_message(message)
    # require "pry"; binding.pry
    encrypted_string = "keder ohulw"
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

  def breakdown_message(message)
    message_breakdown = []
    message_downcase = message.downcase.split("")
      message_downcase.each_slice(4) do |set|
        message_breakdown << set
      end
    message_breakdown
  end

end


#notes for whiteboarding
#must require 'date'
#@date = Date.today.strftime("%d/%m/%Y") require ‘date’
