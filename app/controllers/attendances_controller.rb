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
		@date = Time.local(params[:year], params[:month],15) 
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
		redirect_to(attendances_url, :notice => "员工信息更新成功.")
	end

	def edit
		@nav_attendance = "active"
		@year = params[:year]
		@month = params[:month]
		start_date = Time.local(@year.to_i, @month.to_i)
	  end_date = Time.local(@year.to_i, start_date.mon + 1)
		
		@attendances = Attendance.where(date: start_date.midnight..end_date.midnight)
  	if @attendances.size > 0
			@employees = Employee.all
	  	@employee_attendance = Hash.new
	    @attendances.each do |att|
	    	employee_id = att.employee.id
	    	@employee_attendance[employee_id] = att.work_time
	    end
	  else
			redirect_to(attendances_url, :notice => "#{@month}月考勤不存在.")
  	end
	end

	def show
		@nav_attendance = "active"
		@employee = Employee.find(params[:id])
	end

	def update
		@employee = Employee.find(params[:id])
		if @employee.update_attributes(params[:employee])
			redirect_to(@employee, :notice => "员工信息更新成功.")
		else
			render :action => "edit"
		end
	end

	def destroy
	  @employee = Employee.find(params[:id])
	  @employee.destroy
	  respond_to do |format|
	    format.html { redirect_to employees_url }
	    format.json { head :no_content }
	  end
	end
end