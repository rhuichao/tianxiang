 #encoding: UTF-8

class EmployeesController < ApplicationController

  def index
    @employees = Employee.active
  end

  def index_resign
    @employees = Employee.resign
  end

  def new
  	@employee = Employee.new
  end

	def create
    last = Employee.last
    id_card = last.nil? ? 100001 : last.id + 100001
    @employee = Employee.new(params[:employee])
    @employee.id_card = id_card
    @employee.join_date = Time.now
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
    @employee.update_attributes(:status => Employee::DISABLE)
	  respond_to do |format|
	    format.html { redirect_to employees_url }
	    format.json { head :no_content }
	  end
	end

  def resign
    @employee = Employee.find(params[:id])
    @employee.update_attributes(:status => Employee::RESIGN, :resign_date => Time.now)
    redirect_to(employees_url, :notice => "员工离职成功.")
  end

  def entry
    @employee = Employee.find(params[:id])
    @employee.update_attributes(:status => Employee::ACTIVE, :join_date => Time.now)
    redirect_to(employee_index_resign_path, :notice => "员工重新入职成功.")
  end

private
  def set_nav
    @nav_employee = "active"
  end
end