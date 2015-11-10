/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vector;

import java.io.*;
import vector.impl.*;

/**
 *
 * @author netcracker
 */
public class Vectors {
    public static void sort(Vector inputVector){
        double temp = 0.0;
        for (int i = 0; i < inputVector.getSize(); i++){
            for (int j = 1; j <= inputVector.getSize(); i++){
                if (inputVector.getElement(i) > inputVector.getElement(j)){
                    temp = inputVector.getElement(i);
                    inputVector.setElement(i,inputVector.getElement(j));
                    inputVector.setElement(j,temp);
                }
            }
        }
    }
 
    /**
    *   Модифицируйте класс Vectors из предыдущей работы, добавив в него новые методы:
    *   - записи вектора в байтовый поток
    */     
    public static void outputVector (Vector v, OutputStream out) throws IOException {
        DataOutputStream dos = new DataOutputStream(out);
        dos.writeInt(v.getSize());
        for (int i = 0; i < v.getSize(); i++) {
            dos.writeDouble(v.getElement(i));
        }
        dos.flush();
    }

    /**
    *  - чтения вектора из байтового потока
    */
    public static Vector inputVector (InputStream in) throws IOException {
        DataInputStream dis = new DataInputStream (in);       
        int size = dis.readInt();     
        double [] bufr = new double [size];
        ArrayVector vec = new ArrayVector(size);
        for (int i = 0; i < size; i++) {            
            bufr [i] = dis.readDouble();
        }
        vec.fillFromMass(bufr);
        return vec;
    }
    
    /*
    *   - записи вектора в символьный поток
    */
    public static void writeVector (Vector v, Writer out) throws IOException {
        StringBuffer str = new StringBuffer();
        str.append(v.getSize());
        str.append(" ");
        str.append(v.toString());
        str.append(System.getProperty("line.separator"));
        BufferedWriter bw = new BufferedWriter(out);
        bw.write(str.toString());
        bw.flush();
    }
   
    /**
    *  - чтения вектора из символьного потока
    */
    public static Vector readVector (Reader in) throws IOException{
        StreamTokenizer st = new StreamTokenizer(in);
        st.nextToken();        
        int size = (int)st.nval;
        ArrayVector arr = new ArrayVector(size);
        for (int i = 0; i < size; i++) {                   //////////////
            st.nextToken();
            arr.setElement(i,(int)st.nval); 
        }
        return arr;        
    }
    
    public static void main(String[] args) 
            throws vector.Exceptions.IncompatibleVectorSizesException, IOException{
        double[] students = { 1, 2, 3, 4, 5, 6 };
	ArrayVector v = new ArrayVector(students.length);
	v.fillFromMass(students);
		
	DataOutputStream out = new DataOutputStream(new FileOutputStream("students.bin"));
        outputVector(v, out);
	out.close();

	PrintWriter out2 = new PrintWriter(new BufferedWriter(new FileWriter("out.txt")));
	writeVector(v, out2);
	out2.close();
		
	BufferedReader in1 = new BufferedReader(new FileReader("out.txt"));
	System.out.println(readVector(in1));
        in1.close();
        
        InputStream in2 = new FileInputStream("students.bin");
        System.out.println(inputVector(in2));
        in2.close();
    }
}
