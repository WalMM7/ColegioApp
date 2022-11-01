<%-- 
    Document   : Cursos
    Created on : 12 jul. 2022, 16:23:36
    Author     : Walter
--%>

<%@page import="java.text.Normalizer"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="com.walcompany.Utils.TableHtml"%>
<%@page import="com.walcompany.entities.Curso"%>
<%@page import="com.walcompany.connectors.Connector"%>
<%@page import="com.walcompany.repositories.jdbc.CursoRepository"%>
<%@page import="com.walcompany.repositories.interfaces.I_CursoRepository"%>
<%@page import="com.walcompany.enums.Turno"%>
<%@page import="com.walcompany.enums.Dia"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    I_CursoRepository cr = new CursoRepository(Connector.getConexion());
    
    int x=0, y=0, s=0, r=0, n=0, z=0, q=0,y1=0,y2=0, idObjetivo;
    String nu="null", msj1="", msj2="";
    Dia dia2;
    Turno turno2;
    
    List<String> dias=new ArrayList();
    for(Dia d:Dia.values()){dias.add(d.toString());}
    
    List<String> turnos=new ArrayList();
    for(Turno t:Turno.values()){turnos.add(t.toString());}
    
    String exRAlf = 
        "^[a-­zA-­ZÀ-ÿ\u00F1\u00D1]{1,15}$|"
        + "^[a-­zA-­ZÀ-ÿ\u00F1\u00D1]{1,15}(\\s)[a-­zA-­ZÀ-ÿ\u00F1\u00D1]{1,15}$|"
        + "^[a-­zA-­ZÀ-ÿ\u00F1\u00D1]{1,15}(\\s)[a-­zA-­ZÀ-ÿ\u00F1\u00D1]{1,15}(\\s)[a-­zA-­ZÀ-ÿ\u00F1\u00D1]{1,15}$|"
        +"^[a-­zA-­ZÀ-ÿ\u00F1\u00D1]{1,13}(\\s)[a-­zA-­ZÀ-ÿ\u00F1\u00D1]{1,13}(\\s)[a-­zA-­ZÀ-ÿ\u00F1\u00D1]{1,13}(\\s)[a-­zA-­ZÀ-ÿ\u00F1\u00D1]{1,13}$";
    Pattern patAlf = Pattern.compile(exRAlf);
    
    String exRCarac="[^(àèìòù`~|}{\\[\\]^_¡¬)]*";
    Pattern patCarac = Pattern.compile(exRCarac);
    
    String exRNum = "^[1-9]{1}\\d*$";
    Pattern patNum = Pattern.compile(exRNum);
    
    String exRHor= "^((08)|(09)|(10)|(11)|(12)|(13)|(14)|(15)|(16)|(17)|(18)|(19)|(20)|"
                + "(21)|(22))"
                + "[:]{1}"
                + "((00)|(01)|(02)|(03)|(04)|(05)|(06)|(07)|(08)|(09)|(10)|(11)|(12)|"
                + "(13)|(14)|(15)|(16)|(17)|(18)|(19)|(20)|(21)|(22)|(23)|(24)|(25)|(26)|"
                + "(27)|(28)|(29)|(30)|(31)|(32)|(33)|(34)|(35)|(36)|(37)|(38)|(39)|(40)|"
                + "(41)|(42)|(43)|(44)|(45)|(46)|(47)|(48)|(49)|(50)|(51)|(52)|(53)|(54)|"
                + "(55)|(56)|(57)|(58)|(59))$";
    Pattern patHor= Pattern.compile(exRHor);

