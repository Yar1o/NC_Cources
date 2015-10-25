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
public interface Vector {
        
    /*  получение значения из вектора  */
    public double getElement(int index);
    /*  изменение значения в векторе  */    
    public void setElement(int index, double inputValue);

    /*  получение размера вектора  */
    public int getSize();
    
     /*  заполнение вектора из указанного массива   */
    public void fillFromMass(double[] inputVector);
    
    /*  заполнение вектора из другого объекта этого класса  */
    public void fillFromVector(Vector inputVector);
    
    /*  умножение вектора на значение  */
    public void mult (double inputValue) ;
    
    /*  сложение векторов поэлементно */
    public void sum(Vector summandVector) 
            throws vector.Exceptions.IncompatibleVectorSizesException;
     
    /*  сравнение векторов  */
    public boolean equal (Vector inputVector) ;
}
