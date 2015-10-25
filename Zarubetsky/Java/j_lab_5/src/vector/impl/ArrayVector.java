/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vector.impl;

/**
 *
 * @author AdminY
 */
public class ArrayVector implements vector.Vector {
    protected double[] data;
     
    // конструкторы
    // конструктор по-умолчанию
    public ArrayVector (int length) {
        this.data = new double[length];
    }
    
    /*  заполнение вектора из указанного массива   */
    public ArrayVector(double[] inputVector) {
        this.data = new double[inputVector.length];
        for ( int i = 0; i < inputVector.length; i++) {
            this.data[i] = inputVector[i];
        }
    }
        
    /*  методы  */
    /*  получение значения из вектора  */
    public double getElement(int index) {
        try {
            return(this.data[index]);
        }
        catch (ArrayIndexOutOfBoundsException e){  
            throw new vector.Exceptions.VectorIndexOutOfBoundsException("Index Out");
        }
        
    }
    
    /*  изменение значения в векторе  */    
    public void setElement(int index, double inputValue) {
        try {
            this.data[index] = inputValue;
        }
        catch (ArrayIndexOutOfBoundsException e){  
            throw new vector.Exceptions.VectorIndexOutOfBoundsException("Index Out");
        }
    }
    

    /*  получение размера вектора  */
    public int getSize() {
        return this.data.length;
    }
    
     /*  заполнение вектора из указанного массива   */
    public void fillFromMass(double[] inputVector) {
        for ( int i = 0; i < inputVector.length; i++) {
            this.data[i] = inputVector[i];
        }
    }
    
    /*  заполнение вектора из другого объекта этого класса  */
    public void fillFromVector(vector.Vector inputVector){
        this.data = new double[inputVector.getSize()];
        for (int i = 0; i < inputVector.getSize(); i++) {
                this.data[i] = inputVector.getElement(i);
        }
    }    
    
    /*  умножение вектора на значение  */
    public void mult (double inputValue) {
        for (int i = 0; i < this.data.length; i++) {
            this.data[i] = this.data[i]*inputValue;
        }
    }
    
    /*  сложение векторов поэлементно */
    public void sum(vector.Vector summandVector) throws vector.Exceptions.IncompatibleVectorSizesException{
        if (summandVector.getSize() == this.getSize()){
            for (int i = 0; i < this.data.length; i++){
            this.data[i] = this.data[i] + summandVector.getElement(i);
            }
        } else {
            throw new vector.Exceptions.IncompatibleVectorSizesException("Sum");
        }
    }   
     
    /*  сравнение векторов  */
    public boolean equal (vector.Vector inputVector) { 
        if (inputVector.getSize() == this.data.length) {
            for (int i = 0; i < this.data.length; i++){
                if (inputVector.getElement(i) != this.data[i]) {
                    return false;
                }
            }
            return true;
        } else {
            return false;
        } 
    }
}
