require 'openssl'

cipher = OpenSSL::Cipher.new('des-ede3-cbc')

message = File.open("message.txt")
data = message.readlines
data = data.join()
message.close
puts "data: " + data

cipher.encrypt

key = cipher.random_key
iv = cipher.random_iv

kap = File.open("key.txt","w")
kap.write(key)
kap.close
puts "key: " + key 

ive = File.open("iv.txt","w")
ive.write(iv)
ive.close
puts "iv: " + iv

encrypted = cipher.update(data) + cipher.final

encrypt = File.open("encrypted.txt","w")
encrypt.write(encrypted)
encrypt.close

puts "enctypted: " + encrypted