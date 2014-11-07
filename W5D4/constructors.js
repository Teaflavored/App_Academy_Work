function Cat(name, owner){
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function(){
  return this.owner + "loves" + this.name
}

cat1 = new Cat("Auster", "bob")
cat2 = new Cat("Smith", "bob")
console.log(cat1.cuteStatement());
console.log(cat2.cuteStatement());

var everyoneStatement = function(){
  return "everyone loves " + this.name
}

Cat.prototype.cuteStatement = everyoneStatement;

console.log(cat1.cuteStatement());
console.log(cat2.cuteStatement());

Cat.prototype.meow = function(){
  return "meow";
}

cat1.meow = function() { 
  return "special meow";
}

console.log(cat1.meow());
console.log(cat2.meow());