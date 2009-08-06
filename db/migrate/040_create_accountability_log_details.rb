class CreateAccountabilityLogDetails < ActiveRecord::Migration
  def self.up
    create_table :accountability_log_details do |t|
      t.column :facility_id, :integer
      t.column :context_id, :integer
      t.column :detail_response, :text
      t.column :log_year, :integer
      t.column :log_month, :integer
      t.column :created_on, :date
      t.column :created_by, :string
    end
    add_index :accountability_log_details, :facility_id
    add_index :accountability_log_details, [:context_id, :facility_id, :log_month,:log_year], :name => 'facil_prompt_year_month'
  end

  def self.down
    remove_index :accountability_log_details, :facility_id
    remove_index :accountability_log_details, :name => 'facil_prompt_year_month'
    drop_table :accountability_log_details
  end
end
