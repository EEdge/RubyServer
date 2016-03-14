

class Response404 < Response

	def initialize()
    @body = File.new('./public_html/404.html').to_s
	end

	def respond
    <<-RESULT
HTTP/1.1 404 Not Found
Content-Type: Text/HTML Content-Length: #{@body.size}

#{@body}
    RESULT
	end

end