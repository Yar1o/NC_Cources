/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javavectorapp;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author AdminY
 */
public class VectorTest {
    
    public VectorTest() {
    }

    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

    /**
     * Test of Set method, of class Vector.
     */
    @Test
    public void testSetValue() {
        System.out.println("setValue");
        int index = 3;
        double value = 0.7;
        Vector instance = new Vector(5);
        instance.SetValue(index, value);
        assertEquals(value, instance.data[index], 0.0);
        //fail("The test case is a prototype.");
    }

    /**
     * Test of getValue method, of class Vector.
     */
    @Test
    public void testGetValue() {
        System.out.println("getValue");
        int index = 3;
        Vector instance = new Vector(5);
        double expResult = 0.7;
        instance.data[index] = expResult;
        double result = instance.GetValue(index);
        assertEquals(expResult, result, 0.0);
        //fail("The test case is a prototype.");
    }

    /**
     * Test of fillFromMass method, of class Vector.
     */
    @Test
    public void testFillFromMass() {
        System.out.println("fillFromMass");
        double[] mass = {5.0, -2.9, 0.0, -50000, 9};
        double[] oldMass = {0.0, 0.9, -6.4, 8, -0.4};
        Vector instance = new Vector(5);
        instance.data = oldMass;
        instance.FillFromMass(mass);
        for (int i = 0; i < 5; i++) {
            assertEquals(mass[i], instance.data[i], 0.0);
        }
        //fail("The test case is a prototype.");
    }

    /**
     * Test of fillFromVector method, of class Vector.
     */
    @Test
    public void testFillFromVector() {
        System.out.println("fillFromVector");
        double[] mass = {5.0, -2.9, 0.0, -50000, 9};
        double[] oldMass = {0.0, 0.9, -6.4, 8, -0.4};
        Vector instance = new Vector(5);
        instance.data = oldMass;
        Vector vector = new Vector(5);
        vector.data = mass;
        instance.FillFromVector(vector);
        for (int i = 0; i < 5; i++) {
            assertEquals(mass[i], instance.data[i], 0.0);
        }
        //fail("The test case is a prototype.");
    }

    /**
     * Test of equal method, of class Vector.
     */
    @Test
    public void testEqual() {
        System.out.println("equal");
        double[] mass = {5.0, -2.9, 0.0, -50000, 9};
        double[] newMass = {0.0, 0.9, -6.4, 8, -0.4};
        double[] newOldMass = {5.0, -2.9, 0.0, -50000, 9};
        Vector instance = new Vector(5);
        instance.data = mass;
        Vector vector = new Vector(5);
        vector.data = newMass;
        boolean expResult = false;
        boolean result = instance.Equal(vector);
        assertEquals(expResult, result);
        
        vector.data = newOldMass;
        expResult = true;
        result = instance.Equal(vector);
        assertEquals(expResult, result);
        //fail("The test case is a prototype.");
    }

    /**
     * Test of getSize method, of class Vector.
     */
    @Test
    public void testGetSize() {
        System.out.println("getSize");
        int expResult = 5;
        Vector instance = new Vector(expResult);
        int result = instance.GetSize();
        assertEquals(expResult, result);
        //fail("The test case is a prototype.");
    }
    
    /**
     * Test of getSize method, of class Vector.
     */
    @Test
    public void testGetSize_2() {
        System.out.println("getSize");
        int expResult = 5;
        Vector instance = new Vector(expResult);
        int result = instance.GetSize();
        assertEquals(expResult, result);
        //fail("The test case is a prototype.");
    }
    
    
    
    
    

    /**
     * Test of getMaxValue method, of class Vector.
     */
    @Test
    public void testGetMaxValue() {
        System.out.println("getMaxValue");
        double[] mass = {5.0, -2.9, 0.0, -50000, 9};
        Vector instance = new Vector(5);
        instance.data = mass;
        double expResult = 9;
        double result = instance.Max();
        assertEquals(expResult, result, 0.0);        
        //fail("The test case is a prototype.");
    }

    /**
     * Test of getMinValue method, of class Vector.
     */
    @Test
    public void testGetMinValue() {
        System.out.println("getMinValue");
        double[] mass = {5.0, -2.9, 0.0, -50000, 9};
        Vector instance = new Vector(5);
        instance.data = mass;
        double expResult = -50000;
        double result = instance.Min();
        assertEquals(expResult, result, 0.0);
        //fail("The test case is a prototype.");
    }

    /**
     * Test of sort method, of class Vector.
     */
    /*
    @Test
    public void testSort() {
        System.out.println("sort");
        double[] mass = {5.0, -2.9, 0.0, -50000, 9};
        double[] sortedMass = {-50000, -2.9, 0.0, 5.0, 9};
        double[] backSortedMass = {9, 5.0, 0.0, -2.9, -50000};
        Vector instance = new Vector(5);
        instance.data = mass;
        boolean incr = true;
        instance.sort(incr);
        for (int i = 0; i < 5; i++) {
            assertEquals(sortedMass[i], instance.data[i], 0.0);
        }
        
        incr = false;
        instance.sort(incr);
        for (int i = 0; i < 5; i++) {
            assertEquals(backSortedMass[i], instance.data[i], 0.0);
        }
        //fail("The test case is a prototype.");
    }

    */
    
    /**
     * Test of mult method, of class Vector.
     */
    @Test
    public void testMult() {
        System.out.println("mult");
        double[] mass = {5.0, -2.9, 0.0, -50000, 9};
        double[] resultMass = {10.0, -5.8, 0.0, -100000, 18};
        Vector instance = new Vector(5);
        instance.data = mass;
        double number = 2;
        instance.Mult(number);
        for (int i = 0; i < 5; i++) {
            assertEquals(resultMass[i], instance.data[i],  0.00000000001);
        }
        //fail("The test case is a prototype.");
    }

    /**
     * Test of sum method, of class Vector.
     */
    @Test
    public void testSum() {
        System.out.println("sum");
        double[] mass = {5.0, -2.9, 0.0, -50000, 9};
        double[] newMass = {1.1, 0.9, -6.4, 100, -9.4};
        double[] resultMass = {6.1, -2.0, -6.4, -49900, -0.4};
        Vector instance = new Vector(5);
        instance.data = mass;
        Vector vector = new Vector(5);
        vector.data = newMass;
        instance.Add(vector);
        for (int i = 0; i < 5; i++) {
            assertEquals(resultMass[i], instance.data[i], 0.00000000001);
        }
        //fail("The test case is a prototype.");
    }
    
    
}
