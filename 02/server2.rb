require 'socket'   
require 'openssl'
require 'base64'
require 'digest'

#Bob

server = TCPServer.new(1337)

client = server.accept
puts 'Polaczono'

choose = client.gets.chomp

	if choose == '1'
		dig = OpenSSL::Digest::SHA512.new
	end
	if choose == '2'
		dig = OpenSSL::Digest::SHA256.new
	end
	if choose == '3'
		dig = OpenSSL::Digest::RIPEMD160.new
	end
	if choose == '4'
		dig = OpenSSL::Digest::MD5.new
	end

data1 = client.gets.chomp

digestClient = client.gets.chomp

dataDecyzja = rand(0...2)

client.puts dataDecyzja

newdata1 = client.gets.chomp

newdata2 = client.gets.chomp

newdata3 = client.gets.chomp

if data1.to_s == newdata1.to_s
	toHash = newdata1.to_i + newdata2.to_i + newdata3.to_i
	digestServer = dig.digest(toHash.to_s)
	
	if digestServer == digestClient
		wynik = dataDecyzja.to_i ^ newdata3.to_i
		puts "Wynik: " + (wynik).to_s
	end
	
	end
	
client.close

gets