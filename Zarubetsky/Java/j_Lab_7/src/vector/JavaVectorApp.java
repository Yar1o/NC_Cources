/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vector;

import vector.impl.*;

/**
 *
 * @author User
 */
public class JavaVectorApp {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        ArrayVector firstVector = new ArrayVector(2);
        firstVector.setElement(0, 15);
        
        System.out.println(firstVector.getElement(0));
        System.out.println("        ");
        System.out.println(firstVector.getElement(1));
        
        
        double[] secondValues = {1,2,3,4};
        ArrayVector secondVector = new ArrayVector(secondValues);
        
        try {
            
        firstVector.sum(secondVector);
        firstVector.fillFromVector(secondVector);
        }
        catch (vector.Exceptions.IncompatibleVectorSizesException e){
        }
        
        
        double[] mass = {5.0, -2.9, 0.0, -50000, 9};
        Vector instance = new LinkedVector();
	instance.fillFromMass(mass);
        
        for (int j = 0; j < instance.getSize(); j++) {
            System.out.print(instance.getElement(j)+" ");
	}
        
        double inputValue = 666;
        int index = 0;
        instance.insertElement(inputValue, index);
        System.out.println(" ");
        
        
        
	System.out.println();
        System.out.println(" ");
        
        
        System.out.println(instance.getSize());
        System.out.println(" ");

        
        
    }
}
