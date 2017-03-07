'use strict';

$(() => {
	let w = new Worker("primos_worker.js");
	w.onmessage = (e) => {
		$("#resultado").text(event.data);
	}
});