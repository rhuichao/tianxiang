class WorkType < ActiveRecord::Base
  attr_accessible :name

  has_many :employee
end
