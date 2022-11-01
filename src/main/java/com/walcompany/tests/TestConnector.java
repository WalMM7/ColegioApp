package com.walcompany.tests;

import com.walcompany.connectors.Connector;
import java.sql.ResultSet;
import java.time.LocalTime;

/**
 *
 * @author Walter
 */
public class TestConnector {
    
    public static void main(String[] args) {
              
        try(ResultSet rs = Connector
                                .getConexion()
                                .createStatement()
                                .executeQuery("select version()");){
            if (rs.next()) {
                System.out.println("Se pudo conectar a "+rs.getString(1));
            }else{System.out.println("No se pudo conectar a la BASE DE DATOS");}
            
            
        } catch (Exception e) {
            System.out.println("No se pudo conectar a la BASE DE DATOS");
            System.out.println(e);
        }
      
            
    }
  
    
}
