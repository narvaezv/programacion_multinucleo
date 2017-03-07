'use strict';

$(() => {
	let timeStart = performance.now();
	const start = 1;
	const end = 1E9;
	let w = new Worker("coprimos_worker.js");

	w.postMessage({
		start: start,
		end: end
	});

	w.onmessage = (e) => {
		let timeEnd = performance.now();
		//let seconds = ((timeEnd - timeStart) / 1000).toFixed(4);
		$("#resultado").html(
			'Sumatoria coprimos: ' + e.data + '<br\>' +
			'Tiempo: ' + ((timeEnd - timeStart) / 1000).toFixed(4));
	}
});