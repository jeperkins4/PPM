module PppamsIndicatorBaseRefsHelper
  def indicator_link(facility, *args)
    options = args.extract_options!
    if options[:editable] && !facility[:inactive_on]
      if facility[:indicator_id]
        link_to facility[:name], edit_pppams_indicator_path(facility[:indicator_id])
      else
        link_to facility[:name], new_pppams_indicator_path(:facility_id => facility[:facility_id],
                                                           :pppams_indicator_base_ref_id => facility[:pppams_indicator_base_ref_id])
      end
    elsif facility[:indicator_id]
      link_to facility[:name], pppams_indicator_path(facility[:indicator_id])
    else
      facility[:name]
    end
  end

  def active?(facility)
    facility[:active] ? 'Active' : 'Inactive'
  end

  def active_on(facility, *args)
    options = args.extract_options!
    if options[:editable]
      if facility[:active_on]
        facility[:active_on]
      else
        date_select("pppams_indicator_base_ref[pppams_indicators_attributes][#{facility[:count]}]",
                    'active_on',
                    {:include_blank => true})
      end
    else
      facility[:active_on]
    end
  end

  def inactive_on(facility, *args)
    options = args.extract_options!
    if options[:editable]
      if facility[:inactive_on] && facility[:active_on]
        facility[:inactive_on]
      else
        date_select("pppams_indicator_base_ref[pppams_indicators_attributes][#{facility[:count]}]",
                    'inactive_on',
                    {:include_blank => true})
      end
    else
      facility[:inactive_on]
    end
  end

  def frequency(facility, *args)
    options = args.extract_options!
    if options[:editable]
      select("pppams_indicator_base_ref[pppams_indicators_attributes][#{facility[:count]}]",
             "frequency",
             frequency_options,
             :selected => facility[:frequency].to_i,
             :include_blank => true)
    else
      facility[:frequency]
    end
  end

  def start_month(facility, *args)
    options = args.extract_options!
    if options[:editable]
      date = facility[:start_month].blank? ? Date.today : Date.new(2010,facility[:start_month].to_i,1)
      select_month(date,
                   :add_month_numbers => true,
                   :field_name => 'start_month',
                   :prefix => "pppams_indicator_base_ref[pppams_indicators_attributes][#{facility[:count]}]",
                   :use_short_month => true,
                   :include_blank => true)
    else
      facility[:start_month]
    end
  end
end
