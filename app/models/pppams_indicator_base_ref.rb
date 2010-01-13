class PppamsIndicatorBaseRef < ActiveRecord::Base
  has_many :pppams_indicators
  belongs_to :pppams_category_base_ref
  accepts_nested_attributes_for :pppams_indicators
  named_scope :current_facilities, lambda { |indicator_base_id|
    { :select => "facilities.id,
                  facilities.facility,
                  sub.inactive_on,
                  sub.indicator_id,
                  sub.created_on",
    :from => 'facilities',
    :joins => sanitize_sql_array(["LEFT OUTER JOIN ( SELECT pppams_categories.facility_id AS fac_id, 
                               pppams_indicators.inactive_on, 
                               pppams_indicators.updated_on,
                               pppams_indicators.created_on,
                               pppams_indicators.pppams_indicator_base_ref_id,
                               pppams_indicators.id AS indicator_id
                               FROM pppams_indicators
                               LEFT OUTER JOIN `pppams_categories` ON `pppams_categories`.id = `pppams_indicators`.pppams_category_id 
                               LEFT OUTER JOIN `pppams_indicator_base_refs` ON pppams_indicators.pppams_indicator_base_ref_id = pppams_indicator_base_refs.id 
                               GROUP BY fac_id, 
                                      pppams_indicators.inactive_on, 
                                      pppams_indicators.updated_on,
                                      pppams_indicators.created_on,
                                      pppams_indicator_base_refs.id,
                                      indicator_id
                               HAVING (pppams_indicators.pppams_indicator_base_ref_id = ?) 
                               ORDER BY pppams_indicators.updated_on DESC) sub
                ON sub.fac_id = facilities.id", indicator_base_id])
    }
  }
  def short_question
    self.question[0,100] + "..."
  end

  #retrieves hash of all facilties, indicating which one
  #has an active  hash is in the form of:
  # { facility_id => {:active => true/false,
  #                   :name => facility_name
  #                  },
  #   ...
  # }
  def self.current_facilities_hash(indicator_base_id)
    current_facilities(indicator_base_id).inject({}) do |memo, record|
      {record.id => {:active => ((record.inactive_on.nil? && record.indicator_id.nil? ||
                                  record.inactive_on) ? false : true),
                     :name => record.facility,
                     :indicator_id => record.indicator_id,
                     :created_on => record.created_on
                    }
      }.merge(memo)
    end
  end
end
