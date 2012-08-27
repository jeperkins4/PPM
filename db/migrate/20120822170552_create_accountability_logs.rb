class CreateAccountabilityLogs < ActiveRecord::Migration
  def change
    create_table :accountability_logs do |t|
      t.integer :facility_id
      t.integer :context_id
      t.integer :prompt_id
      t.decimal :response, :precision => 55, :scale => 3
      t.integer :log_year
      t.integer :log_month
      t.datetime :logged_at
      t.integer :user_id
      t.timestamps
    end
  end
end
