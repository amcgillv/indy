class AddTagsAndSubtitleToArchive < ActiveRecord::Migration
  def change
    add_column :archives, :tags, :string
    add_column :archives, :subtitle, :string
  end
end
