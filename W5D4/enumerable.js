var doubleArray = function(num){
	return num * 2;
}

Array.prototype.myEach = function(callBack) {
	for(var i = 0; i < this.length; i++ ){
		callBack(this[i]);
	}
};

Array.prototype.myMap = function(callBack) {
	var result =[];
	var cb2 = function(el){
		result.push(callBack(el))
	}
	this.myEach(cb2);
	return result;
};

var injectCB = function(sum, el){
	return sum * el
}
Array.prototype.myInject = function(callBack){
	
	var sum = this[0];
	var restArray = this.slice(1);

	var cb2 = function(el){
		sum = callBack(sum, el);
	}
	restArray.myEach(cb2);
	return sum;
}

// [1,2,3].inject(){|sum, el| sum + el}
// [1,2,3].myInject(doubleArray)
