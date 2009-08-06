class CreateAccountabilityLogs < ActiveRecord::Migration
  def self.up
    create_table :accountability_logs do |t|
      t.column :facility_id, :integer
      t.column :context_id,  :integer
      t.column :prompt_id,   :integer
      t.column :response,    :decimal, :precision => 55, :scale => 3
      t.column :log_year,    :integer
      t.column :log_month,   :integer
      t.column :created_on,  :date
      t.column :created_by,  :string
    end
    add_index :accountability_logs, [:facility_id, :prompt_id, :log_year, :log_month], :name => 'facility_id'
    add_index :accountability_logs, [:facility_id, :log_month, :log_year, :prompt_id], :name => 'facil_month_year_prompt'
  end
  
  def self.down
    remove_index :accountability_logs, :name => 'facility_id'
    remove_index :accountability_logs, :name => 'facil_month_year_prompt'
    drop_table :accountability_logs
  end
end
