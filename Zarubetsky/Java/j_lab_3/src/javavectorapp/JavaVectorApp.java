/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javavectorapp;
/**
 *
 * @author User
 */
public class JavaVectorApp {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        double[] TestArray1 = {1, 2, 3, 4, 0};
        Vector TestVector = new Vector(TestArray1);
        for (int i = 0; i < TestArray1.length; i++) {
            System.out.println(" " + TestVector.GetValue(i));
        }
        //TestVector();
        
    }
}
