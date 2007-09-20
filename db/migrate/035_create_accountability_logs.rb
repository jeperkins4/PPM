class CreateAccountabilityLogs < ActiveRecord::Migration
  def self.up
    create_table :accountability_logs do |t|
      t.column :facility_id, :integer
      t.column :context_id,  :integer
      t.column :prompt_id,   :integer
      t.column :response,    :string
      t.column :log_year,    :year
      t.column :log_month,   :date
    end
  end
  
  def self.down
    drop_table :accountability_log
  end
end
