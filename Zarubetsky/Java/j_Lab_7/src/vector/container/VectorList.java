/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vector.container;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import vector.*;
/**
 *
 * @author AdminY
 */
public class VectorList extends VectorCollection implements List {
    
    public VectorList(Vector[] data) {
        super(data);
    }
    
    @Override
    public Object get(int index) {
        return this.data[index];
    }

    @Override
    public Object set(int index, Object element) {
       this.data[index] = (Vector)element;
       return this;
    }
    
    @Override
    public void add(int index, Object element) {
        if ((element instanceof Vector) || element == null){
            
        } else {
            throw new ClassCastException();
        }
    }
    
    
    
    
    
    @Override
    public boolean addAll(int index, Collection c) {
        if ((!(c instanceof Vector)) || c == null){
            return false;
        } else {
            Vector[] newVectorArray = (Vector[]) c.toArray();
            
        }
            
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.

        /*
        for (int i = 0; i < newVectorArray.length; i++) {
            this.add(index, tmp);
        }
        if (tmp > 0){
            return true;
        }
        else{
            return false;
        }

        }*/
    }





    @Override
    public Object remove(int index) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int indexOf(Object o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int lastIndexOf(Object o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ListIterator listIterator() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ListIterator listIterator(int index) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List subList(int fromIndex, int toIndex) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }


    
    
    
    
    
}
