package com.walcompany.entities;

import com.walcompany.enums.Dia;
import com.walcompany.enums.Turno;

public class Inscripcion {
    
    private int idReg;
    private int año;
    private int idAlum;
    private String dni;
    private String nombre;
    private String apellido;
    private int edad;
    private String telefono;
    private int idCurso;
    private String titulo;
    private String profesor;
    private Dia dia;
    private Turno turno;
    private String inicio;
    private String fin;

    
    public Inscripcion() {
    }
    
    public Inscripcion(int idAlum, int idCurso, int año) {
        this.idAlum = idAlum;
        this.idCurso = idCurso;
        this.año = año;
    }

    public Inscripcion(int idReg, int año, int idAlum, int idCurso) {
        this.idReg = idReg;
        this.año = año;
        this.idAlum = idAlum;
        this.idCurso = idCurso;
    }

    public Inscripcion(int idReg, int año, int idAlum, String dni, String nombre,
        String apellido, int idCurso,String titulo, String profesor, Dia dia,
        Turno turno, String inicio, String fin) {
        this.idReg = idReg;
        this.año = año;
        this.idAlum = idAlum;
        this.dni = dni;
        this.nombre = nombre;
        this.apellido = apellido;
        this.idCurso = idCurso;
        this.titulo = titulo;
        this.profesor = profesor;
        this.dia = dia;
        this.turno = turno;
        this.inicio = inicio;
        this.fin = fin;
    }

    public Inscripcion(int idReg, int año, int idAlum, String dni, String nombre,
        String apellido, int edad, String telefono, int idCurso, String titulo,
        String profesor, Dia dia, Turno turno, String inicio, String fin) {
        this.idReg = idReg;
        this.año = año;
        this.idAlum = idAlum;
        this.dni = dni;
        this.nombre = nombre;
        this.apellido = apellido;
        this.edad = edad;
        this.telefono = telefono;
        this.idCurso = idCurso;
        this.titulo = titulo;
        this.profesor = profesor;
        this.dia = dia;
        this.turno = turno;
        this.inicio = inicio;
        this.fin = fin;
    }

    @Override
    public String toString() {
        return "Inscripcion{idAlum=" + idAlum + ", idCurso=" + idCurso +
                ", a\u00f1o=" + año + '}';
    }
    
    public String toStringMedium() {
        return "Inscripcion{" + "idReg=" + idReg + ", a\u00f1o=" + año + ", idAlum=" +
                idAlum + ", dni=" + dni + ", nombre=" + nombre + ", apellido=" +
                apellido + ", idCurso=" + idCurso + ", titulo=" + titulo +
                ", profesor=" + profesor + ", dia=" + dia + ", turno=" + turno +
                ", inicio=" + inicio + ", fin=" + fin + '}';
    }
        
    public String toStringFull() {
        return "Inscripcion{" + "idReg=" + idReg + ", a\u00f1o=" + año + ", idAlum=" +
                idAlum + ", dni=" + dni + ", nombre=" + nombre + ", apellido=" +
                apellido + ", edad=" + edad + ", telefono=" + telefono +
                ", idCurso=" + idCurso + ", titulo=" + titulo + ", profesor=" +
                profesor + ", dia=" + dia + ", turno=" + turno + ", inicio=" +
                inicio + ", fin=" + fin + '}';
    }

    
    public int getIdReg() {
        return idReg;
    }

    public void setIdReg(int idReg) {
        this.idReg = idReg;
    }

    public int getAño() {
        return año;
    }

    public void setAño(int año) {
        this.año = año;
    }

    public int getIdAlum() {
        return idAlum;
    }

    public void setIdAlum(int idAlum) {
        this.idAlum = idAlum;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public int getIdCurso() {
        return idCurso;
    }

    public void setIdCurso(int idCurso) {
        this.idCurso = idCurso;
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

    public Turno getTurno() {
        return turno;
    }

    public void setTurno(Turno turno) {
        this.turno = turno;
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
