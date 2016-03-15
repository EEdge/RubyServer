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

      path = resource.absolute_path

      #puts request

      path = AccessCheck.new(request, path, @http_config).check

      content_type = get_content_type(path)

      verb = request[:verb]

      max_age = request[:"Cache-Control"].split("=")[1].chomp if request[:"Cache-Control"]
      puts max_age

      @client.print Responder.new(path, content_type, verb, resource, max_age).send
      
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