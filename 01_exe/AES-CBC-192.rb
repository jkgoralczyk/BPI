require 'openssl'

message = File.open("message.txt")
data = message.readlines
data = data.join()
message.close

puts "data: " + data

#Crypt
cipher = OpenSSL::Cipher.new('aes-128-cbc')
cipher.encrypt

key = cipher.random_key
iv = cipher.random_iv
puts "key: " + key 
puts "iv: " + iv

kap = File.open("key.txt","w")
kap.write(key)
kap.close

ive = File.open("iv.txt","w")
ive.write(iv)
ive.close

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

i = File.open("iv.txt")
iv = i.readlines
iv = iv.join()
i.close

cipher.decrypt
decrypted = cipher.update(data) +cipher.final 

puts "decrypted: " + decrypted