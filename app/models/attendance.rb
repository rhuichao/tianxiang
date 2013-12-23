class Attendance < ActiveRecord::Base
  attr_accessible :absent_reason, :date, :work_time

  belongs_to :employee
end
