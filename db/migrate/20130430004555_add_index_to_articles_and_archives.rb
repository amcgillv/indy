class AddIndexToArticlesAndArchives < ActiveRecord::Migration
  def change
    add_index :archives, :wp_post_date
    add_index :articles, :published_at
    add_index :issues, :date
    add_index :archives, :status
    add_index :articles, :published
  end
end
