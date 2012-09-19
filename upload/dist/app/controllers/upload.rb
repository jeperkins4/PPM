class Upload < Application

  def index
    # for testing check jer terminal
    puts params.inspect
    # new user file object
    @upload = UserFile.new
    @upload.filename = params[:Filename]
    # save
    if @upload.save
      # create directories
      dist_root = Merb::Server.config[:dist_root]
      FileUtils.mkdir dist_root + "/public/uploads/#{@upload.id}"
      # move
      destination = dist_root + "/public/uploads/#{@upload.id}/#{params[:Filename]}"
      FileUtils.mv params[:Filedata][:tempfile].path, destination
    else
      false
    end
    #render_no_layout
  end

end