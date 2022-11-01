package com.walcompany.entities;

import com.walcompany.enums.Dia;
import com.walcompany.enums.Turno;

public class Curso {
  
    private int     idcurso;
    private String  titulo;
    private String  profesor;
    private Dia     dia;
    private Turno   turno;
    private String inicio;
    private String fin;
  
    public Curso() {
    }
   
    public Curso(String titulo, String profesor, Dia dia, Turno turno,
            String inicio, String fin) {
        this.titulo = titulo;
        this.profesor = profesor;
        this.dia = dia;
        this.turno = turno;
        this.inicio = inicio;
        this.fin = fin;
    }
   
    public Curso(int idcurso, String titulo, String profesor, Dia dia, Turno turno,
            String inicio, String fin) {
        this.idcurso = idcurso;
        this.titulo = titulo;
        this.profesor = profesor;
        this.dia = dia;
        this.turno = turno;
        this.inicio = inicio;
        this.fin = fin;
    }
  
    @Override
    public String toString() {
        return "Curso{ titulo= "+titulo+", profesor= "+profesor+", dia= "+
                dia+", turno= "+turno+", inicio="+inicio+
                ", fin="+fin+'}';
    }
    
    public String toString(boolean v){
        return "Curso{ idcurso="+idcurso+", titulo="+titulo+", profesor="
                +profesor+", dia="+dia+", turno="+turno+", inicio="
                +inicio+", fin="+fin+'}';
    }
  
    public Turno getTurno() {
        return turno;
    }

    public void setTurno(Turno turno) {
        this.turno = turno;
    }

    public int getIdcurso() {
        return idcurso;
    }

    public void setIdcurso(int idcurso) {
        this.idcurso = idcurso;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getProfesor() {
        return profesor;
    }

    public void setProfesor(String profesor) {
        this.profesor = profesor;
    }

    public Dia getDia() {
        return dia;
    }
    
    public void setDia(Dia dia) {
        this.dia = dia;
    }
    
    public String getInicio() {
        return inicio;
    }

    public void setInicio(String inicio) {
        this.inicio = inicio;
    }

    public String getFin() {
        return fin;
    }

    public void setFin(String fin) {
        this.fin = fin;
    }
    
    @Override
    public int hashCode() {
        return toString().toLowerCase().hashCode();
    }

    @Override
    public boolean equals(Object obj) {
        if (obj== null) {
            return false;
        }
        return this.hashCode()== obj.hashCode();
    }
   
}
