require 'openssl'

cipher = OpenSSL::Cipher.new('des-ede3-cbc')

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

o = File.open("iv.txt")
iv = o.readlines
iv = iv.join()
o.close
puts "iv: " + iv

cipher.decrypt

cipher.key = key
cipher.iv = iv

decrypted = cipher.update(data) + cipher.final

puts "decrypted: " + decrypted