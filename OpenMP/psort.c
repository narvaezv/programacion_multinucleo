#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <string.h>

#define NANOSECS_PER_SEC 1000000000

void print_array(int *p, int n){
	for (int i = 0; i < n; ++i) {
    	printf( "r[%d] = %d\n", i, p[i]);
  	}
}

long get_time() {
    struct timespec t;
    clock_gettime(CLOCK_MONOTONIC, &t);
    return t.tv_sec * NANOSECS_PER_SEC + t.tv_nsec;
}

void get_random(int *p, int n) {
   time_t t;
   srand((unsigned)time(&t));
   
   #pragma omp parallel for
   for (int i = 0; i < n; ++i) {
      p[i] = rand() % 10;
   }
}

void count_sort(int *p, int n){
	int temp[n];

	#pragma omp parallel for
	for (int i = 0; i < n; i++){
		int count = 0;
		for (int j = 0; j < n; j++){
			#pragma omp if
			if (p[j] < p[i]){
				count++;
			} else if (p[i] == p[j] && j < i) {
         		count++;
        	}
		}
        temp[count] = p[i]; 
	}
	memcpy(p, temp, sizeof(temp));
}

int main(void){
	int n = 100000;

	int p[n];
	get_random(p, n);

	long start = get_time();
	count_sort(p, n);
	long end = get_time();
	printf("Time: %.2fs\n", (double) (end - start) / NANOSECS_PER_SEC);
	return 0;
}