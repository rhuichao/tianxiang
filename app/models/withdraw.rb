class Withdraw < ActiveRecord::Base
  attr_accessible :date, :amount, :employee, :month_bonus

  belongs_to :employee
end
