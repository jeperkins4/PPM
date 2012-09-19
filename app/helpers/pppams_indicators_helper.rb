<<<<<<< HEAD
module PppamsIndicatorsHelper
end
=======
module PppamsIndicatorsHelper

  def back_link
    if request.env["HTTP_REFERER"].nil?
     '/pppams_categories'
    else
      request.env["HTTP_REFERER"].sub('http://'+request.env["HTTP_HOST"],'')    
    end
  end
  
  def to_do_title(time, currents_length)
    mon = time.strftime('%b')
    current_year = time.try(:year)|| Date.today
    select_options = {:field_name => 'selectedyear', 
                      :start_year => PppamsReview.earliest - 1, 
                      :end_year => PppamsReview.latest + 1}
    "(#{mon} #{select_year(current_year, select_options )}): #{currents_length}"
  end

  def new_or_edit_review_link(review, time= Time.now, indicator = nil)
    if review.nil?
      link_to image_tag("review_icon.png",
                                :border=>0,
                                :alt   => "Create a new review for this indicator"),
              {:controller => 'pppams_reviews',
                :action => 'new',
                :pppams_review => {:pppams_indicator_id => indicator.id,
                                   :created_on => time},
                :create_time => time},
              :title => "Create a new review for this indicator"
    elsif review.try(:can_edit?)
      link_to(image_tag("edit_review_icon.png",
                        :border=>0,
                        :alt=> "Edit the review for this indicator"),
          {:controller => 'pppams_reviews',
           :action => 'edit',
           :id => review},
          :title => "Edit the review for this indicator")
    else
      ''
    end
  end
end
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
