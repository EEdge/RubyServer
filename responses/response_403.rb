class Response403 < Response

  def initialize()
    path = require('./public_html/403.html')
    @body = File.open(path, 'r')
  end

  def respond
    <<-RESULT
HTTP/1.1 403 Forbidden
Content-Type: Text/HTML Content-Length: #{@body.size}

#{@body.read}
    RESULT
  end

end