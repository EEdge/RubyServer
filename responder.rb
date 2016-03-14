class Responder 

	def initialize(path, content_type, verb, resource)

		@path = path
		@content_type = content_type
		@verb = verb
	 	@resource = resource

	end

	def send

		if File.exist?(@path) && !File.directory?(@path)
        
        	if @resource.script_aliased? then

            	cgi_appendage = IO.popen([{'ENV_VAR' => 'value'}, @resource.absolute_path]).read
            	return ResponseFactory.new.get_CGI_response(cgi_appendage)

	        else

	          case @verb
	            
	            when "DELETE"

	              File.delete(@resource.absolute_path)
	              return ResponseFactory.new.get_response(204)

	            when "HEAD"

	              return ResponseFactory.new.get_200_response("", @content_type)

	            when "GET"
	              File.open(@path, 'rb') do |file|
	                return ResponseFactory.new.get_200_response(file, @content_type)
	              end
	          end

	        end

	    else

	        if @verb == "PUT" then
	          File.new(@resource.absolute_path, "w").close
	          return ResponseFactory.new.get_response(201)
	        else
	          return ResponseFactory.new.get_response(404)
	        end

	    end

	end

end