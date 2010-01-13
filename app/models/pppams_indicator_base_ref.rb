class PppamsIndicatorBaseRef < ActiveRecord::Base
  has_many :pppams_indicators
  belongs_to :pppams_category_base_ref
  accepts_nested_attributes_for :pppams_indicators
  named_scope :current_facilities, lambda { |indicator_base_id|
    { :select => "facilities.id,
                  facilities.facility,
                  pppams_indicators.inactive_on,
                  pppams_indicators.id AS indicator_id,
                  pppams_indicators.created_on,
                  pppams_indicators.updated_on,
                  pppams_indicators.pppams_indicator_base_ref_id",
      :from => 'facilities',
      :joins => "LEFT OUTER JOIN pppams_indicators ON pppams_indicators.facility_id = facilities.id",
      :group => "facilities.id, 
              facilities.facility,
        pppams_indicators.inactive_on, 
        pppams_indicators.updated_on,
        pppams_indicators.created_on,
        pppams_indicators.pppams_indicator_base_ref_id,
        indicator_id",
      :having => ["pppams_indicators.pppams_indicator_base_ref_id = ?
                   OR pppams_indicators.pppams_indicator_base_ref_id is null", indicator_base_id],
      :order => "pppams_indicators.updated_on DESC"
    }
  }
  def short_question
    self.question[0,100] + "..."
  end

  #retrieves hash of all facilties, indicating which one
  #has an active  hash is in the form of:
  # { facility_id => {:active => true/false,
  #                   :name => facility_name,
  #                   :indicator_id => ...,
  #                   :created_on => date indicator was created
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
