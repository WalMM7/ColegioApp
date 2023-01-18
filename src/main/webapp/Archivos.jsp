<%-- 
    Document   : ArchivoTxt
    Created on : 18 ene. 2023, 00:05:43
    Author     : Walter
--%>

<%@page import="com.walcompany.connectors.Connector"%>
<%@page import="com.walcompany.repositories.jdbc.CursoRepository"%>
<%@page import="com.walcompany.repositories.interfaces.I_CursoRepository"%>
<%@page import="com.walcompany.files.I_File"%>
<%@page import="com.walcompany.files.FileText"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/estilo.css"/>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@500&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,800;1,300&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
        <title>ArchivoTxt</title>
    </head>
    <body>
        <div id="d_h1"><h1 id="tituloPrin">Se ha creado con exito el archivo txt con los cursos</h1></div>
        
        <div id="foot_vol_final_archivo">
            <div class="d_vol" id="b_archivo"
                style="display: flex;justify-content:center;align-items: center;">
                <a href="Archivos/Lista Cursos.txt">Ver ARCHIVO</a>
            </div> 
        </div>
        
        
        <%
            I_File fQueryCur = new FileText(
                "C:\\Users\\Walter\\Documents\\4-CURSOS\\1-CURSOS PROGRAMACION\\JavaStandarWebP_2020\\ProyectosNetBeans\\ColegioApp\\src\\main\\webapp\\Archivos\\Lista Cursos.txt");
            fQueryCur.clear();
            fQueryCur.addLine("LISTA DE CURSOS:");
            I_CursoRepository cr = new CursoRepository(Connector.getConexion());
            fQueryCur.addLine("**********************************************");
            fQueryCur.addLines(cr.getAllString());
            fQueryCur.addLine("**********************************************");
                  
        %>
        
    </body>
      
    <footer id="foot_vol_final_archivo">
        <div class="d_vol">
           <a href="Cursos.jsp" id="a_volIc"><span class="material-symbols-outlined" id="ic_volver">arrow_back</span></a>
        </div>
                    
    </footer>
</html>
