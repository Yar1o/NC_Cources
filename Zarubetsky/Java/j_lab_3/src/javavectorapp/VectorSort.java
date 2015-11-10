/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javavectorapp;

/**
 *
 * @author AdminY
 */
public class VectorSort {
    public static void Sort(Vector inputVector) {
        double zed = 0;
        for(int i = 0; i < inputVector.GetSize()-1; i++) {
            for(int j = 1; j < inputVector.GetSize(); j++) {
                if (inputVector.GetValue(i) > inputVector.GetValue(j)) {
                    zed = inputVector.GetValue(i);
                    inputVector.SetValue(i, inputVector.GetValue(j));
                    inputVector.SetValue(j, zed);
                }
            }
        }
    }   
}
