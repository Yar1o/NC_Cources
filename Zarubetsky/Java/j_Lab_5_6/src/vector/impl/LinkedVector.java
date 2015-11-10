/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vector.impl;

import vector.Vector;
import vector.Exceptions.*;
import java.io.Serializable;


/**
 *
 * @author AdminY
 */
public class LinkedVector implements Vector, Cloneable, Serializable{

    protected Nod head;
    protected int size;

    // Inner Class for Nodes
    public class Nod {
	public double element;
	public Nod next;
	public Nod prev;

	public Nod(double element) {
            this.element = element;
	}
    }

    protected Nod goToElement(int index) {
	Nod result = head;
	int i = 0;
	while (i != index) {
            result = result.next;
            i++;
	}
        return result;
	}

    protected void insertElementBefore(Nod current, Nod newNod) {
	newNod.next = current;
	newNod.prev = current.prev;
	current.prev.next = newNod;
	current.prev = newNod;
	size++;
    }

    protected void deleteElement(Nod current) {
	if (size == 1) {
            head = null;
	} else {
            current.prev.next = current.next;
            current.next.prev = current.prev;
            if (current == head) {
                head = current.next;
            }
	}
	size--;
    }
		
    @Override
    public void addElement(double d) {
        if (head == null) {
            head = new Nod(d);
            head.prev = head;
            head.next = head;
            size = 1;
        } else {
            insertElementBefore(head, new Nod(d));
        }
    }

    @Override
    public double getElement(int num) {
        if (num >= size || num < 0) {
            throw new VectorIndexOutOfBoundsException("Bad Index Error");
        }
        return goToElement(num).element;
	}

    @Override
    public void setElement(int num, double value) {
        if (num >= size || num < 0) {
            throw new VectorIndexOutOfBoundsException("Bad Index Error");
        }
        goToElement(num).element = value;
    }

    @Override
    public int getSize() {
        return size;
    }

    @Override
    public void fillFromMass(double[] mass) {
        size = 0;
        head = null;
        for (int i = 0; i < mass.length; i++) {
            addElement(mass[i]);
        }
    }

    @Override
    public void fillFromVector(Vector v) {
        size = 0;
        head = null;
        for (int i = 0; i < v.getSize(); i++) {
            addElement(v.getElement(i));
        }
    }

    @Override
    public void mult(double num) {
        Nod current = head;
        for (int i = 0; i < getSize(); i++) {
            current.element = num * current.element;
            current = current.next;
        }
    }

    @Override
    public void sum(Vector inputVector) throws IncompatibleVectorSizesException {
        if (getSize() != inputVector.getSize()) {
            throw new IncompatibleVectorSizesException();
        } else {
            Nod current = head;
            for (int i = 0; i < getSize(); i++) {
                current.element = inputVector.getElement(i) + current.element;
                current = current.next;
                //setElement(i, getElement(i) + inputVector.getElement(i));
            }
        }
    }
    @Override
    public void insertElement(double value, int index) {
        if (index > size || index < 0) {
            throw new VectorIndexOutOfBoundsException("Bad Index Error");
        }
        if (index == size) {
            addElement(value);
            return;
        }
        Nod curr = goToElement(index);
        Nod newNd = new Nod(value);
        insertElementBefore(curr, newNd);
        if (index == 0){
            head = head.prev;
        }
    }

    @Override
    public void deleteElement(int num) {
        if (num < 0 || num >= size) {
            throw new VectorIndexOutOfBoundsException("Bad Index Error");
        }
        deleteElement(goToElement(num));
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        Nod current = head;
        for (int i = 0; i < getSize(); i++) {
            sb.append(current.element).append(" ");
            current = current.next;
            //sb.append(getElement(i)).append(" ");
        }
        return sb.toString().trim();
    }

    @Override
    public LinkedVector clone() throws CloneNotSupportedException {
        LinkedVector LVClone = (LinkedVector) super.clone();
        LVClone.fillFromVector(this);
        return LVClone;
    }
    //sum, tostring, equals
    @Override
    public boolean equals(Object obj){
        if (this == obj) return true;
        if (!(obj instanceof Vector)) return false;
        Vector tmpVector = (Vector) obj;
        if (size != tmpVector.getSize())
            return false;
        int index = 0;
        Nod current = head;
        while (index != size){
            if (current.element != tmpVector.getElement(index))
                return false;
            current = current.next;
            index++;
        }
        return true;
    } 
}
