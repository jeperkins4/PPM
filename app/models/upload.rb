class Upload < ActiveRecord::Base
  belongs_to :pppams_reference
   
  attr_accessor :upload_data
   
  # run write_file after save to db
  before_save :write_file

  # run delete_file method after removal from db
  before_destroy :delete_file
  
  def write_file
    if self.upload_data
      self.delete_file if self.name
      name =  self.upload_data['datafile'].original_filename
      nameparts = name.split(".")
      name = nameparts[0] + "-" + Time.now.strftime("%d%m%y") + "-" + self.created_by.to_s
      name += "." + nameparts[1] unless nameparts.size == 1
      self.name= name
      self.size= self.upload_data['datafile'].size
      self.file_type= self.upload_data['datafile'].content_type.strip
      directory = RAILS_ROOT + "/public/data"
      # create the file path
      path = File.join(directory, name)
      # write the file
      File.open(path, "wb") { |f| f.write(self.upload_data['datafile'].read) }
    end
  end

  def delete_file
    directory = "public/data"
    path = File.join(directory, self.name)
    FileUtils.rm_rf(path)
  end

end
