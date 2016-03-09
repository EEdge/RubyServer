require 'socket'
require './request.rb'
require './resource.rb'
require './http_configure.rb'
require './mime_types.rb'
require './file_reader.rb'
require './response.rb'
require './access_check.rb'
require './responses/*'

require 'erb'
require 'uri'

class Server
  attr_reader :options

  DEFAULT_PORT = 56789

  def initialize(options={})
    @options = options
  end

  def start
    http_config_file = File.new("./config/httpd.conf")
    http_config = HttpConfigure.new(http_config_file.to_s)

    mime_types_file = File.new("./config/mime.types")
    mime_types = MimeTypes.new(mime_types_file.to_s).load

    

    loop do
      puts "Opening server socket to listen for connections"
      client = server.accept

      request = Request.new(client).parse_request


      resource = Resource.new(request[:location],http_config)
      resource.generate_absolute_path

      puts resource.absolute_path

      path = resource.absolute_path #TODO: get requested path from request class

      path = AccessCheck.new(path, http_config).check
      

      if File.exist?(path) && !File.directory?(path)
        File.open(path, 'rb') do |file|
          client.print Response.new(200, 'text/html', file.size, File.read(file)).respond #TODO: assign content-type based on file extension
        end
      else
        File.open('./404.html', 'rb') do |file|
          client.print Response.new(404, 'text/html', file.size, File.read(file)).respond
        end
      end

      client.close
    end
  end

  def server
    @server ||= TCPServer.open(options.fetch(:port, DEFAULT_PORT))
  end
end
