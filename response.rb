class Response

  status_responses = Hash.new()
  status_responses['200'] = 'OK'
  status_responses['201'] = 'Created'
  status_responses['204'] = 'No Content'
  status_responses['400'] = 'Bad Request'
  status_responses['403'] = 'Forbidden'
  status_responses['404'] = 'Not Found'

  def initialize (status, body, mime_type)

    @status = status
    @mime_type = mime_type
    @body = body

  end

  def respond
    <<-RESULT
HTTP/1.1 #{@status} #{status_resposes[@status]}
"Content-Type: #{@mime_type} Content-Length: #{@body.bytesize}

#{@body}
    RESULT
  end

end