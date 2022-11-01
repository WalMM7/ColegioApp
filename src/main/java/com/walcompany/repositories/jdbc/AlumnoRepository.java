package com.walcompany.repositories.jdbc;

import com.walcompany.entities.Alumno;
import com.walcompany.repositories.interfaces.I_AlumnoRepository;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.Normalizer;
import java.util.ArrayList;
import java.util.List;

public class AlumnoRepository implements I_AlumnoRepository {
    
    private Connection conex;
    
    public AlumnoRepository(Connection conex){
        this.conex = conex;
    }

    @Override
    public void save(Alumno alumno) {
        if (alumno==null) {return;}
        try(PreparedStatement ps=conex.prepareStatement(
                "insert into alumnos(nombre,apellido,edad,dni,telefono)"
                        + "values(?,?,?,?,?)",
                PreparedStatement.RETURN_GENERATED_KEYS)) {
            //Nombre
            int p=0,q=0,cont=0;
            String nombreFormato,nombreNorm,nombreSTilde;
            for (int i = 0; i < alumno.getNombre().length(); i++) {
                if (alumno.getNombre().charAt(i)==' '){
                    cont++;
                    if (cont==1) {p=i;}
                    if (cont==2) {q=i;}
                }
            }
            if (p!=0 && q==0) {
                nombreFormato = alumno.getNombre().substring(0,1).toUpperCase()
                    +alumno.getNombre().substring(1,p).toLowerCase()
                    +" "+alumno.getNombre().substring(p+1,p+2).toUpperCase()
                    +alumno.getNombre().substring(p+2).toLowerCase();
                nombreNorm= Normalizer.normalize(nombreFormato, Normalizer.Form.NFD);
                nombreSTilde = nombreNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(1,nombreSTilde);
            }else if (p!=0 && q!=0) {
                nombreFormato = alumno.getNombre().substring(0,1).toUpperCase()
                    +alumno.getNombre().substring(1,p).toLowerCase()
                    +" "+alumno.getNombre().substring(p+1,p+2).toUpperCase()
                    +alumno.getNombre().substring(p+2,q).toLowerCase()
                    +" "+alumno.getNombre().substring(q+1,q+2).toUpperCase()
                    +alumno.getNombre().substring(q+2).toLowerCase();
                nombreNorm= Normalizer.normalize(nombreFormato, Normalizer.Form.NFD);
                nombreSTilde = nombreNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(1,nombreSTilde);               
            }else{
                nombreFormato = alumno.getNombre().substring(0,1).toUpperCase()
                    +alumno.getNombre().substring(1).toLowerCase();
                nombreNorm= Normalizer.normalize(nombreFormato, Normalizer.Form.NFD);
                nombreSTilde = nombreNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(1,nombreSTilde);  
            }
            //Apellido
            int r=0,s=0,contt=0;
            String apellidoFormato, apellidoNorm, apellidoSTilde;
            for (int i = 0; i < alumno.getApellido().length(); i++) {
                if (alumno.getApellido().charAt(i)==' '){
                    contt++;
                    if (contt==1) {r=i;}
                    if (contt==2) {s=i;}
                }
            }
            if (r!=0 && s==0) {
                apellidoFormato = alumno.getApellido().substring(0,1).toUpperCase()
                    +alumno.getApellido().substring(1,r).toLowerCase()
                    +" "+alumno.getApellido().substring(r+1,r+2).toUpperCase()
                    +alumno.getApellido().substring(r+2).toLowerCase();
                apellidoNorm = Normalizer
                                .normalize(apellidoFormato, Normalizer.Form.NFD);
                apellidoSTilde = apellidoNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(2,apellidoSTilde);
            }else if (r!=0 && s!=0) {
                apellidoFormato = alumno.getApellido().substring(0,1).toUpperCase()
                    +alumno.getApellido().substring(1,r).toLowerCase()
                    +" "+alumno.getApellido().substring(r+1,r+2).toUpperCase()
                    +alumno.getApellido().substring(r+2,s).toLowerCase()
                    +" "+alumno.getApellido().substring(s+1,s+2).toUpperCase()
                    +alumno.getApellido().substring(s+2).toLowerCase();
                apellidoNorm = Normalizer
                                .normalize(apellidoFormato, Normalizer.Form.NFD);
                apellidoSTilde = apellidoNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(2,apellidoSTilde);
            }else{
                apellidoFormato = alumno.getApellido().substring(0,1).toUpperCase()
                    +alumno.getApellido().substring(1).toLowerCase();
                apellidoNorm = Normalizer
                                .normalize(apellidoFormato, Normalizer.Form.NFD);
                apellidoSTilde = apellidoNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(2,apellidoSTilde);
            }
            //Edad
            ps.setInt(3,alumno.getEdad());
            //dni
            ps.setString(4,alumno.getDni());
            ps.setString(5,alumno.getTelefono());
            ps.execute();
            ResultSet rs=ps.getGeneratedKeys();
            if (rs.next()) {
                alumno.setIdalum(rs.getInt(1));
            }
        } catch (Exception e) {System.out.println(e);}
    }

