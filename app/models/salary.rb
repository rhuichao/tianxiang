class Salary < ActiveRecord::Base
  attr_accessible :bonus, :date, :pay, :total_work_time

  belongs_to :employee
end
