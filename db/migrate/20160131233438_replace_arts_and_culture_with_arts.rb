class ReplaceArtsAndCultureWithArts < ActiveRecord::Migration
  def up
  	# i am scared about running this
  	execute "UPDATE articles SET category = REPLACE(category, 'Arts & Culture', 'Arts')"
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
