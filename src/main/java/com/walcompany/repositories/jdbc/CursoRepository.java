package com.walcompany.repositories.jdbc;

import com.walcompany.entities.Curso;
import com.walcompany.enums.Dia;
import com.walcompany.enums.Turno;
import com.walcompany.repositories.interfaces.I_CursoRepository;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.Normalizer;
import java.util.ArrayList;
import java.util.List;

public class CursoRepository implements I_CursoRepository{

    private Connection conex;

    public CursoRepository (Connection conex){
        this.conex = conex;
    }

    @Override
    public void save(Curso curso) {
        if (curso == null) {return;} 
        
        try(PreparedStatement ps=conex.prepareStatement(
            "insert into cursos (titulo,profesor,dia,turno,inicio,fin)"
                    + "values(?,?,?,?,?,?)",
            PreparedStatement.RETURN_GENERATED_KEYS)){
            //titulo
            int g=0,h=0,k=0,ac=0;
            String tituloFormato, tituloNorm, tituloSTilde;
            for (int i = 0; i < curso.getTitulo().length(); i++) {
                if (curso.getTitulo().charAt(i)==' '){
                    ac++;
                    if (ac==1) {g=i;}
                    if (ac==2) {h=i;}
                    if (ac==3) {k=i;}
                }
            }
            if (g!=0 && h==0 && k==0) {
                tituloFormato = curso.getTitulo().substring(0,1).toUpperCase()
                                +curso.getTitulo().substring(1,g).toLowerCase()
                                +" "+curso.getTitulo().substring(g+1,g+2).toUpperCase()
                                +curso.getTitulo().substring(g+2).toLowerCase();
                tituloNorm = Normalizer.normalize(tituloFormato, Normalizer.Form.NFD);
                tituloSTilde = tituloNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(1,tituloSTilde);
            }else if(g!=0 && h!=0 && k==0) {
                tituloFormato=curso.getTitulo().substring(0,1).toUpperCase()
                        +curso.getTitulo().substring(1,g).toLowerCase()
                        +" "+curso.getTitulo().substring(g+1,g+2).toUpperCase()
                        +curso.getTitulo().substring(g+2,h).toLowerCase()
                        +" "+curso.getTitulo().substring(h+1,h+2).toUpperCase()
                        +curso.getTitulo().substring(h+2).toLowerCase();
                tituloNorm = Normalizer.normalize(tituloFormato, Normalizer.Form.NFD);
                tituloSTilde = tituloNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(1,tituloSTilde); 
            }else if (g!=0 && h!=0 && k!=0) {
                tituloFormato=curso.getTitulo().substring(0,1).toUpperCase()
                        +curso.getTitulo().substring(1,g).toLowerCase()
                        +" "+curso.getTitulo().substring(g+1,g+2).toUpperCase()
                        +curso.getTitulo().substring(g+2,h).toLowerCase()
                        +" "+curso.getTitulo().substring(h+1,h+2).toUpperCase()
                        +curso.getTitulo().substring(h+2,k).toLowerCase()
                        +" "+curso.getTitulo().substring(k+1,k+2).toUpperCase()
                        +curso.getTitulo().substring(k+2).toLowerCase();
                tituloNorm = Normalizer.normalize(tituloFormato, Normalizer.Form.NFD);
                tituloSTilde = tituloNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(1,tituloSTilde); 
            }else{
                tituloFormato = curso.getTitulo().substring(0,1).toUpperCase()
                                +curso.getTitulo().substring(1).toLowerCase();
                tituloNorm = Normalizer.normalize(tituloFormato, Normalizer.Form.NFD);
                tituloSTilde = tituloNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(1,tituloSTilde);}
            //profesor:         
            int p=0,q=0,r=0,acu=0;
            String profeFormato, profeNorm, profeSTilde;
            for (int i = 0; i < curso.getProfesor().length(); i++) {
                if (curso.getProfesor().charAt(i)==' '){
                    acu++;
                    if (acu==1) {p=i;}
                    if (acu==2) {q=i;}
                    if (acu==3) {r=i;}
                }
            }
            if (p!=0 &&q==0 && r==0) {
                profeFormato = curso.getProfesor().substring(0,1).toUpperCase()
                        +curso.getProfesor().substring(1,p).toLowerCase()
                        +" "+curso.getProfesor().substring(p+1,p+2).toUpperCase()
                        +curso.getProfesor().substring(p+2).toLowerCase();
                profeNorm = Normalizer.normalize(profeFormato, Normalizer.Form.NFD);
                profeSTilde = profeNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(2,profeSTilde);   
            }else if(p!=0 && q!=0 && r ==0) {
                profeFormato = curso.getProfesor().substring(0,1).toUpperCase()
                        +curso.getProfesor().substring(1,p).toLowerCase()
                        +" "+curso.getProfesor().substring(p+1,p+2).toUpperCase()
                        +curso.getProfesor().substring(p+2,q).toLowerCase()
                        +" "+curso.getProfesor().substring(q+1,q+2).toUpperCase()
                        +curso.getProfesor().substring(q+2).toLowerCase();
                profeNorm = Normalizer.normalize(profeFormato, Normalizer.Form.NFD);
                profeSTilde = profeNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(2,profeSTilde);
            }else if (p!=0 && q!=0 && r!=0) {
                profeFormato = curso.getProfesor().substring(0,1).toUpperCase()
                        +curso.getProfesor().substring(1,p).toLowerCase()
                        +" "+curso.getProfesor().substring(p+1,p+2).toUpperCase()
                        +curso.getProfesor().substring(p+2,q).toLowerCase()
                        +" "+curso.getProfesor().substring(q+1,q+2).toUpperCase()
                        +curso.getProfesor().substring(q+2,r).toLowerCase()
                        +" "+curso.getProfesor().substring(r+1,r+2).toUpperCase()
                        +curso.getProfesor().substring(r+2).toLowerCase();
                profeNorm = Normalizer.normalize(profeFormato, Normalizer.Form.NFD);
                profeSTilde = profeNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(2,profeSTilde);
            }else{
                profeFormato = curso.getProfesor().substring(0,1).toUpperCase()
                        +curso.getProfesor().substring(1).toLowerCase();
                profeNorm = Normalizer.normalize(profeFormato, Normalizer.Form.NFD);
                profeSTilde = profeNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(2,profeSTilde);
            }
            //dia
            ps.setString(3,curso.getDia().toString());
            //turno
            ps.setString(4,curso.getTurno().toString());
            ps.setString(5,curso.getInicio());
            ps.setString(6,curso.getFin());
            ps.execute();
            ResultSet rs = ps.getGeneratedKeys();  
            if (rs.next()) {curso.setIdcurso(rs.getInt(1));}
        } catch (Exception e) {System.out.println(e);}
    }
   
