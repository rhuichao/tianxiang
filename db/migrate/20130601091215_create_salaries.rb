class CreateSalaries < ActiveRecord::Migration
  def change
    create_table :salaries do |t|
      t.datetime :date
      t.integer :total_work_time
      t.integer :bonus
      t.integer :pay
      t.integer :employee_id
      t.timestamps
    end
  end
end
