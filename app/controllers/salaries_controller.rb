 #encoding: UTF-8

class SalariesController < ApplicationController

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
  end

  def create
    @year = params[:year]
    if(!@year.nil? && !@year.empty?)
      @date = Time.local(params[:year])
      count = Salary.where(date: @date).count
      if(count == 0)
        @salaries = params[:salaries]
        @salaries.each do |it|
          @employee = Employee.find(it[:employee_id])
          Salary.create(date: @date, total: it[:total], employee: @employee)
        end
        Bonus.create(date: @date, month: params[:month_bonus], year: params[:year_bonus])
        redirect_to(salaries_url, :notice => "#{params[:year]}年员工薪水信息创建成功.")
      else
        redirect_to(salaries_url, :alert => "创建失败, #{@year}年份的数据已经存在.")
      end
    else
      redirect_to(salaries_url, :alert => "创建失败, 年份格式不正确.")
    end
  end

  def edit
    @year = params[:year]
    @date = Time.local(@year)
    @salaries = Salary.find_all_by_date(@date)
    @bonus = Bonus.find_by_date(@date)
    if @salaries.size > 0
      @employees = Employee.all
      @employee_salaries = Hash.new
      @salaries.each do |it|
        employee_id = it.employee.id
        @employee_salaries[employee_id] = it
      end
    else
      redirect_to(salaries_url, :alert => "#{@year}年员工薪水信息未创建.")
    end
  end

  def update
    @date = Time.local(params[:year])
    @salaries = Salary.find_all_by_date(@date)
    @salaries_param = params[:salaries]
    @salaries_param.each do |it|
      id = it[:id]
      total = it[:total]
      if id.empty?
        @employee = Employee.find(it[:employee_id])
        Salary.create(date: @date, total: total, employee: @employee)
      else
        index = @salaries.index {|o| o.id == id.to_i }
        salary = @salaries[index]
        salary.update_attributes(total: total) if salary.total.to_s != total
      end
    end
    @bonus = Bonus.find_by_date(@date)
    @bonus.update_attributes(month: params[:month_bonus], year: params[:year_bonus])
    redirect_to(salaries_url, :notice => "#{params[:year]}年员工薪水信息更新成功.")
  end

private
  def set_nav
    @nav_salary = "active"
  end

  def search_by_year(year_str)
    @year = year_str
    if @year.nil? || @year.empty?
      @year = Time.now.year.to_s
    end
    @years = @year.split(',')

    years = []
    @years.each do |o|
      years << Time.local(o.to_i)
    end
    @years.sort!

    @total_salaries = {}
    @salaries = Salary.where(date: years)
    @employees = []
    if @salaries.size > 0
      @employees = Employee.all
      @employee_salaries = Hash.new
    end
    @salaries.each do |it|
      employee_id = it.employee.id
      if @employee_salaries[employee_id].nil?
        @employee_salaries[employee_id] = Hash.new
      end
      year = it.date.year.to_s
      @employee_salaries[employee_id][year] = it.total

      if @total_salaries[year].nil?
        @total_salaries[year] = it.total
      else
        @total_salaries[year] += it.total
      end

    end


  end
end
