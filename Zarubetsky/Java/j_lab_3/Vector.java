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
public class Vector {
    protected double[] data;
     
    // конструкторы
    // конструктор по-умолчанию
    public Vector (int length) {
        this.data = new double[length];
    }
    public Vector (double [] mass) {
        this.data = new double[mass.length];
        for (int i=0; i < mass.length; i++) {
            this.data[i] = mass[i];
        }
    }
    
    /*  методы  */
    /*  получение значения из вектора  */
    public double GetValue(int index) {
        return(this.data[index]);
    }
    
    /*  изменение значения в векторе  */    
    public void SetValue(int index, double inputValue) {
        this.data[index] = inputValue;
    }
    
    /*  получение размера вектора  */
    public int GetSize() {
        return this.data.length;
    }
    
    /*  умножение вектора на значение  */
    public void Mult (double multiplier) {
        for (int i = 0; i < this.GetSize(); i++) {
            this.SetValue(i, this.GetValue(i)*multiplier);
        }
    }
     
    /*  сравнение векторов  */
    public boolean Equal (Vector inputVector) {
        if (inputVector.GetSize() != this.GetSize()) {
            return false;
        } else {
            for (int i = 0; i < this.GetSize(); i++){
                if (inputVector.GetValue(i) != this.GetValue(i)) {
                    return false;
                }
            }
        }
        return true;
    }

    /* получение максимального значения вектора  */
    public double Max() {
        double max = this.GetValue(0);
        for (int i = 0; i < this.GetSize(); i++){
            if (this.GetValue(i) > max) 
                max = this.GetValue(i);
            }
        return max;
     }
    
    /*  получение минимального значения вектора  */
    public double Min() {
        double min = this.GetValue(0);
        for (int i = 0; i < this.GetSize(); i++){
        if (this.GetValue(i) < min) 
            min = this.GetValue(i);
        }
        return min;
    }
        
        
    /*  Заполнение вектора из массива   */
    public void FillFromMass(double[] mass) {
        if(this.GetSize() != mass.length) {
            this.data = new double[mass.length];
                for (int i = 0; i < mass.length; i++) {
                    this.SetValue(i, mass[i]);
                }
            }
            else{
                for (int i = 0; i < mass.length; i++) {
                    this.SetValue(i, mass[i]);
                }
        }
    }
    
    /*  сложение векторов поэлементно */
    public void Add(Vector summandVector){
        if (summandVector.GetSize() == this.GetSize()){
            for (int i = 0; i < this.GetSize(); i++){
            this.SetValue(i, this.GetValue(i) + summandVector.GetValue(i));
            }
        }
    }
        
    /*  заполнение вектора из другого объекта этого класса  */
    public void FillFromVector(Vector inputVector){
        if (this.GetSize() > inputVector.GetSize()) {
            for (int i = 0; i < this.GetSize(); i++) {
                this.SetValue(i, inputVector.GetValue(i));     
            }
        } else {
            for (int i = 0; i < this.GetSize(); i++) {
                this.SetValue(i, inputVector.GetValue(i));
            }
        }
    }    
}
