# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 39) do

  create_table "access_levels", :force => true do |t|
    t.column "access_level", :string
    t.column "description",  :text
  end

  create_table "accountability_logs", :force => true do |t|
    t.column "facility_id", :integer
    t.column "context_id",  :integer
    t.column "prompt_id",   :integer
    t.column "response",    :string
    t.column "log_year",    :integer
    t.column "log_month",   :integer
    t.column "created_on",  :date
    t.column "created_by",  :string
  end

  create_table "action_types", :force => true do |t|
    t.column "action",      :string
    t.column "description", :text
  end

  create_table "contexts", :force => true do |t|
    t.column "title",       :string
    t.column "description", :text
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
  end

  create_table "facilities", :force => true do |t|
    t.column "facility",         :string
    t.column "shortname",        :string
    t.column "address1",         :string
    t.column "address2",         :string
    t.column "city",             :string
    t.column "state",            :string
    t.column "zip",              :string
    t.column "phone",            :string
    t.column "warden",           :string
    t.column "contract_monitor", :string
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
  end

  create_table "positions", :force => true do |t|
    t.column "title",            :string
    t.column "position_type_id", :integer
    t.column "salary",           :decimal, :precision => 10, :scale => 2
    t.column "description",      :text
    t.column "facility_id",      :integer
  end

  create_table "prompts", :force => true do |t|
    t.column "question",      :string
    t.column "description",   :text
    t.column "context_id",    :integer
    t.column "used_in_total", :integer
    t.column "active",        :integer
  end

  create_table "sessions", :force => true do |t|
    t.column "session_id", :string
    t.column "data",       :text
    t.column "updated_at", :datetime
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "user_types", :force => true do |t|
    t.column "user_type",       :string
    t.column "description",     :text
    t.column "access_level_id", :integer
  end

  create_table "users", :force => true do |t|
    t.column "firstname",       :string
    t.column "lastname",        :string
    t.column "name",            :string
    t.column "email",           :string
    t.column "hashed_password", :string
    t.column "salt",            :string
    t.column "user_type_id",    :integer
    t.column "facility_id",     :integer
  end

end
