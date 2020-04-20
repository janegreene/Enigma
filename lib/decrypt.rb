require_relative './enigma'
# ruby ./lib/decrypt.rb encrypted.txt decrypted.txt 82648 240818

handle = File.open(ARGV[0],"r")

incoming_file = handle.read

handle.close
#not sure about the initialize now that we might need to pass things from here.

# enigma1 = Enigma.new
# encrypted_text = enigma1.decrypt(incoming_file)
#
# writer = File.open(ARGV[1],"w")
# writer.write(encrypted_text[:decryption])
# writer.close
#
# puts "Created '" + ARGV[1] + "' with the key " + # + " and date " + enigma1.date
