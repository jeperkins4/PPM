class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.string :name
      t.string :shortname
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :warden
      t.string :contract_monitor
      t.datetime :pppams_started_on

      t.timestamps
    end
  end
end
