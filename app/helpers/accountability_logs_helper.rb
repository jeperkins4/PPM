module AccountabilityLogsHelper
  def calendar
    monthClass={"","","","","","","","","","","",""}
    monthClass[session[:month].to_i]="selected"
    
    result_string = %Q!
    <table class="calendar">
      <tr>
        <td>
        Month: !
        
    ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'].each_with_index do |month, day|
      result_string +=  %Q!
        </td>
        <td class="#{monthClass[day + 1]}">
         #{link_to month, {:action => 'set_calendar', :month => day + 1} }
        </td>!
    end
    
    result_string += %Q!</table>!
  end
end
