package com.walcompany.tests;

import com.walcompany.files.*;
import com.walcompany.connectors.Connector;
import com.walcompany.repositories.interfaces.I_CursoRepository;
import com.walcompany.repositories.jdbc.CursoRepository;
import java.util.List;

public class TestFile {
    
    public static void main(String[] args) {
        
       I_File fQueryCur = new FileText("cursos_query.txt");
       // Al no especificar una ruta el archivo se crea dentro del proyecto
       
       I_CursoRepository cr = new CursoRepository(Connector.getConexion());
       
       fQueryCur.clear();
       fQueryCur.addLine("LISTA DE CURSOS:");
       fQueryCur.addLine("__________________________________________________________"
               + "___________");
       fQueryCur.addLines(cr.getAllString());
       fQueryCur.addLine("__________________________________________________________"
               + "____________");
       
       fQueryCur.printGetAll();
    }
    
}
