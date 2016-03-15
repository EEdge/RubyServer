class Responder 

	def initialize(path, content_type, verb, resource, max_age)

		@path = path
		@content_type = content_type
		@verb = verb
	 	@resource = resource
	 	@max_age = max_age

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

	              if not_updated? then
	              	return ResponseFactory.new.get_response(304)
	              else
	              	File.open(@path, 'rb') do |file|
	                	return ResponseFactory.new.get_200_response(file, @content_type)
	              	end
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

	def not_updated? 
		@max_age == (Time.now  - File.new(@path).mtime).to_i
		
	end

end