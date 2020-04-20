require_relative './enigma'
# ruby ./lib/decrypt.rb encrypted.txt decrypted.txt 02715 190420
# def test_it_can_encrypt_without_key_or_date_provided
#   enigma = Enigma.new
#   expected = {:encryption=>"pm", :key=>"02715", :date=>"190420"}
#   assert_equal expected, enigma.encrypt("hi")
# end

handle = File.open(ARGV[0],"r")

incoming_file = handle.read

handle.close
#not sure about the initialize now that we might need to pass things from here.
enigma1 = Enigma.new
decrypted_text = enigma1.decrypt(incoming_file, ARGV[2], ARGV[3])

writer = File.open(ARGV[1],"w")
writer.write(decrypted_text[:decryption])
writer.close

puts "Created '" + ARGV[1] + "' with the key " + ARGV[2] + " and date " + ARGV[3]
