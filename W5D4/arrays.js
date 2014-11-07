var uniq = function(array){
	var new_arr = [];
	for(var i = 0, length = array.length; i < length; i++){
		if (!included(array[i], new_arr)){
			new_arr.push(array[i]);
		}
	}
	return new_arr;
};

var included = function(el, arr){
	for(var i = 0, length = arr.length; i < length; i++){
		if(el === arr[i]){
			return true;
		}
	}
	return false;
};

var twoSum = function(arr){
	var result = [];
	for(var i = 0, length = arr.length; i < length - 1; i++){
		for(var j = i + 1; j < length; j++){
			if (arr[i] + arr[j] === 0){
				result.push([i, j]);
			}
		}
	}
	return result;
};

var transpose = function(arr){
	var new_arr = [];
	for(var i = 0, length = arr.length; i < length; i++){
		new_arr.push([]);
	}
	
	for(var i = 0, length = arr.length; i < length; i++){
		for(var j = 0, length = arr[i].length; j < length; j++){
			new_arr[j].push(arr[i][j]);
		}
	}
	
	return new_arr;
};

console.log(transpose([
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ]));