class CreatePppamsReportFilters < ActiveRecord::Migration
  def change
    create_table :pppams_report_filters do |t|
      t.string :name
      t.datetime :start_on
      t.datetime :end_on
      t.string :report_type
      t.string :facility_filter
      t.string :status_filter
      t.string :category_filter
      t.string :indicator_filter
      t.integer :created_by_id
      t.integer :updated_by_id
      t.string :score_filter

      t.timestamps
    end
  end
end
