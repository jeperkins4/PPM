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
  end

  def self.down
    drop_table :accountability_log_details
  end
end
