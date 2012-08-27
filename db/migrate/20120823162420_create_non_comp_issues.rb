class CreateNonCompIssues < ActiveRecord::Migration
  def change
    create_table :non_comp_issues do |t|
      t.integer :facility_id
      t.integer :nci_status
      t.string :details
      t.string :requirement
      t.date :discovered_on
      t.date :notified_on
      t.date :cap_due_on
      t.date :cap_review_on
      t.date :resolved_on
      t.integer :created_by_id
      t.integer :updated_by_id
      t.text :notes
      t.string :issue_number
      t.text :conclusion

      t.timestamps
    end
  end
end
