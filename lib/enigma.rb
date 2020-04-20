require_relative './cipher'
require 'date'

class Enigma < Cipher

  def encrypt(message, key = @key, date = @date)
    shifts = generate_shifts(encrypted_key(key), offsets(date))
    encrypted_string = shift_message(message, shifts)
    {
      encryption: encrypted_string,
      key: key,
      date: date
    }
  end

  def decrypt(ciphertext, key = @key, date = @date)
    shifts = generate_shifts(encrypted_key(key), offsets(date))
    reverse_shifts = shifts.inject({}) { |h, (k, v)| h[k] = -v; h }
    decrypt_string = shift_message(ciphertext, reverse_shifts)
    {
       decryption: decrypt_string,
       key: key,
       date: date
     }
  end

end
