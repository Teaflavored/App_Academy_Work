class Student
  
  attr_reader :first_name, :last_name, :courses
  
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = []
  end
  
  
  def enroll(new_course)
    unless courses.include?(new_course) || self.has_conflict?(new_course)
      courses << new_course
      new_course.list_of_students << self
      puts "succesfully enrolled in #{new_course}"
    else
      puts "You are already either enrolled or there's a conflict"
    end
  end
  
  def course_load
    return_hash = Hash.new(0)
    
    courses.each do |course|
      return_hash[course.dept] += course.credits
    end
    
    return_hash
  end
  
  def has_conflict?(new_course)
    courses.each do |course|
      return true if course.conflicts_with?(new_course)
    end
    false
  end
  
end

class Course
  attr_reader :course_name, :dept, :credits, :list_of_students, :block, :set_of_days
  
  def initialize(course_name, dept, credits, time_block, set_of_days )
    @course_name = course_name
    @dept = dept
    @credits = credits
    @list_of_students = []
    @block = time_block
    @set_of_days = set_of_days
  end
  
  def students
    list_of_students
  end
  
  def conflicts_with?(course2)
    return false if block != course2.block
    set_of_days.each do |day|
      return true if course2.set_of_days.include?(day)
    end
    false
  end
end


syntax = Course.new("Syntax", "Linguistics", 3, 2, [:mon,:tues])
programming = Course.new("Programming", "CS", 4, 2, [:tues,:weds])
chocolate = Course.new("Chocolate", "Kitchen", 100,7,[:mon,:tues,:thurs,:fri])

auster = Student.new("Auster", "Chen")

auster.enroll(syntax)
auster.enroll(programming)
auster.enroll(chocolate)

p auster.course_load

programming.students.each { |name| p name.first_name }
