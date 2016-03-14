class Response401 < Response

  def initialize()
    @body = File.new('./public_html/401.html').to_s
  end

  def respond
    <<-RESULT
HTTP/1.1 401 Unauthorized
Content-Type: Text/HTML Content-Length: #{@body.size}

#{@body}
    RESULT
  end

end