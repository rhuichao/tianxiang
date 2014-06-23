 #encoding: UTF-8

class SummaryController < ApplicationController

  def index
    @employees = Employee.all
  end


private
  def set_nav
    @nav_summary = "active"
  end

  def search
    
  end
end