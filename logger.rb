require 'time'
require './http_configure.rb'


class Logger

  def initialize(client)

    http_config_file = File.new("./config/httpd.conf")
    http_config = HttpConfigure.new(http_config_file.to_s)

    @client = client
    @file_path = './Log.txt'

    if not  File.exist?(@file_path)
      File.new "log.txt","w"
      end

  end

  def write(request, status, size)

    h = @client.addr
    l = 'n/a'
    u = 'n/a'
    t = Time.now
    r = request
    s = status
    b = size

    open(@file_path, 'a') {|f|
      #f.puts "%h %l %u %t \"%r\" %>s %b" #IP, identity, username, time, request, status, size of object
      f.write "#{h} #{l} #{u} [#{t}] \"#{r}\" #{s} #{b}" + "\n"
    }


  end
end