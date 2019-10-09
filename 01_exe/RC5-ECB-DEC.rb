require 'openssl'

cipher = OpenSSL::Cipher.new('rc5-ecb')

c = File.open("encrypted.txt")
data = c.readlines
data = data.join()
c.close
puts "encrypted: " + data

k = File.open("key.txt")
key = k.readlines
key = key.join()
k.close
puts "key: " + key

cipher.decrypt

cipher.key = key

decrypted = cipher.update(data) + cipher.final

puts "decrypted: " + decrypted