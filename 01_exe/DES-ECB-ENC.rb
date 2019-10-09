require 'openssl'

cipher = OpenSSL::Cipher.new('des-ecb')

message = File.open("message.txt")
data = message.readlines
data = data.join()
message.close
puts "data: " + data

cipher.encrypt

key = cipher.random_key

kap = File.open("key.txt","w")
kap.write(key)
kap.close
puts "key: " + key 

encrypted = cipher.update(data) + cipher.final

encrypt = File.open("encrypted.txt","w")
encrypt.write(encrypted)
encrypt.close

puts "enctypted: " + encrypted