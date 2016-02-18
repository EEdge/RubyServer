class Response
  attr_reader :resource
  def initialize (resource)
    @resource = resource
  end
  def respond
    body = ""
    @resource.each do |key,value|
      body += "#{key}: #{value}\n"
    end
    body
  end
end
