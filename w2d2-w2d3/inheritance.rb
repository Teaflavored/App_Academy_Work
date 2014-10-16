class Employee
  attr_reader :boss, :salary
  
  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    
    add_to_manager(@boss) unless @boss.nil?

  end
  
  def add_to_manager(manager)
    manager.employees << self 
  end
    
  def bonus(multiplier)
    @salary * multiplier
  end
  
end


class Manager < Employee
  attr_reader :employees, :salary
  
  def initialize(name, title, salary, boss = nil)
    super(name, title, salary, boss)
    @employees = []
  end
  
  def bonus(multiplier)
    employee_total_salary * multiplier
  end
  
  def employee_total_salary
    
    total_money = 0
    @employees.each do |employee|
      if employee.is_a?(Manager)
        total_money += employee.employee_total_salary
      end
      total_money += employee.salary
    end
    
    total_money
  end
  
end



b = Manager.new("b","b", 2000, nil)

a = Employee.new("a", "a", 1500, b)
c = Manager.new("c", "c", 3030, b)
d = Employee.new("d", "d", 4006, c)
p b.employee_total_salary


