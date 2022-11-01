<%-- 
    Document   : Alumnos
    Created on : 27 jul. 2022, 16:13:30
    Author     : Walter
--%>

<%@page import="java.text.Normalizer"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.LinkedHashSet"%>
<%@page import="java.util.Set"%>
<%@page import="com.walcompany.Utils.TableHtml"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="com.walcompany.repositories.jdbc.AlumnoRepository"%>
<%@page import="com.walcompany.repositories.interfaces.I_AlumnoRepository"%>
<%@page import="com.walcompany.entities.Alumno"%>
<%@page import="com.walcompany.connectors.Connector"%>
<%@page import="com.walcompany.repositories.interfaces.I_CursoRepository"%>
<%@page import="com.walcompany.repositories.jdbc.CursoRepository"%>
<%@page import="com.walcompany.entities.Curso"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    I_AlumnoRepository ar = new AlumnoRepository(Connector.getConexion());
    
    int x=0, y=0, s=0, n=0, z=0, q=0, w=0,y1=0,y2, idObjetivo;
    int edad2=0;
    String nu="null", dni2="0";
            
    String[] msj={"","","","","","",""};
    //msj[0]=nom,[1]=ape,[2]=edad,[3]=DNI,[4]=tel-cod.área,[5]=tel-número,[6]=texto-null.
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
        
    String exRDni = "^[^0][0-9]{6,7}";
    Pattern patDni = Pattern.compile(exRDni);
    
    String exRTelCa ="^0[1-9]{2,4}$";
    Pattern patTelCa = Pattern.compile(exRTelCa);
    String exRTelNt ="^15[1-9]{1}[0-9]{5,7}$|^[234567][0-9]{5,7}$";
    Pattern patTelNt = Pattern.compile(exRTelNt);
    
    DecimalFormat miles = new DecimalFormat("###,###");
  
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alumnos</title>
        <link rel="stylesheet" href="css/estilo.css"/>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@500&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,800;1,300&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
            
    </head>
    <body>
        <a id="a_volver"></a> 
        <ul>
            <li><a href="index.html">Inicio</a></li>
            <li><a href="Cursos.jsp">Cursos</a></li>
            <li><a class="active" href="Alumnos.jsp">Alumnos</a></li>
            <li><a href="Inscripciones.jsp">Inscripciones</a></li>
        </ul>
        <div id="d_h1"><h1 id="tituloPrin">Gestión de alumnos</h1></div>
        <div id="d_cuerpo">
            <nav id="n_menu">
                <div id="d_menu">     
                    <a class="a_menu" id="a_alta" href="#alta" title="Ir a form alta alumnos">Alta alumnos</a>
                    <a class="a_menu" id="a_actualizar" href="#actualizar" title="Ir a form actualización alumnos">Actualización alumnos</a>
                    <a class="a_menu" id="a_baja" href="#baja" title="Ir a form baja alumnos">Baja alumnos</a>
                    <a class="a_menu" id="a_buscar" href="#buscar" title="Ir a form busqueda alumnos">Busqueda alumnos</a>
                    <a class="a_menu" id="a_tablita" href="#tablita" title="Ir tabla">Lista alumnos</a>
                    <div id="d_menu_restart">
                        <a class="a_menu" href="Alumnos.jsp" id="a_restart"><span class="material-symbols-outlined" id="ic_restart">refresh</span></a>
                    </div>
                </div>     
            </nav>
            
            <!-- FORM GUARDAR -->
            
            <div class="d_separador"><a id="alta"></a></div>
            <div class="d_combo">
                <div id="d_subTitulo">
                    Dar de alta un nuevo alumno
                </div>
                <div class="d_vol">
                    <a href="#a_volver" id="a_volIc"><span class="material-symbols-outlined" id="ic_volver">arrow_upward</span></a>
                </div>   
            </div>
            
            <%
                try {
                    String nombre = request.getParameter("nombre");
                    String apellido = request.getParameter("apellido");
                    String edad = request.getParameter("edad");
                    String dni = request.getParameter("dni");
                    String codAre = request.getParameter("codAre");
                    String numTel = request.getParameter("numTel");
                                                                       
                    if (nombre!=null&&apellido!=null&&edad!=null&&dni!=null&&
                        codAre!=null&&numTel!=null) {
                    
                        String telefono="("+codAre+") - "+numTel;
                    
                        Matcher mEdad = patNum.matcher(edad);
                        if (mEdad.matches()) {edad2 = Integer.parseInt(edad);}
                 
                        Matcher mDni = patDni.matcher(dni);
                        if (mDni.matches()) {
                            dni2 = miles.format(Integer.parseInt(dni));
                        }else{w=1;dni2="0"; msj[3]="DNI";}
              
                        Alumno alumno = new Alumno(nombre,apellido,edad2,dni2,telefono);
                   
                        for(Alumno a:ar.getAll()){if (alumno.getDni().equals(a.getDni())) {x=1;}}
                     
                        if (alumno.getEdad()<18||alumno.getEdad()>120) {z=1;msj[2]="Edad";}

                        Matcher mNom1= patAlf.matcher(alumno.getNombre());
                        Matcher mNom2= patCarac.matcher(alumno.getNombre());
                        if (!mNom1.matches()) {y=1;msj[0]="Nombre";
                        }else{if (!mNom2.matches()) {y=1;msj[0]="Nombre";}}
                        
                        Matcher mApe1= patAlf.matcher(alumno.getApellido());
                        Matcher mApe2= patCarac.matcher(alumno.getApellido());
                        if (!mApe1.matches()) {y=1;msj[1]="Apellido";
                        }else{if (!mApe2.matches()) {y=1;msj[1]="Apellido";}}
                  
                        Matcher mTelCa = patTelCa.matcher(codAre);
                        if (!mTelCa.matches()) {
                            s=1;msj[4]="Tel-Cod.Área";}
                        Matcher mTelNt = patTelNt.matcher(numTel);
                        if (!mTelNt.matches()) {
                            s=1;msj[5]="Tel-Número";}

                        if (alumno.getNombre().equals(nu)||alumno.getApellido().equals(nu)||
                            alumno.getDni().equals(nu)||alumno.getTelefono().equals(nu)) {
                            n=1;msj[6]="Prohibido null";}

                        if (x==0 && y==0 && z==0 && w==0 && s==0 && n==0) { ar.save(alumno);}
                        if (alumno.getIdalum()!=0) {
                            out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Se ha GUARDADO el alumno id= "+alumno.getIdalum()+"</h4></div>");
                        }else if(x==1){
                            out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>Ya ha sido dado de alta el alumno. Revise DNI</h4></div>");
                        }else if(y==1 ||z==1 ||w==1 ||s==1 || n==1){
                            out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Campos completados incorrectamente</h4></div>");
                            for (int j = 0; j < msj.length; j++) {
                                if (!msj[j].isEmpty()) {out.println("<div class='d_subMsj'><p class='p_smsj'>"+msj[j]+"</p></div>");}
                            }
                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ocurrio un error en la BD</h4></div>");}
                    }else{out.println("<div class='d_msj' id='alerta_1'><span class='material-symbols-outlined' id='ic_completar'>edit_document</span><h4>Se requiere completar los campos para guardar un alumno</h4></div>");}
                } catch (Exception e) {out.println("<div class='d_msj' id='error_2'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ocurrió un error inesperado</h4></div>");}
                
            %>
            <form id="f_guardar">
                <div class="d_form">
                    <label for="i_nombre">Nombre:</label>
                    <input type="text" id="i_nombre"  name="nombre" required minlength="2" maxlength="55" title="Nombre del alumno"/>
                </div>
                <div class="d_form">
                    <label for="i_apellido">Apellido:</label>
                    <input type="text" id="i_apellido"  name="apellido" required minlength="2" maxlength="55" title="Apellido del alumno"/>
                </div>
                <div class="d_form">
                    <label for="i_edad">Edad:</label>
                    <input type="number" id="i_edad"  name="edad" required min="18" max="120" title="Edades entre 18 y 120"/>
                </div>  
                <div class="d_form">
                    <label for="i_dni">Dni:</label>
                    <input type="number" id="i_dni"  name="dni" required min="1000000" max="99999999" title="Caracteres numéricos sin puntos"/>
                </div>
                <div class="d_form" id="d_titTel">Telefóno:</div>
                <div class="d_form" id="d_tel">
                    <div>
                        <label for="i_codAre" class="l_vertical">Cod. área</label>
                        <input type="number" id="i_codAre"  name="codAre" required title="Se requiere ingresar el 0" placeholder="011"/>
                    </div>
                    <div>
                        <label for="i_numTel" class="l_vertical">Número</label>
                        <input type="number" id="i_numTel"  name="numTel" required title="Serequiere ingresar el 15" placeholder="1538619191"/>
                    </div>
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
                    Actualizar un alumno
                </div>
                <div class="d_vol">
                    <a href="#a_volver" id="a_volIc"><span class="material-symbols-outlined" id="ic_volver">arrow_upward</span></a>
                </div>   
            </div>
            
            <%
                try {
                    String idAl = request.getParameter("actAlumno");
                    String nombre = request.getParameter("nombreA");
                    String apellido = request.getParameter("apellidoA");
                    String edad = request.getParameter("edadA");
                    String dni = request.getParameter("dniA");
                    String codAre = request.getParameter("codAreA");
                    String numTel = request.getParameter("numTelA");
                    
                    if (nombre!=null&&apellido!=null&&edad!=null&&dni!=null&&
                        codAre!=null&&numTel!=null&&idAl!=null) {
                    
                        String telefono="("+codAre+") - "+numTel;
                       
                        Matcher mIdAl= patNum.matcher(idAl);
                        if (mIdAl.matches()) {
                            idObjetivo = Integer.parseInt(idAl);
                        }else{q=1;idObjetivo=0;}
                     
                        Matcher mEdad = patNum.matcher(edad);
                        if (mEdad.matches()) {edad2 = Integer.parseInt(edad);}
               
                        Matcher mDni = patDni.matcher(dni);
                        if (mDni.matches()) {
                            dni2 = miles.format(Integer.parseInt(dni));
                        }else{w=1;dni2="0"; msj[3]="DNI";}
                  
                        Alumno alumno = new Alumno(idObjetivo,nombre,apellido,edad2,dni2,telefono);
              
                        for(Alumno a:ar.getAll()){
                            if (alumno.getIdalum()!=a.getIdalum()){
                                if (alumno.getDni().equals(a.getDni())) {x=1;}}
                        }
                  
                        if (alumno.getEdad()<18||alumno.getEdad()>120) {z=1;msj[2]="Edad";}
         
                        Matcher mNom1= patAlf.matcher(alumno.getNombre());
                        Matcher mNom2= patCarac.matcher(alumno.getNombre());
                        if (!mNom1.matches()) {y=1;msj[0]="Nombre";
                        }else{if (!mNom2.matches()) {y=1;msj[0]="Nombre";}}
                        
                        Matcher mApe1= patAlf.matcher(alumno.getApellido());
                        Matcher mApe2= patCarac.matcher(alumno.getApellido());
                        if (!mApe1.matches()) {y=1;msj[1]="Apellido";
                        }else{if (!mApe2.matches()) {y=1;msj[1]="Apellido";}}
            
                        Matcher mTelCa = patTelCa.matcher(codAre);
                        if (!mTelCa.matches()) {
                            s=1;msj[4]="Tel-Cod.Área";}
                        Matcher mTelNt = patTelNt.matcher(numTel);
                        if (!mTelNt.matches()) {
                            s=1;msj[5]="Tel-Número";}

                        if (alumno.getNombre().equals(nu)||alumno.getApellido().equals(nu)||
                            alumno.getDni().equals(nu)||alumno.getTelefono().equals(nu)) {
                            n=1;msj[6]="Prohibido null";}
               
                        if (x==0 &&y==0 &&z==0 &&w==0 &&s==0 &&q==0 &&n==0) {
                            ar.update(alumno);
                            out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Se ha ACTUALIZADO el alumno con id= "+alumno.getIdalum()+"</h4></div>");
                        }else if(x==1){
                            out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>Alumno existente en la base de datos</h4></div>");
                        }else if(y==1 ||z==1 ||w==1 ||s==1 ||q==1 ||n==1){
                            out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Campos completados incorrectamente</h4></div>");
                            for (int j = 0; j < msj.length; j++) {
                                if (!msj[j].isEmpty()) {out.println("<div class='d_subMsj'><p class='p_smsj'>"+msj[j]+"</p></div>");}
                            }
                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ocurrio un error</h4></div>");}
                    }else{out.println("<div class='d_msj' id='alerta_1'><span class='material-symbols-outlined' id='ic_completar'>edit_document</span><h4>Se requiere completar los campos para actualizar un alumno</h4></div>");}
                } catch (Exception e) {out.println("<div class='d_msj' id='error_2'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ocurrió un error inesperado</h4></div>");}
            %>
            <form id="f_act">
                <div class="d_form">
                    <label for="s_alumno">Actualizar alumno:</label>
                    <select id="s_alumno" name="actAlumno" title="Seleccione un alumno">
                        <option value="">Selecionar</option>
                        <%
                            for(Alumno a:ar.getAll()){
                                out.println("<option value='"+a.getIdalum()+"'>"+a.getIdalum()+" - "+a.getNombre()+" - "+a.getApellido()+" - "+a.getEdad()+" - "+a.getDni()+" - "+a.getTelefono()+"</option>");
                            }
                        %>
                    </select>
                </div>
                <div class="d_form">
                    <label for="i_nombre">Nombre:</label>
                    <input type="text" id="i_nombre" name="nombreA" minlength="2" maxlength="55" required title="Nombre del alumno"/>
                </div>
                <div class="d_form">
                    <label for="i_apellido">Apellido:</label>
                    <input type="text" id="i_aplellido" name="apellidoA" minlength="2" maxlength="55" required title="Apellido del alumno" /> 
                </div>
                <div class="d_form">
                    <label for="i_edad">Edad:</label>
                    <input type="number" id="i_edad"  name="edadA" required min="18" max="120" title="Edades entre 18 y 120"/>
                </div>  
                <div class="d_form">
                    <label for="i_dni">Dni:</label>
                    <input type="number" id="i_dni"  name="dniA" required min="9999999" max="99999999" title="Caracteres numéricos sin puntos"/>
                </div>
                <div class="d_form" id="d_titTel">Telefóno:</div>
                <div class="d_form" id="d_tel">
                    <div>
                        <label for="i_codAre" class="l_vertical">Cod. área</label>
                        <input type="number" id="i_codAre"  name="codAreA" required title="Se requiere ingresar el 0" placeholder="011"/>
                    </div>
                    <div>
                        <label for="i_numTel" class="l_vertical">Número</label>
                        <input type="number" id="i_numTel"  name="numTelA" required title="Serequiere ingresar el 15" placeholder="1538619191"/>
                    </div>
                </div>
                                   
                <div class="d_bus_bot">
                    <input type="submit" value="Actualizar" class="i_enviar"/>
                </div>
            </form>
                    
            <!-- FORM ELEIMINAR -->
            
            <div class="d_separador"><a id="baja"></a></div>
            <div class="d_combo">
                <div id="d_subTitulo">
                    Dar de baja un alumno
                </div>
                <div class="d_vol">
                    <a href="#a_volver" id="a_volIc"><span class="material-symbols-outlined" id="ic_volver">arrow_upward</span></a>
                </div>   
            </div>
            
            <%  
                try {
                    String elimAl = request.getParameter("elimAlumno");
                    
                    if (elimAl!=null) {
                        Matcher mEAl= patNum.matcher(elimAl);
                        if (mEAl.matches()) {
                            idObjetivo = Integer.parseInt(elimAl);
                        }else{z=1;idObjetivo=0;}
                                          
                        Alumno a1 = ar.getById(idObjetivo);

                        if (a1.getIdalum()!=0) {
                            ar.remove(a1);
                            out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Se ha ELIMINADO el alumno con id= "+elimAl+"</h4></div>");
                        }else if(elimAl.equals("0")){
                            out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No es valido el id alumno = 0</h4></div>");
                        }else if(z==1){
                            out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ingrese caracteres numéricos</h4></div>");
                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No existe en la BD el alumno con id = "+idObjetivo+"</h4></div>");}
                    }else{out.println("<div class='d_msj' id='alerta_1'><span class='material-symbols-outlined' id='ic_completar'>edit_document</span><h4>Se requiere asignar un alumno para su eliminación</h4></div>");}
                } catch (Exception e) {out.println("<div class='d_msj' id='error_2'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ocurrió un error inesperado</h4></div>");}
            %>
            
            <form id="f_elim">
                <div class="d_form">
                    <label for="s_alumno">Eliminar alumno:</label>
                    <select id="s_alumno" name="elimAlumno" title="Seleccione un alumno">
                        <option value="">Selecionar</option>
                        <%
                            for(Alumno a:ar.getAll()){
                                out.println("<option value='"+a.getIdalum()+"'>"+a.getIdalum()+" - "+a.getNombre()+" - "+a.getApellido()+" - "+a.getEdad()+" - "+a.getDni()+" - "+a.getTelefono()+"</option>");
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
                    Buscar un alumno
                </div>
                <div class="d_vol">
                    <a href="#a_volver" id="a_volIc"><span class="material-symbols-outlined" id="ic_volver">arrow_upward</span></a>
                </div>   
            </div>
            <div id="d_f_bus">
                <form>
                    <div  class="d_form">
                        <label for="i_buscarNom" class="l_vertical">Buscar nombre:</label>
                        <input type="text" name="buscarNom" title="Nombre del alumno" id="i_buscarNom">
                    </div>
                    <div class="d_form">
                        <label for="i_buscarApe" class="l_vertical">Buscar apellido:</label>
                        <input type="text" name="buscarApe" title="Apellido del alumno" id="i_buscarApe">
                    </div>
                    <div class="d_bus_bot">
                        <input type="reset" value="Borrar" class="i_resetear"/>
                        <input type="submit" value="Buscar" class="i_enviar" id="i_bot_bus"/> 
                    </div>
                </form>
                <form>
                    <div  class="d_form" id="d_bus_input">
                        <label for="i_buscarDni" class="l_vertical">Buscar DNI:</label>
                        <input  type="number" name="buscarDni" title="Caracteres numericos sin puntos" id="i_buscarDni" min="0" max="99999999">
                    </div>
                    <div class="d_bus_bot">
                        <input type="reset" value="Borrar" class="i_resetear"/>
                        <input type="submit" value="Buscar" class="i_enviar" id="i_bot_bus"/> 
                    </div>                    
                </form> 
                <form>
                    <div  class="d_form" id="d_bus_input">
                        <label for="i_buscarIdAlum" class="l_vertical">Buscar ID:</label>
                        <input  type="number" name="buscarIdAlum" title="Caracteres numericos" id="i_buscarIdAlum" min="1">
                    </div>
                    <div class="d_bus_bot">
                        <input type="reset" value="Borrar" class="i_resetear"/>
                        <input type="submit" value="Buscar" class="i_enviar" id="i_bot_bus"/>
                    </div>
                </form> 
            </div>
           
            <a id="tablita"></a>
            <%
                try{    
                    String busNom = request.getParameter("buscarNom");
                    String busApe = request.getParameter("buscarApe");
                    String busDni = request.getParameter("buscarDni");
                    String busIdA = request.getParameter("buscarIdAlum");

                    List<Alumno>li=new ArrayList();
                    li.addAll(ar.getLikeNombreApellido(busNom,busApe));

                    if (ar.getAll().size()!=0) {
                        if (busIdA==null||busIdA.isBlank()) {
                            if (busDni==null||busDni.isBlank()) {
                                if  ((busNom==null||busNom.isBlank())&&
                                    (busApe==null||busApe.isBlank())){
                                        out.println("<div class='d_msj' id='alerta_1'><span class='material-symbols-outlined' id='ic_completar'>edit_document</span><h4>Se requiere completar cuaquiera de los campos para hacer una busqueda</h4></div>");
                                        out.println("<div class='d_table'>"+new TableHtml().getTable(ar.getAll())+"</div>");
                                }else if(busNom!=null&&busApe!=null){
                                    
                                    Matcher mNom1= patAlf.matcher(busNom);
                                    Matcher mNom2= patCarac.matcher(busNom);
                                    if (!mNom1.matches()) {y1=1;
                                    }else{if (!mNom2.matches()) {y1=1;}}

                                    Matcher mApe1= patAlf.matcher(busApe);
                                    Matcher mApe2= patCarac.matcher(busApe);
                                    if (!mApe1.matches()) {y2=1;
                                    }else{if (!mApe2.matches()) {y2=1;}}
                                    
                                    if(!busNom.isBlank()&& busApe.isEmpty()){
                                        //Nombre
                                        if (y==0) {
                                            if(li.size()!=0){
                                                out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                                out.println("<div class='d_table'>"+new TableHtml().getTable(li)+"</div>");
                                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No hubo coincidencias</h4></div>");}
                                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Debe ingresar caracteres alfabéticos</h4></div>");}
                                    }
                                    if (!busApe.isBlank()&& busNom.isEmpty()){
                                        //Apellido
                                        if (y==0) {
                                            if(li.size()!=0){
                                                    out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                                    out.println("<div class='d_table'>"+new TableHtml().getTable(li)+"</div>");
                                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No hubo coincidencias</h4></div>");}
                                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Debe ingresar caracteres alfabéticos</h4></div>");}
                                    }
                                    if(!busNom.isBlank() && !busApe.isBlank()){
                                        //Nombre y apellido
                                        if (y==0) {
                                            if(li.size()!=0){
                                                out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                                out.println("<div class='d_table'>"+new TableHtml().getTable(li)+"</div>");
                                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No hubo coincidencias</h4></div>");}
                                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Debe ingresar caracteres alfabéticos</h4></div>");}
                                    }
                                }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>Se produjo un ERROR en los campos 'nombre y apellido'</h4></div>");}
                            }else{
                                    //idDni
                                    Matcher mDni= patDni.matcher(busDni);
                                    if (!mDni.matches()) {z=1;}    
                                    Alumno a1 = (ar.getByDni(busDni));
                                    if (z==0) {
                                        if (a1.getIdalum()!=0) {
                                            out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                            out.println("<div class='d_table'>"+new TableHtml().getTable(a1)+"</div>");
                                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No existe el alumno</h4></div>");}
                                    }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ingrese solamente caracteres numéricos y mayores a cero</h4></div>");}
                            }
                        }else{  
                                //idA
                                Matcher mIdAl= patNum.matcher(busIdA);
                                if (mIdAl.matches()) {
                                    idObjetivo = Integer.parseInt(busIdA);
                                }else{q=1;idObjetivo=0;}
                                Alumno a1 = ar.getById(idObjetivo);
                                if (z==0) {
                                    if (a1.getIdalum()!=0) {
                                        out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                        out.println("<div class='d_table'>"+new TableHtml().getTable(a1)+"</div>");
                                    }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No existe el alumno</h4></div>");}
                                }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ingrese solamente caracteres numéricos y mayores a cero</h4></div>");}
                        }    
                    }else{out.println("<div class='d_msj' id='alerta_1'><h4 style='font-weight:800;'>No hay registros de alumnos</h4></div>");}         
                }catch(Exception e){out.println("<div class='d_msj' id='error_2'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ocurrió un error inesperado</h4></div>");}         
            %>
            <footer id="foot_vol_final">
                <div class="d_vol" >
                    <a href="#a_volver" id="a_volIc"><span class="material-symbols-outlined" id="ic_volver">arrow_upward</span></a>
                </div>
            </footer>
        </div>   
    </body>
</html>
