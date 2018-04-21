require 'money'
def conver_csv_to_array(file)
  document = []
    while !file.eof? 
      line = file.readline.strip.split(',')
      document << line
    end 
  # p document
  return document
end 
  
class Employee
  attr_accessor :last_name, :first_name, :salary
  def initialize(params)
    @last_name = params[:last_name]
    @first_name = params[:first_name]
    @salary = params[:salary]
  end
end



class Employees

  def initialize()
    @employees = []
  end

  def add_employee(employee)
    @employees << employee
  end



  def print_salaries()


    max_last_name = @employees.max_by{|e| e.last_name.length}
    max_first_name = @employees.max_by{|e| e.first_name.length}
    max_salary = @employees.max_by{|e| e.salary.length}


    title_last = "Last" + (" " * 2) + (" " * (max_last_name.last_name.length - "Last".length))
    title_first = "First" + (" " * 2) + (" " * (max_first_name.first_name.length - "First".length))
    title_salary = "Salary"

    title = "#{title_last}#{title_first}#{title_salary}"
    puts title
    puts "-" * title.length
    @employees = @employees.sort_by{|e| e.salary}.reverse
    @employees.each do |e|

      last_name = e.last_name + (" " * 2) + (" " * (max_last_name.last_name.length - e.last_name.length))
      first_name = e.first_name + (" " * 2) + (" " * (max_first_name.first_name.length - e.first_name.length))
      salary = "$"+e.salary.gsub(/(\d)(?=(\d{3})+(?!\d))/, "\\1,")  

      puts "#{last_name}#{first_name}#{salary}"
    end
  end

end

def create_employees()
  file = File.new("salaries.csv")
  salaries = conver_csv_to_array(file)
  employees = Employees.new
  salaries.each do |salary|

    last = salary[0]
    first = salary[1]
    salary_number = salary[2]
    employees.add_employee(Employee.new({last_name: last, first_name: first, salary: salary_number}))
  end
  employees.print_salaries
end

create_employees

