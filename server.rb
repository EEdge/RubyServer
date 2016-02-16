require 'socket'

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
      request_string = client.gets
      client.puts(request_string)
      # request = Request.new(request_string)
      # response = Response.new(request)

      client.close
    end
  end

  def server
    @server ||= TCPServer.open(options.fetch(:port, DEFAULT_PORT))
  end
end
