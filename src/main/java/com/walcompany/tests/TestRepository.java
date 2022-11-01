
package com.walcompany.tests;

import com.walcompany.connectors.Connector;
import com.walcompany.repositories.interfaces.I_InscripcionRepository;
import com.walcompany.repositories.jdbc.InscripcionRepository;

public class TestRepository {
    
    public static void main(String[] args) {
              
       I_InscripcionRepository ir = new InscripcionRepository(Connector.getConexion());         
       for (int i = 0; i <ir.getAllInnerJM().size(); i++) {
            System.out.println(ir.getAllInnerJM().get(i).toStringMedium());
        }
        System.out.println("-------------------------------");
        ir.getAllInnerJM().forEach(System.out::println);
       
      
      
      
    
    }
}
