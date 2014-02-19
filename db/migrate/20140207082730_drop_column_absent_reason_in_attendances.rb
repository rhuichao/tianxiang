class DropColumnAbsentReasonInAttendances < ActiveRecord::Migration
  def up
  	remove_column :attendances, :absent_reason
  end

  def down
  	remove_column :attendances, :absent_reason, :string
  end
end