    @Override
    public void remove(Alumno alumno) {
        if (alumno==null) {return;} 
        try (PreparedStatement ps=conex.prepareStatement(
                "delete from alumnos where idalum=?")){
            ps.setInt(1,alumno.getIdalum());
            ps.execute();
        } catch (Exception e) {
        }
    }

    @Override
    public void update(Alumno alumno) {
        if (alumno==null) {return;}
        try(PreparedStatement ps=conex.prepareStatement(
            "update alumnos set nombre=?,apellido=?,edad=?,dni=?,telefono=?"
                    + " where idalum=?")) {
            //Nombre
            int p=0,q=0,cont=0;
            String nombreFormato, nombreNorm, nombreSTilde;
            for (int i = 0; i < alumno.getNombre().length(); i++) {
                if (alumno.getNombre().charAt(i)==' '){
                    cont++;
                    if (cont==1) {p=i;}
                    if (cont==2) {q=i;}
                }
            }
            if (p!=0 && q==0) {
                nombreFormato = alumno.getNombre().substring(0,1).toUpperCase()
                    +alumno.getNombre().substring(1,p).toLowerCase()
                    +" "+alumno.getNombre().substring(p+1,p+2).toUpperCase()
                    +alumno.getNombre().substring(p+2).toLowerCase();
                nombreNorm= Normalizer.normalize(nombreFormato, Normalizer.Form.NFD);
                nombreSTilde = nombreNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(1,nombreSTilde);
            }else if (p!=0 && q!=0) {
                nombreFormato = alumno.getNombre().substring(0,1).toUpperCase()
                    +alumno.getNombre().substring(1,p).toLowerCase()
                    +" "+alumno.getNombre().substring(p+1,p+2).toUpperCase()
                    +alumno.getNombre().substring(p+2,q).toLowerCase()
                    +" "+alumno.getNombre().substring(q+1,q+2).toUpperCase()
                    +alumno.getNombre().substring(q+2).toLowerCase();
                nombreNorm= Normalizer.normalize(nombreFormato, Normalizer.Form.NFD);
                nombreSTilde = nombreNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(1,nombreSTilde);
            }else{
                nombreFormato = alumno.getNombre().substring(0,1).toUpperCase()
                    +alumno.getNombre().substring(1).toLowerCase();
                nombreNorm= Normalizer.normalize(nombreFormato, Normalizer.Form.NFD);
                nombreSTilde = nombreNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(1,nombreSTilde);
            }
            //Apellido          
            int r=0,s=0,contt=0;
            String apellidoFormato, apellidoNorm, apellidoSTilde;
            for (int i = 0; i < alumno.getApellido().length(); i++) {
                if (alumno.getApellido().charAt(i)==' '){
                    contt++;
                    if (contt==1) {r=i;}
                    if (contt==2) {s=i;}
                }
            }
            if (r!=0 && s==0) {
                apellidoFormato = alumno.getApellido().substring(0,1).toUpperCase()
                    +alumno.getApellido().substring(1,r).toLowerCase()
                    +" "+alumno.getApellido().substring(r+1,r+2).toUpperCase()
                    +alumno.getApellido().substring(r+2).toLowerCase();
                apellidoNorm = Normalizer
                                .normalize(apellidoFormato, Normalizer.Form.NFD);
                apellidoSTilde = apellidoNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(2,apellidoSTilde);
            }else if (r!=0 && s!=0) {
                apellidoFormato = alumno.getApellido().substring(0,1).toUpperCase()
                    +alumno.getApellido().substring(1,r).toLowerCase()
                    +" "+alumno.getApellido().substring(r+1,r+2).toUpperCase()
                    +alumno.getApellido().substring(r+2,s).toLowerCase()
                    +" "+alumno.getApellido().substring(s+1,s+2).toUpperCase()
                    +alumno.getApellido().substring(s+2).toLowerCase();
                apellidoNorm = Normalizer
                                .normalize(apellidoFormato, Normalizer.Form.NFD);
                apellidoSTilde = apellidoNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(2,apellidoSTilde);
            }else{
                apellidoFormato = alumno.getApellido().substring(0,1).toUpperCase()
                    +alumno.getApellido().substring(1).toLowerCase();
                apellidoNorm = Normalizer
                                .normalize(apellidoFormato, Normalizer.Form.NFD);
                apellidoSTilde = apellidoNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(2,apellidoSTilde);
            }
            //Edad
            ps.setInt(3,alumno.getEdad());
            //Dni
            ps.setString(4,alumno.getDni());
            //Telefono & idalum
            ps.setString(5,alumno.getTelefono());
            ps.setInt(6,alumno.getIdalum());
            ps.execute();
        } catch (Exception e) {System.out.println(e);}
    }

    @Override
    public List<Alumno> getAll() {
        List<Alumno> lista= new ArrayList();
        try(ResultSet rs=conex.createStatement().executeQuery(
                "select*from alumnos")) {
            while(rs.next()){
                lista.add(  new Alumno( 
                                        rs.getInt("idalum"),
                                        rs.getString("nombre"),
                                        rs.getString("apellido"),
                                        rs.getInt("edad"),
                                        rs.getString("dni"),
                                        rs.getString("telefono")
                            )
                );
            }
        } catch (Exception e) {System.out.println(e);}
        return lista;
    }
    
}
