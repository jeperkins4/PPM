class CreateAccountabilityLogDetails < ActiveRecord::Migration
  def change
    create_table :accountability_log_details do |t|
      t.integer :facility_id
      t.integer :context_id
      t.text :detail_response
      t.integer :log_year
      t.integer :log_month
      t.datetime :logged_at
      t.integer :user_id

      t.timestamps
    end
  end
end
