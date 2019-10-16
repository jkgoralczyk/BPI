require 'socket'
require 'openssl'
require "base64"

client = TCPSocket.open('localhost', 1337)

puts "Metoda:\n1. des-ecb\n2. des-ede3-cbc\n3. idea-ofb\n4. aes-192-cbc\n5. rc5-ecb"

choice = gets.to_i

if choice == 1
    method = 'des-ecb'
elsif choice == 2
    method = 'des-ede3-cbc'
elsif choice == 3
    method = 'idea-ofb'
elsif choice == 4
    method = 'aes-192-cbc'
elsif choice == 5
    method = 'rc5-ecb'
end

method_send = Base64.encode64(method)
client.puts method_send
puts "method: " + method

key = client.gets
puts "key: " + key
key = Base64.decode64(key) 

iv = client.gets
puts "iv: " + iv
iv = Base64.decode64(iv) 

encrypted = client.gets
puts "encrypted: " + encrypted
encrypted = Base64.decode64(encrypted) 

cipher = OpenSSL::Cipher.new(method)
cipher.decrypt

cipher.key = key
cipher.iv = iv

decrypted = cipher.update(encrypted) + cipher.final

puts "decrypted: " + decrypted
data = File.open("decrypted.txt","w")
data.write(decrypted)
data.close

gets