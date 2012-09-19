class AddConclusionToNonCompIssues < ActiveRecord::Migration
  def self.up
    add_column :non_comp_issues, :conclusion, :text
  end

  def self.down
    remove_column :non_comp_issues, :conclusion
  end
end
