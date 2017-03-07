'use strict';

$(() => {
	let timeStart = performance.now();
	let numRects = 1E10;
	let width = 1 / numRects;
	let numWorkers = 4;
	let chunkSize = numRects / numWorkers;
	let sum = 0;
	let finalized_worker = 0;

	for (let i = 1; 1 < numWorkers; i++){
		let w = new Worker('pi_worker.js');
		w.postMessage({
			numRects: numRects,
			start: i * chunkSize,
			end: (i + 1) * chunkSize
		});
		w.onmessage = (e) => {
			finalized_worker++;
			sum += e.data;
			if (finalized_worker === numWorkers){
				let area = width * sum;
				let timeEnd = performance.now();
				$('#resultado').html(
					'Valor de pi = ' + area + '<br\>' +
					'Tiempo = ' + (timeEnd - timeStart) / 1000
				);
			}
		};
	}
});