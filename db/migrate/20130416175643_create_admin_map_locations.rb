class CreateAdminMapLocations < ActiveRecord::Migration
  def change
    create_table :admin_map_locations do |t|
      t.decimal :lat
      t.decimal :lng
      t.text :content

      t.timestamps
    end
  end
end
