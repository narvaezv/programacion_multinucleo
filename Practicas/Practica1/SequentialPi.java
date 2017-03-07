/*------------------------------------------------------------------- 
 * Práctica #1: Calculando Pi con threads en Java
 * Fecha: 24-Ene-2017
 * Autores:
 *          A01167870 Joel Narváez Valdivieso
 *          A01373631 Andrea Margarita Pérez Barrera
 *-------------------------------------------------------------------*/
 
package practica1;

public class SequentialPi {

	public static void main(String[] args) {
		long timeStart = System.currentTimeMillis();
		
		long num_rects = 1000000000; //1,000,000,000;
		double mid, height;
		double sum = 0.0;
		double width = 1.0 / (double) num_rects;
		
	    for (long i = 0; i < num_rects; i++) {
	        mid = (i + 0.5) * width;
	        height = 4.0 / (1.0 + mid * mid);
	        sum += height;
	    }
	    double area = width * sum;
	    long timeEnd = System.currentTimeMillis();
		System.out.printf("Computed PI: %f, time = %.4f",
				area, (timeEnd - timeStart) / 1000.0);
	}

}
