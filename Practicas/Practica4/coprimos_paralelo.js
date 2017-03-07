'use strict';

$(() => {
	let timeStart = performance.now();
	let num_workers = 4;
	let finalized_worker = 0;
	let sum = 0;
	const total = 1E9;
	const chunk = total / num_workers;

	for (let i = 0; i < num_workers; i++){
		let w = new Worker("coprimos_worker.js");

		w.postMessage({
			start: i * chunk,
			end: (i + 1) * chunk
		});

		w.onmessage = (e) => {
			finalized_worker++;
			sum += e.data;

			if (finalized_worker === num_workers){
				let timeEnd = performance.now();
				$("#resultado").html(
					'Sumatoria coprimos: ' + sum + '<br\>' +
					'Tiempo: ' + ((timeEnd - timeStart) / 1000).toFixed(4));
				//console.log(sum);
			}
		}
	}
});