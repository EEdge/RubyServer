class Response403 < Response

  def initialize(client, request)
    @body = File.new('./public_html/403.html').to_s
    status = 403

    logger = Logger.new(client)
    logger.write(request, status, 0)
  end

  def respond
    <<-RESULT
HTTP/1.1 403 Forbidden
Content-Type: Text/HTML Content-Length: #{@body.size}

#{@body}
    RESULT
  end

end