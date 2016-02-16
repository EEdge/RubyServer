require 'socket'

class Simple
  attr_reader :options

  DEFAULT_PORT = 56789

  def initialize(options={})
    @options = options
  end

  def start
    loop do
      puts "Opening server socket to listen for connections"
      client = server.accept

      # Just to make the responses a little different...
      puts "Received connection, waiting for one second"
      sleep(1)

      puts "Writing message"
      client.puts "The current time is #{Time.now}"

      client.close
    end
  end

  def server
    @server ||= TCPServer.open(options.fetch(:port, DEFAULT_PORT))
  end
end
