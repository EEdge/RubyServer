class Logger



  def initialize(filepath)
    @file_path = filepath
  end

  def write(request, response)
    open(@file_path, 'a') {|f|
      f.puts "" #IP, identity, username, time, request, status, size of object
    }
  end
end