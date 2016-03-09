class Response204 < Response

	def initialize()
		path = require('./public_html/204.html')
		@body = File.open(path, 'r')
	end

	def respond
		<<-RESULT
HTTP/1.1 204 Created
Content-Type: Text/HTML Content-Length: #{@body.size}

#{@body.read}
		RESULT
	end

end