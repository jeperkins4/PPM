PppamsReference.all.each do |pr|

  pppams_indicator_ids = pr.pppams_indicator_base_ref_ids

  base_ref_ids = pppams_indicator_ids.map {|pi| PppamsIndicator.find(pi).pppams_indicator_base_ref_id}

  pr.pppams_indicator_base_ref_ids= base_ref_ids
  pr.save
end
