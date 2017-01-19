class AddHeroCaptionHeroXAndHeroYToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :hero_caption, :string
    add_column :articles, :hero_x, :decimal
    add_column :articles, :hero_y, :decimal
  end
end