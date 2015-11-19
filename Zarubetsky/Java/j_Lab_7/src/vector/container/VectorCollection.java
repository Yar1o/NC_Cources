/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vector.container;
import java.util.Collection;
import java.util.Iterator;
import vector.*;
        
        
/**
 *
 * @author AdminY
 */
public class VectorCollection implements Collection{
    
    protected Vector[] data;

    public VectorCollection(Vector[] data) {
        this.data = data;
    }
    
    @Override
    public int size() {
        return data.length;
    }

    @Override
    public boolean isEmpty() {
        if(data == null){
            return false;
        }
        else if (data.length == 0){
            return true;
        }
        else return false;
    }

    @Override
    public boolean contains(Object o) {
        Vector tmp = (Vector)o;
        int tmp2 = 0;
        for (int i = 0; i < data.length; i++) {
            if (this.data[i].equals(o)) tmp2++;
        }
        if (tmp2 > 0){
            return true;
        }
        else{
            return false;
        }
    }

    @Override
    public Iterator<Vector> iterator() {
        throw new UnsupportedOperationException();
    }

    @Override
    public Object[] toArray() {
        Vector[] newArray =  new Vector[data.length];
        System.arraycopy(data, 0, newArray, 0,  data.length);
        return newArray;
    }

    @Override
    public Object[] toArray(Object[] a) {
        if (a.length >= size()){
            System.arraycopy(data,0,a,0,data.length);
            int diff = a.length - size();
            for (int i = 0; i < diff; i++) {
                a[data.length+i] = null;
            }
        } else {
            a =  new Vector[data.length];
            System.arraycopy(data, 0, a, 0,  data.length);
        }
        return a;
    }

    @Override
    public boolean add(Object o) {
        if ((o instanceof Vector) || o == null){
            Vector[] tmpArray = new Vector[data.length];
            System.arraycopy(data, 0, tmpArray, 0, data.length);
            data = new Vector[data.length + 1];
            System.arraycopy(tmpArray, 0, data, 0, data.length-1);
            data[data.length-1] = (Vector)o;
            return true;
        } else {
            throw new ClassCastException();
        }
    }

    @Override
    public boolean remove(Object o) {
        if ((o instanceof Vector) || o == null){
            for (int i = 0; i < data.length; i++) {
                if (o == null ? data[i] == null : data[i].equals(o)) {
                    Vector[] tmpArray = new Vector[data.length - 1];
                    System.arraycopy(data, 0, tmpArray, 0, i);
                    if (i != data.length - 1) {
                        System.arraycopy(data, i + 1, tmpArray, i, data.length - 1 - i);
                    }
                    data = new Vector[data.length - 1];
                    System.arraycopy(tmpArray, 0, data, 0 , data.length);
                    return true;
                }
            }
        } else {
            throw new ClassCastException();
        }
        return false;
    }

    @Override
    public boolean containsAll(Collection c) {
        Vector[] newVectorArray = (Vector[]) c.toArray();
        int tmp = 0;
        for (int i = 0; i < newVectorArray.length; i++) {
            if (this.contains(newVectorArray[i])) tmp++;
        }
        if (tmp > 0){
            return true;
        }
        else{
            return false;
        }
    }

    @Override
    public boolean addAll(Collection c) {
        Vector[] newVectorArray = (Vector[])c.toArray();
        Vector[] tmpArray = data.clone();
        data = new Vector[data.length + newVectorArray.length];
        System.arraycopy(tmpArray, 0, data, 0, tmpArray.length);
        System.arraycopy(newVectorArray, 0, data, tmpArray.length, newVectorArray.length);
        return true;
    }

    @Override
    public boolean removeAll(Collection c) {
        int cnt = 0;
        for (int i = 0; i < data.length;) {
            if (c.contains(data[i])){
                remove(data[i]);
                cnt++;
            }else{
                i++;
            }
        }
        if (cnt == 0){return false;}
        return true;
    }

    @Override
    public boolean retainAll(Collection c) {
        int cnt = 0;
        for (int i = 0; i < data.length; ) {
            if (!c.contains(data[i])){
                remove(data[i]);
                cnt++;
            } else {
                i++;
            }
        }
        if (cnt == 0){return false;}
        return true;
    }

    @Override
    public void clear() {
       data = new Vector[0];
    }
}
