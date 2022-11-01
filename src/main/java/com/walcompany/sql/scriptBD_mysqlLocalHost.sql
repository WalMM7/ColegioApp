use colegio;

CREATE TABLE cursos (
  idcurso int(11) NOT NULL AUTO_INCREMENT,
  titulo varchar(55) NOT NULL,
  profesor varchar(55) NOT NULL,
  dia varchar(20) NOT NULL,
  turno varchar(20) NOT NULL,
  inicio varchar(5) NOT NULL,
  fin varchar(5) NOT NULL,
  PRIMARY KEY (idcurso)
) ;

CREATE TABLE alumnos (
  idalum int(11) NOT NULL AUTO_INCREMENT,
  nombre varchar(55) NOT NULL,
  apellido varchar(55) NOT NULL,
  edad int(3) NOT NULL,
  dni varchar(20) DEFAULT NULL,
  telefono varchar(18) DEFAULT NULL,
  PRIMARY KEY (idalum),
  UNIQUE KEY dni (dni)
) ;

CREATE TABLE inscripciones (
  idReg int(11) NOT NULL AUTO_INCREMENT,
  idAlum int(11) NOT NULL,
  idCurso int(11) NOT NULL,
  año int(4) NOT NULL,
  PRIMARY KEY (idAlum,idCurso,año),
  UNIQUE KEY (idReg),
  FOREIGN KEY (idAlum) REFERENCES alumnos (idalum) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idCurso) REFERENCES cursos (idcurso) ON DELETE CASCADE ON UPDATE CASCADE
);

describe cursos;
describe alumnos;
describe inscripciones;

select*from inscripciones;

select i.idReg,i.año,a.idalum,a.dni,a.nombre,a.apellido,
c.idcurso,c.titulo,c.profesor,c.dia,c.turno,c.inicio,c.fin 
from inscripciones as i
inner join alumnos as a
on i.idAlum = a.idalum
inner join cursos as c
on i.idCurso = c.idcurso
order by i.idReg;

