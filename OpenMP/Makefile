all: version monte_carlo pmonte_carlo sort psort

version: version.c
	gcc version.c -o version -fopenmp -std=c99

monte_carlo: monte_carlo.c
	gcc monte_carlo.c -o monte_carlo -std=gnu99

pmonte_carlo: parallel_monte_carlo.c
	gcc parallel_monte_carlo.c -o pmonte_carlo -fopenmp -std=gnu99

sort: sort.c
	gcc sort.c -o sort -std=gnu99

psort: psort.c
	gcc psort.c -o psort -fopenmp -std=gnu99