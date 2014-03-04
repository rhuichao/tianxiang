class CreateWithdraws < ActiveRecord::Migration
  def change
    create_table :withdraws do |t|
      t.datetime :date
      t.integer :amount
      t.timestamps
    end
  end
end