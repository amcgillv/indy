class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :by
      t.text :body
      t.string :title
      t.datetime :published_at
      t.string :category
      t.string :tags
      t.text :promo

      t.timestamps
    end
  end
end