%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cursos</title>
        <link rel="stylesheet" href="css/estilo.css"/>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@500&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,800;1,300&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

    </head>
    <body>
        <a id="a_volver"></a>      
        <ul>
            <li><a href="index.html">Inicio</a></li>
            <li><a class="active" href="Cursos.jsp">Cursos</a></li>
            <li><a href="Alumnos.jsp">Alumnos</a></li>
            <li><a href="Inscripciones.jsp">Inscripciones</a></li>
        </ul>
        <div id="d_h1"><h1 id="tituloPrin">Gestión de cursos</h1></div>
        <div id="d_cuerpo">
            <nav id="n_menu">
                <div id="d_menu">     
                    <a class="a_menu" id="a_alta" href="#alta" title="Ir a form alta cursos">Alta cursos</a>
                    <a class="a_menu" id="a_actualizar" href="#actualizar" title="Ir a form actualización">Actualización cursos</a>
                    <a class="a_menu" id="a_baja" href="#baja" title="Ir a form baja">Baja cursos</a>
                    <a class="a_menu" id="a_buscar" href="#buscar" title="Ir a form busqueda">Busqueda cursos</a>
                    <a class="a_menu" id="a_tablita" href="#tablita" title="Ir tabla">Lista cursos</a>
                    <div id="d_menu_restart">
                        <a class="a_menu" href="Cursos.jsp" id="a_restart"><span class="material-symbols-outlined" id="ic_restart">refresh</span></a>
                    </div>
                </div>     
            </nav>
                    
            <!-- FORM GUARAR -->
            <div class="d_separador"><a id="alta"></a></div>
            <div class="d_combo">
                <div id="d_subTitulo">
                    Dar de alta un nuevo curso
                </div>
                <div class="d_vol">
                    <a href="#a_volver" id="a_volIc"><span class="material-symbols-outlined" id="ic_volver">arrow_upward</span></a>
                </div>   
            </div>
                        
            <%      
                try {
                    String titulo = request.getParameter("titulo");
                    String profesor = request.getParameter("profesor");
                    String dia = request.getParameter("dia");
                    String turno = request.getParameter("turno");
                    String inicio = request.getParameter("inicio");
                    String fin = request.getParameter("fin");

                    if (titulo!=null&&profesor!=null&&dia!=null&&turno!=null&&
                        inicio!=null&&fin!=null) {

                        if (!dias.contains(dia)) {
                            s=1;
                            dia2=null;
                        }else{dia2=Dia.valueOf(dia);}
                        
                        if (!turnos.contains(turno)) {
                            r=1;
                            turno2=null;
                        }else{turno2=Turno.valueOf(turno);}

                        Curso curso = new Curso(titulo,profesor,dia2,turno2,inicio,fin);

                        for(Curso c:cr.getAll()){
                            if (curso.equals(c)) {x=1;}
                        }

                        Matcher mTit1= patAlf.matcher(curso.getTitulo());
                        Matcher mTit2= patCarac.matcher(curso.getTitulo());
                        if (!mTit1.matches()) {y=1;msj1="Titulo";
                        }else{if (!mTit2.matches()) {y=1;msj1="Titulo";}}
                        
                        Matcher mPro1= patAlf.matcher(curso.getProfesor());
                        Matcher mPro2= patCarac.matcher(curso.getProfesor());
                        if (!mPro1.matches()) {y=1;msj2="Profesor";
                        }else{if (!mPro2.matches()) {y=1;msj2="Profesor";}}

                        if (curso.getTitulo().equals(nu)||curso.getProfesor().equals(nu)||
                            curso.getInicio().equals(nu)||curso.getFin().equals(nu)) {n=1;} 

                        Matcher mIni=patHor.matcher(curso.getInicio());
                        Matcher mFin=patHor.matcher(curso.getFin());
                        if (!mIni.matches()||!mFin.matches()) {q=1;}
                                                    
                        //Guardar
                        if (n==0 && x==0 && y==0 && s==0 && r==0 && q==0) {cr.save(curso);}
                     
                        if(curso.getIdcurso()!=0){
                            out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Se ha GUARDADO el curso con id= "+curso.getIdcurso()+"</h4></div>");
                        }else if(x==1){
                            out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>Curso existente en la base de datos</h4></div>");
                        }else if(y==1||s==1||r==1 || n==1 ||q==1){
                            out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Campos completados incorrectamente</h4></div>");
                            if (msj1!="") {out.println("<div class='d_subMsj'><p class='p_smsj'>"+msj1+"</p></div>");}
                            if (msj2!="") {out.println("<div class='d_subMsj'><p class='p_smsj'>"+msj2+"</p></div>");}
                            if (s==1) {out.println("<div class='d_subMsj'><p class='p_smsj'>Dia</p></div>");}
                            if (r==1) {out.println("<div class='d_subMsj'><p class='p_smsj'>Turno</p></div>");}
                            if (n==1) {out.println("<div class='d_subMsj'><p class='p_smsj'>Prohibido null</p></div>");}
                            if (q==1) {out.println("<div class='d_subMsj'><p class='p_smsj'>Horario</p></div>");}
                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ocurrio un error en la BD</h4></div>");}
                    }else{out.println("<div class='d_msj' id='alerta_1'><span class='material-symbols-outlined' id='ic_completar'>edit_document</span><h4>Se requiere completar los campos para guardar un curso</h4></div>");}
                } catch (Exception e) {out.println("<div class='d_msj' id='error_2'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ocurrió un error inesperado</h4></div>");}
            %>
            <form id="f_guardar">
                <div class="d_form">
                    <label for="i_titulo">Titulo:</label>
                    <input type="text" id="i_titulo" name="titulo" minlength="2" maxlength="55" required title="Titulo del curso sin números"/>
                </div>
                <div class="d_form">
                    <label for="i_profesor">Profesor:</label>
                    <input type="text" id="i_profesor" name="profesor" minlength="2" maxlength="55" required title="Nombre y apellido" /> 
                </div>
                <div class="d_form">
                    <label for="s_dia">Día:</label>     
                    <select  id="s_dia" name="dia" required title="Seleccione el día">
                           
                            <%
                                for (Dia d:Dia.values()){
                                    if (!d.equals(d.Lunes)&&!d.equals(d.Martes)&&!d.equals(d.Miercoles)&&
                                        !d.equals(d.Jueves)&&!d.equals(d.Viernes)&&!d.equals(d.Sabado)){
                                            if (d.toString().length()==4) {
                                                 out.println("<option value='"+d+"'>"+d.toString().substring(0,1).toUpperCase()+d.toString().substring(1,2).toLowerCase()+"-"+d.toString().substring(2,3).toUpperCase()+d.toString().substring(3).toLowerCase()+"</option>");
                                            }else{out.println("<option value='"+d+"'>"+d.toString().substring(0,1).toUpperCase()+d.toString().substring(1,2).toLowerCase()+"-"+d.toString().substring(2,3).toUpperCase()+d.toString().substring(3,4).toLowerCase()+"-"+d.toString().substring(4,5).toUpperCase()+d.toString().substring(5).toLowerCase()+"</option>");}
                                    }else{out.println("<option value='"+d+"'>"+d.toString().substring(0,1).toUpperCase()+d.toString().substring(1).toLowerCase()+"</option>");}
                                }  
                  
                            %>
                    </select>
                </div>        
                <div class="d_form">
                    <label  for="s_turno">Turno:</label>
                    <select  id="s_turno" name="turno" required title="Seleccione el turno" >

                            <%
                                for(Turno t:Turno.values()){
                                    out.println("<option value='"+t+"'>"+t+"</option>");
                                }
                            %>
                    </select>
                </div>
                <div class="d_form">
                    <label for="i_inicio">Inicio</label>
                    <input type="time" id="i_inicio" name="inicio" title="Rango horario 08:00 - 22:59"/>
                                            
                </div>
                <div class="d_form">
                    <label for="i_fin">Fin</label>
                    <input type="time" id="i_fin" name="fin" title="Rango horario 08:00 - 22:59"/>
                </div>
                
                <div class="d_bus_bot">
                    <input type="reset" value="Borrar" class="i_resetear"/>
         
                    <input type="submit" value="Guardar" class="i_enviar" id="i_bot_guardar"/>
   
                </div>
            </form>
                      
            <!--FORM ACTUALIZAR -->
            
            <div class="d_separador"><a id="actualizar"></a></div>
            <div class="d_combo">
                <div id="d_subTitulo">
                    Actualizar un curso
                </div>
                <div class="d_vol">
                    <a href="#a_volver" id="a_volIc"><span class="material-symbols-outlined" id="ic_volver">arrow_upward</span></a>
                </div>   
            </div>
            
            <%
                try {
                    String idC = request.getParameter("actualizarCurso");
                    String titulo = request.getParameter("tituloA");
                    String profesor = request.getParameter("profesorA");
                    String dia = request.getParameter("diaA");
                    String turno = request.getParameter("turnoA");
                    String inicio = request.getParameter("inicioA");
                    String fin = request.getParameter("finA");
                                   
                    if (titulo!=null&&profesor!=null&&dia!=null&&turno!=null&&
                        inicio!=null&&fin!=null&&idC!=null) {
      
                        Matcher mIdc= patNum.matcher(idC);
                        if (mIdc.matches()) {
                            idObjetivo = Integer.parseInt(idC);
                        }else{z=1;idObjetivo=0;}
   
                        if (!dias.contains(dia)) {
                            s=1;
                            dia2=null;
                        }else{dia2=Dia.valueOf(dia);}

                        if (!turnos.contains(turno)) {
                            r=1;
                            turno2=null;
                        }else{turno2=Turno.valueOf(turno);}

                        Curso curso = new Curso(idObjetivo,titulo,profesor,dia2,turno2,inicio,fin);
 
                        for(Curso c:cr.getAll()){if (curso.equals(c)) {x=1;}}

                        Matcher mTit1= patAlf.matcher(curso.getTitulo());
                        Matcher mTit2= patCarac.matcher(curso.getTitulo());
                        if (!mTit1.matches()) {y=1;msj1="Titulo";
                        }else{if (!mTit2.matches()) {y=1;msj1="Titulo";}}
                        
                        Matcher mPro1= patAlf.matcher(curso.getProfesor());
                        Matcher mPro2= patCarac.matcher(curso.getProfesor());
                        if (!mPro1.matches()) {y=1;msj2="Profesor";
                        }else{if (!mPro2.matches()) {y=1;msj2="Profesor";}}
            
                        if (curso.getTitulo().equals(nu)||curso.getProfesor().equals(nu)||
                            curso.getInicio().equals(nu)||curso.getFin().equals(nu)) {n=1;}
                
                        Matcher mIni=patHor.matcher(curso.getInicio());
                        Matcher mFin=patHor.matcher(curso.getFin());
                        if (!mIni.matches()||!mFin.matches()) {q=1;}
                
                        //Actualizar
                        if (n==0 && x==0 && y==0 && s==0 && r==0 && z==0 && q==0) {
                            cr.update(curso);
                            out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Se ha ACTUALIZADO el curso con id= "+curso.getIdcurso()+"</h4></div>");
                        }else if(x==1){
                            out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>Curso existente en la base de datos</h4></div>");
                        }else if(y==1 ||s==1||r==1 ||n==1 ||z==1 ||q==1){
                            out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Campos completados incorrectamente</h4></div>");
                            if (z==1) {out.println("<div class='d_subMsj'><p class='p_smsj'>id curso</p></div>");}
                            if (msj1!="") {out.println("<div class='d_subMsj'><p class='p_smsj'>"+msj1+"</p></div>");}
                            if (msj2!="") {out.println("<div class='d_subMsj'><p class='p_smsj'>"+msj2+"</p></div>");}
                            if (s==1) {out.println("<div class='d_subMsj'><p class='p_smsj'>Dia</p></div>");}
                            if (r==1) {out.println("<div class='d_subMsj'><p class='p_smsj'>Turno</p></div>");}
                            if (n==1) {out.println("<div class='d_subMsj'><p class='p_smsj'>Prohibido null</p></div>");}
                            if (q==1) {out.println("<div class='d_subMsj'><p class='p_smsj'>Horario</p></div>");}
                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ocurrio un error en la BD</h4></div>");}
                    }else{out.println("<div class='d_msj' id='alerta_1'><span class='material-symbols-outlined' id='ic_completar'>edit_document</span><h4>Se requiere completar los campos para actualizar un curso</h4></div>");}
                } catch (Exception e) {out.println("<div class='d_msj' id='error_2'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ocurrió un error inesperado</h4></div>");}
                
            %>
                        
            <form id="f_act">
                <div class="d_form">
                    <label for="s_curso">Actualizar curso:</label>
                    <select id="s_curso" name="actualizarCurso" title="Seleccione un curso">
                        <option value="">Selecionar</option>
                        <%
                            for(Curso c:cr.getAll()){
                                out.println("<option value='"+c.getIdcurso()+"'>"+c.getIdcurso()+" - "+c.getTitulo()+" - "+c.getProfesor()+" - "+c.getDia()+" - "+c.getTurno()+" - "+c.getInicio()+" - "+c.getFin()+"</option>");
                            }
                        %>
                    </select>
                </div>
                <div class="d_form">
                    <label for="i_titulo">Titulo:</label>
                    <input type="text" id="i_titulo" name="tituloA" minlength="2" maxlength="55" required title="Titulo del curso sin números"/>
                </div>
                <div class="d_form">
                    <label for="i_profesor">Profesor:</label>
                    <input type="text" id="i_profesor" name="profesorA" minlength="2" maxlength="55" required title="Nombre y apellido" /> 
                </div>
                <div class="d_form">
                    <label for="s_dia">Día:</label>     
                    <select  id="s_dia" name="diaA" required title="Seleccione el día">
                        <%
                                for (Dia d:Dia.values()){
                                                                    
                                    if (!d.equals(d.Lunes)&&!d.equals(d.Martes)&&!d.equals(d.Miercoles)&&
                                            !d.equals(d.Jueves)&&!d.equals(d.Viernes)&&!d.equals(d.Sabado)){
                                                if (d.toString().length()==4) {
                                                    out.println("<option value='"+d+"'>"+d.toString().substring(0,1).toUpperCase()+d.toString().substring(1,2).toLowerCase()+"-"+d.toString().substring(2,3).toUpperCase()+d.toString().substring(3).toLowerCase()+"</option>");
                                                }else{out.println("<option value='"+d+"'>"+d.toString().substring(0,1).toUpperCase()+d.toString().substring(1,2).toLowerCase()+"-"+d.toString().substring(2,3).toUpperCase()+d.toString().substring(3,4).toLowerCase()+"-"+d.toString().substring(4,5).toUpperCase()+d.toString().substring(5).toLowerCase()+"</option>");}
                                    }else{out.println("<option value='"+d+"'>"+d.toString().substring(0,1).toUpperCase()+d.toString().substring(1).toLowerCase()+"</option>");}
                                }
                        %>
                    </select>
                </div>        
                <div class="d_form">
                    <label  for="s_turno">Turno:</label>
                    <select  id="s_turno" name="turnoA" required title="Seleccione el turno" >
                        <%
                                for(Turno t:Turno.values()){
                                    out.println("<option value='"+t+"'>"+t+"</option>");}
                        %>
                    </select>
                </div>
                <div class="d_form">
                    <label for="i_inicio">Inicio</label>
                    <input type="time" id="i_inicio" name="inicioA" title="Rango horario 08:00 - 22:59"/>
                </div>
                <div class="d_form">
                    <label for="i_fin">Fin</label>
                    <input type="time" id="i_fin" name="finA" title="Rango horario 08:00 - 22:59"/>
                </div>
                
                <div class="d_bus_bot">
                    <input type="submit" value="Actualizar" class="i_enviar"/>
                </div>
            </form>
            
            <!-- FORM ELEIMINAR -->
            
            <div class="d_separador"><a id="baja"></a></div>
            <div class="d_combo">
                <div id="d_subTitulo">
                    Dar de baja un curso
                </div>
                <div class="d_vol">
                    <a href="#a_volver" id="a_volIc"><span class="material-symbols-outlined" id="ic_volver">arrow_upward</span></a>
                </div>   
            </div>
            
            <%  
                try {
                    String elimCur = request.getParameter("eliminarCurso");
                   
                    if (elimCur!=null) {
                        Matcher mat= patNum.matcher(elimCur);
                        if (mat.matches()) {
                            idObjetivo = Integer.parseInt(elimCur);
                        }else{z=1;idObjetivo=0;}
                                          
                        Curso c1 = cr.getById(idObjetivo);

                        if (c1.getIdcurso()!=0) {
                            cr.remove(c1);
                            out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Se ha ELIMINADO el curso con id= "+elimCur+"</h4></div>");
                        }else if(elimCur.equals("0")){
                            out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No es valido el id curso = 0</h4></div>");
                        }else if(z==1){
                            out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ingrese caracteres numéricos</h4></div>");
                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No existe en la BD el curso con id = "+elimCur+"</h4></div>");}
                    }else{out.println("<div class='d_msj' id='alerta_1'><span class='material-symbols-outlined' id='ic_completar'>edit_document</span><h4>Se requiere asignar un curso para su eliminación</h4></div>");}
                } catch (Exception e) {out.println("<div class='d_msj' id='error_2'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ocurrió un error inesperado</h4></div>");}
            %>
            
            <form id="f_elim">
                <div class="d_form">
                    <label for="s_curso">Eliminar curso:</label>
                    <select id="s_curso" name="eliminarCurso" title="Seleccione un curso">
                        <option value="">Selecionar</option>
                        <%
                            for(Curso c:cr.getAll()){
                                out.println("<option value='"+c.getIdcurso()+"'>"+c.getIdcurso()+" - "+c.getTitulo()+" - "+c.getProfesor()+" - "+c.getDia()+" - "+c.getTurno()+" - "+c.getInicio()+" - "+c.getFin()+"</option>");
                            }
                        %>
                    </select>
                </div>
                    
                <div class="d_bus_bot">
                    <input type="submit" value="Eliminar" class="i_enviar"/>
                </div>
            </form>
                    
            <!-- FORM BUSCAR -->
            
            <div class="d_separador"><a id="buscar"></a></div>
            <div class="d_combo">
                <div id="d_subTitulo">
                    Buscar un curso
                </div>
                <div class="d_vol">
                    <a href="#a_volver" id="a_volIc"><span class="material-symbols-outlined" id="ic_volver">arrow_upward</span></a>
                </div>   
            </div>
            <div id="d_f_bus">
                <form>
                    <div  class="d_form">
                        <label for="i_buscarTitulo" class="l_vertical">Buscar título:</label>
                        <input type="text" name="buscarTitulo" title="Titulo del curso sin números" id="i_buscarTitulo">
                    </div>
                    <div class="d_form">
                        <label for="i_buscarProfesor" class="l_vertical">Buscar profesor:</label>
                        <input type="text" name="buscarProfesor" title="Nombre y apellido" id="i_buscarProfesor">
                    </div>
                    
                    <div class="d_bus_bot">
                        <input type="reset" value="Borrar" class="i_resetear"/>
                        <input type="submit" value="Buscar" class="i_enviar" id="i_bot_busTP"/> 
                    </div>
                </form>
                <form>
                    <div  class="d_form" id="d_bus_input">
                        <label for="i_buscarIdCur" class="l_vertical">Buscar ID:</label>
                        <input  type="number" name="buscarIdCurso" title="Caracteres numéricos" id="i_buscarIdCur" min="1">
                    </div>
                    <div class="d_bus_bot">
                        <input type="reset" value="Borrar" class="i_resetear"/>
                        <input type="submit" value="Buscar" class="i_enviar" id="i_bot_bus"/>
                    </div>
                </form> 
            </div>
      
            <a id="tablita"></a>
            <%
                try {
                    String busTitulo = request.getParameter("buscarTitulo");
                    String busProfesor = request.getParameter("buscarProfesor");
                    String busIdCurso = request.getParameter("buscarIdCurso");

                    List<Curso>li=new ArrayList();
                    li.addAll(cr.getLikeTituloProfesor(busTitulo, busProfesor));
          
                    if (cr.getAll().size()!=0) {
                        if (busIdCurso==null||busIdCurso.isBlank()) {
                            if ((busTitulo==null||busTitulo.isBlank())&&
                                (busProfesor==null||busProfesor.isBlank())) {
                                out.println("<div class='d_msj' id='alerta_1'><span class='material-symbols-outlined' id='ic_completar'>edit_document</span><h4>Se requiere completar cuaquiera de los campos para hacer una busqueda</h4></div>");
                                out.println("<div class='d_table'>"+new TableHtml().getTable(cr.getAll())+"</div>");
                            }else if(busTitulo!=null&&busProfesor!=null){

                                Matcher mTit1= patAlf.matcher(busTitulo);
                                Matcher mTit2= patCarac.matcher(busTitulo);
                                if (!mTit1.matches()) {y1=1;
                                }else{if (!mTit2.matches()) {y1=1;}}

                                Matcher mPro1= patAlf.matcher(busProfesor);
                                Matcher mPro2= patCarac.matcher(busProfesor);
                                if (!mPro1.matches()) {y2=1;
                                }else{if (!mPro2.matches()) {y2=1;}}

                                if (!busTitulo.isBlank()&& busProfesor.isEmpty()) {
                                    //titulo
                                    if (y1==0) {
                                        if(li.size()!=0){
                                            out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                            out.println("<div class='d_table'>"+new TableHtml().getTable(li)+"</div>");
                                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No hubo coincidencias</h4></div>");}
                                    }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Debe ingresar caracteres alfabéticos</h4></div>");}
                                }
                                if(!busProfesor.isBlank()&& busTitulo.isEmpty()){
                                    //profesor
                                    if (y2==0) {
                                        if(li.size()!=0){
                                                out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                                out.println("<div class='d_table'>"+new TableHtml().getTable(li)+"</div>");
                                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No hubo coincidencias</h4></div>");}
                                    }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Debe ingresar caracteres alfabéticos</h4></div>");}
                                }
                                if(!busTitulo.isBlank()&& !busProfesor.isBlank()){
                                    //titulo y profesor
                                    if (y1==0 && y2==0) {
                                        if(li.size()!=0){
                                            out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                            out.println("<div class='d_table'>"+new TableHtml().getTable(li)+"</div>");
                                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No hubo coincidencias</h4></div>");}
                                    }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Debe ingresar caracteres alfabéticos</h4></div>");}
                                }
                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>Se produjo un ERROR en los campos 'titulo y profesor'</h4></div>");}
                        }else{
                            //idCurso
                            Matcher mat= patNum.matcher(busIdCurso);
                            if (!mat.matches()) {
                                z=1;
                                idObjetivo=0;
                            }else{idObjetivo = Integer.parseInt(busIdCurso);}

                            Curso c1 = cr.getById(idObjetivo);

                            if (z==0) {
                                if (c1.getIdcurso()!=0) {
                                    out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas (id)</h4></div>");
                                    out.println("<div class='d_table'>"+new TableHtml().getTable(c1)+"</div>");
                                }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No existe el curso</h4></div>");}
                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ingrese solamente caracteres numéricos y mayores a cero</h4></div>");}
                        }
                    }else{out.println("<div class='d_msj' id='alerta_1'><h4 style='font-weight:800;'>No hay registros de cursos</h4></div>");}
                } catch (Exception e) {out.println("<div class='d_msj' id='error_2'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ocurrió un error inesperado</h4></div>");}
            %>
            <footer id="foot_vol_final">
                <div class="d_vol" >
                    <a href="#a_volver" id="a_volIc"><span class="material-symbols-outlined" id="ic_volver">arrow_upward</span></a>
                </div>
            </footer>
        </div>
    </body>
</html>
