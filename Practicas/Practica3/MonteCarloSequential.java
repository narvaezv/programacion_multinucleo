package practica3;

import java.util.concurrent.ThreadLocalRandom;

public class MonteCarloSequential {
	public final static int NUM_TIROS = 1000000000;

	public static void main(String[] args) {
		long timeStart = System.currentTimeMillis();
		
		double pi = sequentialMonteCarlo(NUM_TIROS);
		
		long timeEnd = System.currentTimeMillis();
		
		System.out.printf("Computed PI: %f, time = %.4f",
				pi, (timeEnd - timeStart) / 1000.0);
	}
	
	public static double sequentialMonteCarlo(int n) {
	    int sum = 0;
	    for (int i = 0; i < n; i++) {
	        // Generar dos números aleatorios entre -1 y 1.
	        double x = ThreadLocalRandom.current().nextDouble() * 2 - 1;
	        double y = ThreadLocalRandom.current().nextDouble() * 2 - 1;

	        // Aplicar teorema de Pitágoras.
	        double h = x * x + y * y;

	        // Verificar si el tiro cayó dentro del círculo.
	        if (h <= 1) {
	            sum++;
	        }
	    }
	    return 4 * ((double) sum / n);
	}

}
