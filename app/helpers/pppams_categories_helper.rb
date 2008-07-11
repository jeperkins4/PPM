module PppamsCategoriesHelper
  
  def back_link
    if request.env["HTTP_REFERER"].nil?
     '/pppams_categories'
    else
      request.env["HTTP_REFERER"].sub('http://'+request.env["HTTP_HOST"],'')    
    end
  end
  
end
