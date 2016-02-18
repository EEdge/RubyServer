class Resource
  attr_reader :headers_hash
  def initialize(headers_hash)
    @headers_hash = headers_hash
  end
  def return_resource
    @headers_hash
  end
end
