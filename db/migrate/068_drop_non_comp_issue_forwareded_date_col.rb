class DropNonCompIssueForwarededDateCol < ActiveRecord::Migration
  def self.up
      remove_column :non_comp_issues, :cap_forwarded_date
  end

  def self.down
      add_column :non_comp_issues, :cap_forwarded_date, :date
  end
end
