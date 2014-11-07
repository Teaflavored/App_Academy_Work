Array.prototype.included = function(el){
	for(var i = 0, length = this.length; i < length; i++){
    if(typeof(el) === Course){
      if (el.equals(this[i])){
        return true;
      }
    }
		else if (el === this[i]){
			return true;
		}
	}
	return false;
}


function Student(fname, lname){
  this.fname = fname;
  this.lname = lname;
  this.courses = [];
}

Student.prototype.name = function(){
  return this.fname + " " + this.lname;
};

Student.prototype.enroll = function(course){
  for(var i = 0; i < this.courses.length; i++){
    if (this.courses[i].conflictsWith(course)){
      console.log("has conflict, can't enroll");
      return;
    }
  }
  if (this.courses.included(course)){
    return null;
  }
  this.courses.push(course);
  course.students.push(this);
} 

Student.prototype.courseLoad = function(){
  
  var result = {};
  
  for(var i = 0; i < this.courses.length; i++){
    result[this.courses[i].dpt] = 0;
  }
  
  for(var i = 0; i < this.courses.length; i++){
    result[this.courses[i].dpt] += this.courses[i].cred;
  }
  
  return result;
}


function Course(cname, dpt, cred, days, timeBlock){
  this.cname = cname;
  this.dpt = dpt;
  this.cred = cred;
  this.days = days
  this.timeBlock = timeBlock
  this.students = [];
}

Course.prototype.addStudent = function(student){
  student.enroll(this);
};

Course.prototype.equals = function(otherCourse){
  var cname = (this.cname === otherCourse.cname);
  var dpt = (this.dpt === otherCourse.dpt);
  var cred = (this.cred === otherCourse.cred);
  
  
  return cname && dpt && cred;
}

Course.prototype.conflictsWith = function(otherCourse){
  
  if(this.timeBlock != otherCourse.timeBlock){
    return false;
  } else {
    for( var i = 0; i < this.days.length; i++){
      if (otherCourse.days.included(this.days[i])){
        return true;
      }
    }
  }
  
  return false;
}
var bio = new Course("biology1", "science", 4, ["mon", "tues", "wed"], 6);
var chem = new Course("chem1", "science", 6, ["thur", "fri"], 6);
var cs = new Course("introcs", "math", 5, ["thur", "fri"], 7);
var math = new Course("math", "math", 4, ["mon", "thur"], 7)
var auster = new Student("Auster", "Chen");
auster.enroll(bio);
auster.enroll(chem);
auster.enroll(cs);
auster.enroll(cs);
console.log(auster.courseLoad());
console.log(bio.students);

