/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vector.container;

import java.util.Collection;
import java.util.Iterator;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import vector.*;
import vector.impl.ArrayVector;
import vector.container.VectorCollection;

/**
 *
 * @author AdminY
 */
public class VectorCollectionTest{
    
    public VectorCollectionTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

    /**
     * Test of size method, of class VectorCollection.
     */
    
    public class TestVectorCollection {
        
    }
    double [] mass1 = {3.14, 2.71, 0, -2.5, 99.12};
    double [] mass2 = {6.28, 6.48, 0, -2.5, 93.12};
    double [] mass3 = {3.35, 5.11, 0, -2.5, 16.12};
    ArrayVector arV1 = new ArrayVector(mass1);
    ArrayVector arV2 = new ArrayVector(mass2);
    ArrayVector arV3 = new ArrayVector(mass3);
    
    ArrayVector[] testVectorArray = {arV1, arV2,arV3};
    ArrayVector[] expectedVectorArray = {arV1, arV2,arV3,arV1};
    ArrayVector[] expectedVectorArray2 = {arV1, arV2};
    
    VectorCollection expectedCollection = new VectorCollection(expectedVectorArray);        
    VectorCollection expectedCollection2 = new VectorCollection(expectedVectorArray2); 
    
    
    // test Add
    ArrayVector[] startVectorArray = {arV1}; // начальное значение                  // начальное
    ArrayVector[] testAddVectorArray = {arV2,arV3};                                 // добавляемое
                                                                                    // ожидаемое
    VectorCollection startCollection = new VectorCollection(startVectorArray);      // начальное
    VectorCollection addCollection = new VectorCollection(testAddVectorArray);
    VectorCollection expAddVectorArray = new VectorCollection(testAddVectorArray);  // ожидаемое
            
            
    @Test
    public void testSize() {
        VectorCollection instance = new VectorCollection(testVectorArray);
        System.out.println("size");
        int expResult = 3;
        int result = instance.size();
        assertEquals(expResult, result);
    }

    /**
     * Test of isEmpty method, of class VectorCollection.
     */
    @Test
    public void testIsEmpty() {
        System.out.println("isEmpty");
        VectorCollection instance = new VectorCollection(testVectorArray);
        boolean expResult = false;
        boolean result = instance.isEmpty();
        assertEquals(expResult, result);
    }

    /**
     * Test of contains method, of class VectorCollection.
     */
    @Test
    public void testContains() {
        System.out.println("contains");
        Object o = arV3;
        VectorCollection instance = new VectorCollection(testVectorArray);
        boolean expResult = true;
        boolean result = instance.contains(o);
        assertEquals(expResult, result);
    }

    /**
     * Test of iterator method, of class VectorCollection.
     */
    @Test(expected = UnsupportedOperationException.class)
    public void testIterator() {
        System.out.println("iterator");
        VectorCollection instance = new VectorCollection(testVectorArray);
        Iterator<Vector> expResult = null;
        Iterator<Vector> result = instance.iterator();
        assertEquals(expResult, result);
    }

    /**
     * Test of toArray method, of class VectorCollection.
     */
    @Test
    public void testToArray_0args() {
        System.out.println("toArray");
        VectorCollection instance = new VectorCollection(testVectorArray);
        Object[] expResult = testVectorArray;
        Object[] result = instance.toArray();
        assertArrayEquals(expResult, result);
    }

    /**
     * Test of toArray method, of class VectorCollection.
     */
    @Test
    public void testToArray_ObjectArr() {
        System.out.println("toArray");
        Object[] a = {mass1, mass2,mass3};
        VectorCollection instance = new VectorCollection(testVectorArray);
        Object[] expResult = testVectorArray;
        Object[] result = instance.toArray(a);
        assertArrayEquals(expResult, result);
    }

    /**
     * Test of add method, of class VectorCollection.
     */
    @Test
    public void testAdd() {
        System.out.println("add");
        Object o = arV1;
        VectorCollection instance = new VectorCollection(testVectorArray);
        boolean expResult = true;
        boolean result = instance.add(o);
        assertEquals(expResult, result);
    }

    /**
     * Test of containsAll method, of class VectorCollection.
     */
    @Test
    public void testContainsAll() {
        System.out.println("containsAll");
        Collection c = expectedCollection;
        VectorCollection instance = expectedCollection;
        boolean expResult = true;
        boolean result = instance.containsAll(c);
        assertEquals(expResult, result);
    }

    /**
     * Test of addAll method, of class VectorCollection.
     */
    @Test
    public void testAddAll() {
        System.out.println("addAll");
        Collection c = addCollection;
        VectorCollection instance = new VectorCollection(startVectorArray);
        boolean expResult = true;
        boolean result = instance.addAll(c);
        assertEquals(expResult, result);
    }
    /**
     * Test of clear method, of class VectorCollection.
     */
    @Test
    public void testClear() {
        System.out.println("clear");
        VectorCollection instance = new VectorCollection(testVectorArray);
        instance.clear();
    }
    
    
    
    /**
    * Test of remove method, of class VectorCollection.
    */
    @Test
    public void testRemove() {
        System.out.println("remove");
        Object o = arV3;
        VectorCollection instance = expectedCollection2;
        boolean expResult = true;
        boolean result = instance.remove(o);
        assertEquals(expResult, result);
    }
    
    
    /**
     * Test of removeAll method, of class VectorCollection.
     */
    @Test
    public void testRemoveAll() {
        System.out.println("removeAll");
        Collection c = null;
        VectorCollection instance = null;
        boolean expResult = false;
        boolean result = instance.removeAll(c);
        assertEquals(expResult, result);
    }

    /**
     * Test of retainAll method, of class VectorCollection.
     */
    @Test
    public void testRetainAll() {
        System.out.println("retainAll");
        Collection c = null;
        VectorCollection instance = null;
        boolean expResult = false;
        boolean result = instance.retainAll(c);
        assertEquals(expResult, result);
    }


}











/*
            System.out.println("clear");
        Vector[] expValue = {new ArrayVector(0)};
        VectorCollection instance = new VectorCollection(testVectorArray);
        VectorCollection expResult = new VectorCollection(expValue);
        instance.clear();
        VectorCollection result = instance;
        assertEquals(expResult, result);
    */