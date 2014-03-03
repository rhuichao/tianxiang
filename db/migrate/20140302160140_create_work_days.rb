class CreateWorkDays < ActiveRecord::Migration
  def change
    create_table :work_days do |t|
      t.datetime :date
      t.float :total
      t.timestamps
    end
  end
end
