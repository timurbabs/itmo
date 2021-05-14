/** 
 * Класс "Main"  
 * @author Baburin Timur
 * @version 1.0
*/
public class Main {
	/**
	* main() - основной метод
	* @param args - массив типа String
	*/
	public static void main(String[] args) {
	byte v_byte=120;
	short v_short=129;
	char v_char='a';
	int v_int=65999;
	long v_long=429496729;
	float v_float=0.33333334f;
	double v_double=0.3333333333333333;
	boolean v_boolean=true;
	System.out.println("This is a byte: "+v_byte);
	System.out.println("This is a short: "+v_short);
	System.out.println("This is a char: "+v_char);
	System.out.println("This is a int: "+v_int);
	System.out.println("This is a long: "+v_long);
	System.out.println("This is a float: "+v_float);
	System.out.println("This is a double: "+v_double);
	System.out.println("This is a boolean: "+v_boolean);
	System.out.println("Starting project");

	long begin = new java.util.Date().getTime(); 

	for(char i = 97; i <= 122; i++) {	
		System.out.print((char)i);
	}
	System.out.println("");

	for(long i = 0; i <= 10000000; i++) {}

	/*int i = 0;
	for (; i<100000000;) {}*/	

	long end = new java.util.Date().getTime();	
	System.out.println(end-begin);		

	int[] mas = {12,43,12,-65,778,123,32,76};
	int max = mas[0];
    	for (int i = 0; i < mas.length; ++i) {
        	if (mas[i] > max) {
            		max = mas[i];
        	}
    	}	
	
	int[][] matrix = new int[3][3];
	for (int i = 0; i < matrix.length; i++) {
        	for (int j = 0; j < matrix[i].length; j++) {
        		matrix[i][j]=(int)Math.round(Math.random()*10);
        	}
        }		
	int t = 0;
	for(int i = 0; i < matrix.length; i++){
        	for(int j = i; j < matrix[i].length; j++){
        		t = matrix[i][j];
            		matrix[i][j] = matrix[j][i];
            		matrix[j][i] = t;
        	}
    	}	
	}
}
