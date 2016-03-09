class Response201 < Response

	def initialize()
		path = require('./public_html/201.html')
		@body = File.open(path, 'r')
	end

	def respond
		<<-RESULT
HTTP/1.1 201 No Content
Content-Type: Text/HTML Content-Length: #{@body.size}

#{@body.read}
		RESULT
	end

end