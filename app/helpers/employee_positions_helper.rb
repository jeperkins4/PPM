module EmployeePositionsHelper
  def select_position
    if session[:facility] 
      options = session[:facility].positions.find(:all, :order => :title).collect {|pn| [ pn.title, pn.id ] } 
    else   
      options = ''
    end

    selected_position = {:selected => (session[:position].id rescue ''), :include_blank => true}

    select("facility","position_id", options, selected_position, {:onchange => "JavaScript:submit()"})
  end
  def select_position_number(form_object)
    if session[:position]
      available_position_numbers = session[:position].position_numbers.
        find(:all,:conditions=>['id not in (?)', @assigned_numbers],:order => :position_num).
        collect {|pn| [ pn.position_num, pn.id ] }
    else
      available_position_numbers = ''
    end
    form_object.select("position_number_id", available_position_numbers, { :include_blank => true, :selected => (session[:position_number]) ? session[:position_number].id : "" })
  end
end
