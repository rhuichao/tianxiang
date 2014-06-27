 #encoding: UTF-8

class WithdrawsController < ApplicationController

  def index
    search_by_year(Time.now.year.to_s)
  end

  def search
    search_by_year(params[:year])
    render "index"
  end

  def new
    @employees = Employee.all
    now = Time.now
    @year = now.year
    @month = now.mon - 1
    a = Attendance.order("date DESC").first
    b = Bonus.order("date DESC").first
    date = a.nil? ? nil : a.date
    bonus = b.nil? ? 0 : b.month
    work_day = WorkDay.where("date = ?", date).first
    days = work_day.nil? ? 0 : work_day.total

    attendances = {}
    Attendance.find_all_by_date(date).each do |e|
      attendances[e.employee_id] = e.work_time
    end

    @bonus = {}
    @employees.each do |e| 
      @bonus[e.id] = attendances[e.id] < days ? 0 : bonus
    end
  end

  def create
    @date = Time.local(params[:year], params[:month])
    @withdraws = params[:withdraws]
    @withdraws.each do |it|
      @employee = Employee.find(it[:employee_id])
      Withdraw.create(date: @date, amount: it[:amount], month_bonus: it[:bonus], employee: @employee)
    end
    redirect_to(withdraws_url, :notice => "#{params[:year]}年#{params[:month]}月费用支取信息创建成功.")
  end

  def edit
    @year = params[:year]
    @month = params[:month]   
    @date = Time.local(params[:year], params[:month])
    @withdraws = Withdraw.find_all_by_date(@date)
    if @withdraws.size > 0
      @employees = Employee.all
      @employee_withdraws = Hash.new
      @withdraws.each do |it|
        employee_id = it.employee.id
        @employee_withdraws[employee_id] = it
      end
    else
      redirect_to(withdraws_url, :notice => "#{@year}年#{@month}月费用支取信息未创建.")
    end
  end

  def update
    @date = Time.local(params[:year], params[:month])
    @withdraws = Withdraw.find_all_by_date(@date)
    @withdraws_param = params[:withdraws]
    @withdraws_param.each do |it|
      id = it[:id]
      amount = it[:amount]
      if id.empty?
        @employee = Employee.find(it[:employee_id])
        Withdraw.create(date: @date, amount: amount, month_bonus: it[:bonus], employee: @employee)
      else
        index = @withdraws.index {|o| o.id == id.to_i }
        withdraw = @withdraws[index]
        if withdraw.amount.to_s != amount || withdraw.month_bonus.to_s != it[:bonus]
          withdraw.update_attributes(amount: amount, month_bonus: it[:bonus])
        end
      end
    end
    redirect_to(withdraws_url, :notice => "#{params[:year]}年#{params[:month]}月费用支取信息更新成功.")
  end

private
  def set_nav
    @nav_withdraw = "active"
  end

  def search_by_year(year)
    @year = year
    @months = [1,2,3,4,5,6,7,8,9,10,11,12]
    if !@year.nil? && !@year.empty?
      start_time = Time.local(@year.to_i)
      end_time = Time.local(start_time.year+1)
      @withdraws = Withdraw.where(date: start_time.midnight..end_time.midnight)
      @employees = []
      if @withdraws.size > 0
        @employees = Employee.all
        @employee_withdraws = Hash.new
        @months = []
      end
      @withdraws.each do |it|
        employee_id = it.employee.id
        if @employee_withdraws[employee_id].nil?
          @employee_withdraws[employee_id] = Array.new(12)
        end
        date = it.date
        month = it.date.mon
        @employee_withdraws[employee_id][month-1] = it.amount + it.month_bonus
        @months << month if !@months.include?(month)
      end
      @months.sort!
    end    
    
  end
end
