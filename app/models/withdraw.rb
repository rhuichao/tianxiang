class Withdraw < ActiveRecord::Base
  attr_accessible :date, :amount, :employee

  belongs_to :employee
end
