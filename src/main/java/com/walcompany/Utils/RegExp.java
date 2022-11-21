package com.walcompany.Utils;

import com.walcompany.connectors.Connector;
import com.walcompany.entities.Alumno;
import com.walcompany.entities.Curso;
import com.walcompany.entities.Inscripcion;
import com.walcompany.enums.Dia;
import com.walcompany.enums.Turno;
import com.walcompany.repositories.interfaces.I_AlumnoRepository;
import com.walcompany.repositories.interfaces.I_CursoRepository;
import com.walcompany.repositories.interfaces.I_InscripcionRepository;
import com.walcompany.repositories.jdbc.AlumnoRepository;
import com.walcompany.repositories.jdbc.CursoRepository;
import com.walcompany.repositories.jdbc.InscripcionRepository;
import static java.lang.System.out;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Walter
 */

public class RegExp {
    
    String exRAlf = 
        "^[a-­zA-­ZÀ-ÿ\u00F1\u00D1]{1,15}$|"
        + "^[a-­zA-­ZÀ-ÿ\u00F1\u00D1]{1,15}(\\s)[a-­zA-­ZÀ-ÿ\u00F1\u00D1]{1,15}$|"
        + "^[a-­zA-­ZÀ-ÿ\u00F1\u00D1]{1,15}(\\s)[a-­zA-­ZÀ-ÿ\u00F1\u00D1]{1,15}"
        + "(\\s)[a-­zA-­ZÀ-ÿ\u00F1\u00D1]{1,15}$|"
        +"^[a-­zA-­ZÀ-ÿ\u00F1\u00D1]{1,13}(\\s)[a-­zA-­ZÀ-ÿ\u00F1\u00D1]{1,13}"
        + "(\\s)[a-­zA-­ZÀ-ÿ\u00F1\u00D1]{1,13}(\\s)[a-­zA-­ZÀ-ÿ\u00F1\u00D1]{1,13}$";
    Pattern patAlf = Pattern.compile(exRAlf);
    
    String exRCarac="[^(àèìòù`~|}{\\[\\]^_¡¬)]*";
    Pattern patCarac = Pattern.compile(exRCarac);
    
    String exRNum = "^[1-9]{1}\\d*$";
    Pattern patNum = Pattern.compile(exRNum);
    
    String exRHor= 
                "^((08)|(09)|(10)|(11)|(12)|(13)|(14)|(15)|(16)|(17)|(18)|(19)|(20)|"
                + "(21)|(22))"
                + "[:]{1}"
                + "((00)|(01)|(02)|(03)|(04)|(05)|(06)|(07)|(08)|(09)|(10)|(11)|(12)|"
                + "(13)|(14)|(15)|(16)|(17)|(18)|(19)|(20)|(21)|(22)|(23)|(24)|(25)|"
                + "(26)|(27)|(28)|(29)|(30)|(31)|(32)|(33)|(34)|(35)|(36)|(37)|(38)|"
                + "(39)|(40)|(41)|(42)|(43)|(44)|(45)|(46)|(47)|(48)|(49)|(50)|(51)|"
                + "(52)|(53)|(54)|(55)|(56)|(57)|(58)|(59))$";
    Pattern patHor= Pattern.compile(exRHor);
    
    String exRDni = "^[^0][0-9]{6,7}";
    Pattern patDni = Pattern.compile(exRDni);
    
    String exRTelCa ="^0[1-9]{2,4}$";
    Pattern patTelCa = Pattern.compile(exRTelCa);
    
    String exRTelNt ="^15[1-9]{1}[0-9]{5,7}$|^[234567][0-9]{5,7}$";
    Pattern patTelNt = Pattern.compile(exRTelNt);
    
    //unuseful
    String exRExtraer = ".(\\d+).\\s-\\s(\\d+)";
    Pattern patExtraer = Pattern.compile(exRExtraer);
    
    String exRAño = "^[2]{1}\\d{3}$";
    Pattern patAño = Pattern.compile(exRAño);
        
    DecimalFormat miles = new DecimalFormat("###,###");
        
    List<String> dias=new ArrayList();
    List<String> turnos=new ArrayList();
    List<String> msjs = new ArrayList();
    
    I_CursoRepository cr = new CursoRepository(Connector.getConexion());
    I_AlumnoRepository ar = new AlumnoRepository(Connector.getConexion());
    I_InscripcionRepository ir = new InscripcionRepository(Connector.getConexion());
    
    //METODOS:
    
    public int validateNumero(String num){
        int valor;
        Matcher m= patNum.matcher(num);
        if(m.matches()) {valor= Integer.parseInt(num);
        }else{valor= -1;}
              
        return valor;
    }
    
