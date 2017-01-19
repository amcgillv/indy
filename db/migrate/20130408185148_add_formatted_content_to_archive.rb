class AddFormattedContentToArchive < ActiveRecord::Migration
  def change
    add_column :archives, :formatted_content, :text
  end
end
