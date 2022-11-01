package com.walcompany.Utils;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

public class TableHtml<E> {
    
    /**
     * Metodo para crear una tabla
    */
    
    List<Field> camposNuevos = new ArrayList();
    
    String[] camposShort={"idReg","año","idAlum","idCurso"};
    
    String[] camposMedium={"idReg","año","idAlum","dni","nombre","apellido",
        "idCurso","titulo","profesor","dia","turno","inicio","fin"};
       
    // Metodo tabla: cursos, alumnos y inscripcion (alumnos a cursos)
    public String getTable(List<E> list){
        String table="";
        if (list==null || list.isEmpty()) {return table;}
        E e=list.get(0);
        String nomClase="Inscripcion";
        if (e.getClass().getSimpleName().equals(nomClase)) {
            table+="<table id=\"table_3\">";
            table+="<caption>Tabla simplificada: Alumnos y cursos</caption>";
            Field[] campos = e.getClass().getDeclaredFields();
            for(Field c:campos){
                for (String s:camposShort) {
                    if (c.getName().equals(s)) {camposNuevos.add(c);}}
            }
            table+="<thead>";
            table+="<tr>";
            for(Field c:camposNuevos){
                table+="<th>"+c.getName()+"</th>";
            }
            table+="</tr>";
            table+="</thead>";
            table+="<tbody>";
            for(E o:list){
                table+="<tr>";
                for(Field c:camposNuevos){
                    table+="<td>";
                    String metodo="get"+c.getName().substring(0,1).toUpperCase()+
                        c.getName().substring(1);
                    try {
                        table+=e.getClass().getMethod(metodo,null).invoke(o,null); 
                        } catch (Exception ex) {System.out.println(ex);}
                    table+="</td>";
                }
                table+="</tr>";
            }
            table+="</tbody>";
            table+="</table>";
            return table;
        }else{
            String nomClase1="Curso";
            if (e.getClass().getSimpleName().equals(nomClase1)) {
                table+="<table id=\"table_1\">";
            }else{table+="<table id=\"table_2\">";}
            table+="<caption>"+e.getClass().getSimpleName()+"s"+"</caption>";
            Field[] campos = e.getClass().getDeclaredFields();
            table+="<thead>";
            table+="<tr>";
            for(Field c:campos){
                table+="<th>"+c.getName()+"</th>";
            }
            table+="</tr>";
            table+="</thead>";
            table+="<tbody>";
            for(E o:list){
                table+="<tr>";
                for(Field c:campos){
                    table+="<td>";
                    String metodo="get"+c.getName().substring(0,1).toUpperCase()+
                            c.getName().substring(1);
                    try {
                        table+=e.getClass().getMethod(metodo,null).invoke(o,null); 
                    } catch (Exception ex) {System.out.println(ex);}
                    table+="</td>";
                }
                table+="</tr>";
            }
            table+="</tbody>";
            table+="</table>";

            return table;
        }
    }
   
    //Metodo tabla: consulta innerjJoin Medium
    public String getTableInnerJM(List<E> list){
        String table="";
        if (list==null || list.isEmpty()) {return table;}
        
        E e=list.get(0);
        table+="<table>";
        table+="<caption>Tabla detallada: Alumnos y cursos</caption>";
        Field[] campos = e.getClass().getDeclaredFields();
        for(Field c:campos){
            for (String m:camposMedium) {
                if (c.getName().equals(m)) {camposNuevos.add(c);}}
        }
        table+="<thead>";
        table+="<tr>";
        for(Field c:camposNuevos){
            table+="<th>"+c.getName()+"</th>";
        }
        table+="</tr>";
        table+="</thead>";
        table+="<tbody>";
        for(E o:list){
            table+="<tr>";
            for(Field c:camposNuevos){
                table+="<td>";
                String metodo="get"+c.getName().substring(0,1).toUpperCase()+
                    c.getName().substring(1);
                try {
                    table+=e.getClass().getMethod(metodo,null).invoke(o,null); 
                    } catch (Exception ex) {System.out.println(ex);}
                table+="</td>";
            }
            table+="</tr>";
        }
        table+="</tbody>";
        table+="</table>";

        return table;
    }

   // Metodo tabla con parametro 1 objeto 
   public String getTable(Object obj){
        String table="";
        if (obj==null) {return table;}
        String nomClase="Inscripcion";
        if (obj.getClass().getSimpleName().equals(nomClase)) {
            table+="<table>";
            table+="<caption>Tabla detallada: Alumnos y Cursos</caption>";
            table+="<thead>";
            Field[] campos = obj.getClass().getDeclaredFields();
            for(Field c:campos){
                for (String m:camposMedium) {
                    if (c.getName().equals(m)) {camposNuevos.add(c);}}
            }
            table+="<tr>";
            for(Field c:camposNuevos){
                table+="<th>"+c.getName()+"</th>";
            }
            table+="</tr>";
            table+="</thead>";
            table+="<tbody>";
            table+="<tr>";
            for(Field c:camposNuevos){
                table+="<td>";
                String metodo="get"+c.getName().substring(0,1).
                        toUpperCase()+c.getName().substring(1);
                try {
                    table+=obj.getClass().getMethod(metodo,null).invoke(obj,null); 
                } catch (Exception ex) {System.out.println(ex);}

                table+="</td>";
            }
            table+="</tr>";
            table+="</tbody>";
            table+="</table>";

            return table;
            
        }else{
            String nomClase1="Curso";
            if (obj.getClass().getSimpleName().equals(nomClase1)) {
                table+="<table id=\"table_1\">";
            }else{table+="<table id=\"table_2\">";}
            table+="<caption>"+obj.getClass().getSimpleName()+"s"+"</caption>";
            Field[] campos = obj.getClass().getDeclaredFields();
            table+="<thead>";
            table+="<tr>";
            for(Field c:campos){
                table+="<th>"+c.getName()+"</th>";
            }
            table+="</tr>";
            table+="</thead>";
            table+="<tbody>";
            table+="<tr>";
            for(Field c:campos){
                table+="<td>";
                String metodo="get"+c.getName().substring(0,1)
                        .toUpperCase()+c.getName().substring(1);
                try {
                    table+=obj.getClass().getMethod(metodo,null).invoke(obj,null); 
                } catch (Exception ex) {System.out.println(ex);}

                table+="</td>";
            }
            table+="</tr>";
            table+="</tbody>";
            table+="</table>";

            return table;
        }
    }
}
