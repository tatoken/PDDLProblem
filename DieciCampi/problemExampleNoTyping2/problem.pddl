(define (problem DieciCampi) 
(:domain CAMPI) 
(:objects f1 f2 f3 t1 t2 far1 far2 far3 p1 p2 s1) 
(:init 
       (CAMPO f1)
       (CAMPO f2)
       (CAMPO f3)
       (TRA t1)
       (TRA t2)
       (TRA-ARA t1)
       (TRA-SEMINA t2)
       (contadino far1)
       (contadino far2)
       (contadino far3)
       (ARATRO p1)
       (ARATRO p2)
       (SEMINATORE s1)

       (at t1 f1)
       (at t2 f2)
       (at far1 f1)
       (at far2 f2)
       (at far3 f3)
       (at p1 f1)
       (at p2 f2)
       (at s1 f1)

       (CONNESSO f1 f2)
       (CONNESSO f2 f3)
)

(:goal (and
	 (innaffiato f1)
         (innaffiato f2)
         (innaffiato f3)
	)
)
)  
