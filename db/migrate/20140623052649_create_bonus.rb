class CreateBonus < ActiveRecord::Migration
  def change
    create_table :bonus do |t|
      t.datetime :date
      t.integer :month
      t.integer :year
      t.timestamps
    end
  end
end
