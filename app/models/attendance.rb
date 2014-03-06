class Attendance < ActiveRecord::Base
  attr_accessible :date, :work_time, :employee

  belongs_to :employee
end
