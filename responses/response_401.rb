class Response401 < Response

  def initialize(client, request)
    @body = File.new('./public_html/401.html').to_s
    status = 401

    logger = Logger.new(client)
    logger.write(request, status, 0)
  end

  def respond
    <<-RESULT
HTTP/1.1 401 Unauthorized
Content-Type: Text/HTML 
WWW-Authenticate: Basic
Content-Length: #{@body.size}

#{@body}
    RESULT
  end

end