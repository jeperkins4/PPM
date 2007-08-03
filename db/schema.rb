# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 18) do

  create_table "access_levels", :force => true do |t|
    t.column "access_level", :string
    t.column "description",  :text
  end

  create_table "action_types", :force => true do |t|
    t.column "action",      :string
    t.column "description", :text
  end

  create_table "custody_types", :force => true do |t|
    t.column "custody_type", :string
    t.column "description",  :text
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
    t.column "custody_type_id",  :integer
    t.column "warden",           :string
    t.column "contract_monitor", :string
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
    t.column "incident_date",             :date
    t.column "reported_date",             :date
    t.column "inspector_general",         :date
    t.column "description",               :text
    t.column "incident_type_id",          :integer
    t.column "facility_id",               :integer
    t.column "contract_monitor_notified", :date
    t.column "bureau_notified",           :date
    t.column "warden_notified",           :date
    t.column "investigation_completed",   :date
    t.column "action_type_id",            :integer
    t.column "incident_type_other",       :string
    t.column "incident_class_id",         :integer
  end

  create_table "inmates", :force => true do |t|
    t.column "facility_id",    :integer
    t.column "inmate_count",   :integer
    t.column "date_collected", :date
  end

  create_table "investigators", :force => true do |t|
    t.column "firstname",   :string
    t.column "lastname",    :string
    t.column "phone",       :string
    t.column "email",       :string
    t.column "entity",      :string
    t.column "facility_id", :integer
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
