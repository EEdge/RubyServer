require 'socket'
require './request.rb'
require './resource.rb'
require './http_configure.rb'
require './mime_types.rb'
require './file_reader.rb'
require './response.rb'
require './access_check.rb'
require './worker.rb'
require './response_factory.rb'
require './responder.rb'
require './logger.rb'
Dir['./responses/*.rb'].each {|file| require file}
Dir['./exceptions/*.rb'].each {|file| require file}

require 'erb'
require 'uri'

class Server
  attr_reader :options

  @default_port = 56789

  def initialize(options={})
    @options = options
  end

  def start

    http_config_file = File.new("./config/httpd.conf")
    http_config = HttpConfigure.new(http_config_file.to_s)

    @default_port = http_config.listen_port

    mime_types_file = File.new("./config/mime.types")
    mime_types = MimeTypes.new(mime_types_file.to_s).load

    loop do

      puts "Opening server socket to listen for connections"

      client = server.accept

      Thread.new do 
        Worker.new(http_config, mime_types).listen(client)
        Thread.exit
      end

    end
  end

  def server
    @server ||= TCPServer.open(options.fetch(:port, @default_port))
  end
end
