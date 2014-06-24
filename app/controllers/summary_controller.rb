 #encoding: UTF-8

class SummaryController < ApplicationController

  def index
    @employees = []
  end
  
  def search
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @employees = Employee.all
    @summary = {}
    date = Salary.order("date").last.date

    salaries = get_salaries(@employees, date)
    full_work_days = get_full_work_days(@employees, date)
    actual_work_days = get_actual_work_days(@employees, date)
    attendance_bonus = get_attendance_bonus(@employees, date)
    year_bonus = get_year_bonus(@employees, date)
    withdraws = get_withdraws(@employees, date)

    # @employees.each do |e|
    #   id = e.id
    #   @summary[id] = {}
    #   @summary[id]["工资标准"] = salaries[id]
    #   @summary[id]["全年工作日"] = full_work_days[id]
    #   @summary[id]["实际工作日"] = actual_work_days[id]
    #   @summary[id]["实际工资"] = @summary[id]["工资标准"] * @summary[id]["实际工作日"] / @summary[id]["全年工作日"]
    #   @summary[id]["满勤奖"] = attendance_bonus[id]
    #   @summary[id]["年终奖"] = year_bonus[id]
    #   @summary[id]["总计"] = @summary[id]["实际工资"] + @summary[id]["满勤奖"] + @summary[id]["年终奖"]
    #   @summary[id]["支取"] = withdraws[id]
    #   @summary[id]["余额"] = @summary[id]["总计"] - @summary[id]["支取"]
    # end

    render "index"
  end

private
  def set_nav
    @nav_summary = "active"
  end

  def get_salaries(employees, date)
    salaries = Salary.
  end

  def get_full_work_days(date)
    WorkDay.where("date = ?", date)
  end

  def get_actual_work_days(employees, date)
    
  end

  def get_attendance_bonus(employees, date)
    
  end

  def get_year_bonus(date)
    Bonus.where("date = ?", date)
  end

  def get_withdraws(employees, date)
    
  end
end