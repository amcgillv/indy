class CreateAlums < ActiveRecord::Migration
  def change
    create_table :alums do |t|
      t.string :name
      t.string :email
      t.integer :grad_year
      t.string :staff_position
      t.string :job_now
      t.string :where_you_live

      t.timestamps
    end
  end
end
