class AddColumnStatusToEmployees < ActiveRecord::Migration
  def up
    add_column :employees, :status, :integer, :default => 1
  end

  def down
    remove_column :employees, :status
  end
end
