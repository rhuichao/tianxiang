class Salary < ActiveRecord::Base
  attr_accessible :date, :total, :employee

  belongs_to :employee
end
