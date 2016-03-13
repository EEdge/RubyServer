require 'socket'

class Logger

  def initialize(filepath)
    @file_path = filepath

   # directory = File.dirname(filepath)
    if not  File.exist?(filepath)
      File.new "log.txt","w"
      end

  end

  def write(request, response)

    h = Socket.gethostname
    l = identity
    u = username
    t = time.now
    r = request
    s = response.code
    b = response.length

    open(@file_path, 'a') {|f|
      #f.puts "%h %l %u %t \"%r\" %>s %b" #IP, identity, username, time, request, status, size of object
      f.write "#{h} #{l} #{u} [#{t}] \"#{r}\" #{s} #{b}" + "\n"
    }


  end
end