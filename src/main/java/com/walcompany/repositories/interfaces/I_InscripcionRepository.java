package com.walcompany.repositories.interfaces;

import com.walcompany.entities.Inscripcion;
import java.text.Normalizer;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public interface I_InscripcionRepository {
    
    void save(Inscripcion insc);
    void update(Inscripcion insc);
    void remove(Inscripcion insc);
    List<Inscripcion> getAll();
    List<Inscripcion> getAllInnerJM();
        
    default Inscripcion getByIdReg(int idReg){
        return getAllInnerJM()
                .stream()
                .filter(i->i.getIdReg()==idReg)
                .findFirst()
                .orElse(new Inscripcion());
    }
    
    default Inscripcion getByDni (String dni){
        return getAllInnerJM()
                .stream()
                .filter(i->i.getDni().replaceAll("\\.","").equals(dni))
                .findFirst()
                .orElse(new Inscripcion());
    }
        
    default List<Inscripcion> getByIdCur(int idcur){
        return getAllInnerJM()
                .stream()
                .filter(i->i.getIdCurso()==idcur)
                .collect(Collectors.toList());
    } 
    
    default List<Inscripcion> getByIdAlum(int idAlum){
        return getAllInnerJM()
                .stream()
                .filter(i->i.getIdAlum()==idAlum)
                .collect(Collectors.toList());
    }
    
    default List<Inscripcion> getByAño(int año){
        return getAllInnerJM()
                .stream()
                .filter(i->i.getAño()==año)
                .collect(Collectors.toList());
    }
    // Metodo DNI - Titulo - Año
    default List<Inscripcion> getLikeDniTitAño(String dni,String tit,int año){
        if (dni!=null&&tit!=null) {
            List<Inscripcion>li=new ArrayList();
            String titNorm= Normalizer.normalize(tit, Normalizer.Form.NFD);
            String titSTilde = titNorm.replaceAll("[^\\p{ASCII}]","");
            li.addAll(getAllInnerJM()
                .stream()
                .filter(i-> i.getDni().replaceAll("\\.","").equals(dni) &&
                        i.getTitulo().toLowerCase()
                        .contains(titSTilde.toLowerCase())
                        &&i.getAño()==año)
                .collect(Collectors.toList()));
            if (!li.isEmpty()){return li;}else{return new ArrayList();}
        }else{ return new ArrayList();}
    }
    
    default List<Inscripcion> getLikeDniTit(String dni,String tit){
        if (dni!=null&&tit!=null) {
            List<Inscripcion>li=new ArrayList();
            String titNorm= Normalizer.normalize(tit, Normalizer.Form.NFD);
            String titSTilde = titNorm.replaceAll("[^\\p{ASCII}]","");
            li.addAll(getAllInnerJM()
                    .stream()
                    .filter(i-> i.getDni().replaceAll("\\.","").equals(dni)&&
                                i.getTitulo().toLowerCase()
                                .contains(titSTilde.toLowerCase()))
                    .collect(Collectors.toList()));
            if (!li.isEmpty()){return li;}else{return new ArrayList();}
        }else{ return new ArrayList();}
    }
    
    default List<Inscripcion> getLikeDniAño(String dni,int año){
        if (dni!=null) {
            List<Inscripcion>li=new ArrayList();
            li.addAll(getAllInnerJM()
                    .stream()
                    .filter(i-> i.getDni().replaceAll("\\.","").equals(dni) &&       
                                i.getAño()==año)
                    .collect(Collectors.toList()));
            if (!li.isEmpty()){return li;}else{return new ArrayList();}
        }else{ return new ArrayList();}
    }
    default List<Inscripcion> getLikeTitAño(String tit,int año){
        if (tit!=null) {
            List<Inscripcion>li=new ArrayList();
            String titNorm= Normalizer.normalize(tit, Normalizer.Form.NFD);
            String titSTilde = titNorm.replaceAll("[^\\p{ASCII}]","");
            li.addAll(getAllInnerJM()
                .stream()
                .filter(i-> i.getTitulo().toLowerCase()
                        .contains(titSTilde.toLowerCase())
                        &&i.getAño()==año)
                .collect(Collectors.toList()));
            if (!li.isEmpty()){return li;}else{return new ArrayList();}
        }else{ return new ArrayList();}
    }
    
    default List<Inscripcion> getLikeTit(String tit){
        if (tit!=null) {
            List<Inscripcion>li=new ArrayList();
            String titNorm= Normalizer.normalize(tit, Normalizer.Form.NFD);
            String titSTilde = titNorm.replaceAll("[^\\p{ASCII}]","");
            li.addAll(getAllInnerJM()
                    .stream()
                    .filter(i->i.getTitulo().toLowerCase()
                            .contains(titSTilde.toLowerCase()))
                    .collect(Collectors.toList()));
            if (!li.isEmpty()){return li;}else{return new ArrayList();}
        }else{ return new ArrayList();}
    }
    
    //Metodo Nombre - Apellido - Id Curso
    default List<Inscripcion> getLikeNomApeIdC(String nom,String ape,int idc){
        if (nom!=null&&ape!=null) {
            List<Inscripcion>li=new ArrayList();
            String nomNorm= Normalizer.normalize(nom, Normalizer.Form.NFD);
            String nomSTilde = nomNorm.replaceAll("[^\\p{ASCII}]","");
            String apeNorm= Normalizer.normalize(ape, Normalizer.Form.NFD);
            String apeSTilde = apeNorm.replaceAll("[^\\p{ASCII}]","");
            li.addAll(getAllInnerJM()
                .stream()
                .filter(i-> i.getNombre().toLowerCase()
                    .contains(nomSTilde.toLowerCase())
                    &&i.getApellido().toLowerCase()
                    .contains(apeSTilde.toLowerCase())
                    &&i.getIdCurso()==idc)
                .collect(Collectors.toList()));
            if (!li.isEmpty()){return li;}else{return new ArrayList();}
        }else{ return new ArrayList();}
    }
    
    default List<Inscripcion> getLikeNomApe(String nom,String ape){
        if (nom!=null&&ape!=null) {
            List<Inscripcion>li=new ArrayList();
            String nomNorm= Normalizer.normalize(nom, Normalizer.Form.NFD);
            String nomSTilde = nomNorm.replaceAll("[^\\p{ASCII}]","");
            String apeNorm= Normalizer.normalize(ape, Normalizer.Form.NFD);
            String apeSTilde = apeNorm.replaceAll("[^\\p{ASCII}]","");
            li.addAll(getAllInnerJM()
                .stream()
                .filter(i-> i.getNombre().toLowerCase()
                    .contains(nomSTilde.toLowerCase())
                    &&i.getApellido().toLowerCase()
                    .contains(apeSTilde.toLowerCase()))
                .collect(Collectors.toList()));
            if (!li.isEmpty()){return li;}else{return new ArrayList();}
        }else{ return new ArrayList();}
    }
        
    // profesor - titulo - año
    default List<Inscripcion> getLikeProTitAño(String pro,String tit,int año){
        if (pro!=null&&tit!=null) {
            List<Inscripcion>li=new ArrayList();
            String tituloNorm= Normalizer.normalize(tit, Normalizer.Form.NFD);
            String profesorNorm= Normalizer.normalize(pro, Normalizer.Form.NFD);
            String titSTilde = tituloNorm.replaceAll("[^\\p{ASCII}]","");
            String proSTilde = profesorNorm.replaceAll("[^\\p{ASCII}]","");
            li.addAll(getAllInnerJM()
                .stream()
                .filter(i-> i.getProfesor().toLowerCase()
                    .contains(proSTilde.toLowerCase())
                    &&i.getTitulo().toLowerCase()
                    .contains(titSTilde.toLowerCase())
                    &&i.getAño()==año)
                .collect(Collectors.toList()));
            if (!li.isEmpty()){return li;}else{return new ArrayList();}
        }else{ return new ArrayList();}
    }
    
    default List<Inscripcion> getLikeProTit(String pro,String tit){
        if (pro!=null&&tit!=null) {
            List<Inscripcion>li=new ArrayList();
            String tituloNorm= Normalizer.normalize(tit, Normalizer.Form.NFD);
            String profesorNorm= Normalizer.normalize(pro, Normalizer.Form.NFD);
            String titSTilde = tituloNorm.replaceAll("[^\\p{ASCII}]","");
            String proSTilde = profesorNorm.replaceAll("[^\\p{ASCII}]","");
            li.addAll(getAllInnerJM()
                .stream()
                .filter(i-> i.getProfesor().toLowerCase()
                    .contains(proSTilde.toLowerCase())
                    &&i.getTitulo().toLowerCase()
                    .contains(titSTilde.toLowerCase()))
                .collect(Collectors.toList()));
            if (!li.isEmpty()){return li;}else{return new ArrayList();}
        }else{ return new ArrayList();}
    }
   
    
    
}
    
    
    
    
    

