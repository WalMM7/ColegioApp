package com.walcompany.repositories.interfaces;

import com.walcompany.entities.Curso;
import java.text.Normalizer;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public interface I_CursoRepository {

    /**
    save: guarda los objetos curso en la tabla cursos de la bd colegio
    */
    public abstract void save(Curso curso);
    
    /**
    remove: borra registros de la tabla cursos segun id
    */
    void remove(Curso curso);   
    
    /**
    update: actualiza registros de la tabla cursos
    */                               
    void update(Curso curso);
    
    /**
    getAll: Devuelve una lista con todos los cursos
    */
    List<Curso> getAll();
     
    /**
     *GetById: Devuelve un unico objeto curso o ninguno en función de filtrar
     *         la lista por el parametro idcurso ingresado. 
     */
    
    default Curso getById(int idcurso){
        return getAll().stream()
                       .filter(c->c.getIdcurso()== idcurso)
                       .findFirst()
                       .orElse(new Curso());  
    }
    
    /**
     * getLikeTituloProfesor: Devuelve una lista filtrada de los cursos en base
     * a los parametros titulo y profesor ingresados.
    */
    
    default List<Curso> getLikeTituloProfesor(String titulo,String profesor){
        
        if (titulo==null || profesor==null) {
            return new ArrayList();
        }else{
            List<Curso>li=new ArrayList();
            String tituloNorm= Normalizer.normalize(titulo, Normalizer.Form.NFD);
            String profesorNorm= Normalizer.normalize(profesor, Normalizer.Form.NFD);
            String tituloSTilde = tituloNorm.replaceAll("[^\\p{ASCII}]","");
            String profesorSTilde = profesorNorm.replaceAll("[^\\p{ASCII}]","");
            li.addAll(getAll()
                .stream()
                .filter(c->c.getTitulo().toLowerCase()
                            .contains(tituloSTilde.toLowerCase())
                            && c.getProfesor().toLowerCase()
                            .contains(profesorSTilde.toLowerCase()))
                .collect(Collectors.toList()));
            
            if (li.size()!=0){return li; 
            }else{ return new ArrayList();}
        }
    }  
       
}
