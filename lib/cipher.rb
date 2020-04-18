require 'date'

class Cipher

  attr_reader :character_set, :date

  def initialize
    @character_set = ('a'..'z').to_a << ' '
    @date = Date.today.strftime('%d%m%y')
    # @key = rand(99999).to_s.rjust(5,"0")
  end

  def key
    # rand.to_s[2..6]
    rand(99999).to_s.rjust(5,"0")
  end

end