    public int validateNumero(String num1,String num2){
        int valor;
        if (!num1.isBlank()&&num2.isEmpty()) {
            Matcher m= patNum.matcher(num1);
            if(m.matches()) {valor= Integer.parseInt(num1);
            }else{valor= -1;}
        }else if(num1.isEmpty()&&!num2.isBlank()){
            Matcher m= patNum.matcher(num2);
            if(m.matches()) {valor= Integer.parseInt(num2);
            }else{valor= -2;}
        }else{valor=-3;}
                      
        return valor;
    }
    
    public int validateText(String text){
        int valor=0;
        Matcher m1= patAlf.matcher(text);
        Matcher m2= patCarac.matcher(text);
        if (!m1.matches()){valor=-1;
        }else{if (!m2.matches()) {valor=-1;}}
        
        return valor;
    }
    
    public int[] validateText(String text1,String text2){
        String[]campos={text1,text2};
        int[] valores={0,0};
        for (int i=0;i<campos.length; i++) {
            Matcher m1= patAlf.matcher(campos[i]);
            Matcher m2= patCarac.matcher(campos[i]);
            if (!m1.matches()){valores[i]=-1;
            }else{if (!m2.matches()) {valores[i]=-1;}}
        }
        return valores;
    }
    
    public String validateDni(String dni){
        String valor;
        Matcher m= patDni.matcher(dni);
        if(m.matches()){
            valor = miles.format(Integer.parseInt(dni));
        }else{valor="-1";}
              
        return valor;
    }
    public int validateDniSf(String dni){
        int valor=0;
        Matcher m= patDni.matcher(dni);
        if(!m.matches()){valor=-1;}
              
        return valor;
    }
    
    public Dia validateDia(String dia){
        for(Dia d:Dia.values()){dias.add(d.toString());}
        Dia dia2;
        if (dias.contains(dia)) {
            dia2 = Dia.valueOf(dia);
        }else{dia2 = null;}
        
        return dia2;
    }
    
    public Turno validateTurno(String turno){
        for(Turno t:Turno.values()){turnos.add(t.toString());}
        Turno turno2;
        if (turnos.contains(turno)) {
            turno2 = Turno.valueOf(turno);
        }else{turno2 = null;}
        
        return turno2;
    }
    
    public int validateAño(String año){
        int valor;
        Matcher m= patAño.matcher(año);
        if (m.matches()) { valor= Integer.parseInt(año);
        }else{valor=-1;}
        
        return valor;
    }
    
    public String validateTelefono(String codA, String numT){
        String telefono="";
        String ca="";
        String nt="";
                
        Matcher m1 = patTelCa.matcher(codA);
        if (!m1.matches()) {ca="x";}
        Matcher m2 = patTelNt.matcher(numT);
        if (!m2.matches()) {nt="y";}
        
        if (ca.isEmpty()&&nt.isEmpty()) {
            telefono="("+codA+")"+" - "+numT;
        }else if(!ca.isEmpty()&&nt.isEmpty()){
            telefono=ca;
        }else if (ca.isEmpty()&&!nt.isEmpty()) {
            telefono=nt;
        }else{ telefono="z";}
        
        return telefono;
    }
    
    public List<String> validateCurso(Curso curso){
        //List<String> msjs = new ArrayList();
        for(Curso c:cr.getAll()){
            if (curso.equals(c)) {
                msjs.add("Curso existente en la base de datos");}
        }
        Matcher m1= patAlf.matcher(curso.getTitulo());
        Matcher m2= patCarac.matcher(curso.getTitulo());
        if (!m1.matches()){msjs.add("Titulo");
        }else{if (!m2.matches()) {msjs.add("Titulo");}}
        
        Matcher m3= patAlf.matcher(curso.getProfesor());
        Matcher m4= patCarac.matcher(curso.getProfesor());
        if (!m3.matches()){msjs.add("Profesor");
        }else{if (!m4.matches()) {msjs.add("Profesor");}}
        
        if (curso.getDia()==null) {msjs.add("Dia");}
        if (curso.getTurno()==null) {msjs.add("Turno");}
        
        Matcher m5= patHor.matcher(curso.getInicio());
        if (!m5.matches()) {msjs.add("Hora - Inicio");}
        
        Matcher m6= patHor.matcher(curso.getFin());
        if (!m6.matches()) {msjs.add("Hora - Fin");}
        
        if (curso.getIdcurso()==-1) {msjs.add("Id Curso");}
                
        return msjs;
    }
     
