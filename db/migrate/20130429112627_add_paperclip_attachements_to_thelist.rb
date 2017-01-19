class AddPaperclipAttachementsToThelist < ActiveRecord::Migration
    def up
      add_attachment :thelists, :image
      add_attachment :thelists, :title
    end
    def down
      remove_attachment :thelists, :image
      remove_attachment :thelists, :title
    end
end
