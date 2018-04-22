require_relative 'csv'
require 'paint'

class Employee
  attr_accessor :last_name, :first_name, :salary
  def initialize(params)
    @last_name = params[:last_name]
    @first_name = params[:first_name]
    @salary = params[:salary] || "0"
  end
end

class Organization
  include Csv
  SPACE = 2
  TITLE_LAST = "Last"
  TITLE_FIRST = "First"
  TITLE_SALARY = "Salary"

  def initialize()
    @employees = []
    create_employees
  end

  def create_employees()
    array('salaries.csv').each{|employee| add_employee(Employee.new({last_name: employee[0], first_name: employee[1], salary: employee[2]})) }
  end

  def add_employee(employee)
    @employees << employee
  end

  def space_name(word,longest_word,space = SPACE)
   ((difference = longest_word.length - word.length) > 0 ? word + (" " * difference) + (" " * space) : word + (" " * space)) + "|"
  end

  def print()
    @employees = @employees.sort_by{|e| e.salary}.reverse

    max_last_name = @employees.max_by{|e| e.last_name.length}.last_name
    max_first_name = @employees.max_by{|e| e.first_name.length}.first_name

    last_names = @employees.map { |e|  space_name(e.last_name,max_last_name)  }
    first_names = @employees.map { |e|  space_name(e.first_name,max_first_name)  }
    salaries = @employees.map{|e| "$"+e.salary.gsub(/(\d)(?=(\d{3})+(?!\d))/, "\\1,") }

    max_salary = salaries.max_by{|salary| salary.length}

    title_last = space_name(TITLE_LAST,max_last_name)
    title_first = space_name(TITLE_FIRST,max_first_name)
    title_salary = space_name(TITLE_SALARY,max_salary,0)

    title = "#{title_last}#{title_first}#{title_salary}"
    puts title
    puts "-" * title.length
    @employees.length.times do |index|
      green_salary = Paint[salaries[index], :yellow]
      puts "#{last_names[index]}#{first_names[index]}#{green_salary}"
    end
  end

end


Organization.new.print

