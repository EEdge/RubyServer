require './configure.rb'
class HttpConfigure
  attr_reader :server_root, :listen_port, :document_root, :log_file, :alias,
              :script_alias, :access_file_name, :directory_index
  def initialize(string)
    configure = Configure.new(string).load

    @server_root = configure[:ServerRoot][0] #only one server root
    @listen_port = configure[:Listen][0] #can only listen on one port
    @document_root = configure[:DocumentRoot] #only one document root
    @log_file = configure[:LogFile][0] #only one log file
    @alias = configure[:Alias] #multiple aliases
    @script_alias = configure[:ScriptAlias] #multiple script aliases
    @access_file_name = configure[:AccessFileName] 
    @directory_index = configure[:DirectoryIndex]
  end

end