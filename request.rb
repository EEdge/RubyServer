class Request
  def initialize (client)
    @request_client = client
  end
  def parse_request
    request_hash = Hash.new
    first_line = @request_client.gets.split(" ")

    request_hash[:verb] = first_line[0]
    request_hash[:location] = first_line[1]
    request_hash[:version] = first_line[2]

    request_hash[:headers] = Hash.new

    while (line = @request_client.gets) != "\r\n"
      line = line.split(": ")
      request_hash[:headers][line[0].to_sym] = line[1]
    end

    if request_hash[:headers][:'Content-Length'] then
      request_hash[:body] = @request_client.gets
    end
    request_hash
  end
end
