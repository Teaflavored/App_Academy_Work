function range(start, end){
  if(end<start){
    return [];
  }

  return [start].concat(range(start+1, end))
};

function exp(base, n){
  if(n === 0){
    return 1;
  }
  return base * exp(base, n - 1)
}

function exp2(base, n){
  if(n === 0){
    return 1;
  } else if (n === 1) {
    return base;
  }

  if(n % 2 === 0){
    return exp2(base, n / 2) * exp2(base, n / 2);
  }else {
    return base * (exp2(base, (n - 1) / 2 ) * exp2(base, (n - 1) / 2 ));
  }
}

function fib(n){
  if (n === 0){
    return [];
  }else if (n === 1){
    return [1];
  } else if (n === 2){
    return [1,1];
  }

  prevFibs = fib(n - 1)
  length = prevFibs.length
  newFib = prevFibs[length - 1] + prevFibs[length - 2]
  return prevFibs.concat([newFib])
}

function bSearch(arr, key){
  var mid = parseInt(arr.length / 2);

  if (arr.length === 0){
    return null;

  }
  if (arr[mid] === key){
    console.log("found at " + mid)
    return mid;
  }
  else if (arr[mid] > key){
    return bSearch(arr.slice(0, mid), key);
  }
  else {
    var searchResult = bSearch(arr.slice(mid + 1, arr.length), key) 

    if(searchResult === null){
      return null;
    }
    else{
      return search + mid + 1;
    }
  }
}


function msort(arr){
  if (arr.length <= 1){
    return arr
  }
  var mid = parseInt(arr.length / 2);
  var left = msort(arr.slice(0, mid));
  var right = msort(arr.slice(mid, arr.length));

  return merge(left, right);
}

var merge = function(arr1, arr2){
  var index_a = 0;
  var index_b = 0;
  var result = []
  while(index_a < arr1.length && index_b < arr2.length){
    if (arr1[index_a] < arr2[index_b]){
      result.push(arr1[index_a]);
      index_a++;
    }
    else{
      result.push(arr2[index_b]);
      index_b++;
    }
  }
  return result.concat(arr1.slice(index_a, arr1.length)).concat(arr2.slice(index_b, arr2.length))
}

function subsets(arr){

  if(arr.length === 0){
    return [[]];
  }

  var prevSubsets = subsets(arr.slice(0, arr.length -1 ))
  var lastValue = arr[arr.length - 1]
  var newSubsets = []
  for(var i = 0; i < prevSubsets.length; i++){
    newSubsets.push(prevSubsets[i].concat([lastValue]))
  }
  return prevSubsets.concat(newSubsets)
}

function makeChange(money, denom){

  if (money === 0){
    return [];
  }

  var bestChange = []; 
  for(var i = 0; i < denom.length; i++){
    var currentChange = [];
    if(money >= denom[i]){
      var new_money = money - denom[i];
      currentChange.push(denom[i]);
      var remainingChange = makeChange(new_money, denom);
      currentChange = currentChange.concat(remainingChange);
      bestChange.push(currentChange)
    }
  }
  var bestestChange = bestChange[0];
  for(var i = 1; i < bestChange.length; i++){
    if(bestChange[i].length < bestestChange.length){
      bestestChange = bestChange[i];
    }
  }
  return bestestChange;
  
}


console.log(makeChange(14, [10, 7, 1]))


