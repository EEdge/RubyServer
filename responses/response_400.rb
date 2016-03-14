class Response400 < Response

  def initialize()
    @body = File.new('./public_html/400.html').to_s
  end

  def respond
    <<-RESULT
HTTP/1.1 400 Bad Request
Content-Type: Text/HTML Content-Length: #{@body.size}

#{@body}
    RESULT
  end

end