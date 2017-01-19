class AddIssueIdToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :issue_id, :integer
  end
end
