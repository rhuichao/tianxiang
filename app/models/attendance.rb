class Attendance < ActiveRecord::Base
  attr_accessible :date, :work_time

  belongs_to :employee
end
