class Resource
  attr_reader :absolute_path

  def initialize(location, http_configure)
    @location = location
    @http_configure = http_configure
    @absolute_path = ""
  end
  def generate_absolute_path

  	if self.script_aliased? then 
  		
  		location = @location.split("/")
  		index_of_script_alias = location.rindex do |dir| 
  			@http_configure.script_alias.has_key?(dir.to_sym)
  		end
  		location[index_of_script_alias] = 
  			@http_configure.script_alias[location[index_of_script_alias].to_sym]

  		@absolute_path = location.join

  		
  	
  	elsif self.uri_aliased? then

  		location = @location.split("/")

  		index_of_alias = location.rindex do |dir|
  			@http_configure.alias.has_key?(dir.to_sym)
  		end

  		location[index_of_alias] = 
  			@http_configure.script_alias[location[index_of_alias].to_sym]

  		@absolute_path = location.join

  	else

  		location = @location

  		puts location

  		@absolute_path = @http_configure.document_root + location[1, location.length - 1]
  	end

  	puts self.is_file?

  	if !self.is_file? && @http_configure.directory_index then
  		@absolute_path += @http_configure.directory_index 
  	end
  end

  def uri_aliased?
  	@location.split("/")
  	.any? do |directory| 
  		@http_configure.alias.has_key?(directory.to_sym)
  	end
  end

  def script_aliased?
  	@location.split("/")
  	.any? do |directory| 
  		@http_configure.script_alias.has_key?(directory.to_sym)
  	end
  end

  def is_file?
  	last = @location.split("/").last
  	if last then 
  		last.include? "." 
  	else
  		false
  	end
  end

  protected :uri_aliased?, :is_file?
end
