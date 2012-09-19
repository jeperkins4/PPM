class PppamsIndicatorBaseRef < ActiveRecord::Base
  has_many :pppams_indicators
  belongs_to :pppams_category_base_ref
  has_and_belongs_to_many :pppams_references

  attr_accessible :pppams_category_base_ref_id, :question

  accepts_nested_attributes_for :pppams_indicators

  named_scope :current_facilities, lambda { |indicator_base_id|
    { :select => sanitize_sql_array(["facilities.id,
                  facilities.facility,
                  indicators.inactive_on,
                  indicators.frequency,
                  indicators.start_month,
                  indicators.id AS indicator_id,
                  indicators.active_on,
                  indicators.updated_on,
                  ? as pppams_indicator_base_ref_id ", indicator_base_id]),
      :from => 'facilities',
      :joins => sanitize_sql_array([" LEFT OUTER JOIN (
                       SELECT * 
                       FROM pppams_indicators 
                       WHERE pppams_indicator_base_ref_id = ?
                       ) indicators ON indicators.facility_id = facilities.id ",indicator_base_id]),
      :order => "facilities.facility ASC"
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
  #                   :active_on => date indicator was created
  #                   :pppams_indicator_base_ref_id => base_indicator_id
  #                  },
  #   ...
  # }
  def self.current_facilities_hash(indicator_base_id)
    current_facilities(indicator_base_id).inject({}) do |memo, record|
      {record.id => {:active => ((record.inactive_on.nil? && record.active_on.nil? ||
                                  record.inactive_on) ||
                                  DateTime.strptime(record.active_on, '%Y-%m-%d') > Time.now ? false : true),
                     :name => record.facility,
                     :indicator_id => record.indicator_id,
                     :facility_id=> record.id,
                     :frequency => record.frequency,
                     :start_month => record.start_month,
                     :active_on => record.active_on,
                     :pppams_indicator_base_ref_id=> record.pppams_indicator_base_ref_id,
                     :inactive_on => record.inactive_on
                    }
      }.merge(memo)
    end
  end
  def current_facilities_hash
    self.class.current_facilities_hash(self.id)
  end
end
