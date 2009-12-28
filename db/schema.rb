# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091228183157) do

  create_table "access_levels", :force => true do |t|
    t.string "access_level"
    t.text   "description"
  end

  create_table "accountability_log_details", :force => true do |t|
    t.integer "facility_id"
    t.integer "context_id"
    t.text    "detail_response"
    t.integer "log_year"
    t.integer "log_month"
    t.date    "created_on"
    t.string  "created_by"
  end

  add_index "accountability_log_details", ["context_id", "facility_id", "log_month", "log_year"], :name => "facil_prompt_year_month"
  add_index "accountability_log_details", ["facility_id"], :name => "facility_id"

  create_table "accountability_logs", :force => true do |t|
    t.integer "facility_id"
    t.integer "context_id"
    t.integer "prompt_id"
    t.decimal "response",    :precision => 55, :scale => 3
    t.integer "log_year"
    t.integer "log_month"
    t.date    "created_on"
    t.string  "created_by"
  end

  add_index "accountability_logs", ["facility_id", "log_month", "log_year", "prompt_id"], :name => "facil_month_year_prompt"
  add_index "accountability_logs", ["facility_id", "prompt_id", "log_year", "log_month"], :name => "facility_id"

  create_table "action_types", :force => true do |t|
    t.string "action"
    t.text   "description"
  end

  create_table "application_status_codes", :force => true do |t|
    t.string   "code"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "application_statuses", :force => true do |t|
    t.integer  "firm_id"
    t.integer  "application_status_code_id"
    t.integer  "deprecating_user_id"
    t.integer  "created_by_id"
    t.date     "application_in_at"
    t.date     "application_closed_at"
    t.date     "deprecated_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "application_statuses", ["application_status_code_id"], :name => "app_status_code"
  add_index "application_statuses", ["firm_id"], :name => "firm_id"

  create_table "assert_certs", :force => true do |t|
    t.integer  "firm_id"
    t.integer  "assertion_code_id"
    t.integer  "certification_code_id"
    t.integer  "status_qualifier_code_id"
    t.date     "effective_date"
    t.integer  "officer_id"
    t.date     "deprecated_date"
    t.integer  "deprecating_user_id"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assert_certs", ["assertion_code_id"], :name => "assertion_code_id"
  add_index "assert_certs", ["certification_code_id", "status_qualifier_code_id"], :name => "cert_status"
  add_index "assert_certs", ["certification_code_id"], :name => "certification_code_id"
  add_index "assert_certs", ["effective_date"], :name => "effective_date"
  add_index "assert_certs", ["firm_id"], :name => "firm_id"
  add_index "assert_certs", ["status_qualifier_code_id"], :name => "status_qualifier_code_id"

  create_table "assertion_codes", :force => true do |t|
    t.string  "code"
    t.string  "name"
    t.date    "deprecated_date"
    t.integer "deprecating_user"
    t.integer "used_for_selection"
    t.integer "assertion_type_id"
    t.integer "duration"
  end

  add_index "assertion_codes", ["code"], :name => "code"

  create_table "assertion_types", :force => true do |t|
    t.string "name", :limit => 50
    t.string "desc", :limit => 100
  end

  create_table "business_designation_codes", :force => true do |t|
    t.string   "code"
    t.string   "mfmp_code"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "business_designation_codes", ["description"], :name => "index_business_designation_codes_on_description"

  create_table "certification_codes", :force => true do |t|
    t.string   "code"
    t.text     "description"
    t.integer  "duration"
    t.date     "deprecated_date"
    t.integer  "deprecating_user_id"
    t.integer  "duration_period_code_id"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "certification_codes", ["code"], :name => "code"

  create_table "certifying_entities", :force => true do |t|
    t.string   "entity_name"
    t.string   "entity_description"
    t.boolean  "active_flag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certifying_informations", :force => true do |t|
    t.integer  "vendor_id"
    t.string   "owner"
    t.integer  "employees"
    t.decimal  "sales",               :precision => 10, :scale => 2
    t.decimal  "net_worth",           :precision => 10, :scale => 2
    t.date     "deprecated_date"
    t.integer  "deprecating_user_id"
    t.date     "created_at"
    t.integer  "created_by_id"
    t.datetime "updated_at"
    t.string   "osd_file_number"
    t.integer  "analyst_id"
    t.string   "specialty"
  end

  add_index "certifying_informations", ["analyst_id"], :name => "analyst_id"
  add_index "certifying_informations", ["vendor_id"], :name => "vendor_id"

  create_table "commodity_codes", :force => true do |t|
    t.string "code"
    t.text   "description"
  end

  add_index "commodity_codes", ["code"], :name => "index_commodity_codes_on_code"

  create_table "contexts", :force => true do |t|
    t.string  "title"
    t.text    "description"
    t.integer "position"
  end

  create_table "correspondences", :force => true do |t|
    t.integer  "firm_id"
    t.integer  "certification_id"
    t.integer  "certification_code_id"
    t.integer  "duration_period_code_id"
    t.integer  "prior_correspondence_id"
    t.integer  "incoming"
    t.integer  "duration"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "message_template_id"
    t.string   "subject"
    t.text     "body"
    t.date     "effective_date"
    t.datetime "built_at"
    t.datetime "sent_at"
    t.date     "expire_date"
    t.integer  "sent_by_id"
    t.boolean  "email"
  end

  add_index "correspondences", ["firm_id"], :name => "firm_id"
  add_index "correspondences", ["message_template_id"], :name => "message_template_id"

  create_table "county_codes", :force => true do |t|
    t.string "code"
    t.string "abbreviation"
    t.string "profiler_code"
    t.text   "description"
  end

  add_index "county_codes", ["code"], :name => "code"
  add_index "county_codes", ["profiler_code"], :name => "index_county_codes_on_profiler_code"

  create_table "custody_types", :force => true do |t|
    t.string "custody_type"
    t.text   "description"
  end

  create_table "directory_adv_vendors", :id => false, :force => true do |t|
    t.integer "firm_id"
    t.string  "id",              :limit => 273
    t.string  "tin_type"
    t.string  "tin"
    t.integer "tin_sequence"
    t.string  "company"
    t.string  "shortname"
    t.string  "contact"
    t.text    "address",         :limit => 2147483647
    t.string  "phone"
    t.string  "city"
    t.integer "county_code"
    t.binary  "minority_code",   :limit => 2147483647
    t.text    "minority_desc",   :limit => 2147483647
    t.string  "state"
    t.string  "zip"
    t.string  "email"
    t.string  "ci",              :limit => 1
    t.string  "commodity_num",   :limit => 6
    t.string  "commodity_descr", :limit => 80
  end

  add_index "directory_adv_vendors", ["commodity_num"], :name => "commnum"
  add_index "directory_adv_vendors", ["company"], :name => "company"
  add_index "directory_adv_vendors", ["county_code"], :name => "index_directory_adv_vendors_tmp_on_county_code"
  add_index "directory_adv_vendors", ["firm_id"], :name => "index_directory_adv_vendors_tmp_on_firm_id"
  add_index "directory_adv_vendors", ["id"], :name => "index_directory_adv_vendors_tmp_on_id"
  add_index "directory_adv_vendors", ["minority_code"], :name => "minority_code"
  add_index "directory_adv_vendors", ["shortname"], :name => "shortname"

  create_table "employee_position_hists", :force => true do |t|
    t.integer "position_number_id"
    t.integer "employee_id"
    t.date    "start_date"
    t.date    "end_date"
    t.decimal "salary",             :precision => 10, :scale => 2
    t.date    "create_date"
  end

  add_index "employee_position_hists", ["employee_id"], :name => "index_employee_position_hists_on_employee_id"
  add_index "employee_position_hists", ["position_number_id"], :name => "index_employee_position_hists_on_position_number_id"

  create_table "employee_positions", :force => true do |t|
    t.integer "position_number_id"
    t.integer "employee_id"
    t.date    "start_date"
    t.date    "end_date"
  end

  add_index "employee_positions", ["employee_id"], :name => "index_employee_positions_on_employee_id"
  add_index "employee_positions", ["position_number_id"], :name => "index_employee_positions_on_position_number_id"

  create_table "employees", :force => true do |t|
    t.integer "facility_id"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "emplid"
    t.integer "active"
    t.string  "tea_status"
  end

  create_table "facilities", :force => true do |t|
    t.string   "facility"
    t.string   "shortname"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "warden"
    t.string   "contract_monitor"
    t.datetime "pppams_started_on"
  end

  create_table "facility_custodies", :force => true do |t|
    t.integer "facility_id"
    t.integer "custody_type_id"
  end

  create_table "facility_custody_types", :force => true do |t|
    t.integer "facility_id"
    t.integer "custody_type_id"
  end

  create_table "follow_ups", :force => true do |t|
    t.text    "follow_up"
    t.date    "follow_up_date"
    t.integer "incident_id"
    t.string  "added_by"
  end

  create_table "incident_classes", :force => true do |t|
    t.string "incident_class"
    t.text   "description"
  end

  create_table "incident_investigators", :force => true do |t|
    t.integer "investigator_id"
    t.integer "incident_id"
  end

  create_table "incident_types", :force => true do |t|
    t.string "incident_type"
    t.text   "description"
  end

  create_table "incidents", :force => true do |t|
    t.date    "incident_date"
    t.date    "reported_date"
    t.date    "inspector_general"
    t.text    "description"
    t.integer "incident_type_id"
    t.integer "facility_id"
    t.date    "contract_manager_notified_date"
    t.date    "bureau_notified_date"
    t.date    "warden_notified_date"
    t.date    "facility_investigation_complete_date"
    t.integer "action_type_id"
    t.string  "incident_type_other"
    t.integer "incident_class_id"
    t.integer "investigator_id"
    t.string  "mins"
    t.string  "action_type_other"
    t.string  "designee_name"
    t.integer "contract_manager_notified"
    t.integer "warden_notified"
    t.integer "bureau_notified"
    t.integer "facility_investigation_complete"
    t.integer "investigation_closed"
    t.date    "investigation_closed_date"
    t.string  "entity_closing"
  end

  create_table "inmate_counts", :force => true do |t|
    t.integer "facility_id"
    t.integer "inmate_count"
    t.date    "date_collected"
    t.integer "custody_type_id"
  end

  create_table "investigators", :force => true do |t|
    t.string  "firstname"
    t.string  "lastname"
    t.string  "phone"
    t.string  "email"
    t.string  "entity"
    t.integer "facility_id"
  end

  create_table "non_comp_follow_ups", :force => true do |t|
    t.text    "follow_up"
    t.integer "non_comp_issue_id"
    t.date    "created_on"
    t.date    "updated_on"
    t.integer "created_by"
    t.integer "updated_by"
  end

  create_table "non_comp_issues", :force => true do |t|
    t.integer "facility_id"
    t.integer "nci_status"
    t.text    "details"
    t.text    "requirement"
    t.date    "discovery_date"
    t.date    "notification_date"
    t.date    "cap_due_date"
    t.date    "cap_review_date"
    t.date    "resolved_date"
    t.date    "created_on"
    t.date    "updated_on"
    t.integer "created_by"
    t.integer "updated_by"
    t.text    "notes"
    t.string  "issue_number"
  end

  create_table "notification_receivers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "facility_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notification_receivers", ["facility_id", "status"], :name => "index_notification_receivers_on_facility_id_and_status"
  add_index "notification_receivers", ["user_id", "status"], :name => "index_notification_receivers_on_user_id_and_status"

  create_table "notification_reports", :force => true do |t|
    t.integer  "user_id"
    t.integer  "facility_id"
    t.integer  "eom_offset"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notification_reports", ["facility_id", "eom_offset"], :name => "index_notification_reports_on_facility_id_and_eom_offset"
  add_index "notification_reports", ["user_id"], :name => "index_notification_reports_on_user_id"

  create_table "notifications", :force => true do |t|
    t.string   "to_email"
    t.string   "from_email"
    t.string   "subject"
    t.text     "body"
    t.string   "status"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["status"], :name => "index_notifications_on_status"

  create_table "position_hists", :force => true do |t|
    t.integer "position_id"
    t.decimal "salary",      :precision => 10, :scale => 2
    t.date    "create_date"
  end

  create_table "position_numbers", :force => true do |t|
    t.integer "position_id"
    t.string  "position_num"
    t.string  "position_type"
    t.date    "waiver_approval_date"
    t.date    "created_on"
    t.boolean "active_flag",          :default => true
    t.date    "inactive_on"
    t.string  "inactive_comment"
  end

  create_table "position_reports", :force => true do |t|
  end

  create_table "position_types", :force => true do |t|
    t.string  "position_type"
    t.text    "description"
    t.integer "deductable"
    t.integer "deduction_days"
    t.integer "facility_id"
  end

  create_table "positions", :force => true do |t|
    t.string  "title"
    t.integer "position_type_id"
    t.decimal "salary",           :precision => 10, :scale => 2
    t.text    "description"
  end

  create_table "pppams_categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "facility_id"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer  "pppams_category_base_ref_id"
  end

  add_index "pppams_categories", ["facility_id"], :name => "facility_id"

  create_table "pppams_category_base_refs", :force => true do |t|
    t.string   "name"
    t.integer  "pppams_category_group_id"
    t.datetime "inactive_on"
  end

  create_table "pppams_category_groups", :force => true do |t|
    t.string "name"
  end

  create_table "pppams_indicator_base_refs", :force => true do |t|
    t.text     "question"
    t.integer  "pppams_category_base_ref_id"
    t.datetime "inactive_on"
  end

  add_index "pppams_indicator_base_refs", ["pppams_category_base_ref_id"], :name => "pppams_cat_base_id"
  add_index "pppams_indicator_base_refs", ["question"], :name => "question"

  create_table "pppams_indicators", :force => true do |t|
    t.integer  "pppams_category_id"
    t.text     "question"
    t.integer  "frequency"
    t.integer  "start_month"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.string   "good_months"
    t.integer  "pppams_indicator_base_ref_id"
  end

  add_index "pppams_indicators", ["good_months"], :name => "good_months"
  add_index "pppams_indicators", ["pppams_category_id", "good_months"], :name => "category_good_months"
  add_index "pppams_indicators", ["pppams_category_id"], :name => "pppams_category_id"
  add_index "pppams_indicators", ["pppams_indicator_base_ref_id"], :name => "pppams_indicator_base_ref_id"

  create_table "pppams_indicators_pppams_references", :id => false, :force => true do |t|
    t.integer "pppams_indicator_id", :null => false
    t.integer "pppams_reference_id", :null => false
  end

  add_index "pppams_indicators_pppams_references", ["pppams_indicator_id", "pppams_reference_id"], :name => "indicator_reference"
  add_index "pppams_indicators_pppams_references", ["pppams_indicator_id"], :name => "pppams_indicator_id"
  add_index "pppams_indicators_pppams_references", ["pppams_reference_id"], :name => "pppams_reference_id"

  create_table "pppams_indicators_pppams_references_copy", :id => false, :force => true do |t|
    t.integer "pppams_indicator_id", :null => false
    t.integer "pppams_reference_id", :null => false
  end

  create_table "pppams_issue_follow_ups", :force => true do |t|
    t.text    "follow_up"
    t.integer "pppams_issue_id"
    t.date    "created_on"
    t.date    "updated_on"
    t.date    "created_by"
    t.date    "updated_by"
  end

  create_table "pppams_issues", :force => true do |t|
    t.string  "pppams_issue_number"
    t.integer "pppams_issue_status"
    t.string  "receiver"
    t.date    "received_date"
    t.integer "facility_id"
    t.text    "reported_by"
    t.text    "inmate_details"
    t.text    "inmate_id"
    t.text    "description"
    t.date    "CM_response_due_date"
    t.date    "CM_response_date"
    t.date    "resolved_date"
    t.date    "created_on"
    t.date    "updated_on"
    t.integer "created_by"
    t.integer "updated_by"
    t.string  "category"
  end

  create_table "pppams_references", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "pppams_report_filters", :force => true do |t|
    t.string   "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "report_type"
    t.text     "facility_filter"
    t.text     "status_filter"
    t.text     "category_filter"
    t.text     "indicator_filter"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.text     "score_filter"
  end

  create_table "pppams_reviews", :force => true do |t|
    t.integer  "pppams_indicator_id"
    t.integer  "doc_count"
    t.integer  "score"
    t.text     "observation_ref"
    t.text     "documentation_ref"
    t.text     "interview_ref"
    t.text     "evidence"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.string   "status"
    t.text     "notes"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.integer  "submit_count"
    t.datetime "real_creation_date"
  end

  add_index "pppams_reviews", ["created_on", "pppams_indicator_id"], :name => "created_on_pppams_indicator"
  add_index "pppams_reviews", ["created_on"], :name => "created_on"
  add_index "pppams_reviews", ["pppams_indicator_id"], :name => "pppams_indicator_id"

  create_table "prompts", :force => true do |t|
    t.string  "question"
    t.text    "description"
    t.integer "context_id"
    t.integer "used_in_total"
    t.integer "active"
  end

  add_index "prompts", ["context_id", "used_in_total"], :name => "context_used_in_total"
  add_index "prompts", ["question"], :name => "prompt_questions"

  create_table "schema_info", :id => false, :force => true do |t|
    t.integer "version"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id"
    t.text     "data",       :limit => 2147483647
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "uploads", :force => true do |t|
    t.integer  "pppams_review_id"
    t.integer  "size"
    t.string   "file_type"
    t.string   "name"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer  "created_by"
  end

  add_index "uploads", ["created_by", "pppams_review_id"], :name => "created_by_pppams_review_id"

  create_table "user_types", :force => true do |t|
    t.string  "user_type"
    t.text    "description"
    t.integer "access_level_id"
  end

  create_table "users", :force => true do |t|
    t.string  "firstname"
    t.string  "lastname"
    t.string  "name"
    t.string  "email"
    t.string  "hashed_password"
    t.string  "salt"
    t.integer "user_type_id"
    t.integer "facility_id"
    t.string  "notify_method"
    t.string  "notify_digest_time"
    t.string  "password_reset_code"
  end

end
