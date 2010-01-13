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

end
