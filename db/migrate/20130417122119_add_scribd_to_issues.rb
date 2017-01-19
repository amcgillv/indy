class AddScribdToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :scribd, :boolean, :default => false
  end
end
