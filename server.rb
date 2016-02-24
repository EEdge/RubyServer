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

      #request = Request.new(client).parse_request
      #resource = Resource.new(request).return_resource

      path = './blah.html' #TODO: get requested path from request class
      if File.exist?(path) && !File.directory?(path)
        File.open(path, 'rb') do |file|
          client.print StatusCodeResponse.new(200, 'text/html', file.size, File.read(file)).respond #TODO: assign content-type based on file extension
        end
      else
        File.open('./not_found_error.html', 'rb') do |file|
          client.print StatusCodeResponse.new(404, 'text/html', file.size, File.read(file)).respond
        end
      end

      client.close
    end
  end

  def server
    @server ||= TCPServer.open(options.fetch(:port, DEFAULT_PORT))
  end
end
