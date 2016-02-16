class Request
  def initialize (string)
    @request_string = string
  end
  def parse_request
    request_items = @request_string.split
  end
end