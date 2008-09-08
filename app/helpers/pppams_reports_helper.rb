module PppamsReportsHelper

  def output_summary_perc(last_object_store, agg_store, missing_flag)
    output = "<tr "
    output += "class='warning_row'" if missing_flag
    output += ">"
    if @group_level == 0
      output += "<td>#{agg_store.mean.perc_round_to(2)}</td>"
    elsif @group_level == 1
      output += "<td>#{last_object_store.pppams_category.facility.facility}</td><td>#{agg_store.mean.perc_round_to(2)}</td>"
    elsif @group_level == 2
      output += "<td>#{last_object_store.pppams_category.name}</td><td>#{agg_store.mean.perc_round_to(2)}</td>"
    elsif @group_level == 3
      output += "<td>#{last_object_store.question}</td><td>#{agg_store.mean.perc_round_to(2)}</td>"
    end
    output += "</tr>"
    output
  end

  def output_summary(last_object_store, agg_store, missing_flag)
    output = "<tr "
    output += "class='warning_row'" if missing_flag
    output += ">"
    if @group_level == 0
      output += "<td>#{agg_store.mean.round_to(2)}</td>"
    elsif @group_level == 1
      output += "<td>#{last_object_store.pppams_category.facility.facility}</td><td>#{agg_store.mean.round_to(2)}</td>"
    elsif @group_level == 2
      output += "<td>#{last_object_store.pppams_category.name}</td><td>#{agg_store.mean.round_to(2)}</td>"
    elsif @group_level == 3
      output += "<td>#{last_object_store.question}</td><td>#{agg_store.mean.round_to(2)}</td>"
    end
    output += "</tr>"
    output
  end

end
