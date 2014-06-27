class AddColumnToWithdraws < ActiveRecord::Migration
  def up
    add_column :withdraws, :month_bonus, :integer
  end

  def down
    remove_column :withdraws, :month_bonus
  end
end
