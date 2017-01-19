class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :title
      t.date :date
      t.string :document_number
      t.string :url_slug
      t.boolean :published

      t.timestamps
    end
  end
end
