/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vector;

/**
 *
 * @author netcracker
 */
public class Vectors {
     public static void sort(Vector inputVector)
	{
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
}
