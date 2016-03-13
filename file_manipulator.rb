class FileManipulator

  def create(filepath, filename)
    File.new filename,"w" unless File.exist?(filepath)
  end

  def delete(filepath)
    File.delete(filepath) if File.exist?(filepath)
  end

end