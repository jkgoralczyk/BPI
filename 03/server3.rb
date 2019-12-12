require 'prime'
require 'openssl'
require 'socket'
require 'securerandom'

sock = TCPServer.new 2000
client = sock.accept

client.puts "1.des-ecb, 2.des-ede3-cbc, 3.aes-192-cbc 4.idea-ofb"
mode = client.gets.gsub(/\n$/, '')
sleep(3)
pp=client.gets
pp=pp.chop
sleep(4)
dh2 = OpenSSL::PKey::DH.new(pp.chomp)

dh2.generate_key!

puts "Wygenerowano"
client.puts dh2.pub_key

key=client.gets
key=key.chop
key=key.to_i

symm_key2 = dh2.compute_key(key.to_bn)

case mode.strip 
when "1"
    mode = "des-ecb"  
    d = OpenSSL::Cipher.new(mode)
    d.decrypt 
    d.key = symm_key2[0..7]
when "2"
    mode = "des-ede3-cbc"
    d = OpenSSL::Cipher.new(mode)
    d.decrypt
    d.key = symm_key2[0..23]
    d.iv = iv = client.gets.chomp
when "3"
    mode = "aes-192-cbc"
    d = OpenSSL::Cipher.new(mode)
    d.decrypt
    d.key = symm_key2[0..23]
    d.iv = iv = client.gets.chomp
when '4'
    mode = 'idea-ofb'
    d = OpenSSL::Cipher.new(mode)
    d.decrypt
    c.key = symm_key1[0..128]
    d.iv = iv = client.gets.chomp
end

message = client.gets
message.delete!("\n")
decrypted=d.update(message)+d.final

puts
puts "Klucz publczny: " + (dh2.pub_key).to_s
puts "Klucz otrzymany: " + (key).to_s
puts "Sposob szyfrowania: " + mode
puts "Klucz symmetryczny: " + symm_key2
puts "IV: " + iv.inspect
puts "Odszyfrowana wiadomosc: " + decrypted
puts

client.close

gets