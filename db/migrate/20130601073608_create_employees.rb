class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.integer :id_card
      t.string :name
      t.datetime :join_date
      t.datetime :resign_date
      t.datetime :birth_date
      t.integer :mobile
      t.integer :telephone
      t.integer :fax
      t.string :address
      t.integer :work_type_id

      t.timestamps
    end
  end
end
