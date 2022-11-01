package com.walcompany.repositories.interfaces;

import com.walcompany.entities.Alumno;
import java.text.Normalizer;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public interface I_AlumnoRepository {
  
    public abstract void save(Alumno alumno);
    void remove(Alumno alumno);
    void update(Alumno alumno);
    List<Alumno> getAll();
  
    default Alumno getById(int idalum){
        return getAll()
                .stream()
                .filter(a->a.getIdalum()==idalum)
                .findFirst()
                .orElse(new Alumno());
    }
    
    default Alumno getByDni (String dni){
        return getAll()
                .stream()
                .filter(a->a.getDni().replaceAll("\\.","").equals(dni))
                .findFirst()
                .orElse(new Alumno());
    }
  
    default List<Alumno> getLikeNombreApellido(String nom,String ape){
        if (nom==null || ape==null) {
            return new ArrayList();
        }else{
            List<Alumno>li=new ArrayList();
            String nomNorm= Normalizer.normalize(nom, Normalizer.Form.NFD);
            String apeNorm= Normalizer.normalize(ape, Normalizer.Form.NFD);
            String nomSTilde = nomNorm.replaceAll("[^\\p{ASCII}]","");
            String apeSTilde = apeNorm.replaceAll("[^\\p{ASCII}]","");
            li.addAll(getAll()
                .stream()
                .filter(a->a.getNombre().toLowerCase().contains(nomSTilde.toLowerCase())
                    && a.getApellido().toLowerCase().contains(apeSTilde.toLowerCase()))
                .collect(Collectors.toList()));
            if (!li.isEmpty()){return li;
            }else{ return new ArrayList();}
        }
    }
}
