class Worker

  def initialize(http_config, mime_types)

    @http_config = http_config
    @mime_types = mime_types

  end

  def listen(client)

    @client = client

    begin 
      request = Request.new(@client).parse_request

      resource = Resource.new(request[:location], @http_config)

      resource.generate_absolute_path

      puts resource.absolute_path

      path = resource.absolute_path


      path = AccessCheck.new(path, @http_config).check

      content_type = get_content_type(path)

      verb = request[:verb]

      @client.print Responder.new(path, content_type, verb, resource).send
      
    rescue Exception400
      @client.print ResponseFactory.new.get_response(400)
    rescue Exception401
      @client.print ResponseFactory.new.get_response(401)
    rescue Exception403
      @client.print ResponseFactory.new.get_response(403)
    end
    @client.close

  end

  def get_content_type(path)
    extension = path.split('.')[-1]
    @mime_types[extension]
  end

end