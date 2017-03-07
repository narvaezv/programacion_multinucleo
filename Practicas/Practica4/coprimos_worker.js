'use strict';

onmessage = (e) => {
	const n = 666;
	const start = e.data.start;
	const end = e.data.end;
	let sum = 0;

	for (let i = start; i <= end; i++){
		if (euclides(i, n)){
			sum += i;
		}
	}
	postMessage(sum);
}


function euclides(a, b){
	if (a > b) return false;

	let a1 = Math.max(a,b);
	let b1 = Math.min(a,b);
	let div	= 0;

	while (b1 !== 0){
		div = b1;
		b1 = a1 % b1;
		a1 = div;
	}

	if (a1 === 1){
		return true;
	} else {
		return false;
	}
}
