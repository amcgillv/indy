class AddIsArchiveToAdminMapLocations < ActiveRecord::Migration
  def change
    add_column :admin_map_locations, :is_archive, :boolean
  end
end
