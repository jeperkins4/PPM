class CreatePppamsReferences < ActiveRecord::Migration
  def change
    create_table :pppams_references do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
