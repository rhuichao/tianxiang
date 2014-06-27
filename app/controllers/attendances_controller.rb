 #encoding: UTF-8

class AttendancesController < ApplicationController

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
    @month = now.month - 1
  end

	def create
		@date = Time.local(params[:year], params[:month])
    count = WorkDay.where(date: @date).count
    if(count == 0)
  		@total = params[:total]
  		@attendances = params[:attendances]
  		@attendances.each do |att|
  			@employee = Employee.find(att[:employee_id])
  			@attendance = Attendance.create(date: @date, work_time: att[:work_time], employee: @employee)
  		end

      WorkDay.create(date: @date, total: @total)
  		redirect_to(attendances_url, :notice => "#{params[:year]}年#{params[:month]}月考勤信息创建成功.")
    else
      redirect_to(attendances_url, :alert => "#{params[:year]}年#{params[:month]}月考勤信息已经存在.")
    end
	end

	def edit
		@year = params[:year]
		@month = params[:month]		
    @date = Time.local(params[:year], params[:month])
    @attendances = Attendance.find_all_by_date(@date)
  	if @attendances.size > 0
			@employees = Employee.all
	  	@employee_attendance = Hash.new
	    @attendances.each do |att|
	    	employee_id = att.employee.id
	    	@employee_attendance[employee_id] = att
	    end
      @total = WorkDay.find_by_date(@date).total
	  else
			redirect_to(attendances_url, :notice => "#{@month}月考勤信息不存在.")
  	end
	end

	def update
    @date = Time.local(params[:year], params[:month])
    @attendances = Attendance.find_all_by_date(@date)
    @total = params[:total]
    @attendances_param = params[:attendances]
    @attendances_param.each do |it|
      id = it[:id]
      work_time = it[:work_time]
      if id.empty?
        @employee = Employee.find(it[:employee_id])
        Attendance.create(date: @date, work_time: work_time, employee: @employee)
      else
        index = @attendances.index {|o| o.id == id.to_i }
        attendance = @attendances[index]
        p "#{attendance.work_time.to_s}, #{work_time}"
        attendance.update_attributes(work_time: work_time) if attendance.work_time.to_s != work_time
      end
    end

    work_day = WorkDay.find_by_date(@date)
    work_day.update_attributes(total: @total) if work_day.total.to_s != @total
    redirect_to(attendances_url, :notice => "#{params[:month]}月考勤信息更新成功.")
	end

private
  def set_nav
    @nav_attendance = "active"
  end

  def search_by_year(year)
    @year = year
    @months = [1,2,3,4,5,6,7,8,9,10,11,12]
    if !@year.nil? && !@year.empty?
      start_time = Time.local(@year.to_i)
      end_time = Time.local(start_time.year+1)
      @attendances = Attendance.where(date: start_time.midnight..end_time.midnight)
      @employees = []
      if @attendances.size > 0
        @employees = Employee.all
        @employee_attendance = Hash.new
        @months = []
        
        @full_work_days = WorkDay.where(date: start_time.midnight..end_time.midnight)
        @work_days = {}
        @full_work_days.each do |work_day|
          @work_days[work_day.date.mon] = work_day.total
        end
      end
      @attendances.each do |att|
        employee_id = att.employee.id
        if @employee_attendance[employee_id].nil?
          @employee_attendance[employee_id] = Array.new(12)
        end
        date = att.date
        month = att.date.mon
        @employee_attendance[employee_id][month-1] = att.work_time
        @months << month if !@months.include?(month)
      end
      @months.sort!
    end    
  end
end
