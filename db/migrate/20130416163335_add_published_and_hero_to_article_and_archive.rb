class AddPublishedAndHeroToArticleAndArchive < ActiveRecord::Migration
  def change
    add_column :articles, :published, :boolean, :default => false
    add_column :articles, :has_hero, :boolean, :default => false
  end
end
