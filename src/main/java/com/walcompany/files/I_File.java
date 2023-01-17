package com.walcompany.files;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;

public interface I_File {
    
    // METODOS DE ESCRITURA
    /**
     *seText:
     * Agrega una palabra y borra lo anterior
     */
    public abstract void setText(String texto);
    
    /**
     * appendText:
     * Agrega texto al final del texto existente.
     */
    void appendText(String texto);
    
    /**
     * Agrega una linea de texto y da un enter
     */
    default void addLine(String linea){
        appendText(linea+"\n");
    }
    
    /**
     * Agrega varias lineas de texto una debajo de la otra
     */
    default void addLines(List<String> lineas){
        lineas.forEach(this::addLine);
    }
    
    // METODOS DE LECTURA
    /**
     * Retorna el texto agregado
     */
    public abstract String getText();
    
    /**
     * Imprime el texto obtenido
     */
    default void printText(){
        System.out.println(getText());
    }
    
    /**
     * Obtiene todas las lineas agregadas
     */
    List<String> getAll();
    
    default void printGetAll(){
        getAll().forEach(System.out::println);
    }
    default void printSorted(){
        getSortedLines().forEach(System.out::println);
    }
   
    //METODOS DE LECTURA->CON ORDENAMINETO O FILTRADO
    /**
     * Devuelve las lineas de texto que contengan el texto buscado
     */
    default List<String> getLikeFilter(String texto){
        if (texto==null) {
            return new ArrayList();
        }else{
            return getAll()
                    .stream()
                    .filter(t->t.toLowerCase().contains(texto.toLowerCase()))
                    .collect(Collectors.toList());
        }
    }
    /**
     * Devuelve listas ordenadas/sin duplicados, etc
     */
    default List<String> getSortedLines(){
        return getAll()
                .stream()
                .sorted()
                .collect(Collectors.toList());
    }
    default List<String> getReverseSortedLines(){
        return getAll()
                .stream()
                .sorted(Comparator.reverseOrder())
                .collect(Collectors.toList());
    }
    default Set<String> getLikedHashSet(){
        Set<String> set=new LinkedHashSet();
        set.addAll(getAll());
        return set;
    }
    default Set<String> getTreeSet(){
        Set<String> set=new TreeSet();
        set.addAll(getAll());
        return set;
    }
    
    //METODOS DE ELIMINACION
    /**
     * Elimina todo el texto o lineas
     */
    default void clear(){
        setText("");
    }
    
    /**
     * Elimina un texto especifico
     */
    default void delete(String linea){
        //List<String>list=getAll();
        List<String> list=new ArrayList();
        list.addAll(getAll());
        list.remove(linea);
        clear();
        addLines(list);
    };
}