    @Override
    public void remove(Curso curso) {
        if (curso == null) {return;}
        try(PreparedStatement ps = conex.prepareStatement(
            "delete from cursos where idcurso=?")) {
            ps.setInt(1,curso.getIdcurso());
            ps.execute();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    @Override
    public void update(Curso curso) {
        if (curso == null) {return;}
            
        try(PreparedStatement ps = conex.prepareStatement(
            "update cursos set titulo=?,profesor=?,dia=?,turno=?,inicio=?,"
            + "fin=? where idcurso=? ")) {
            
            int g=0,h=0,k=0,ac=0;
            String tituloFormato, tituloNorm, tituloSTilde;
            for (int i = 0; i < curso.getTitulo().length(); i++) {
                if (curso.getTitulo().charAt(i)==' '){
                    ac++;
                    if (ac==1) {g=i;}
                    if (ac==2) {h=i;}
                    if (ac==3) {k=i;}
                }
            }
            if (g!=0 && h==0 && k==0) {
                tituloFormato = curso.getTitulo().substring(0,1).toUpperCase()
                        +curso.getTitulo().substring(1,g).toLowerCase()
                        +" "+curso.getTitulo().substring(g+1,g+2).toUpperCase()
                        +curso.getTitulo().substring(g+2).toLowerCase();
                tituloNorm = Normalizer.normalize(tituloFormato, Normalizer.Form.NFD);
                tituloSTilde = tituloNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(1,tituloSTilde);
            }else if(g!=0 && h!=0 && k==0) {
                tituloFormato = curso.getTitulo().substring(0,1).toUpperCase()
                        +curso.getTitulo().substring(1,g).toLowerCase()
                        +" "+curso.getTitulo().substring(g+1,g+2).toUpperCase()
                        +curso.getTitulo().substring(g+2,h).toLowerCase()
                        +" "+curso.getTitulo().substring(h+1,h+2).toUpperCase()
                        +curso.getTitulo().substring(h+2).toLowerCase();
                tituloNorm = Normalizer.normalize(tituloFormato, Normalizer.Form.NFD);
                tituloSTilde = tituloNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(1,tituloSTilde);
            }else if (g!=0 && h!=0 && k!=0) {
                tituloFormato = curso.getTitulo().substring(0,1).toUpperCase()
                        +curso.getTitulo().substring(1,g).toLowerCase()
                        +" "+curso.getTitulo().substring(g+1,g+2).toUpperCase()
                        +curso.getTitulo().substring(g+2,h).toLowerCase()
                        +" "+curso.getTitulo().substring(h+1,h+2).toUpperCase()
                        +curso.getTitulo().substring(h+2,k).toLowerCase()
                        +" "+curso.getTitulo().substring(k+1,k+2).toUpperCase()
                        +curso.getTitulo().substring(k+2).toLowerCase();
                tituloNorm = Normalizer.normalize(tituloFormato, Normalizer.Form.NFD);
                tituloSTilde = tituloNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(1,tituloSTilde);
            }else{
                tituloFormato = curso.getTitulo().substring(0,1).toUpperCase()
                        +curso.getTitulo().substring(1).toLowerCase();
                tituloNorm = Normalizer.normalize(tituloFormato, Normalizer.Form.NFD);
                tituloSTilde = tituloNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(1,tituloSTilde);                
            }
            //profesor:         
            int p=0,q=0,r=0,acu=0;
            String profeFormato, profeNorm, profeSTilde;
            for (int i = 0; i < curso.getProfesor().length(); i++) {
                if (curso.getProfesor().charAt(i)==' '){
                    acu++;
                    if (acu==1) {p=i;}
                    if (acu==2) {q=i;}
                    if (acu==3) {r=i;}
                }
            }
            if (p!=0 &&q==0 && r==0) {
                profeFormato = curso.getProfesor().substring(0,1).toUpperCase()
                        +curso.getProfesor().substring(1,p).toLowerCase()
                        +" "+curso.getProfesor().substring(p+1,p+2).toUpperCase()
                        +curso.getProfesor().substring(p+2).toLowerCase();
                profeNorm = Normalizer.normalize(profeFormato, Normalizer.Form.NFD);
                profeSTilde = profeNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(2,profeSTilde);
            }else if(p!=0 && q!=0 && r ==0) {
                profeFormato = curso.getProfesor().substring(0,1).toUpperCase()
                        +curso.getProfesor().substring(1,p).toLowerCase()
                        +" "+curso.getProfesor().substring(p+1,p+2).toUpperCase()
                        +curso.getProfesor().substring(p+2,q).toLowerCase()
                        +" "+curso.getProfesor().substring(q+1,q+2).toUpperCase()
                        +curso.getProfesor().substring(q+2).toLowerCase();
                profeNorm = Normalizer.normalize(profeFormato, Normalizer.Form.NFD);
                profeSTilde = profeNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(2,profeSTilde);
            }else if (p!=0 && q!=0 && r!=0) {
                profeFormato = curso.getProfesor().substring(0,1).toUpperCase()
                        +curso.getProfesor().substring(1,p).toLowerCase()
                        +" "+curso.getProfesor().substring(p+1,p+2).toUpperCase()
                        +curso.getProfesor().substring(p+2,q).toLowerCase()
                        +" "+curso.getProfesor().substring(q+1,q+2).toUpperCase()
                        +curso.getProfesor().substring(q+2,r).toLowerCase()
                        +" "+curso.getProfesor().substring(r+1,r+2).toUpperCase()
                        +curso.getProfesor().substring(r+2).toLowerCase();
                profeNorm = Normalizer.normalize(profeFormato, Normalizer.Form.NFD);
                profeSTilde = profeNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(2,profeSTilde);
            }else{
                profeFormato = curso.getProfesor().substring(0,1).toUpperCase()
                        +curso.getProfesor().substring(1).toLowerCase();
                profeNorm = Normalizer.normalize(profeFormato, Normalizer.Form.NFD);
                profeSTilde = profeNorm.replaceAll("[^\\p{ASCII}]","");
                ps.setString(2,profeSTilde);
            }
            ps.setString(3,curso.getDia().toString());
            ps.setString(4,curso.getTurno().toString());
            ps.setString(5,curso.getInicio());
            ps.setString(6,curso.getFin());
            ps.setInt(7,curso.getIdcurso());
            ps.execute();
        } catch (Exception e) {System.out.println(e);}
    }

    @Override
    public List<Curso> getAll() {
        List<Curso> lista = new ArrayList();
        try(ResultSet rs = conex.createStatement().executeQuery(
            "select * from cursos order by idcurso")) {
            while (rs.next()) {
                lista.add(  new Curso(  rs.getInt("idcurso"),    
                                        rs.getString("titulo"),
                                        rs.getString("profesor"),
                                        Dia.valueOf(rs.getString("dia")),
                                        Turno.valueOf(rs.getString("turno")),
                                        rs.getString("inicio"),
                                        rs.getString("fin")
                            )
                );
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return lista;
    }
}    

