 #encoding: UTF-8

class AttendancesController < ApplicationController

  def index
    @nav_attendance = "active"
    @employees = Employee.all
  end

  def new
  	@nav_attendance = "active"
  	@employees = Employee.all
  end

	def create
		date = params[:date]
		total = params[:total]
		attendances = params[:attendances]
		attendances.each do |att|
			p att
		end
	end

	def edit
		@nav_attendance = "active"
		@employee = Employee.find(params[:id])
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