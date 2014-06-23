class DropColumnFromSalaries < ActiveRecord::Migration
  def up
    remove_column :salaries, :total_work_time
    remove_column :salaries, :pay
    remove_column :salaries, :bonus
  end

  def down
    add_column :salaries, :total_work_time, :integer
    add_column :salaries, :pay, :integer
    add_column :salaries, :bonus, :integer
  end
end
