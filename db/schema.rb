# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120911143305) do

  create_table "access_levels", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "accountability_log_details", :force => true do |t|
    t.integer  "facility_id"
    t.integer  "context_id"
    t.text     "detail_response"
    t.integer  "log_year"
    t.integer  "log_month"
    t.datetime "logged_at"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "accountability_logs", :force => true do |t|
    t.integer  "facility_id"
    t.integer  "context_id"
    t.integer  "prompt_id"
    t.decimal  "response",    :precision => 55, :scale => 3
    t.integer  "log_year"
    t.integer  "log_month"
    t.datetime "logged_at"
    t.integer  "user_id"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  create_table "action_types", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "contexts", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "position"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "shortname"
  end

  create_table "custody_types", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "custody_types_facilities", :id => false, :force => true do |t|
    t.integer "custody_type_id", :null => false
    t.integer "facility_id",     :null => false
  end

  create_table "employee_position_histories", :force => true do |t|
    t.integer  "position_number_id"
    t.integer  "employee_id"
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "salary",             :precision => 10, :scale => 2
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  create_table "employees", :force => true do |t|
    t.integer  "facility_id"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "emplid"
    t.boolean  "active"
    t.string   "tea_status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "facilities", :force => true do |t|
    t.string   "name"
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
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "follow_ups", :force => true do |t|
    t.string   "comment"
    t.date     "commented_at"
    t.integer  "incident_id"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "incident_classes", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "incident_investigators", :force => true do |t|
    t.integer  "investigator_id"
    t.integer  "incident_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "incident_types", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "incidents", :force => true do |t|
    t.date     "incident_on"
    t.date     "reported_on"
    t.date     "inspector_general_on"
    t.text     "description"
    t.integer  "incident_type_id"
    t.integer  "facility_id"
    t.date     "contract_manager_notified_on"
    t.date     "bureau_notified_on"
    t.date     "warden_notified_on"
    t.date     "facility_investigation_completed_on"
    t.integer  "action_type_id"
    t.string   "incident_type_other"
    t.integer  "incident_class_id"
    t.integer  "investigator_id"
    t.string   "mins"
    t.string   "action_type_other"
    t.string   "designee_name"
    t.boolean  "contract_manager_notified"
    t.integer  "warden_notified"
    t.boolean  "bureau_notified"
    t.boolean  "facility_investigation_complete"
    t.boolean  "investigation_closed"
    t.date     "investigation_closed_on"
    t.string   "entity_closing"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  create_table "inmate_counts", :force => true do |t|
    t.integer  "facility_id"
    t.integer  "inmate_count"
    t.datetime "collected_on"
    t.integer  "custody_type_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "investigators", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "phone"
    t.string   "email"
    t.string   "entity"
    t.integer  "facility_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "non_comp_follow_ups", :force => true do |t|
    t.text     "comment"
    t.integer  "non_comp_issue_id"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "non_comp_issues", :force => true do |t|
    t.integer  "facility_id"
    t.integer  "nci_status"
    t.string   "details"
    t.string   "requirement"
    t.date     "discovered_on"
    t.date     "notified_on"
    t.date     "cap_due_on"
    t.date     "cap_review_on"
    t.date     "resolved_on"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.text     "notes"
    t.string   "issue_number"
    t.text     "conclusion"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "notification_receivers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "facility_id"
    t.string   "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "notification_reports", :force => true do |t|
    t.integer  "user_id"
    t.integer  "facility_id"
    t.integer  "eom_offset"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "notifications", :force => true do |t|
    t.string   "recipient"
    t.string   "sender"
    t.string   "subject"
    t.string   "message"
    t.string   "status"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "position_histories", :force => true do |t|
    t.integer  "position_id"
    t.decimal  "salary",      :precision => 10, :scale => 2
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  create_table "position_numbers", :force => true do |t|
    t.integer  "position_id"
    t.string   "position_num"
    t.integer  "position_type_id"
    t.date     "waiver_approval_date"
    t.boolean  "active"
    t.date     "inactive_on"
    t.string   "inactive_comment"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "position_types", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "deductable"
    t.integer  "deduction_days"
    t.integer  "facility_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "positions", :force => true do |t|
    t.string   "title"
    t.integer  "position_type_id"
    t.decimal  "salary",           :precision => 10, :scale => 2
    t.string   "description"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  create_table "pppams_category_base_refs", :force => true do |t|
    t.string   "name"
    t.integer  "pppams_category_group_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "pppams_category_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pppams_indicator_base_refs", :force => true do |t|
    t.string   "question"
    t.integer  "pppams_category_base_ref_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "pppams_indicators", :force => true do |t|
    t.integer  "frequency"
    t.integer  "start_month"
    t.string   "good_months"
    t.integer  "pppams_indicator_base_ref_id"
    t.date     "inactive_on"
    t.integer  "facility_id"
    t.date     "active_on"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "pppams_issue_follow_ups", :force => true do |t|
    t.text     "comment"
    t.integer  "pppams_issue_id"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "pppams_issues", :force => true do |t|
    t.string   "pppams_issue_number"
    t.integer  "pppams_issue_status"
    t.string   "receiver"
    t.date     "received_on"
    t.integer  "facility_id"
    t.string   "reported_by"
    t.string   "inmate_details"
    t.string   "inmate_id"
    t.string   "description"
    t.date     "cm_response_due_on"
    t.date     "cm_response_on"
    t.date     "resolved_on"
    t.string   "category"
    t.integer  "pppams_issue_id"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "pppams_references", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pppams_report_filters", :force => true do |t|
    t.string   "name"
    t.datetime "start_on"
    t.datetime "end_on"
    t.string   "report_type"
    t.string   "facility_filter"
    t.string   "status_filter"
    t.string   "category_filter"
    t.string   "indicator_filter"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.string   "score_filter"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "pppams_reviews", :force => true do |t|
    t.integer  "pppams_indicator_id"
    t.integer  "doc_count"
    t.integer  "score"
    t.string   "observation_ref"
    t.string   "documentation_ref"
    t.string   "interview_ref"
    t.string   "status"
    t.text     "notes"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "submit_count"
    t.datetime "real_creation_on"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "prompts", :force => true do |t|
    t.string   "question"
    t.string   "description"
    t.integer  "context_id"
    t.boolean  "used_in_total"
    t.boolean  "active"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id"
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "uploads", :force => true do |t|
    t.integer  "uploadable_id"
    t.string   "uploadable_type"
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "user_types", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "access_level_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "username"
    t.integer  "facility_id"
    t.integer  "user_type_id"
    t.datetime "inactive_on"
    t.string   "inactive_comment"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
end
