class ResponseFactory

  def initialize ()

  end

  def get_response(status, body, mime_type)
    case status
      when 200
        Response200.new(body, mime_type)
      when 201
        Response201.new()
      when 204
        Response204.new()
      when 400
        Response400.new()
      when 401
        Response401.new()
      when 403
        Response403.new()
      when 404
        Response404.new()
      else
        Response.new(status, body, mime_type)
    end
  end
end