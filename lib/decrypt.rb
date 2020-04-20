require_relative './enigma'
# ruby ./lib/decrypt.rb encrypted.txt decrypted.txt 15333 200420

handle = File.open(ARGV[0],"r")

incoming_file = handle.read

handle.close
enigma1 = Enigma.new
decrypted_text = enigma1.decrypt(incoming_file, ARGV[2], ARGV[3])

writer = File.open(ARGV[1],"w")
writer.write(decrypted_text[:decryption])
writer.close

puts "Created '" + ARGV[1] + "' with the key " + ARGV[2] + " and date " + ARGV[3]
