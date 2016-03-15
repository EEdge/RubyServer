class Request
  def initialize (client)
    @request_client = client
  end
  def parse_request
    begin

      request_hash = Hash.new
      puts "request: #{@request_client}"
      first_line = @request_client.gets.split
      puts first_line[0]
      puts first_line[1]
      puts first_line[2]
      puts first_line[3]

      request_hash[:verb] = first_line[0]
      request_hash[:location] = first_line[1]

      puts "location : #{request_hash[:location]}"
      request_hash[:query_string] = request_hash[:location].split("?")

      if request_hash[:query_string][1] then
        request_hash[:location] = request_hash[:query_string][0]
        temp_hash = Hash.new
        request_hash[:query_string][1].split("&").each do |pair|
          temp = pair.split("=")
          temp_hash[temp[0].to_sym] = temp[1]
        end
        request_hash[:query_string] = temp_hash
      end
      
      request_hash[:version] = first_line[2]

      request_hash[:headers] = Hash.new

      while (line = @request_client.gets) != "\r\n"
        line = line.split(": ")
        request_hash[:headers][line[0].to_sym] = line[1]
      end

      if request_hash[:headers][:'Content-Length'] then
        request_hash[:body] = ""
        0.upto(request_hash[:headers][:'Content-Length'].to_i - 1) do |index|
           request_hash[:body] += @request_client.readchar
         end
      end
      request_hash
    rescue
      raise Exception400.new
    end
  end
end
