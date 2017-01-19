class AddAddressAndArticleIdToMapLocation < ActiveRecord::Migration
  def change
    add_column :admin_map_locations, :address, :string
    add_column :admin_map_locations, :article_id, :integer
  end
end
