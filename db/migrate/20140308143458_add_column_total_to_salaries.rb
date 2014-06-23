class AddColumnTotalToSalaries < ActiveRecord::Migration
  def up
    add_column :salaries, :total, :integer
  end

  def down
    remove_column :salaries, :total
  end
end
