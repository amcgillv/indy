class AddFirstImageUrlToArticleAndArchive < ActiveRecord::Migration
  def change
    add_column :articles, :first_image_url, :string
    add_column :archives, :first_image_url, :string
  end
end
