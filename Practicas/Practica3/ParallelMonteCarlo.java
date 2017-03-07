package practica3;

import java.time.Duration;
import java.time.Instant;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.IntStream;

public class ParallelMonteCarlo {
	public final static int NUM_TIROS = 1000000000;
	
	public static void main(String[] args) {
		Instant start = Instant.now();
		
		double pi = 
                IntStream.range(0, NUM_TIROS)
                    .parallel()
                    .mapToDouble(ParallelMonteCarlo::monteCarlo)
                    .sum() / NUM_TIROS * 4;
		
		Instant end = Instant.now();
		Duration delta = Duration.between(start, end);
		System.out.println("Pi: " + pi);
		System.out.println("Time: " + delta.toMillis() / 1000.0);
	}
	
	public static double monteCarlo(int n) {
	    int sum = 0;
        // Generar dos números aleatorios entre -1 y 1.
        double x = ThreadLocalRandom.current().nextDouble() * 2 - 1;
        double y = ThreadLocalRandom.current().nextDouble() * 2 - 1;

        // Aplicar teorema de Pitágoras.
        double h = x * x + y * y;

        // Verificar si el tiro cayó dentro del círculo.
        if (h <= 1) {
            return 1;
        }
	    
	    return 0;
	}

}
