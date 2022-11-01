package com.walcompany.repositories.jdbc;

import com.walcompany.entities.Inscripcion;
import com.walcompany.enums.Dia;
import com.walcompany.enums.Turno;
import com.walcompany.repositories.interfaces.I_InscripcionRepository;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class InscripcionRepository implements I_InscripcionRepository {
    
    private Connection conex;

    public InscripcionRepository(Connection conex) {
        this.conex = conex;
    }
    
    
    @Override
    public void save(Inscripcion inscripcion) {
        if (inscripcion == null) {return;}
        try (PreparedStatement ps = conex.prepareStatement(
            "insert into inscripciones(idAlum,idCurso,año) values(?,?,?)",
                PreparedStatement.RETURN_GENERATED_KEYS)){
            
            ps.setInt(1,inscripcion.getIdAlum());
            ps.setInt(2,inscripcion.getIdCurso());
            ps.setInt(3,inscripcion.getAño());
            ps.execute();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {inscripcion.setIdReg(rs.getInt(1));}
        }catch (Exception e) {System.out.println(e);}
    }

    @Override
    public void update(Inscripcion inscripcion) {
        if (inscripcion==null) {return;}
        try (PreparedStatement ps = conex.prepareStatement(
            "update inscripciones set idAlum=?,idCurso=?,año=? where idReg=?")){
            
            ps.setInt(1,inscripcion.getIdAlum());
            ps.setInt(2,inscripcion.getIdCurso());
            ps.setInt(3,inscripcion.getAño());
            ps.setInt(4,inscripcion.getIdReg());
            ps.execute();
        } catch (Exception e) {System.out.println(e);}
    }

    @Override
    public void remove(Inscripcion inscripcion) {
        if (inscripcion==null) {return;}
        try(PreparedStatement ps = conex.prepareStatement(
            "delete from inscripciones where idReg=?")) {
            
            ps.setInt(1,inscripcion.getIdReg());
            ps.execute();
        } catch (Exception e) {System.out.println(e);}
    }
    
    @Override
    public List<Inscripcion> getAll() {
        List<Inscripcion> lista = new ArrayList();
        try (ResultSet rs = conex.createStatement().executeQuery(
            "select * from inscripciones order by idReg")){
            while(rs.next()){
                lista.add(new Inscripcion(
                        rs.getInt("idReg"),
                        rs.getInt("año"),
                        rs.getInt("idAlum"),
                        rs.getInt("idCurso")));
            }
        } catch (Exception e) {System.out.println(e);}
               
        return lista;
    }

    @Override
    public List<Inscripcion> getAllInnerJM() {
        List<Inscripcion> lista = new ArrayList();
        try (ResultSet rs = conex.createStatement().executeQuery(
            "select i.idReg,i.año,a.idalum,a.dni,a.nombre,a.apellido,\n" +
            "c.idcurso,c.titulo,c.profesor,c.dia,c.turno,c.inicio,c.fin \n" +
            "from inscripciones as i\n" +
            "inner join alumnos as a\n" +
            "on i.idAlum = a.idalum\n" +
            "inner join cursos as c\n" +
            "on i.idCurso = c.idcurso\n" +
            "order by i.idReg")){
            while(rs.next()){
                lista.add(new Inscripcion(  rs.getInt("idReg"),//1
                                            rs.getInt("año"),//2
                                            rs.getInt("idalum"),//3
                                            rs.getString("dni"),//4
                                            rs.getString("nombre"),//5
                                            rs.getString("apellido"),//6
                                            rs.getInt("idcurso"),//7
                                            rs.getString("titulo"),//8
                                            rs.getString("profesor"),//9
                                            Dia.valueOf(rs.getString("dia")),//10
                                            Turno.valueOf(rs.getString("turno")),//11
                                            rs.getString("inicio"),//12
                                            rs.getString("fin")));//13
            }
        } catch (Exception e) {System.out.println(e);}
               
        return lista;
    }
    
    /*
    @Override
    public List<Inscripcion> getAllInnerJL() {
        List<Inscripcion> lista = new ArrayList();
        try (ResultSet rs = conex.createStatement().executeQuery(
                "select i.idReg,i.año,a.idalum,a.dni,a.nombre,a.apellido,"
                + "a.edad,a.telefono,c.idcurso,c.titulo,c.profesor,c.dia,"
                + "c.turno,c.inicio,c.fin "
                + "from inscripciones as i"
                + " inner join alumnos as a "
                + "on i.idAlum = a.idalum "
                + "inner join cursos as c "
                + "on i.idCurso = c.idcurso"
                + "order by i.idReg")){
                   
            while(rs.next()){
                lista.add(new Inscripcion(  rs.getInt("idReg"),//1
                                            rs.getInt("año"),//2
                                            rs.getInt("idalum"),//3
                                            rs.getString("dni"),//4
                                            rs.getString("nombre"),//5
                                            rs.getString("apellido"),//6
                                            rs.getInt("edad"),//7
                                            rs.getString("telefono"),//8
                                            rs.getInt("idcurso"),//9
                                            rs.getString("titulo"),//10
                                            rs.getString("profesor"),//11
                                            Dia.valueOf(rs.getString("dia")),//12
                                            Turno.valueOf(rs.getString("turno")),//13
                                            rs.getString("inicio"),//14
                                            rs.getString("fin")));//15
            }
        } catch (Exception e) {System.out.println(e);}
               
        return lista;
    }
    */

    
}
