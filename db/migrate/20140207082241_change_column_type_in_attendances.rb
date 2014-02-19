class ChangeColumnTypeInAttendances < ActiveRecord::Migration
  def up
  	change_column :attendances, :work_time, :float
  end

  def down
  	change_column :attendances, :work_time, :int
  end
end
