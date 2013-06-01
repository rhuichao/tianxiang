class Attendance < ActiveRecord::Base
  attr_accessible :absent_reason, :date, :work_time
end
