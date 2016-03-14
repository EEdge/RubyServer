class Response204 < Response

	def initialize()
		@body = File.new('./public_html/204.html').to_s
	end

	def respond
		<<-RESULT
HTTP/1.1 204 Created
Content-Type: Text/HTML Content-Length: #{@body.size}

#{@body.read}
		RESULT
	end

end