    public List<String> validateAlumno(Alumno alumno){
        //List<String> msjs = new ArrayList();
        for(Alumno a:ar.getAll()){
            if (alumno.getIdalum()==0) {
                if (alumno.getDni().equals(a.getDni())) {
                    msjs.add("Alumno existente en la base de datos");}  
            }else{
                if (alumno.getIdalum()!=a.getIdalum()&&alumno.getIdalum()!=-1){
                    if (alumno.getDni().equals(a.getDni())) {
                        msjs.add("Alumno existente en la base de datos");}}}
        }
        Matcher m1= patAlf.matcher(alumno.getNombre());
        Matcher m2= patCarac.matcher(alumno.getNombre());
        if (!m1.matches()){msjs.add("Nombre");
        }else{if (!m2.matches()) {msjs.add("Nombre");}}
        
        Matcher m3= patAlf.matcher(alumno.getApellido());
        Matcher m4= patCarac.matcher(alumno.getApellido());
        if (!m3.matches()){msjs.add("Apellido");
        }else{if (!m4.matches()) {msjs.add("Apellido");}}
             
        if (alumno.getEdad()<18||alumno.getEdad()>120) {msjs.add("Edad");}
        if (alumno.getDni().equals("-1")) {msjs.add("DNI");}
        if (alumno.getTelefono().equals("x")){msjs.add("Tel - C.Área");}
        if (alumno.getTelefono().equals("y")){msjs.add("Tel - Número");}
        if (alumno.getTelefono().equals("z")){msjs.add("Tel - C.Área/Número");}
        if(alumno.getIdalum()==-1){msjs.add("Id Alumno");}
                      
        return msjs;
    }
        
    public List<String> validateInscripcion(Inscripcion inscripcion){
        for(Inscripcion i:ir.getAll()){
            if (inscripcion.equals(i)) {
                msjs.add("El alumno ya esta inscripto a ese curso");}
        }
        if (inscripcion.getIdAlum()==-1) {msjs.add("Alumno inexistente");}
        if(inscripcion.getIdAlum()==-2){msjs.add("Lista alumnos");}
        if (inscripcion.getIdAlum()==-3) {msjs.add("Alumno: id/lista");}
        if (inscripcion.getIdCurso()==-1) {msjs.add("Curso");}
        if (inscripcion.getAño()==-1) {msjs.add("Año");}
            
        return msjs;
    }
    
    public String msjsElimReg(int num,Inscripcion inscripcion){
        String msj;
        if (num>0) {
            if (inscripcion.getIdReg()!=0) {
                String valor= String.valueOf(inscripcion.getIdReg());
                msj="Se ha ELIMINADO el N° Registro = "+valor;
            }else{
                String valor= Integer.toString(num);
                msj="No existe en la Base de Datos el N° Registro = "+valor;}
        }else if (num==-1) {
            msj="Error en N° Registro. Ingrese caracteres numéricos y mayores a '0'";
        }else if (num==-2) {
            msj="Error en Lista Registros. Ingrese caracteres numéricos y "
                    + "mayores a '0'";
        }else{msj="Error, complete N° Registro o Lista Registros";}
        
        return msj;    
    }
       
    //Matcher mDni = patDni.matcher(dni);
    //if (mDni.matches()) {
    //    dni2 = miles.format(Integer.parseInt(dni));
    //}else{w=1;dni2="0"; msj[3]="DNI";}
    
    /*
    public String[] msjTitPro(int[] valores){
        String msjs[]={"",""};
        for (int i=0; i<valores.length; i++) {
            if (valores[i]==1) {
                if (i==0) {msjs[i]="Titulo";}
                if (i==1) {msjs[i]="Profesor";}
            }
        }
        return msjs;  
    }
    
    public int[] validarCurso(String titulo,String profesor,String dia,
        String turno,String inicio,String fin){
        
        int[] valores={0,0,0,0,0,0};
        for(Dia d:Dia.values()){dias.add(d.toString());}
        for(Turno t:Turno.values()){turnos.add(t.toString());}
        String[]campos={titulo,profesor,dia,turno,inicio,fin};
        for (int i=0; i<campos.length; i++) {
            if (i<=1) {
                Matcher m1= patAlf.matcher(campos[i]);
                Matcher m2= patCarac.matcher(campos[i]);
                if (!m1.matches()){valores[i]=1;
                }else{if (!m2.matches()) {valores[i]=1;}}
            }
            if (i==2) {if (!dias.contains(campos[i])) {valores[i]=1;}}
            if (i==3) {if (!turnos.contains(campos[i])) {valores[i]=1;}}
            if (i>3&i<=campos.length-1) {
                Matcher m3= patHor.matcher(campos[i]);
                if (!m3.matches()) {valores[i]=1;}
            }
        }
        return valores;
    }*/
    

}
