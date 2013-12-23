class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.datetime :date
      t.integer :work_time
      t.string :absent_reason
      t.integer :employee_id
      t.timestamps
    end
  end
end
