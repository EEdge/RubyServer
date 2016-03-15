class ResponseFactory

  def initialize ()

  end

  def get_response(status, client, request)
    case status
      when 201
        Response201.new(client, request).respond
      when 204
        Response204.new(client, request).respond
      when 304
        Response304.new(client, request).repsond
      when 400
        Response400.new(client, request).respond
      when 401
        Response401.new(client, request).respond
      when 403
        Response403.new(client, request).respond
      when 404
        Response404.new(client, request).respond
      else
        Response.new(status, body, mime_type).respond
    end
  end

  def get_200_response(body, mime_type, client, request)

    Response200.new(body, mime_type, client, request).respond

  end

  def get_CGI_response(cgi_appendage)

    ResponseCGI.new(cgi_appendage).respond

  end
end