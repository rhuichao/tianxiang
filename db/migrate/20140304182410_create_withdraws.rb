class CreateWithdraws < ActiveRecord::Migration
  def change
    create_table :withdraws do |t|
      t.integer :employee_id
      t.datetime :date
      t.integer :amount
      t.timestamps
    end
  end
end