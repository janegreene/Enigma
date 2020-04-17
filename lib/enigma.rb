class Enigma

  def encrypt(encryption, key, date)
    encrypted_string = "keder ohulw"
      {
        encryption: encrypted_string,
        key: key,
        date: date
      }
  end

  def encrypted_key(key)
    {
      A: key[0..1],
      B: key[1..2],
      C: key[2..3],
      D: key[3..4]
    }
  end

  def encrypted_date(date)
    squared_date = date.to_i ** 2
    last_four = squared_date.to_s.split("").last(4)
    {
      A: last_four[0],
      B: last_four[1],
      C: last_four[2],
      D: last_four[3]
    }
  end

end
