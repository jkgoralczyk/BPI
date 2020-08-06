require 'socket'
require 'openssl'
require 'base64'
require 'digest'

server = TCPSocket.open('localhost', 1337)

dsa = OpenSSL::PKey::DSA.new(2048)

privKey = dsa.to_pem

pubKey = dsa.public_key

message = 'Tajny dokument'
digest = OpenSSL::Digest::SHA1.digest(message)

sig = dsa.syssign(digest)

server.puts Base64.encode64(digest)
server.puts "NONE\n"

server.puts Base64.encode64(sig)
server.puts "NONE\n"

server.puts pubKey
server.puts "NONE\n"

puts digest
puts sig
puts pubKey

puts "Verify: " + (dsa.sysverify(digest, sig)).to_s 

server.close

gets