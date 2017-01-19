class AddExcerptAndPullquoteToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :excerpt, :text
    add_column :articles, :pullquote, :text
    add_column :archives, :pullquote, :text
  end
end
