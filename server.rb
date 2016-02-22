require 'socket'
require './request.rb'
require './response.rb'
require './resource.rb'
require 'erb'
require 'uri'

class Server
  attr_reader :options

  DEFAULT_PORT = 56789

  def initialize(options={})
    @options = options
  end

  def start
    loop do
      puts "Opening server socket to listen for connections"
      client = server.accept

      request = Request.new(client).parse_request
      resource = Resource.new(request).return_resource

      path = './index.html'
      if File.exist?(path) && !File.directory?(path)
        File.open(path, 'rb') do |file|
          IO.copy_stream(file, client)
        end

      end

      client.close
    end
  end

  def server
    @server ||= TCPServer.open(options.fetch(:port, DEFAULT_PORT))
  end
end