class ResponseCGI < Response 

	def initialize(cgi_appendage)
    @cgi_appendage = cgi_appendage
	end

	def respond

		<<-RESULT
HTTP/1.1 200 OK
#{@cgi_appendage}
		RESULT

	end

end