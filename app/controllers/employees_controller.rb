 #encoding: UTF-8

class EmployeesController < ApplicationController

  def index
    @employees = Employee.all
  end

  def new
  	@employee = Employee.new
  end

	def create
		@employee = Employee.new(params[:employee])
		if @employee.save
			redirect_to(@employee, :notice => "新建员工成功")
		else
			render :action => "new"
		end
	end

	def edit
		@employee = Employee.find(params[:id])
	end

	def show
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

private
  def set_nav
    @nav_employee = "active"
  end
end