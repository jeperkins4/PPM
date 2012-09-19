class ModifyContextAddShortname < ActiveRecord::Migration
  def up
    add_column :contexts, :shortname, :string
  end

  def down
  end
end
