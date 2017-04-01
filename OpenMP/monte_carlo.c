#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#define NANOSECS_PER_SEC 1000000000


long get_time() {
    struct timespec t;
    clock_gettime(CLOCK_MONOTONIC, &t);
    return t.tv_sec * NANOSECS_PER_SEC + t.tv_nsec;
}

double monteCarlo(int n){
	int sum = 0, i;
	time_t t;
	srand((unsigned) time(&t));

	for (i = 0; i < n; i++){
		double x = -1+2*((double)rand())/RAND_MAX;
		double y = -1+2*((float)rand())/RAND_MAX;
		double h = x * x + y * y;
		
		if (h <= 1){
			sum++;
		}

	}
	return 4 * ((double) sum / n);
}

int main(void){
	long int n = 10000000000;

	long start = get_time();
	double result = monteCarlo(n);
	long end = get_time();
	printf("Pi: %.6f\nTime: %.2fs\n", result, (double) (end - start) / NANOSECS_PER_SEC);
	return 0;
}