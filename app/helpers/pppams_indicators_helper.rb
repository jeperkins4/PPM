module PppamsIndicatorsHelper

  def back_link
    if request.env["HTTP_REFERER"].nil?
     '/pppams_categories'
    else
      request.env["HTTP_REFERER"].sub('http://'+request.env["HTTP_HOST"],'')    
    end
  end
  
  def to_do_title(time, currents_length)
    mon = time.strftime('%b')
    current_year = time.try(:year)|| Date.today
    select_options = {:field_name => 'selectedyear', 
                      :start_year => PppamsReview.earliest - 1, 
                      :end_year => PppamsReview.latest + 1}
    "(#{mon} #{select_year(current_year, select_options )}): #{currents_length}"
  end
end
