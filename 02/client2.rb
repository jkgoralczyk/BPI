require 'socket'
require 'openssl'
require 'base64'
require 'digest'

#Alice

server = TCPSocket.open('localhost', 1337)   

puts "Wybierz tryb:\n1.SHA512\n2.SHA256\n3.RIPEMD160\n4.MD5\n"
choose = gets
choose = choose.chomp
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

	server.puts choose

	data1 = rand(0...10000000)

	data2 = rand(0...10000000)

	puts 'Wybierz 0 lub 1:'
	data3 = gets.chomp
	
	toHash = data1.to_i + data2.to_i + data3.to_i

	digest = dig.digest(toHash.to_s)
	server.puts data1
	
	server.puts digest
	
	wyborBoba = server.gets
	
	server.puts data1
	
	server.puts data2

	server.puts data3

	wynik = wyborBoba.to_i ^ data3.to_i
	
	puts "Wynik: " + (wynik).to_s
	
server.close

gets