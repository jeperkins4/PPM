module AccountabilityLogsHelper
  def calendar
   (session[:month]) ? @month = session[:month] : @month = Time.now.month
    result_string = %Q! <p> Month: !
   [{'Jul'=>'7'},{'Aug'=>'8'},{'Sep'=>'9'},{'Oct'=>'10'},{'Nov'=>'11'},{'Dec'=>'12'},{'Jan'=>'1'},{'Feb'=>'2'},{'Mar'=>'3'},{'Apr'=>'4'},{'May'=>'5'},{'Jun'=>'6'}].each do |month_pair|
     month_pair.each_pair do |month, month_number|
      if (month_number.to_i ) == @month.to_i then
        result_string += %Q! <b>#{month}</b> !
      else
        result_string += %Q! #{link_to month, {:action => :set_calendar, :month => month_number }} !
      end
    end
     end
    result_string += %Q! </p> !
  end
 
end
