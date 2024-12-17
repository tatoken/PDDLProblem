(define (domain CAMPI) 
   (:requirements :strips :typing :negative-preconditions :quantified-preconditions) 
   (:types  tractor plow sower farmer fields -object)
   ; sower (seminatore) - plow (aratro)
   ; i trattori stanno sempre su campi
   ; per assunto i campi nello stato iniziale sono tutti non arati 
   (:predicates 
        (tractorWithSower ?tractor - tractor ?sower - sower)
        (tractorWithPlow ?tractor - tractor ?plow - plow)
        (tractorInField ?tractor - tractor ?field - field)
        (fieldNeighbor ?field1 - field ?field2 - field)
        (farmerInField ?farmer - farmer ?y - field)
        (farmerOnTractor ?farmer - farmer ?tractor - tractor)
        (fieldPlowed ?field - field)
        (fieldSown ?field - field)
        (fieldWatered ?field - field)
        (sowerInField ?sower - sower ?field - field)
        (plowInField ?plow - plow ?field - field)
    )

   (:action moveOnTractor
        :parameters (?farmer - farmer ?tractor - tractor ?field - field)
        :precondition 
        (and
            (forall (?t - tractor) (not (farmerOnTractor ?farmer ?t)))  ; Assicurarsi che il contadino non sia su nessun trattore
            (farmerInField ?farmer ?field)  ; Il contadino deve essere nel campo
            (tractorInField ?tractor ?field)  ; Il trattore deve essere nel campo
        )
        :effect (and
            (farmerOnTractor ?farmer ?tractor)  ; Il contadino ora è sul trattore
            (not (farmerInField ?farmer ?field))  ; Il contadino non è più nel campo
        )
    )

     (:action moveOffTractor
        :parameters (?farmer - farmer ?tractor - tractor ?field - field)
        :precondition (farmerOnTractor ?farmer ?tractor )
        :effect (and
            (not(farmerOnTractor ?farmer ?tractor))  ; Il contadino ora non è sul trattore
            (farmerInField ?farmer ?field)  ; Il contadino deve essere nello stesso campo del trattore
            (tractorInField ?tractor ?field)  ; Il trattore deve essere nello stesso campo del contadino
        )
    )

    (:action attachPlow
        :parameters (?tractor - tractor ?plow - plow ?farmer - farmer ?field - field)
        :precondition 
        (and
            (exists (?genericPlow - plow) (not (forall (?genericTractor - tractor) (tractorWithPlow ?genericTractor ?genericPlow))))  ; esiste un aratro non attaccato ad alcun trattore
            (exists (?tractor - tractor)
                    (and
                        (not (exists (?plow - plow) (tractorWithPlow ?tractor ?plow)))  ; non ha un aratro
                        (not (exists (?plow - sower) (tractorWithSower ?tractor ?plow))) ; non ha un seminatore
                    )
            ); esiste un trattore che non ha attaccato nessun aratro o seminatore
            (farmerInField ?farmer ?field)
            (tractorInField ?tractor ?field)
            (plowInField ?plow ?field)
        )
                    
        :effect (tractorWithPlow ?tractor ?plow)   ; Il trattore ha agganciato l'aratro
        
    )

    (:action detachPlow
        :parameters (?tractor - tractor ?plow - plow ?farmer - farmer ?field - field)
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
        :parameters (?x - tractor ?y - sower ?w - farmer ?z - field)
        :precondition 
        (and
            (exists (?genericSower - sower) (not (forall (?genericTractor - tractor) (tractorWithSower ?genericTractor ?genericSower))))  ; esiste un seminatore non attaccato ad alcun trattore
            (exists (?tractor - tractor)
                    (and
                        (not (exists (?genericPlow - plow) (tractorWithPlow ?tractor ?genericPlow)))  ; non ha un aratro
                        (not (exists (?genericSower - sower) (tractorWithSower ?tractor ?genericSower))) ; non ha un seminatore
                    )
            ); esiste un trattore che non ha attaccato nessun aratro o seminatore
            (farmerInField ?x ?z)
            (tractorInField ?y ?z)
            (sowerInField ?y ?z)
        )
                    
        :effect (tractorWithSower ?x ?y) ; Il trattore ha attaccato un seminatore
    )

    (:action detachSower
        :parameters (?tractor - tractor ?sower - sower ?farmer - farmer ?field - field)
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
        :parameters (?tractor - tractor ?plow - plow ?farmer - farmer ?field - field)
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
        :parameters (?tractor - tractor ?sower - sower ?farmer - farmer ?field - field)
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
        :parameters (?farmer - farmer ?field - field)
        :precondition 
        (and
            (fieldSown ?field)
            (farmerInField ?farmer ?field)
            (not (fieldWatered ?field))

        )
                    
        :effect (fieldWatered ?field )  ; Il campo è stato innaffiato
        
    )



    (:action moveFarmer
        :parameters (?farmer - farmer ?fromField - field ?toField - field)
        :precondition 
        (and
            (farmerInField ?farmer ?fromField)
            (fieldNeighbor ?fromField ?toField)
        )
                    
        :effect (and
            (farmerInField ?toField)
            (not(farmerInField ?fromField))
         )
        
    )

    (:action moveTractor
        :parameters (?tractor - tractor ?farmer - farmer ?fromField - field ?toField - field)
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
