require 'openssl'

message = File.open("message.txt")
data = message.readlines
data = data.join()
message.close

puts "data: " + data

#Crypt
cipher = OpenSSL::Cipher.new('des-ecb')
cipher.encrypt
key = cipher.random_key

puts "key: " + key 

kap = File.open("key.txt","w")
kap.write(key)
kap.close

encrypted = cipher.update(data) + cipher.final
encrypt = File.open("encrypted.txt","w")
encrypt.write(encrypted)
encrypt.close

puts "enctypted: " + encrypted

#Decrypt
c = File.open("encrypted.txt")
data = c.readlines
data = data.join()
c.close

k = File.open("key.txt")
key = k.readlines
key = key.join()
k.close

cipher.decrypt
decrypted = cipher.update(data) + cipher.final

puts "decrypted: " + decrypted
