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
  
  
  def output_summary_sig(last_object_store, agg_store, missing_flag)
    output = "<tr "
    output += "class='warning_row'" if missing_flag
    output += ">"
    output += "<td>#{last_object_store.pppams_category.name}</td><td>#{agg_store.length * 10}</td><td>#{agg_store.length == 0  ? 0 : agg_store.sum}</td><td>#{agg_store.mean.perc_round_to(2)}</td>"
    output += "</tr>"
    output
  end

  def average_or_percent(sum_type, percent_value)

    return percent_value unless percent_value.instance_of? Float

    if sum_type == 'average_score'
      (percent_value / 10).round(2)
    elsif sum_type == 'percent_average'
      percent_value.round(1).to_s + '%'
    end
  end
  def filtered_by?(symbol, filter)
    filter[symbol] && filter[symbol].uniq_numerics.size > 0
  end
end
