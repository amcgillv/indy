class RemoveMaps < ActiveRecord::Migration
  def up
  	drop_table :admin_map_locations
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
