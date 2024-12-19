(define (problem DieciCampi) 
(:domain CAMPI) 
(:objects f1 -field 
	  t1 - tractor
         far1 - farmer
         p - plow
         s - sower) 
(:init (tractorInField t1 f1) 
       (farmerInField far1 f1) 
       (plowInField p f1) 
       (sowerInField s f1)

       (not(fieldPlowed f1)) 
       (not(fieldSown f1)) 
       (not(fieldWatered f1)) 
       )

(:goal (fieldWatered f1) )
)  
