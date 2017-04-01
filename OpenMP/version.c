#ifdef _OPENMP
#include <omp.h>
#endif

#include <stdio.h>

int main(void){
    #ifdef _OPENMP
        printf("Version de OpenMP = %d\n", _OPENMP);
    #else
        printf("No hay soporte de OpenMP.\n");
    #endif
    return 0;
}