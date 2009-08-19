# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 87) do

  create_table "access_levels", :force => true do |t|
    t.column "access_level", :string
    t.column "description",  :text
  end

  create_table "accountability_log_details", :force => true do |t|
    t.column "facility_id",     :integer
    t.column "context_id",      :integer
    t.column "detail_response", :text
    t.column "log_year",        :integer
    t.column "log_month",       :integer
    t.column "created_on",      :date
    t.column "created_by",      :string
  end

  add_index "accountability_log_details", ["facility_id"], :name => "index_accountability_log_details_on_facility_id"
  add_index "accountability_log_details", ["context_id", "facility_id", "log_month", "log_year"], :name => "facil_prompt_year_month"

  create_table "accountability_logs", :force => true do |t|
    t.column "facility_id", :integer
    t.column "context_id",  :integer
    t.column "prompt_id",   :integer
    t.column "response",    :decimal, :precision => 55, :scale => 3
    t.column "log_year",    :integer
    t.column "log_month",   :integer
    t.column "created_on",  :date
    t.column "created_by",  :string
  end

  add_index "accountability_logs", ["facility_id", "prompt_id", "log_year", "log_month"], :name => "facility_id"
  add_index "accountability_logs", ["facility_id", "log_month", "log_year", "prompt_id"], :name => "facil_month_year_prompt"

  create_table "action_types", :force => true do |t|
    t.column "action",      :string
    t.column "description", :text
  end

  create_table "contexts", :force => true do |t|
    t.column "title",       :string
    t.column "description", :text
    t.column "position",    :integer
  end

  create_table "custody_types", :force => true do |t|
    t.column "custody_type", :string
    t.column "description",  :text
  end

  create_table "employee_position_hists", :force => true do |t|
    t.column "position_number_id", :integer
    t.column "employee_id",        :integer
    t.column "start_date",         :date
    t.column "end_date",           :date
    t.column "salary",             :decimal, :precision => 10, :scale => 2
    t.column "create_date",        :date
  end

  add_index "employee_position_hists", ["position_number_id"], :name => "index_employee_position_hists_on_position_number_id"
  add_index "employee_position_hists", ["employee_id"], :name => "index_employee_position_hists_on_employee_id"

  create_table "employee_positions", :force => true do |t|
    t.column "position_number_id", :integer
    t.column "employee_id",        :integer
    t.column "start_date",         :date
    t.column "end_date",           :date
  end

  add_index "employee_positions", ["position_number_id"], :name => "index_employee_positions_on_position_number_id"
  add_index "employee_positions", ["employee_id"], :name => "index_employee_positions_on_employee_id"

  create_table "employees", :force => true do |t|
    t.column "facility_id", :integer
    t.column "first_name",  :string
    t.column "last_name",   :string
    t.column "emplid",      :string
    t.column "active",      :integer
    t.column "tea_status",  :string
  end

  create_table "facilities", :force => true do |t|
    t.column "facility",          :string
    t.column "shortname",         :string
    t.column "address1",          :string
    t.column "address2",          :string
    t.column "city",              :string
    t.column "state",             :string
    t.column "zip",               :string
    t.column "phone",             :string
    t.column "warden",            :string
    t.column "contract_monitor",  :string
    t.column "pppams_started_on", :datetime
  end

  create_table "facility_custodies", :force => true do |t|
    t.column "facility_id",     :integer
    t.column "custody_type_id", :integer
  end

  create_table "facility_custody_types", :force => true do |t|
    t.column "facility_id",     :integer
    t.column "custody_type_id", :integer
  end

  create_table "follow_ups", :force => true do |t|
    t.column "follow_up",      :text
    t.column "follow_up_date", :date
    t.column "incident_id",    :integer
    t.column "added_by",       :string
  end

  create_table "incident_classes", :force => true do |t|
    t.column "incident_class", :string
    t.column "description",    :text
  end

  create_table "incident_investigators", :force => true do |t|
    t.column "investigator_id", :integer
    t.column "incident_id",     :integer
  end

  create_table "incident_types", :force => true do |t|
    t.column "incident_type", :string
    t.column "description",   :text
  end

  create_table "incidents", :force => true do |t|
    t.column "incident_date",                        :date
    t.column "reported_date",                        :date
    t.column "inspector_general",                    :date
    t.column "description",                          :text
    t.column "incident_type_id",                     :integer
    t.column "facility_id",                          :integer
    t.column "contract_manager_notified_date",       :date
    t.column "bureau_notified_date",                 :date
    t.column "warden_notified_date",                 :date
    t.column "facility_investigation_complete_date", :date
    t.column "action_type_id",                       :integer
    t.column "incident_type_other",                  :string
    t.column "incident_class_id",                    :integer
    t.column "investigator_id",                      :integer
    t.column "mins",                                 :string
    t.column "action_type_other",                    :string
    t.column "designee_name",                        :string
    t.column "contract_manager_notified",            :integer
    t.column "warden_notified",                      :integer
    t.column "bureau_notified",                      :integer
    t.column "facility_investigation_complete",      :integer
    t.column "investigation_closed",                 :integer
    t.column "investigation_closed_date",            :date
    t.column "entity_closing",                       :string
  end

  create_table "inmate_counts", :force => true do |t|
    t.column "facility_id",     :integer
    t.column "inmate_count",    :integer
    t.column "date_collected",  :date
    t.column "custody_type_id", :integer
  end

  create_table "investigators", :force => true do |t|
    t.column "firstname",   :string
    t.column "lastname",    :string
    t.column "phone",       :string
    t.column "email",       :string
    t.column "entity",      :string
    t.column "facility_id", :integer
  end

  create_table "non_comp_follow_ups", :force => true do |t|
    t.column "follow_up",         :text
    t.column "non_comp_issue_id", :integer
    t.column "created_on",        :date
    t.column "updated_on",        :date
    t.column "created_by",        :integer
    t.column "updated_by",        :integer
  end

  create_table "non_comp_issues", :force => true do |t|
    t.column "facility_id",       :integer
    t.column "nci_status",        :integer
    t.column "details",           :text
    t.column "requirement",       :text
    t.column "discovery_date",    :date
    t.column "notification_date", :date
    t.column "cap_due_date",      :date
    t.column "cap_review_date",   :date
    t.column "resolved_date",     :date
    t.column "created_on",        :date
    t.column "updated_on",        :date
    t.column "created_by",        :integer
    t.column "updated_by",        :integer
    t.column "notes",             :text
    t.column "issue_number",      :string
  end

  create_table "notification_receivers", :force => true do |t|
    t.column "user_id",     :integer
    t.column "facility_id", :integer
    t.column "status",      :string
    t.column "created_at",  :datetime
    t.column "updated_at",  :datetime
  end

  add_index "notification_receivers", ["user_id", "status"], :name => "index_notification_receivers_on_user_id_and_status"
  add_index "notification_receivers", ["facility_id", "status"], :name => "index_notification_receivers_on_facility_id_and_status"

  create_table "notification_reports", :force => true do |t|
    t.column "user_id",     :integer
    t.column "facility_id", :integer
    t.column "eom_offset",  :integer
    t.column "created_at",  :datetime
    t.column "updated_at",  :datetime
  end

  add_index "notification_reports", ["user_id"], :name => "index_notification_reports_on_user_id"
  add_index "notification_reports", ["facility_id", "eom_offset"], :name => "index_notification_reports_on_facility_id_and_eom_offset"

  create_table "notifications", :force => true do |t|
    t.column "to_email",   :string
    t.column "from_email", :string
    t.column "subject",    :string
    t.column "body",       :text
    t.column "status",     :string
    t.column "created_by", :integer
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  add_index "notifications", ["status"], :name => "index_notifications_on_status"

  create_table "position_hists", :force => true do |t|
    t.column "position_id", :integer
    t.column "salary",      :decimal, :precision => 10, :scale => 2
    t.column "create_date", :date
  end

  create_table "position_numbers", :force => true do |t|
    t.column "position_id",          :integer
    t.column "position_num",         :string
    t.column "position_type",        :string
    t.column "waiver_approval_date", :date
    t.column "created_on",           :date
  end

  create_table "position_reports", :force => true do |t|
  end

  create_table "position_types", :force => true do |t|
    t.column "position_type",  :string
    t.column "description",    :text
    t.column "deductable",     :integer
    t.column "deduction_days", :integer
    t.column "facility_id",    :integer
  end

  create_table "positions", :force => true do |t|
    t.column "title",            :string
    t.column "position_type_id", :integer
    t.column "salary",           :decimal, :precision => 10, :scale => 2
    t.column "description",      :text
  end

  create_table "pppams_categories", :force => true do |t|
    t.column "name",                        :string
    t.column "description",                 :text
    t.column "facility_id",                 :integer
    t.column "created_on",                  :datetime
    t.column "updated_on",                  :datetime
    t.column "pppams_category_base_ref_id", :integer
  end

  add_index "pppams_categories", ["facility_id"], :name => "facility_id"

  create_table "pppams_category_base_refs", :force => true do |t|
    t.column "name",                     :string
    t.column "pppams_category_group_id", :integer
  end

  create_table "pppams_category_groups", :force => true do |t|
    t.column "name", :string
  end

  create_table "pppams_indicator_base_refs", :force => true do |t|
    t.column "question",                    :text
    t.column "pppams_category_base_ref_id", :integer
  end

  add_index "pppams_indicator_base_refs", ["question"], :name => "question"
  add_index "pppams_indicator_base_refs", ["pppams_category_base_ref_id"], :name => "pppams_cat_base_id"

  create_table "pppams_indicators", :force => true do |t|
    t.column "pppams_category_id",           :integer
    t.column "question",                     :text
    t.column "frequency",                    :integer
    t.column "start_month",                  :integer
    t.column "created_on",                   :datetime
    t.column "updated_on",                   :datetime
    t.column "good_months",                  :string
    t.column "pppams_indicator_base_ref_id", :integer
  end

  add_index "pppams_indicators", ["pppams_category_id"], :name => "pppams_category_id"
  add_index "pppams_indicators", ["pppams_indicator_base_ref_id"], :name => "pppams_indicator_base_ref_id"
  add_index "pppams_indicators", ["good_months"], :name => "good_months"
  add_index "pppams_indicators", ["pppams_category_id", "good_months"], :name => "category_good_months"

  create_table "pppams_indicators_pppams_references", :id => false, :force => true do |t|
    t.column "pppams_indicator_id", :integer, :null => false
    t.column "pppams_reference_id", :integer, :null => false
  end

  add_index "pppams_indicators_pppams_references", ["pppams_indicator_id"], :name => "index_pppams_indicators_pppams_references_on_pppams_indicator_id"
  add_index "pppams_indicators_pppams_references", ["pppams_reference_id"], :name => "index_pppams_indicators_pppams_references_on_pppams_reference_id"
  add_index "pppams_indicators_pppams_references", ["pppams_indicator_id", "pppams_reference_id"], :name => "indicator_reference"

  create_table "pppams_issue_follow_ups", :force => true do |t|
    t.column "follow_up",       :text
    t.column "pppams_issue_id", :integer
    t.column "created_on",      :date
    t.column "updated_on",      :date
    t.column "created_by",      :date
    t.column "updated_by",      :date
  end

  create_table "pppams_issues", :force => true do |t|
    t.column "pppams_issue_number",  :string
    t.column "pppams_issue_status",  :integer
    t.column "receiver",             :string
    t.column "received_date",        :date
    t.column "facility_id",          :integer
    t.column "reported_by",          :text
    t.column "inmate_details",       :text
    t.column "inmate_id",            :text
    t.column "description",          :text
    t.column "CM_response_due_date", :date
    t.column "CM_response_date",     :date
    t.column "resolved_date",        :date
    t.column "created_on",           :date
    t.column "updated_on",           :date
    t.column "created_by",           :integer
    t.column "updated_by",           :integer
    t.column "category",             :string
  end

  create_table "pppams_references", :force => true do |t|
    t.column "name",       :string
    t.column "url",        :string
    t.column "created_on", :datetime
    t.column "updated_on", :datetime
  end

  create_table "pppams_report_filters", :force => true do |t|
    t.column "name",             :string
    t.column "start_date",       :datetime
    t.column "end_date",         :datetime
    t.column "report_type",      :string
    t.column "facility_filter",  :text
    t.column "status_filter",    :text
    t.column "category_filter",  :text
    t.column "indicator_filter", :text
    t.column "created_on",       :datetime
    t.column "updated_on",       :datetime
    t.column "created_by",       :integer
    t.column "updated_by",       :integer
    t.column "score_filter",     :text
  end

  create_table "pppams_reviews", :force => true do |t|
    t.column "pppams_indicator_id", :integer
    t.column "doc_count",           :integer
    t.column "score",               :integer
    t.column "observation_ref",     :text
    t.column "documentation_ref",   :text
    t.column "interview_ref",       :text
    t.column "evidence",            :text
    t.column "created_on",          :datetime
    t.column "updated_on",          :datetime
    t.column "status",              :string
    t.column "notes",               :text
    t.column "created_by",          :integer
    t.column "updated_by",          :integer
    t.column "submit_count",        :integer
    t.column "real_creation_date",  :datetime
  end

  add_index "pppams_reviews", ["pppams_indicator_id"], :name => "index_pppams_reviews_on_pppams_indicator_id"
  add_index "pppams_reviews", ["created_on"], :name => "index_pppams_reviews_on_created_on"
  add_index "pppams_reviews", ["created_on", "pppams_indicator_id"], :name => "index_pppams_reviews_on_created_on_and_pppams_indicator_id"

  create_table "prompts", :force => true do |t|
    t.column "question",      :string
    t.column "description",   :text
    t.column "context_id",    :integer
    t.column "used_in_total", :integer
    t.column "active",        :integer
  end

  add_index "prompts", ["context_id", "used_in_total"], :name => "context_used_in_total"

  create_table "sessions", :force => true do |t|
    t.column "session_id", :string
    t.column "data",       :text
    t.column "updated_at", :datetime
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "uploads", :force => true do |t|
    t.column "pppams_review_id", :integer
    t.column "size",             :integer
    t.column "file_type",        :string
    t.column "name",             :string
    t.column "created_on",       :datetime
    t.column "updated_on",       :datetime
    t.column "created_by",       :integer
  end

  add_index "uploads", ["created_by", "pppams_review_id"], :name => "created_by_pppams_review_id"

  create_table "user_types", :force => true do |t|
    t.column "user_type",       :string
    t.column "description",     :text
    t.column "access_level_id", :integer
  end

  create_table "users", :force => true do |t|
    t.column "firstname",           :string
    t.column "lastname",            :string
    t.column "name",                :string
    t.column "email",               :string
    t.column "hashed_password",     :string
    t.column "salt",                :string
    t.column "user_type_id",        :integer
    t.column "facility_id",         :integer
    t.column "notify_method",       :string
    t.column "notify_digest_time",  :string
    t.column "password_reset_code", :string,  :limit => 40
  end

end
