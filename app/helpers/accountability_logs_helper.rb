module AccountabilityLogsHelper
  def calendar
   (session[:month]) ? @month = session[:month] : @month = Time.now.month
    result_string = %Q! <p> Month: !
    ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'].each_with_index do |month, month_number|
      if (month_number + 1) == @month.to_i then
        result_string += %Q! <b>#{month}</b> !
      else
        result_string += %Q! #{link_to month, {:action => :set_calendar, :month => month_number + 1}} !
      end
    end
    result_string += %Q! </p> !
  end
end
