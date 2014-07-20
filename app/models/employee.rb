class Employee < ActiveRecord::Base
  attr_accessible :address, :birth_date, :fax, :id_card, \
      :join_date, :mobile, :name, :resign_date, :telephone, :status

  has_many :attendances
  has_many :withdraws
  has_many :salarys
  belongs_to :worktype

  DISABLE = 0
  ACTIVE = 1
  RESIGN = 2

  scope :active, where("status = #{ACTIVE}")
  scope :resign, where("status = #{RESIGN}")
  scope :all, where("status in (#{RESIGN},#{ACTIVE})").order("status")
  
  def resigned?
    return status == RESIGN 
  end
end
