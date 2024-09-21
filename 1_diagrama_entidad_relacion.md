## DIAGRAMA ENTIDAD RELACIÓN

La parte superior del diagrama muestra el área de profesores, coordinadores
La parte inferior del diagrmaa muestra el área del alumno

Para establecer las conexiones se considera que: 
- Cada **bootcamp** solo puede tener 1 **coordinador** y vicecersa

- Cada **profesor** puede impartir n **módulos**, y cada **módulo** puede ser impartido por n **profesores** --> Se crea la tabla intermedia *profesor_modulo* que puede recibir muchos registros con diferentes **profesores** y **modulos**

- Cada **bootcamp** puede tener  n **modulos** y cada **modulo** puede pertenecer a n **bootcamps** --> Se crea la tabla intermedia *modulo_bootcamp* que puede recibir muchos registros con diferentes **bootcamps** y **modulos**


- Cada **alumno** puede tener  n **matricula** y cada **matricula** pertenece a un único **alumno** , es decir, un alumno puede estar matriculado en varios bootcamps a la vez.

Cada **modulo** tiene una **evaluacion** y cada evaluación pertenece a un único **modulo** y **alumno**. Después keepcoding internamente se encarga de que las evaluaciones sean anónimas.



