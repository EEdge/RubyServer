require 'digest/sha2'
require 'base64'

class Htaccess

  def protected?(path, header)

  end

  def can_authorize?(path)
    auth_file = File.read(path)
    username = auth_file.split(':')[0]
    return username.nil?
  end

  def authorized?(path)
    auth_file = File.read(path)
    password = auth_file.split(':')[1]
    decrypted = Base64.decode64(password)
    return decrypted
  end

end