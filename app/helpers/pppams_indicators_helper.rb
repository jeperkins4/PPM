require 'orderedhash'
module PppamsIndicatorsHelper

  def back_link
    if request.env["HTTP_REFERER"].nil?
     '/pppams_categories'
    else
      request.env["HTTP_REFERER"].sub('http://'+request.env["HTTP_HOST"],'')    
    end
  end

  def frequency_options
    frequency_options=OrderedHash.new()
    frequency_options['1 - Annual'] =1
    frequency_options['2 - Semi-annual'] = 2
    frequency_options['4 - Quarterly'] = 4
    frequency_options['12 - Monthly'] = 12
    frequency_options
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
