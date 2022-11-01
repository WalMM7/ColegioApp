package com.walcompany.entities;

public class Alumno {

    private int     idalum;
    private String  nombre;
    private String  apellido;
    private int     edad;
    private String     dni;
    private String telefono;

    public Alumno() {
    }

    public Alumno(String nombre, String apellido, int edad, String dni,
            String telefono) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.edad = edad;
        this.dni = dni;
        this.telefono = telefono;
    }

    public Alumno(int idalum, String nombre, String apellido, int edad, String dni,
            String telefono) {
        this.idalum = idalum;
        this.nombre = nombre;
        this.apellido = apellido;
        this.edad = edad;
        this.dni = dni;
        this.telefono = telefono;
    }

    @Override
    public String toString() {
        return "Alumno{ nombre="+nombre+", apellido="+apellido+", edad="+edad+
                ", dni="+dni+'}';
    }

    public String toString(boolean v) {
        return "Alumno{"+"idalum="+idalum+", nombre="+nombre+", apellido="+                       apellido+ ", edad="+edad+", dni="+dni+", telefono= "+telefono+'}';
    }

    public int getIdalum() {
        return idalum;
    }

    public void setIdalum(int idalum) {
        this.idalum = idalum;
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

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
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