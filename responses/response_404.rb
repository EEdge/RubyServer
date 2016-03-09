

class Response404 < Response

	def initialize()
    path = require('./public_html/404.html')
    @body = File.open(path, 'r')
	end

	def respond
    <<-RESULT
HTTP/1.1 404 Not Found
Content-Type: Text/HTML Content-Length: #{@body.size}

#{@body.read}
    RESULT
	end

end