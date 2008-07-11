class AddSavedReportFilterTable < ActiveRecord::Migration
  def self.up
    create_table :pppams_report_filters do |t|
      t.column :name, :string
      t.column :start_date, :datetime
      t.column :end_date, :datetime
      t.column :report_type, :string
      t.column :facility_filter, :text
      t.column :status_filter, :text
      t.column :category_filter, :text
      t.column :indicator_filter, :text
      t.column :created_on, :timestamp
      t.column :updated_on, :timestamp
      t.column :created_by, :integer
      t.column :updated_by, :integer
    end
  end

  def self.down
    drop_table :pppams_report_filters
  end
end
