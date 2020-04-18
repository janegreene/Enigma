require 'date'

class Cipher

  attr_reader :character_set, :date

  def initialize
    @character_set = ('a'..'z').to_a << ' '
    @date = Date.today.strftime('%d%m%y')
  end

end
