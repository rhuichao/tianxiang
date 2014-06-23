class DropColumnAbsentReasonInAttendances < ActiveRecord::Migration
  def up
  	remove_column :attendances, :absent_reason
  end

  def down
  	add_column :attendances, :absent_reason, :string
  end
end
