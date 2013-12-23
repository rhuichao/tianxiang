class Employee < ActiveRecord::Base
  attr_accessible :address, :birth_date, :fax, :id_card, :join_date, :mobile, :name, :resign_date, :telephone

  has_many :attendances
  has_many :salarys
  belongs_to :worktype
end
