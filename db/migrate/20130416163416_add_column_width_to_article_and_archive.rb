class AddColumnWidthToArticleAndArchive < ActiveRecord::Migration
  def change
    add_column :archives, :column_width, :integer, :default => 1
    add_column :articles, :column_width, :integer, :default => 1
  end
end
