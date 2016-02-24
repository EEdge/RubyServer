require 'erb'

class StatusCodeResponse


  def initialize (code, content, length, body)

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
    @body = body
  end

  def respond

<<-RESULT
HTTP/1.1 #{@status_code} #{@status_string}
"Content-Type: #{@content_type} Content-Length: #{@content_length}

#{@body}
RESULT
  end

end

