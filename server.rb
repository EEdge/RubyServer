require 'socket'
require './request.rb'
require './response.rb'
require './resource.rb'
require './status_code_response.rb'
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

      path = '/index.html'
      if File.exist?(path) && !File.directory?(path)
        File.open(path, 'rb') do |file|
          client.print StatusCodeResponse(200, content_type(file), file.size)
          client.print '\r\n'
          IO.copy_stream(file, client)
        end
      else
        File.open('./not_found_error.html', 'rb') do |file|
          client.print StatusCodeResponse.new(404, 'text/html', file.size).respond
          client.print '\r\n'
          IO.copy_stream(file, client)
        end
      end

      #client.puts Response.new(request).respond

      client.close
    end
  end

  def server
    @server ||= TCPServer.open(options.fetch(:port, DEFAULT_PORT))
  end
end
