class Response400 < Response

  def initialize()
    path = require('./public_html/400.html')
    @body = File.open(path, 'r')
  end

  def respond
    <<-RESULT
HTTP/1.1 400 Bad Request
Content-Type: Text/HTML Content-Length: #{@body.size}

#{@body.read}
    RESULT
  end

end