class AddScoreColToReportsFilter < ActiveRecord::Migration
  def self.up
    add_column :pppams_report_filters, :score_filter, :text
    add_column :non_comp_issues, :issue_number, :string
  end

  def self.down
    remove_column :pppams_report_filters, :score_filter
    remove_column :non_comp_issues, :issue_number
  end
end
