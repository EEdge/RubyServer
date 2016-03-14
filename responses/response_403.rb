class Response403 < Response

  def initialize()
    @body = File.new('./public_html/403.html').to_s
  end

  def respond
    <<-RESULT
HTTP/1.1 403 Forbidden
Content-Type: Text/HTML Content-Length: #{@body.size}

#{@body}
    RESULT
  end

end