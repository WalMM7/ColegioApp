<%-- 
    Document   : Consultas
    Created on : 11 oct. 2022, 16:18:48
    Author     : Walter
--%>

<%@page import="com.walcompany.Utils.RegExp"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.walcompany.Utils.TableHtml"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.walcompany.entities.Curso"%>
<%@page import="com.walcompany.repositories.jdbc.CursoRepository"%>
<%@page import="com.walcompany.repositories.interfaces.I_CursoRepository"%>
<%@page import="com.walcompany.repositories.jdbc.AlumnoRepository"%>
<%@page import="com.walcompany.repositories.interfaces.I_AlumnoRepository"%>
<%@page import="com.walcompany.entities.Alumno"%>
<%@page import="com.walcompany.connectors.Connector"%>
<%@page import="com.walcompany.repositories.jdbc.InscripcionRepository"%>
<%@page import="com.walcompany.repositories.interfaces.I_InscripcionRepository"%>
<%@page import="com.walcompany.entities.Inscripcion"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    I_InscripcionRepository ir = new InscripcionRepository(Connector.getConexion());
    I_AlumnoRepository ar = new AlumnoRepository(Connector.getConexion());
    I_CursoRepository cr = new CursoRepository(Connector.getConexion());
    
    LocalDate fecha= LocalDate.now();
    int x=0,tit2=0,dni2=0,idCur2,año2,idObj,añoCero=2015,añoActual= fecha.getYear();
    int[]valores;
    List<String>msjss= new ArrayList();
 
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inscripciones</title>
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
            <li><a href="Alumnos.jsp">Alumnos</a></li>
            <li><a class="active" href="Inscripciones.jsp">Inscripciones</a></li>
        </ul>
        <div id="d_h1"><h1 id="tituloPrin">Gestión de inscripciones</h1></div>
        <div id="d_cuerpo">
            <nav id="n_menu">
                <div id="d_menu">     
                    <a class="a_menu" id="a_alta" href="#alta" title="Ir a form alta alumnos">Inscripción alumnos</a>
                    <a class="a_menu" id="a_baja" href="#baja" title="Ir a form baja alumnos">Anulación inscripciones</a>
                    <!-- <a class="a_menu" id="a_tablita" href="#listaS" title="Ir a form actualización alumnos">Lista simplificada</a> -->
                    <a class="a_menu" id="a_buscar" href="#buscar" title="Ir a form busqueda alumnos">Busqueda inscripciones</a>
                    <a class="a_menu" id="a_tablita" href="#listaD" title="Ir tabla">Lista inscripciones</a>
                    <div id="d_menu_restart">
                        <a class="a_menu" href="Inscripciones.jsp" id="a_restart"><span class="material-symbols-outlined" id="ic_restart">refresh</span></a>
                    </div>
                </div>     
            </nav>
            
            <!-- FORM GUARDAR INSCRIPCION -->
            
            <div class="d_separador"><a id="alta"></a></div>
            <div class="d_combo">
                <div id="d_subTitulo">
                    Inscribir un alumno a un curso
                </div>
                <div class="d_vol">
                    <a href="#a_volver" id="a_volIc"><span class="material-symbols-outlined" id="ic_volver">arrow_upward</span></a>
                </div>   
            </div>
            <%
                try {
                    String idAlM = request.getParameter("idAlManual");
                    String idAlA = request.getParameter("idAlAuto");
                    String idCur = request.getParameter("idCurso");
                    String año = request.getParameter("año");
                                                                        
                    if (idAlM!=null&&idAlA!=null&&idCur!=null&&año!=null) {
                        
                        idObj= new RegExp().validateNumero(idAlM,idAlA);
                        idCur2= new RegExp().validateNumero(idCur);
                        año2= new RegExp().validateAño(año);
                        Inscripcion inscripcion = new Inscripcion(idObj,idCur2,año2);
                        msjss.addAll(new RegExp().validateInscripcion(inscripcion));
                        for(String ms:msjss){if (!ms.isEmpty()){x=-1;}};
                        //Guardar
                        if (x==0) {ir.save(inscripcion);}
                        if (inscripcion.getIdReg()!=0) {
                            out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Se ha INSCRIPTO EXITOSAMENTE el alumno (id= "+inscripcion.getIdAlum()+") al curso (id= "+inscripcion.getIdCurso()+")</h4></div>");
                        }else if(x==-1){
                            if (msjss.contains("El alumno ya esta inscripto a ese curso")) {
                                    out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>"+msjss.get(0)+"</h4></div>");
                            }else{
                                out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Campos completados incorrectamente</h4></div>");
                                for (int j = 0; j < msjss.size(); j++) {
                                    if (!msjss.get(j).isEmpty()) {out.println("<div class='d_subMsj'><p class='p_smsj'>"+msjss.get(j)+"</p></div>");}
                                }
                            }
                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ocurrio un error en la BD</h4></div>");}
                    }else{out.println("<div class='d_msj' id='alerta_1'><span class='material-symbols-outlined' id='ic_completar'>edit_document</span><h4>Se requiere completar los campos para efectuar una inscripción</h4></div>");}
                } catch (Exception e) {out.println("<div class='d_msj' id='error_2'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ocurrió un error inesperado</h4></div>");}
                
            %>
            <form id="f_guardar">
                <div class="d_form" id="d_titTel">Alumno:</div>
                <div class="d_form" id="d_idAlum">
                    <div>
                        <label for="i_idAl" class="l_vertical">Id alumno</label>
                        <input type="number" id="i_idAl"  name="idAlManual" title="Caracteres numéricos"/>
                    </div>
                    <div>
                        <label for="s_alumno" class="l_vertical">Lista alumnos</label>
                        <select id="s_alumno" name="idAlAuto" title="Seleccione un alumno de la lista">
                        <option value="">Selecionar</option>
                        <%
                            for(Alumno a:ar.getAll()){
                                out.println("<option value='"+a.getIdalum()+"'>"+a.getIdalum()+" - "+a.getNombre()+" - "+a.getApellido()+" - "+a.getDni()+"</option>");
                            }
                        %>
                        </select>
                    </div>
                </div>
                <div class="d_form">
                    <label for="s_curso">Curso:</label>
                    <select id="s_curso" name="idCurso" title="Seleccione un curso de la lista">
                        <option value="">Selecionar</option>
                        <%
                            for(Curso c:cr.getAll()){
                                out.println("<option value='"+c.getIdcurso()+"'>"+c.getIdcurso()+" - "+c.getTitulo()+" - "+c.getProfesor()+" - "+c.getDia()+" - "+c.getTurno()+" - "+c.getInicio()+" - "+c.getFin()+"</option>");
                            }
                        %>
                    </select>
                </div>
                <div class="d_form">
                    <label for="s_año">Año:</label>
                    <select id="s_año" name="año" title="Seleeccione un año">
                        <option value="">Selecionar</option>
                        <%
                            for (int a=añoCero; a <(añoActual+2); a++) {
                                out.println("<option value='"+a+"'>"+a+"</option>");}
                        %>
                    </select>
                </div>
                
                <div class="d_bus_bot">
                    <input type="reset" value="Borrar" class="i_resetear"/>
                    <input type="submit" value="Inscribir" class="i_enviar" id="i_bot_guardar"/>
                </div>
            </form>
            
            <!-- FORM ELEIMINAR -->
            
            <div class="d_separador"><a id="baja"></a></div>
            <div class="d_combo">
                <div id="d_subTitulo">
                    Anular inscripción de un alumno a un curso
                </div>
                <div class="d_vol">
                    <a href="#a_volver" id="a_volIc"><span class="material-symbols-outlined" id="ic_volver">arrow_upward</span></a>
                </div>   
            </div>
            
            <%  
                try {
                    String elimRegM = request.getParameter("elimRegManual");
                    String elimRegA = request.getParameter("elimRegAutomatico");
                                      
                    if (elimRegM!=null&&elimRegA!=null) {
                        idObj= new RegExp().validateNumero(elimRegM,elimRegA);
                        Inscripcion inscripcion = ir.getByIdReg(idObj);
                        if (idObj>0) {
                            if (inscripcion.getIdReg()!=0) {
                                ir.remove(inscripcion);
                                out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>"+new RegExp().msjsElimReg(idObj, inscripcion)+"</h4></div>");
                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>"+new RegExp().msjsElimReg(idObj, inscripcion)+"</h4></div>");}
                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>"+new RegExp().msjsElimReg(idObj, inscripcion)+"</h4></div>");}
                    }else{out.println("<div class='d_msj' id='alerta_1'><span class='material-symbols-outlined' id='ic_completar'>edit_document</span><h4>Se requiere seleccionar un registro para su eliminación</h4></div>");}
                } catch (Exception e) {out.println("<div class='d_msj' id='error_2'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ocurrió un error inesperado</h4></div>");}
            %>
            <form id="f_elim">
                <div class="d_form" id="d_titTel">Registro:</div>
                <div class="d_form" id="d_reg">
                    <div>
                        <label for="i_buscarIdReg" class="l_vertical">N° registro</label>
                        <input type="number" id="i_buscarIdReg"  name="elimRegManual" title="Ingrese N° registro"/>
                    </div>
                    <div>
                        <label for="s_reg"class="l_vertical">Lista registros</label>
                        <select id="s_reg" name="elimRegAutomatico" title="Seleccione un registro de la lista">
                            <option value="">Selecionar</option>
                            <%
                                for(Inscripcion i:ir.getAll()){
                                    out.println("<option value='"+i.getIdReg()+"'>N°reg: "+i.getIdReg()+" - Id alumno: "+i.getIdAlum()+" - Id curso: "+i.getIdCurso()+"</option>");
                                }
                            %>
                        </select>
                    </div>
                </div>
                <div class="d_bus_bot">
                    <input type="submit" value="Eliminar" class="i_enviar"/>
                </div>         
            </form>
                        
            <!-- 
            VISTA ASIGNACIÓN de inscripciones
            
            <div class="d_separador"><a id="listaS"></a></div>
            
            <div class="d_combo">
                <div id="d_subTitulo">
                    Vista simplificada de asignación de inscripciones
                </div>
                <div class="d_vol">
                    <a href="#a_volver" id="a_volIc"><span class="material-symbols-outlined" id="ic_volver">arrow_upward</span></a>
                </div>   
            </div>
            -->
            <%
                //if (ir.getAll().size()!=0) {
                //    out.println("<div class='d_table'>"+new TableHtml().getTable(ir.getAll())+"</div>");        
                //}else{out.println("<div class='d_msj' id='alerta_1'><h4 style='font-weight:800;'>No hay registros para mostrar</h4></div>");}
                
            %>
            
            <!-- FORM BUSACAR -->
            
            <div class="d_separador"><a id="buscar"></a></div>
            <div class="d_combo">
                <div id="d_subTitulo">
                    Buscar alumnos, curos y profesores
                </div>
                <div class="d_vol">
                    <a href="#a_volver" id="a_volIc"><span class="material-symbols-outlined" id="ic_volver">arrow_upward</span></a>
                </div>   
            </div>
            <div id="d_f_bus_1">
                 <!-- Dni tit año -->
                <form>
                    <div  class="d_form">
                        <label for="i_buscarDni" class="l_vertical">DNI alumno:</label>
                        <input type="number" name="buscarDni" title="Caracteres numéricos sin puntos" id="i_buscarDni" min="0" max="99999999">
                    </div>
                    <div  class="d_form">
                        <label for="i_buscarTitulo" class="l_vertical">Titulo curso:</label>
                        <input type="text" name="buscarTit" title="Titulo del curso sin tildes" id="i_buscarTitulo">
                    </div>
                    <div  class="d_form">
                        <label for="i_buscarAño" class="l_vertical">Año:</label>
                        <input  type="number" name="buscarAño" title="Caracteres numéricos" id="i_buscarAño" min="2015">
                    </div>
                                                           
                    <div class="d_bus_bot">
                        <input type="reset" value="Borrar" class="i_resetear"/>
                        <input type="submit" value="Buscar" class="i_enviar" id="i_bot_bus"/> 
                    </div>
                </form>
                <!-- Ape Nom IdC -->
                <form>
                    <div class="d_form">
                        <label for="i_buscarApe" class="l_vertical">Apellido alumno:</label>
                        <input type="text" name="buscarApe" title="Apellido del alumno sin tildes" id="i_buscarApe">
                    </div>
                    <div  class="d_form">
                        <label for="i_buscarNom" class="l_vertical">Nombre alumno:</label>
                        <input type="text" name="buscarNom" title="Nombre del alumno sin tildes" id="i_buscarNom">
                    </div>
                    <div  class="d_form">
                        <label for="i_buscarIdCur" class="l_vertical">Id Curso:</label>
                        <input  type="number" name="buscarIdCur" title="Caracteres numéricos" id="i_buscarIdCur" min="1">
                    </div>
                    
                    <div class="d_bus_bot">
                        <input type="reset" value="Borrar" class="i_resetear"/>
                        <input type="submit" value="Buscar" class="i_enviar" id="i_bot_bus"/> 
                    </div>
                </form>
                <!-- Prof Tit Año -->
                <form>
                    <div  class="d_form">
                        <label for="i_buscarProfesor" class="l_vertical">Nombre profesor:</label>
                        <input type="text" name="buscarPro" title="Nombre y apellido del profesor sin tildes" id="i_buscarProfesor">
                    </div>
                    <div  class="d_form">
                        <label for="i_buscarTitulo" class="l_vertical">Titulo curso:</label>
                        <input type="text" name="buscarTitP" title="Titulo del curso sin tildes" id="i_buscarTitulo">
                    </div>
                    <div  class="d_form">
                        <label for="i_buscarAño" class="l_vertical">Año:</label>
                        <input  type="number" name="buscarAñoP" title="Caracteres numéricos" id="i_buscarAño" min="2015">
                    </div>
                                       
                    <div class="d_bus_bot">
                        <input type="reset" value="Borrar" class="i_resetear"/>
                        <input type="submit" value="Buscar" class="i_enviar" id="i_bot_bus"/> 
                    </div>                    
                </form> 
                <!-- n° Reg -->    
                <form>
                    <div  class="d_form" id="d_bus_input2">
                        <label for="i_buscarIdReg" class="l_vertical">N° Reg.:</label>
                        <input  type="number" name="buscarIdReg" title="Caracteres numéricos" id="i_buscarIdReg" min="1">
                    </div>
                    
                    <div class="d_bus_bot">
                        <input type="reset" value="Borrar" class="i_resetear"/>
                        <input type="submit" value="Buscar" class="i_enviar" id="i_bot_bus"/>
                    </div>
                </form> 
            </div>
           
            <a id="listaD"></a>
            
            <%
          
                try{    
                    String busDni = request.getParameter("buscarDni");
                    String busTit = request.getParameter("buscarTit");
                    String busAño = request.getParameter("buscarAño");
                    String busNom = request.getParameter("buscarNom");
                    String busApe = request.getParameter("buscarApe");
                    String busIdC = request.getParameter("buscarIdCur");
                    String busPro = request.getParameter("buscarPro");
                    String busTitP = request.getParameter("buscarTitP");
                    String busAñoP = request.getParameter("buscarAñoP");
                    String busIdR = request.getParameter("buscarIdReg");

                    List<Inscripcion>li=new ArrayList();

                    if (ir.getAll().size()!=0) {
                        if (busIdR==null||busIdR.isBlank()) {
                            if ((busPro==null||busPro.isBlank())&&(busTitP==null||busTitP.isBlank())
                                &&(busAñoP==null||busAñoP.isBlank())) {
                                if  ((busNom==null||busNom.isBlank())&&(busApe==null||busApe.isBlank())
                                    &&(busIdC==null||busIdC.isBlank())){
                                    if ((busDni==null||busDni.isBlank())&&(busTit==null||busTit.isBlank())
                                       &&(busAño==null||busAño.isBlank())) {
                                        out.println("<div class='d_msj' id='alerta_1'><span class='material-symbols-outlined' id='ic_completar'>edit_document</span><h4>Se requiere completar cuaquiera de los campos para hacer una busqueda</h4></div>");
                                        out.println("<div class='d_table'>"+new TableHtml().getTableInnerJM(ir.getAllInnerJM())+"</div>");
                                    }else if(busDni!=null&&busTit!=null&&busAño!=null){ 
                                        dni2= new RegExp().validateDniSf(busDni);
                                        tit2= new RegExp().validateText(busTit);
                                        año2= new RegExp().validateAño(busAño);
                                        if(!busDni.isBlank()&&busTit.isEmpty()&&busAño.isEmpty()){
                                            //idDni
                                            Inscripcion i1=ir.getByDni(busDni);
                                            if (dni2==0) {
                                                if (i1.getIdReg()!=0) {
                                                    out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas (id)</h4></div>");
                                                    out.println("<div class='d_table'>"+new TableHtml().getTable(i1)+"</div>");
                                                }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No existe el registro</h4></div>");}
                                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ingrese solamente caracteres numéricos y mayores a cero</h4></div>");}
                                        }
                                        if(busDni.isEmpty()&&!busTit.isBlank()&&busAño.isEmpty()){
                                            //Titulo
                                            li.addAll(ir.getLikeTit(busTit));

                                            if (tit2==0) {
                                                if(li.size()!=0){
                                                    out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                                    out.println("<div class='d_table'>"+new TableHtml().getTableInnerJM(li)+"</div>");
                                                }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No hubo coincidencias</h4></div>");}
                                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Debe ingresar caracteres alfabéticos</h4></div>");}
                                        }
                                        if(busDni.isEmpty()&&busTit.isEmpty()&&!busAño.isBlank()){
                                            //Año
                                            li.addAll(ir.getByAño(año2));

                                            if (año2!=-1) {
                                                if (li.size()!=0) {
                                                    out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas (id)</h4></div>");
                                                    out.println("<div class='d_table'>"+new TableHtml().getTableInnerJM(li)+"</div>");
                                                }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No existe el año</h4></div>");}
                                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ingrese solamente caracteres numéricos</h4></div>");}
                                        }
                                        if(!busDni.isBlank()&&!busTit.isBlank()&&busAño.isEmpty()){
                                            //dni y tit
                                            li.addAll(ir.getLikeDniTit(busDni,busTit));

                                            if (dni2==0 && tit2==0) {
                                                if(li.size()!=0){
                                                    out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                                    out.println("<div class='d_table'>"+new TableHtml().getTableInnerJM(li)+"</div>");
                                                }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No hubo coincidencias</h4></div>");}
                                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Caracteres ingresados incorrectos</h4></div>");}
                                        }
                                        if(!busDni.isBlank()&&busTit.isEmpty()&&!busAño.isBlank()){
                                            //dni y año
                                            li.addAll(ir.getLikeDniAño(busDni,año2));

                                            if (dni2==0 && año2!=-1) {
                                                if(li.size()!=0){
                                                    out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                                    out.println("<div class='d_table'>"+new TableHtml().getTableInnerJM(li)+"</div>");
                                                }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No hubo coincidencias</h4></div>");}
                                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Caracteres ingresados incorrectos</h4></div>");} 
                                        }
                                        if(!busTit.isBlank()&&!busAño.isBlank()){
                                            //titulo y año
                                            li.addAll(ir.getLikeTitAño(busTit,año2));

                                            if (tit2==0 && año2!=-1) {
                                                if(li.size()!=0){
                                                    out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                                    out.println("<div class='d_table'>"+new TableHtml().getTableInnerJM(li)+"</div>");
                                                }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No hubo coincidencias</h4></div>");}
                                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Caracteres ingresados incorrectos</h4></div>");}
                                        }
                                        if(!busDni.isBlank()&&!busTit.isBlank()&&!busAño.isBlank()){
                                            //dni, titulo y año
                                            li.addAll(ir.getLikeDniTitAño(busDni,busTit,año2));

                                            if (dni2==0 && tit2==0 && año2!=-1) {
                                                if(li.size()!=0){
                                                    out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                                    out.println("<div class='d_table'>"+new TableHtml().getTableInnerJM(li)+"</div>");
                                                }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No hubo coincidencias</h4></div>");}
                                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Caracteres ingresados incorrectos</h4></div>");}
                                        }
                                    }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Algo ha salido mal en la busqueda de 'dni, titulo y año'</h4></div>");}
                                }else if(busNom!=null&&busApe!=null&&busIdC!=null){ 
                                    valores= new RegExp().validateText(busNom,busApe);
                                    idObj= new RegExp().validateNumero(busIdC);
                                    if(busNom.isEmpty()&&!busApe.isBlank()&&busIdC.isEmpty()){
                                        // apellido
                                        li.addAll(ir.getLikeNomApe(busNom,busApe));

                                        if (valores[1]==0) {
                                            if(li.size()!=0){
                                                out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                                out.println("<div class='d_table'>"+new TableHtml().getTableInnerJM(li)+"</div>");
                                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No hubo coincidencias</h4></div>");}
                                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Debe ingresar caracteres alfabéticos</h4></div>");} 
                                    }
                                    if(!busNom.isBlank()&&!busApe.isBlank()&&busIdC.isEmpty()){
                                        //Nombre y apellido
                                        li.addAll(ir.getLikeNomApe(busNom,busApe));

                                        if (valores[0]==0&&valores[1]==0) {
                                            if(li.size()!=0){
                                                out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                                out.println("<div class='d_table'>"+new TableHtml().getTableInnerJM(li)+"</div>");
                                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No hubo coincidencias</h4></div>");}
                                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Debe ingresar caracteres alfabéticos</h4></div>");}
                                    }
                                    if((!busNom.isBlank()||busNom.isEmpty())&&!busApe.isBlank()&&!busIdC.isBlank()){
                                        //nombre , apellido e idc
                                        li.addAll(ir.getLikeNomApeIdC(busNom,busApe,idObj));
                                        
                                        if (!busNom.isBlank()) {
                                            if (valores[0]==0 && valores[1]==0 && idObj!=-1){
                                                if(li.size()!=0){
                                                    out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                                    out.println("<div class='d_table'>"+new TableHtml().getTableInnerJM(li)+"</div>");
                                                }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No hubo coincidencias</h4></div>");}
                                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Caracteres ingresados incorrectos</h4></div>");}
                                        }else{
                                            if (valores[1]==0 && idObj!=-1) {
                                                if(li.size()!=0){
                                                    out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                                    out.println("<div class='d_table'>"+new TableHtml().getTableInnerJM(li)+"</div>");
                                                }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No hubo coincidencias</h4></div>");}
                                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Caracteres ingresados incorrectos</h4></div>");} 
                                        }
                                    }
                                    if(busNom.isEmpty()&&busApe.isEmpty()&&!busIdC.isBlank()){
                                        //idC
                                        li.addAll(ir.getByIdCur(idObj));

                                        if (idObj!=-1) {
                                            if (li.size()!=0) {
                                                out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas (id)</h4></div>");
                                                out.println("<div class='d_table'>"+new TableHtml().getTableInnerJM(li)+"</div>");
                                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No existe el curso</h4></div>");}
                                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ingrese solamente caracteres numéricos y mayores a cero</h4></div>");}
                                    }
                                    if (busApe.isBlank()&&!busNom.isBlank()&&busIdC.isBlank()) {
                                        out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Error. Se requiere ingresar un 'apellido'</h4></div>");
                                    }
                                }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Algo ha salido mal con la busqueda de 'nombre,apellido e IdC'</h4></div>");}
                            }else if (busPro!=null&&busTitP!=null&&busAñoP!=null){
                                valores= new RegExp().validateText(busPro,busTitP);
                                año2= new RegExp().validateAño(busAñoP);
                                if (!busPro.isBlank()&&busTitP.isEmpty()&&busAñoP.isEmpty()){
                                    //profesor
                                    li.addAll(ir.getLikeProTit(busPro,busTitP));

                                    if (valores[0]==0) {
                                        if(li.size()!=0){
                                            out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                            out.println("<div class='d_table'>"+new TableHtml().getTableInnerJM(li)+"</div>");
                                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No hubo coincidencias</h4></div>");}
                                    }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Debe ingresar caracteres alfabéticos</h4></div>");}
                                }
                                if(!busPro.isBlank()&&!busTitP.isBlank()&&busAñoP.isEmpty()){
                                    // profesor y titulo
                                    li.addAll(ir.getLikeProTit(busPro,busTitP));

                                    if (valores[0]==0&&valores[1]==0) {
                                        if(li.size()!=0){
                                            out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                            out.println("<div class='d_table'>"+new TableHtml().getTableInnerJM(li)+"</div>");
                                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No hubo coincidencias</h4></div>");}
                                    }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Debe ingresar caracteres alfabéticos</h4></div>");}
                                }
                                if(!busPro.isBlank()&&!busTitP.isBlank()&&!busAñoP.isBlank()){
                                    //profesor, titulo y año
                                    li.addAll(ir.getLikeProTitAño(busPro,busTitP,año2));

                                    if (valores[0]==0&&valores[1]==0 && año2!=-1) {
                                        if(li.size()!=0){
                                            out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas</h4></div>");
                                            out.println("<div class='d_table'>"+new TableHtml().getTableInnerJM(li)+"</div>");
                                        }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No hubo coincidencias</h4></div>");}
                                    }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Caracteres ingresados incorrectos</h4></div>");}
                                }
                                if (busPro.isBlank()&&!busTitP.isBlank()&&busAñoP.isBlank()) {
                                    out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Error. Se requiere ingresar un 'nombre de profesor'</h4></div>");
                                }
                                if (busPro.isBlank()&&busTitP.isBlank()&&!busAñoP.isBlank()) {
                                    out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Error. Se requiere ingresar un 'nombre de profesor'</h4></div>");
                                }
                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Algo ha salido mal en la busqueda de 'profesor, tiulo y año'</h4></div>");}
                        }else{
                            //IdR
                            idObj= new RegExp().validateNumero(busIdR);
                            Inscripcion i1 = ir.getByIdReg(idObj);
                            if (idObj!=-1) {
                                if (i1.getIdReg()!=0) {
                                    out.println("<div class='d_msj' id='exitoso'><span class='material-symbols-outlined' id='ic_ok'>check_circle</span><h4>Coincidencias encontradas (id)</h4></div>");
                                    out.println("<div class='d_table'>"+new TableHtml().getTable(i1)+"</div>");
                                }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_cancel'>cancel</span><h4>No existe el registro</h4></div>");}
                            }else{out.println("<div class='d_msj' id='error_1'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ingrese solamente caracteres numéricos y mayores a cero</h4></div>");}
                        }
                    }else{out.println("<div class='d_msj' id='alerta_1'><h4 style='font-weight:800;'>No hay registros de inscripciones</h4></div>");}         
                }catch(Exception e){out.println("<div class='d_msj' id='error_2'><span class='material-symbols-outlined' id='ic_aviso'>error</span><h4>Ocurrió un error inesperado</h4></div>");}         
            %>
            <footer id="foot_vol_final">
                <div class="d_vol" >
                    <a href="#a_volver" id="a_volIc"><span class="material-symbols-outlined" id="ic_volver">arrow_upward</span></a>
                </div>
            </footer>
            
        </div>   
    <body>
</html>
