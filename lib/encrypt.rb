require_relative './enigma'

handle = File.open(ARGV[0],"r")

incoming_file = handle.read

handle.close
enigma1 = Enigma.new
encrypted_text = enigma1.encrypt(incoming_file)

writer = File.open(ARGV[1],"w")
writer.write(encrypted_text[:encryption]) #need to pull out encrypted test and key
writer.close

puts "Created '" + ARGV[1] + "' with the key " + enigma1.key + " and date " + enigma1.date
