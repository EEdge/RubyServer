require './configure.rb'
class HttpConfigure
  attr_reader :server_root, :listen_port, :document_root, :log_file, :alias,
              :script_alias, :access_file_name, :directory_index
  def initialize(string)
    configure = Configure.new(string).load
    @server_root = configure['server_root']
    @listen_port = configure['listen_port']
    @document_root = configure['document_root']
    @log_file = configure['log_file']
    @alias = configure['alias']
    @script_alias = configure['script_alias']
    @access_file_name = configure['access_file_name']
    @directory_index = configure['directory_index']
  end

end