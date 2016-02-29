require 'socket'
require './request.rb'
require './response.rb'
require './resource.rb'
require './http_configure.rb'
require './file_reader.rb'

class Server
  attr_reader :options

  DEFAULT_PORT = 56789

  def initialize(options={})
    @options = options
  end

  def start
    http_config_file = File.new("./httpd.conf")

    http_config = HttpConfigure.new(http_config_file.to_s)

    puts "#{http_config.server_root}, #{http_config.alias}"

    loop do
      puts "Opening server socket to listen for connections"
      client = server.accept

      request = Request.new(client).parse_request
      resource = Resource.new(request).return_resource

      client.puts Response.new(request).respond

      client.close
    end
  end

  def server
    @server ||= TCPServer.open(options.fetch(:port, DEFAULT_PORT))
  end
end
