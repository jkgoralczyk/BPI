require 'socket'
require 'openssl'
require "base64"

message = File.open("message.txt")
data = message.readlines
data = data.join()
message.close
puts "data: " + data

server = TCPServer.open(1337)   

client = server.accept

method = client.gets
method = Base64.decode64(method)
puts "method: " + method

cipher = OpenSSL::Cipher.new(method)
cipher.encrypt

key = cipher.random_key
key = Base64.encode64(key)
client.puts key
puts "key: " + key

iv = cipher.random_iv
iv = Base64.encode64(iv)
client.puts iv
puts "iv: " + iv

encrypted = cipher.update(data) + cipher.final
encrypted = Base64.encode64(encrypted)
client.puts encrypted
puts "encrypted: " + encrypted

gets