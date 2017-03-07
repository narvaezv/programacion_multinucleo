'use strict';

let n = 1;

busca: while (true){
	n++;
	for (let i = 2; i < Math.sqrt(n); i++){
		if (n % i == 0){
			continue busca;
		}
	}
	postMessage(n);
}