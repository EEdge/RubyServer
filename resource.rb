class Resource
  attr_reader :headers_hash, :http_configure, :mime_types, :absolute_path
  def initialize(headers_hash, http_configure, mime_types)
    @headers_hash = headers_hash
    @http_configure = http_configure
    @mime_types = mime_types
  end
  def return_absolute_path
  	if self.script_aliased? then 
  		
  		location = @headers_hash[:location].split("/")
  		index_of_script_alias = location.rindex do |dir| 
  			@http_configure.script_alias.has_key?(dir.to_sym)
  		end
  		location[index_of_script_alias] = 
  			@http_configure.script_alias[location[index_of_script_alias].to_sym]

  		@absolute_path = location.join

  		
  	
  	elsif self.uri_aliased? then

  		location = @headers_hash[:location].split("/")

  		index_of_alias = location.rindex do |dir|
  			@http_configure.alias.has_key?(dir.to_sym)
  		end

  		location[index_of_alias] = 
  			@http_configure.script_alias[location[index_of_alias].to_sym]

  		@absolute_path = location.join

  	else
  		location = @headers_hash[:location]

  		@absolute_path = @http_configure.document_root << location[1, location.length - 1]
  	end

  	puts @http_configure.directory_index

  	if !self.is_file? && @http_configure.directory_index then
  		@absolute_path << @http_configure.directory_index 
  	end
  	@absolute_path
  end

  def uri_aliased?
  	@headers_hash[:location].split("/")
  	.any? do |directory| 
  		@http_configure.alias.has_key?(directory.to_sym)
  	end
  end

  def script_aliased?
  	@headers_hash[:location].split("/")
  	.any? do |directory| 
  		@http_configure.script_alias.has_key?(directory.to_sym)
  	end
  end

  def is_file?
  	last = @headers_hash[:location].split("/").last
  	last.count(".") > 0 if last
  end
end
