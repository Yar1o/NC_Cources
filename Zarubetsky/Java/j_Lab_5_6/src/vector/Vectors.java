/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vector;

import java.io.*;
import vector.impl.ArrayVector;
import vector.impl.LinkedVector;


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
        for (int i = 0; i < size; i++) {                   
            st.nextToken();
            arr.setElement(i,(double)st.nval); 
        }
        return arr;        
    }
    
    public static void main(String[] args) 
            throws vector.Exceptions.IncompatibleVectorSizesException, IOException,ClassNotFoundException{

        double[] students = { 1.3, 2.8, 3.4, 4.1, 5.3, 6.6 };
	ArrayVector vect = new ArrayVector(students.length);
	vect.fillFromMass(students);
		
	DataOutputStream out1 = new DataOutputStream(new FileOutputStream("students.bin"));
        outputVector(vect, out1);
	out1.close();

	PrintWriter out2 = new PrintWriter(new BufferedWriter(new FileWriter("out1.txt")));
	writeVector(vect, out2);
	out2.close();
		
	BufferedReader in1 = new BufferedReader(new FileReader("out1.txt"));
	System.out.println("Read from text file:            "+readVector(in1));
        in1.close();
        
        InputStream in2 = new FileInputStream("students.bin");
        System.out.println("Read from binary file:          "+inputVector(in2));
        in2.close();
                
        // ArrayVector serialization
        // Test serialization
	ObjectOutputStream out3 = new ObjectOutputStream(new FileOutputStream("out.bin"));
	out3.writeObject(vect);
	out3.close();
        System.out.println("Serialization of ArrayVector:   " + vect.toString());
        
	// Test deserialization
	ObjectInputStream in3 = new ObjectInputStream(new FileInputStream("out.bin"));
	vect = (ArrayVector) in3.readObject();
	in3.close();
	System.out.println("Deserialization of ArrayVector: " + vect.toString());	
        
        // LinkedVector serialization
        LinkedVector lvect = new LinkedVector();
	lvect.fillFromMass(students);
        
        // Test serialization
	ObjectOutputStream out4 = new ObjectOutputStream(new FileOutputStream("out2.bin"));
	out4.writeObject(lvect);
	out4.close();
        System.out.println("Serialization of LinkedVector:  " + lvect.toString());
        
        // Test deserialization
	ObjectInputStream in4 = new ObjectInputStream(new FileInputStream("out2.bin"));
	lvect = (LinkedVector) in4.readObject();
	in4.close();
	System.out.println("Deserialization of LinkedVector:" + lvect.toString());	
        
    }
}
