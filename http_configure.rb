require './configure.rb'
class HttpConfigure
  attr_reader :server_root, :listen_port, :document_root, :log_file, :alias,
              :script_alias, :access_file_name, :directory_index
  def initialize(string)
    configure = Configure.new(string).load

    @server_root = configure[:ServerRoot][0] #only one server root
    @listen_port = configure[:Listen][0] #can only listen on one port
    @document_root = configure[:DocumentRoot][0] #only one document root
    @log_file = configure[:LogFile][0] #only one log file
    @alias = Hash.new
    configure[:Alias].each_index do |i| 
      if i % 2 == 0 then 
        @alias[configure[:Alias][i].gsub("/",'').to_sym] = configure[:Alias][i+1]
      end
    end
    @script_alias = Hash.new
    configure[:ScriptAlias].each_index do |i| 
      if i % 2 == 0 then 
        @script_alias[configure[:ScriptAlias][i].gsub("/",'').to_sym] = configure[:ScriptAlias][i+1]
      end
    end 
    @access_file_name = configure[:AccessFileName] 
    @directory_index = configure[:DirectoryIndex][0]
  end

end