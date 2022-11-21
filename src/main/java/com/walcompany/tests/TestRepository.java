
package com.walcompany.tests;

import com.walcompany.connectors.Connector;
import com.walcompany.repositories.interfaces.I_InscripcionRepository;
import com.walcompany.repositories.jdbc.InscripcionRepository;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class TestRepository {
    
    public static void main(String[] args) {
              
       I_InscripcionRepository ir = new InscripcionRepository(Connector.getConexion());         
       for (int i = 0; i <ir.getAllInnerJM().size(); i++) {
            System.out.println(ir.getAllInnerJM().get(i).toStringMedium());
        }
        System.out.println("-------------------------------");
        ir.getAllInnerJM().forEach(System.out::println);
       
       // Curso curso= new Curso("", profesor, Dia.MiVi, Turno.Tarde, inicio, fin);
        System.out.println("--------------Prueba array list-----------------");
       List<String> lista= new ArrayList();
       String txt1="Curso existente en la BD";
       String txt2="Titulo";
       String txt3="Profesor";
       
       lista.add(txt1);
       lista.add(txt2);
       lista.add(txt3);
       
       lista.forEach(System.out::println);
       
        if (lista.contains("Curso existente en la BD")) {
            System.out.println("Verdadero");
            
        }else{System.out.println("False");}
        
        String txt4 = txt2.substring(0,2)+"-"+txt2.substring(2);
        
        System.out.println("txt4="+txt4);
        
        System.out.println("---------Prueba expresiones regulares---------");
        
        String CA="011";
        String NUM ="1538619191";
        String TEL="("+CA+")"+" - "+NUM;
        
        System.out.println("tel="+TEL);
        String erExtraer=
            ".(\\d+).\\s-\\s(\\d+)";
        // el . indica cualquier caracter 1 vez
        Pattern p = Pattern.compile(erExtraer);
        Matcher m = p.matcher(TEL);
        
        if (m.find()) {
            System.out.println("Codigo área="+m.group(1));
            System.out.println("Numero="+m.group(2));
        }else{System.out.println("falló");}
        
        
    
    }
}
