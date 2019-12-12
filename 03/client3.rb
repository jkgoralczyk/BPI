require 'prime'
require 'openssl'
require 'socket'
require 'securerandom'

message = File.read("message.txt")

dh1=OpenSSL::PKey::DH.new(1024)
dh1.generate_key!
der = dh1.public_key.to_der

sock = TCPSocket.new("localhost",2000)
puts sock.gets  
mode = gets.gsub(/\n$/, '')
sock.puts mode

sock.puts der
sock.puts dh1.pub_key

key=sock.gets
key=key.chop
key=key.to_i

symm_key1 = dh1.compute_key(key.to_bn)

case mode.chomp
when "1"     
    mode = "des-ecb" 
    c = OpenSSL::Cipher.new(mode)
    c.encrypt 
    c.key = symm_key1[0..7]
when "2"
    mode = "des-ede3-cbc"    
    c = OpenSSL::Cipher.new(mode)
    c.encrypt    
    c.key = symm_key1[0..23]
    iv = c.iv = SecureRandom.random_bytes(8)
    sock.puts iv
when "3"
    mode = "aes-192-cbc"
    c = OpenSSL::Cipher.new(mode)
    c.encrypt  
    c.key = symm_key1[0..23]
    iv = c.iv = SecureRandom.random_bytes(16)
    sock.puts iv
when "4"
    mode = "idea-ofb"
    c = OpenSSL::Cipher.new(mode)
    c.encrypt  
    iv = c.iv = SecureRandom.random_bytes(8)
    sock.puts iv
end

encrypted = c.update(message) + c.final
sock.puts encrypted

puts "Klucz publiczny: " + (dh1.pub_key).to_s
puts "Klucz otrzymany: " + (key).to_s
puts "Sposób szyfrowania: " + mode
puts "Klucz symetryczny: " + symm_key1
puts "IV: " + iv.inspect
puts "Zaszyfrowana wiadomosc: " + encrypted
puts

sock.close 

gets