class AddIllustatorsToArchiveAndArticles < ActiveRecord::Migration
  def change
    add_column :archives, :illustrator, :string
    add_column :articles, :illustrator, :string
  end
end