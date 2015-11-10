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
    public double getElement(int index);
    public void setElement(int index, double inputValue);
    public int getSize();
    public void fillFromMass(double[] inputVector);
    public void fillFromVector(Vector inputVector);
    public void mult (double inputValue) ;
    public void sum(Vector summandVector) 
        throws vector.Exceptions.IncompatibleVectorSizesException;

    public void addElement (double inputValue);
    public void insertElement (double inputValue, int index);
    public void deleteElement (int index);
    
    public String toString();
    public boolean equals(Object obj);
    public Object clone() throws CloneNotSupportedException;
}
