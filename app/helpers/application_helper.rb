<<<<<<< HEAD
module ApplicationHelper
end
=======
require 'orderedhash'
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def collection_select_multiple(object, method,
                                 collection, value_method, text_method,
                                 options = {}, html_options = {})
    real_method = "#{method.to_s.singularize}_ids".to_sym
    collection_select(
      object, real_method,
      collection, value_method, text_method,
      options,
      html_options.merge({
        :multiple => true,
        :name => "#{object}[#{real_method}][]"
      })
    )
  end

  def collection_select_multiple_pppams_references(object, method,
                                            options = {}, html_options = {})
    collection_select_multiple(
      object, method,
      PppamsReference.find(:all, :order => 'name ASC'), :id, :name,
      options, html_options
    )
  end

  def frequency_options
    frequency_options=OrderedHash.new()
    frequency_options['1 - Annual'] =1
    frequency_options['2 - Semi-annual'] = 2
    frequency_options['4 - Quarterly'] = 4
    frequency_options['12 - Monthly'] = 12
    frequency_options
  end

  def default_js
   javascript_include_tag('prototype', 'effects', 'dragdrop', 'controls', 'limit_chars', 'jquery', 'application', 'overlib')+
   calendar_date_select_includes('blue')
  end

end
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
