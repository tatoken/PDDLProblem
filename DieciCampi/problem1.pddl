(define (problem DieciCampi) 
(:domain CAMPI) 
(:objects f1 f2 f3 -field 
	       t1 t2 - tractor
         far1 far2 far3 - farmer
         p1 p2 - plow
         s - sower) 
(:init (tractorInField t1 f1) 
       (tractorInField t2 f2) 
       (farmerInField far1 f1)
       (farmerInField far2 f2)
       (farmerInField far3 f3)
       (plowInField p1 f1)
       (plowInField p2 f2)
       (sowerInField s f1)

       (not(fieldPlowed f1)) 
       (not(fieldSown f1)) 
       (not(fieldWatered f1))
       (not(fieldPlowed f2)) 
       (not(fieldSown f2)) 
       (not(fieldWatered f2))
       (not(fieldPlowed f3)) 
       (not(fieldSown f3)) 
       (not(fieldWatered f3))

       (fieldNeighbor f1 f2)
       (fieldNeighbor f2 f3)
)

(:goal (and
	 (fieldWatered f1)
         (fieldWatered f2)
         (fieldWatered f3)
	)
)
)  
