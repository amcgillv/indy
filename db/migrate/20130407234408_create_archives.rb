class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|
      t.string :title
      t.string :link
      t.integer :wp_post_id
      t.datetime :wp_post_date
      t.text :content
      t.string :creator
      t.string :status
      t.string :category
      t.string :author
      t.text :excerpt
      t.string :post_type

      t.timestamps
    end
  end
end
