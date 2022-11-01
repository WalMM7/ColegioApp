package com.walcompany.connectors;

import java.sql.Connection;
import java.sql.DriverManager;

public class Connector {
    
    // Conexión a la Base de datos "colegio"
       
    //Ruta del DRIVER de conexión
    private static String driver = "com.mysql.cj.jdbc.Driver";
       
    //Conexion localhost:
    /*
    private static String vendor = "mysql";
    private static String server = "localhost";
    private static String port = "3306";
    private static String db = "colegio";
    private static String params = "?zeroDateTimeBehavior=CONVERT_TO_NULL";
    private static String user ="root";
    private static String password = "";
    */
    
    //Conexion remota: free MySQL
    private static String vendor = "mysql";
    private static String server = "sql10.freemysqlhosting.net";
    private static String port = "3306";
    private static String db = "sql10529518";
    private static String params = "?zeroDateTimeBehavior=CONVERT_TO_NULL";
    private static String user ="sql10529518";
    private static String password = "lEplZYfvGF";
    
    // URL
    private static String url ="jdbc:"+vendor+"://"+server+":"+port+"/"+db+params;
    
    //1- Mecanismo para realizar la conexión
    
    private static Connection conn = null; 
    
    private Connector (){};
      
    public synchronized static Connection getConexion(){
        try {                  
            if (conn == null || conn.isClosed()) {
                Class.forName(driver); 
                conn = DriverManager.getConnection(url, user, password);
            }
        }
        catch (Exception e) {System.out.println(e);}
        
        return conn;
    }
    
}
