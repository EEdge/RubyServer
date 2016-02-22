require 'erb'

class StatusCodeResponse

  def initialize (code, content, length)
    status_responses = Hash.new()
    status_responses['200'] = 'OK'
    status_responses['201'] = 'Created'
    status_responses['204'] = 'No Content'
    status_responses['400'] = 'Bad Request'
    status_responses['403'] = 'Forbidden'
    status_responses['404'] = 'Not Found'
    @status_code = code
    @status_string = status_responses["#{code}"]
    @content_type = content
    @content_length = length
  end

  def respond
    response_body = "HTTP/1.1 #{@status_code} #{@status_string}\r\n" +
        "Content-Type: #{@content_type}\r\n" +
        "Content-Length: #{@content_length}\r\n" +
        "Connection: close\r\n"
    response_body
  end

end