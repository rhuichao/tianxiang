 #encoding: UTF-8

class SummaryController < ApplicationController

  def index
    @employees = []
  end
  
  def search
    @start_date = Time.parse(params[:start_date])
    @end_date = Time.parse(params[:end_date])
    @employees = Employee.all
    @summary = {}
    @total = Hash.new(0)

    salary = Salary.order("date").last
    if !salary.nil?
      date = salary.date
      salaries = get_salaries(date)
      full_work_days = get_full_work_days(@start_date, @end_date)
      actual_work_days = get_actual_work_days(@start_date, @end_date)
      year_bonus = get_year_bonus(date)
      withdraws = get_withdraws(@start_date, @end_date)

      salaries.each_key do |key|
        id = key
        @summary[id] = Hash.new(0)
        @summary[id]["工资标准"] = get_val(salaries[id])
        @summary[id]["全年工作日"] = full_work_days
        @summary[id]["实际工作日"] = get_val(actual_work_days[id])
        @summary[id]["实际工资"] = @summary[id]["工资标准"] * @summary[id]["实际工作日"] / @summary[id]["全年工作日"]
        @summary[id]["满勤奖"] = get_val(withdraws[id]["bonus"]) if !withdraws[id].nil?
        @summary[id]["年终奖"] = get_val(year_bonus) if (@summary[id]["全年工作日"] == @summary[id]["实际工作日"])
        @summary[id]["总计"] = @summary[id]["实际工资"] + @summary[id]["满勤奖"] + @summary[id]["年终奖"]
        @summary[id]["支取"] = get_val(withdraws[id]["amount"]) + @summary[id]["满勤奖"] if !withdraws[id].nil?
        @summary[id]["余额"] = @summary[id]["总计"] - @summary[id]["支取"]

        @total["工资标准"] += @summary[id]["工资标准"]
        @total["实际工资"] += @summary[id]["实际工资"]
        @total["满勤奖"] += @summary[id]["满勤奖"]
        @total["年终奖"] += @summary[id]["年终奖"]
        @total["总计"] += @summary[id]["总计"]
        @total["支取"] += @summary[id]["支取"]
        @total["余额"] += @summary[id]["余额"]
      end
    end
    @start_date = @start_date.strftime("%Y-%m-%d")
    @end_date = @end_date.strftime("%Y-%m-%d")
    render "index"
  end

private

  def get_val(val)
    return val.nil? ? 0 : val
  end

  def set_nav
    @nav_summary = "active"
  end

  def get_salaries(date)
    salaries = Salary.where("date = ?", date)
    result = {}
    salaries.each do |e|
      id = e.employee_id
      result[id] = get_val(e.total)
    end
    return result
  end

  def get_full_work_days(start_date, end_date)
    total = WorkDay.select("sum(total) as total") \
                  .where("date >= ? and date < ?", start_date,end_date).first.total
  end

  def get_actual_work_days(start_date, end_date)
    result = {}
    data = Attendance.select("employee_id as eid, sum(work_time) as total") \
                      .where("date >= ? and date < ?", start_date,end_date) \
                      .group("eid")
    data.each do |e|
      result[e.eid] =  get_val(e.total)
    end
    return result
  end

  def get_year_bonus(date)
    bonus = Bonus.where("date = ?", date).first
    bonus.nil? ? 0 : bonus.year
  end

  def get_withdraws(start_date, end_date)
    result = {}
    data = Withdraw.select("employee_id as eid, sum(amount) as amount, sum(month_bonus) as bonus") \
                      .where("date >= ? and date < ?", start_date,end_date) \
                      .group("eid")
    data.each do |e|
      result[e.eid] = {}
      result[e.eid]["bonus"] = get_val(e.bonus)
      result[e.eid]["amount"] = get_val(e.amount)
    end
    return result
  end
end