// var it = values(1,2,3,4)
// it.next() 1
// it.next() 2
function values(){
  var args = arguments;
  //need to bind since arguments within next refers to arguments passed in to next
  //not the origin values arguments
  var n = args.length;
  var i = 0;
  return {
    next: function(){
      if (i >= n ){
        throw new Error("end of iteration");
      } else {
        return args[i++];
        //store args[i] to return, increments i then return args[i]
      }
    }
  }
}


var it = values(1, 2, 3, 4);
console.log(it.next());
console.log(it.next());
console.log(it.next());
console.log(it.next());

// console.log(it.next());
