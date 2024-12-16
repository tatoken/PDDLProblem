(define (domain CAMPI) 
   (:requirements :strips :typing :negative-preconditions :quantified-preconditions) 
   (:types  tractor plow sower farmer fields -object)
   ;sower (seminatore) - plow (aratro)
   ;i trattori stanno sempre su campi
   (:predicates 
        (tractorWithSower ?x - tractor ?y - sower)
        (tractorWithPlow ?x - tractor ?y - plow)
        (tractorInField ?x - tractor ?y - field)
        (fieldNeighbor ?x - field ?y - field)
        (farmerInField ?x - farmer ?y - field)
        (farmerOnTractor ?x - farmer ?y - tractor)
        (fieldPlowed ?x - field)
        (fieldSown ?x - field)
        (fieldWatered ?x - field)
        (sowerInField ?x - sower ?y - field)
        (plowInField ?x - plow ?y - field)
    )

   (:action moveOnTractor
        :parameters (?x - farmer ?y - tractor ?z - field)
        :precondition 
        (and
            (forall (?w - tractor) (not (farmerOnTractor ?x ?w)))  ; Assicurarsi che il contadino non sia su nessun trattore
            (farmerInField ?x ?z)  ; Il contadino deve essere nel campo
            (tractorInField ?y ?z)  ; Il trattore deve essere nel campo
        )
        :effect (and
            (farmerOnTractor ?x ?y)  ; Il contadino ora è sul trattore
            (not (farmerInField ?x ?z))  ; Il contadino non è più nel campo
        )
    )

     (:action moveOffTractor
        :parameters (?x - farmer ?y - tractor ?z - field)
        :precondition (farmerOnTractor ?x ?y )
        :effect (and
            (not(farmerOnTractor ?x ?y))  ; Il contadino ora non è sul trattore
            (farmerInField ?x ?z)  ; Il contadino deve essere nello stesso campo del trattore
            (tractorInField ?y ?z)  ; Il trattore deve essere nello stesso campo del contadino
        )
    )

    (:action attachPlow
        :parameters (?x - tractor ?y - plow ?w - farmer ?z - field)
        :precondition 
        (and
            (exists (?p - plow) (not (forall (?t - tractor) (tractorWithPlow ?t ?p))))  
            (farmerInField ?x ?z)
            (tractorInField ?y ?z)
        )
                    
        :effect (and
            (not(farmerOnTractor ?x ?y))  ; Il contadino ora non è sul trattore
            (farmerInField ?x ?z)  ; Il contadino deve essere nello stesso campo del trattore
            (tractorInField ?y ?z)  ; Il trattore deve essere nello stesso campo del contadino
        )
    )

    ; detachPlow
    ; attachSower
    ; detachSower
    ; plowField
    ; sowField
    ; waterField
    ; move ( implementiamolo con or, contadino e trattore)
    
    ; andareADisoneste


            
)
