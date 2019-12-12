require 'socket'
require 'openssl'
require 'base64'
require 'digest'


server = TCPServer.new(1337)

client = server.accept
puts 'Polaczono'
digest = ""
sig = ""
pubKey = ""

line = client.gets
while line != "NONE\n"
digest += line
line = client.gets
end

line = client.gets
while line != "NONE\n"
sig += line
line = client.gets
end

line = client.gets
while line != "NONE\n"
pubKey += line
line = client.gets
end

pubKeyBob = OpenSSL::PKey::DSA.new(pubKey)

puts "Verify: " + (pubKeyBob.sysverify(Base64.decode64(digest), Base64.decode64(sig))).to_s

client.close

gets