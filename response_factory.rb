class ResponseFactory

  def initialize ()

  end

  def get_response(status)
    case status
      when 201
        Response201.new().respond
      when 204
        Response204.new().respond
      when 400
        Response400.new().respond
      when 401
        Response401.new().respond
      when 403
        Response403.new().respond
      when 404
        Response404.new().respond
      else
        Response.new(status, body, mime_type).respond
    end
  end

  def get_200_response(body, mime_type)

    Response200.new(body, mime_type).respond

  end
end