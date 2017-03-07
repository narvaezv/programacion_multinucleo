/*------------------------------------------------------------------- 
 * Práctica #1: Calculando Pi con threads en Java
 * Fecha: 24-Ene-2017
 * Autores:
 *          A01167870 Joel Narváez Valdivieso
 *          A01373631 Andrea Margarita Pérez Barrera
 *-------------------------------------------------------------------*/

package practica1;

public class ParallelPi implements Runnable {
	private long start;
	private long end;
	private static long num_rects = 1000000000; //1,000,000,000;
	private double area = 0.0;
	
	public ParallelPi(long start, long end) {
		super();
		this.start = start;
		this.end = end;
	}

	public static void main(String[] args) throws InterruptedException {
		long timeStart = System.currentTimeMillis();
		
		//Depending the threads you want to create
		long slice = num_rects / 4;
		ParallelPi pp1 = new ParallelPi(0, slice);
		ParallelPi pp2 = new ParallelPi(slice, slice * 2);
		ParallelPi pp3 = new ParallelPi(slice * 2, slice * 3);
		ParallelPi pp4 = new ParallelPi(slice * 3, slice * 4);
		Thread t1 = new Thread(pp1);
		Thread t2 = new Thread(pp2);
		Thread t3 = new Thread(pp3);
		Thread t4 = new Thread(pp4);
		t1.start();
		t2.start();
		t3.start();
		t4.start();
		t1.join();
		t2.join();
		t3.join();
		t4.join();
		
		double sum = pp1.area + pp2.area + pp3.area + pp4.area;
		
		long timeEnd = System.currentTimeMillis();
		
		System.out.printf("Computed PI: %f, time = %.4f",
				sum, (timeEnd - timeStart) / 1000.0);
	
	}

	@Override
	public void run() {
		double mid, height;
		double sum = 0.0;
		double width = 1.0 / (double) num_rects;
	    for (long i = start; i < end; i++) {
	        mid = (i + 0.5) * width;
	        height = 4.0 / (1.0 + mid * mid);
	        sum += height;
	    }
	    area = sum * width;
	}

}
