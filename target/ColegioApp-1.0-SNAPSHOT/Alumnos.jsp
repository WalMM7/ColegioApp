<%-- 
    Document   : Alumnos
    Created on : 27 jul. 2022, 16:13:30
    Author     : Walter
--%>

<%@page import="com.walcompany.Utils.RegExp"%>
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
    
    int x=0, idObjetivo, edad2;
    String dni2, telefono2;
    List<String>msjss;
   
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
                                            
                        edad2= new RegExp().validateNumero(edad);
                        dni2= new RegExp().validateDni(dni);
                        telefono2=new RegExp().validateTelefono(codAre,numTel);
              
                        Alumno alumno = new Alumno(nombre,apellido,edad2,dni2,telefono2);
                        
                        msjss= new RegExp().validateAlumno(alumno);
                        for(String ms:msjss){if (!ms.isEmpty()) {x=-1;}}
                      
                        //Guardar
                        if (x==0) {ar.save(alumno);}
                        if (alumno.getIdalum()!=0) {
                            out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Se ha GUARDADO EXITOSAMENTE el alumno con id= "+alumno.getIdalum()+"</h4></div>");
                        }else if(x==-1){
                            if (msjss.contains("Alumno existente en la base de datos")) {
                                    out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>"+msjss.get(0)+"</h4></div>");
                            }else{
                                out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Campos completados incorrectamente</h4></div>");
                                for (int j = 0; j < msjss.size(); j++) {
                                    if (!msjss.get(j).isEmpty()) {out.println("<div class='d_subMsj'><p class='p_smsj'>"+msjss.get(j)+"</p></div>");}
                                }
                            }
                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ocurrio un error en la BD</h4></div>");}
                    }else{out.println("<div class='d_msj' id='alerta_1'><span class='material-symbols-outlined' id='ic_completar'>edit_document</span><h4>Se requiere completar los campos para guardar un alumno</h4></div>");}
                }catch (Exception e) {out.println("<div class='d_msj' id='error_2'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ocurrió un error inesperado</h4></div>");}
                
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
                 
                        idObjetivo= new RegExp().validateNumero(idAl);
                        edad2= new RegExp().validateNumero(edad);
                        dni2= new RegExp().validateDni(dni);
                        telefono2=new RegExp().validateTelefono(codAre,numTel);

                        Alumno alumno = new Alumno(idObjetivo,nombre,apellido,edad2,dni2,telefono2);

                        msjss= new RegExp().validateAlumno(alumno);
                        for(String ms:msjss){if (!ms.isEmpty()) {x=-1;}}
                    
                        //Actualizar
                        if (x==0) {
                            ar.update(alumno);
                            out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Se ha ACTUALIZADO el alumno con id= "+alumno.getIdalum()+"</h4></div>");
                        }else if(x==-1){
                            if (msjss.contains("Alumno existente en la base de datos")) {
                                out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>"+msjss.get(0)+"</h4></div>");
                            }else{
                                out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Campos completados incorrectamente</h4></div>");
                                for (int j = 0; j < msjss.size(); j++) {
                                    if (!msjss.get(j).isEmpty()) {out.println("<div class='d_subMsj'><p class='p_smsj'>"+msjss.get(j)+"</p></div>");}
                                }
                            }
                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ocurrio un error en la Base de Datos</h4></div>");}
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
                        idObjetivo= new RegExp().validateNumero(elimAl);
                        Alumno a1 = ar.getById(idObjetivo);
                        if (idObjetivo!=-1) {
                            if (a1.getIdalum()!=0) {
                                ar.remove(a1);
                                out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Se ha ELIMINADO el alumno con id= "+a1.getIdalum()+"</h4></div>");
                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No existe en la BD el alumno con id = "+elimAl+"</h4></div>");}
                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ingrese solamente caracteres numéricos y mayores a '0'</h4></div>");}
                    }else{out.println("<div class='d_msj' id='alerta_1'><span class='material-symbols-outlined' id='ic_completar'>edit_document</span><h4>Se requiere asignar un curso para su eliminación</h4></div>");}
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
                                    int[] valores={0,0};
                                    valores = new RegExp().validateText(busNom,busApe);
                                    
                                    if(!busNom.isBlank()&& busApe.isEmpty()){
                                        //Nombre
                                        if (valores[0]==0) {
                                            if(li.size()!=0){
                                                out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                                out.println("<div class='d_table'>"+new TableHtml().getTable(li)+"</div>");
                                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No hubo coincidencias</h4></div>");}
                                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Debe ingresar caracteres alfabéticos</h4></div>");}
                                    }
                                    if (!busApe.isBlank()&& busNom.isEmpty()){
                                        //Apellido
                                        if (valores[1]==0) {
                                            if(li.size()!=0){
                                                    out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                                    out.println("<div class='d_table'>"+new TableHtml().getTable(li)+"</div>");
                                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No hubo coincidencias</h4></div>");}
                                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Debe ingresar caracteres alfabéticos</h4></div>");}
                                    }
                                    if(!busNom.isBlank() && !busApe.isBlank()){
                                        //Nombre y apellido
                                        if (valores[0]==0 && valores[1]==0) {
                                            if(li.size()!=0){
                                                out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                                out.println("<div class='d_table'>"+new TableHtml().getTable(li)+"</div>");
                                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No hubo coincidencias</h4></div>");}
                                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Debe ingresar caracteres alfabéticos</h4></div>");}
                                    }
                                }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>Se produjo un ERROR en los campos 'nombre y apellido'</h4></div>");}
                            }else{
                                dni2= new RegExp().validateDni(busDni);
                                Alumno a1 = (ar.getByDni(busDni));
                                if (!dni2.equals("-1")) {
                                    if (a1.getIdalum()!=0) {
                                        out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                        out.println("<div class='d_table'>"+new TableHtml().getTable(a1)+"</div>");
                                    }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No existe el alumno</h4></div>");}
                                }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ingrese caracteres numéricos (8 dígitos) y mayores a '0'</h4></div>");}
                            }
                        }else{  
                            idObjetivo=new RegExp().validateNumero(busIdA);
                            Alumno a1 = ar.getById(idObjetivo);
                            if (idObjetivo!=-1) {
                                if (a1.getIdalum()!=0) {
                                    out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                    out.println("<div class='d_table'>"+new TableHtml().getTable(a1)+"</div>");
                                }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No existe el alumno</h4></div>");}
                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ingrese solamente caracteres numéricos y mayores a '0'</h4></div>");}
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
