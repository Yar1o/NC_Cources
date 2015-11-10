/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vector.impl;

import vector.Vector;
import vector.Exceptions.*;
/**
 *
 * @author User
 */
public class ArrayVector implements Vector, Cloneable {
    
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
    public void fillFromMass(double[] mass) {
        if (this.getSize() != mass.length) {
            double[] newMass = new double[mass.length];
            for (int i = 0; i < mass.length; i++) {
		newMass[i] = mass[i];
            }
            this.data = newMass;
            } else {
                for (int i = 0; i < this.data.length; i++) {
                    this.data[i] = mass[i];
		}
            }
    }
    
    /*  заполнение вектора из другого объекта этого класса  */
    public void fillFromVector(Vector inputVector){
	if (this.getSize() != inputVector.getSize()) {
            double[] newMass = new double[inputVector.getSize()];
            for (int i = 0; i < inputVector.getSize(); i++) {
		newMass[i] = inputVector.getElement(i);
            }
            this.data = newMass;
            } else {
                for (int i = 0; i < this.data.length; i++) {
                    this.data[i] = inputVector.getElement(i);
		}
            }
    }    

    /*  умножение вектора на значение  */
    public void mult (double inputValue) {
        for (int i = 0; i < this.data.length; i++) {
            this.data[i] = this.data[i]*inputValue;
        }
    }
    
    /*  сложение векторов поэлементно */
    public void sum(Vector summandVector) throws vector.Exceptions.IncompatibleVectorSizesException{
        if (summandVector.getSize() == this.getSize()){
            for (int i = 0; i < this.data.length; i++){
            this.data[i] = this.data[i] + summandVector.getElement(i);
            }
        } else {
            throw new vector.Exceptions.IncompatibleVectorSizesException("Sum");
        }
    }   
     
    public void addElement (double inputValue){
        double[] NewMass = new double[this.data.length + 1];
        System.arraycopy(this.data, 0, NewMass, 0, this.data.length);
        NewMass[this.data.length] = inputValue;
        this.data = NewMass;
    }
    
    public void insertElement (double inputValue, int index){
        if (index < 0 || index > this.data.length + 1) {
            throw new VectorIndexOutOfBoundsException("Bad Index Error");
	}
	double[] NewMass = new double[this.data.length + 1];
	System.arraycopy(this.data, 0, NewMass, 0, this.data.length);
        for (int j = this.data.length - 1; j >= index; j--) {
            NewMass[j + 1] = NewMass[j];
	}
	NewMass[index] = inputValue;
	this.data = NewMass;
    }
    public void deleteElement (int index){
        if (index < 0 || index >= this.data.length) {
            throw new VectorIndexOutOfBoundsException("Bad Index Error");
	}
	double[] newMass = new double[this.data.length - 1];
	for (int i = 0; i < index; i++) {
            newMass[i] = this.data[i];
	}
        for (int i = index; i < newMass.length; i++) {
            newMass[i] = this.data[i + 1];
        }
	this.data = newMass;
    }
    
    public String toString () {
        StringBuilder s = new StringBuilder();
	for (int i = 0; i < this.data.length; i++) {
            s.append(Double.toString(this.data[i]));
            s.append(" ");
	}
	return s.toString().trim();
    }
        
    public boolean equals (Object obj) {
        if (obj instanceof Vector ) {
            Vector tmp = (Vector) obj;
            if (tmp.getSize() == this.data.length) {
                for (int i = 0; i < this.data.length; i++){
                    if (tmp.getElement(i) != this.data[i]) {
                        return false;
                    }
                }
            return true;
            } else {
            return false;
            }
        }
        else {
            return false;
        }
    }

    public Object clone () {            
        ArrayVector obj = null;
        try{
            obj = (ArrayVector) super.clone();
            obj.data = new double[this.getSize()];
            obj.fillFromVector(this);
        }
        catch (CloneNotSupportedException e){
            return obj;   
        }
        return obj;
    }
}
