Array.prototype.bubbleSort = function(){
	var sorted = false;
	while(!sorted){
		sorted = true;
		for(var i = 0; i < this.length - 1; i++){
			if(this[i] > this[i+1]){
				sorted = false;
				var temp = this[i + 1];
				this[i + 1] = this[i];
				this[i] = temp;
			}
		}
	}
	return this;
};

String.prototype.substring = function(){
	var result = [];
	for(var i = 0; i < this.length; i++){
		for(var j = i; j < this.length; j++){
			result.push(this.slice(i,j+1));
		}
	}
	return result;
};