class Response401 < Response

  def initialize()
    path = require('./public_html/401.html')
    @body = File.open(path, 'r')
  end

  def respond
    <<-RESULT
HTTP/1.1 401 Unauthorized
Content-Type: Text/HTML Content-Length: #{@body.size}

#{@body.read}
    RESULT
  end

end