class CreateIncidentClasses < ActiveRecord::Migration
  def change
    create_table :incident_classes do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
