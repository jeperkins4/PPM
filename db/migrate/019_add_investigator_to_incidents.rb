class AddInvestigatorToIncidents < ActiveRecord::Migration
  def self.up
    add_column :incidents, :investigator_id, :integer
  end

  def self.down
    remove_column :incidents, :investigator_id
  end
end
