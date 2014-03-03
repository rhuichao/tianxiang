 #encoding: UTF-8

class AttendancesController < ApplicationController

  def index
    @nav_attendance = "active"
    @months = Array.new(12)
  end

  def search
    @nav_attendance = "active"
    @year = params[:year]
    @months = Array.new(12)	
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
	  end
	  render "index"
  end

  def new
  	@nav_attendance = "active"
  	@employees = Employee.all
  end

	def create
		@date = Time.local(params[:year], params[:month], 15)
		@total = params[:total]
		@attendances = params[:attendances]
		@attendances.each do |att|
			@employee = Employee.find(att[:employee_id])
			@attendance = Attendance.new
			@attendance.date = @date
			@attendance.work_time = att[:work_time]
			@attendance.employee = @employee
			@attendance.save
		end

    WorkDay.create(date: @date, total: @total)
		redirect_to(attendances_url, :notice => "#{params[:month]}月考勤信息创建成功.")
	end

	def edit
		@nav_attendance = "active"
		@year = params[:year]
		@month = params[:month]		
    @date = Time.local(params[:year], params[:month], 15)
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
    @date = Time.local(params[:year], params[:month], 15)
    @attendances = Attendance.find_all_by_date(@date)
    @total = params[:total]
    @attendances_param = params[:attendances]
    @attendances.each do |att|
      id = att.id
      index = @attendances_param.index {|o| o[:id].to_i == id }
      att.update_attributes(work_time: @attendances_param[index][:work_time])
    end

    WorkDay.find_by_date(@date).update_attributes(total: @total)
    redirect_to(attendances_url, :notice => "#{params[:month]}月考勤信息更新成功.")
	end


end
