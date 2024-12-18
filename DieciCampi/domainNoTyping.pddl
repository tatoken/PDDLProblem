(define (domain CAMPI) 
   (:requirements :strips :negative-preconditions :quantified-preconditions)
   ; sower (seminatore)  (aratro)
   ; i trattori stanno sempre su campi
   ; per assunto i campi nello stato iniziale sono tutti non arati 
   (:predicates 
        
        (tractorWithSower ?tractor ?sower)
        (tractorWithPlow ?tractor ?plow)
        (tractorInField ?tractor ?field)
        (fieldNeighbor ?field1 ?field2)
        (farmerInField ?farmer ?field )
        (farmerOnTractor ?farmer ?tractor)
        (fieldPlowed ?field)
        (fieldSown ?field)
        (fieldWatered ?field)
        (sowerInField ?sower ?field)
        (plowInField ?plow ?field)
    )

   (:action moveOnTractor
        :parameters (?farmer ?tractor  ?field )
        :precondition 
        (and
        
            (forall (?t ) (not (farmerOnTractor ?farmer ?t)))  ; Assicurarsi che il contadino non sia su nessun trattore
            (farmerInField ?farmer ?field)  ; Il contadino deve essere nel campo
            (tractorInField ?tractor ?field)  ; Il trattore deve essere nel campo
        )
        :effect (and
            (farmerOnTractor ?farmer ?tractor)  ; Il contadino ora è sul trattore
            (not (farmerInField ?farmer ?field))  ; Il contadino non è più nel campo
        )
    )

     (:action moveOffTractor
        :parameters (?farmer  ?tractor  ?field )
        :precondition (and 
            (farmerOnTractor ?farmer ?tractor )
            (tractorInField ?tractor ?field )
            )
        :effect (and
            (not(farmerOnTractor ?farmer ?tractor))  ; Il contadino ora non è sul trattore
            (farmerInField ?farmer ?field)  ; Il contadino deve essere nello stesso campo del trattore
            (tractorInField ?tractor ?field)  ; Il trattore deve essere nello stesso campo del contadino
        )
    )

    (:action attachPlow
        :parameters (?tractor  ?plow  ?farmer  ?field )
        :precondition 
        (and
            (exists (?genericPlow ) (not (forall (?genericTractor ) (tractorWithPlow ?genericTractor ?genericPlow))))  ; esiste un aratro non attaccato ad alcun trattore
            (not (exists (?plow ) (tractorWithPlow ?tractor ?plow)))  ; non ha un aratro
            (not (exists (?plow ) (tractorWithSower ?tractor ?plow))) ; non ha un seminatore
            (farmerInField ?farmer ?field)
            (tractorInField ?tractor ?field)
            (plowInField ?plow ?field)
        )
                    
        :effect (tractorWithPlow ?tractor ?plow)   ; Il trattore ha agganciato l'aratro
        
    )

    (:action detachPlow
        :parameters (?tractor  ?plow  ?farmer  ?field )
        :precondition 
        (and
            (tractorWithPlow ?tractor ?plow)  
            (farmerInField ?farmer ?field)
            (tractorInField ?tractor ?field)
        )
                    
        :effect (and
            (not(tractorWithPlow ?tractor ?plow))  ; Il trattore non ha attaccato un aratro
        )
    )


    (:action attachSower
        :parameters (?tractor  ?sower  ?farmer  ?field )
        :precondition 
        (and
            (exists (?genericSower ) (not (forall (?genericTractor ) (tractorWithSower ?genericTractor ?genericSower))))  ; esiste un seminatore non attaccato ad alcun trattore
            (not (exists (?genericPlow ) (tractorWithPlow ?tractor ?genericPlow)))  ; non ha un aratro
            (not (exists (?genericSower ) (tractorWithSower ?tractor ?genericSower))) ; non ha un seminatore
            (farmerInField ?farmer ?field)
            (tractorInField ?tractor ?field)
            (sowerInField ?sower ?field)
        )
                    
        :effect (tractorWithSower ?tractor ?sower) ; Il trattore ha attaccato un seminatore
    )

    (:action detachSower
        :parameters (?tractor  ?sower  ?farmer  ?field )
        :precondition 
        (and
            (tractorWithSower ?tractor ?sower)  
            (farmerInField ?farmer ?field)
            (tractorInField ?tractor ?field)
        )
                    
        :effect (and
            (not(tractorWithSower ?tractor ?sower))  ; Il trattore non ha attaccato l'aratro
        )
    )

    (:action plowField
        :parameters (?tractor  ?plow  ?farmer  ?field )
        :precondition 
        (and
            (tractorInField ?tractor ?field)  
            (tractorWithPlow ?tractor ?plow)
            (farmerOnTractor ?farmer ?tractor)
            (not (fieldPlowed ?field))

        )
                    
        :effect (fieldPlowed ?field )  ; Il campo è stato arato
        
    )


    (:action sowField
        :parameters (?tractor  ?sower  ?farmer  ?field )
        :precondition 
        (and
            (tractorInField ?tractor ?field)  
            (tractorWithSower ?tractor ?sower)
            (farmerOnTractor ?farmer ?tractor)
            (not (fieldSown ?field))
            (fieldPlowed ?field)

        )
                    
        :effect (fieldSown ?field )  ; Il campo è stato seminato
        
    )


    (:action waterField
        :parameters (?farmer  ?field )
        :precondition 
        (and
            (fieldSown ?field)
            (farmerInField ?farmer ?field)
            (not (fieldWatered ?field))

        )
                    
        :effect (fieldWatered ?field )  ; Il campo è stato innaffiato
        
    )



    (:action moveFarmer
        :parameters (?farmer  ?fromField  ?toField )
        :precondition 
        (and
            (farmerInField ?farmer ?fromField)
            (fieldNeighbor ?fromField ?toField)
        )
                    
        :effect (and
            (farmerInField ?farmer ?toField)
            (not(farmerInField ?farmer ?fromField))
         )
        
    )

    (:action moveTractor
        :parameters (?tractor  ?farmer  ?fromField  ?toField )
        :precondition 
        (and
            (farmerOnTractor ?farmer ?tractor)
            (tractorInField ?tractor ?fromField)
            (fieldNeighbor ?fromField ?toField)
        )
                    
        :effect (and
            (tractorInField ?tractor ?toField)
            (not(tractorInField ?tractor ?fromField))
         )
        
    )

            
)
