class CreateThelists < ActiveRecord::Migration
  def change
    create_table :thelists do |t|

      t.timestamps
    end
  end
end
