(define (domain CAMPI) 
   (:requirements :strips :negative-preconditions :quantified-preconditions :disjunctive-preconditions)
   ; sower (seminatore)  (aratro)
   ; i trattori stanno sempre su campi
   ; per assunto i campi nello stato iniziale sono tutti non arati 
   (:predicates 
        (CAMPO ?field)
        (TRA ?tractor)
        (TRA-ARA ?traAratro)
        (TRA-SEMINA ?traSemina)
        (SEMINATORE ?sower)
        (ARATRO ?plow)
        (contadino ?farmer)

        (occupiedForPlow ?tractor)
        (occupiedForSower ?tractor)
        (occupiedForFarmer ?tractor)
        (together ?object ?tractor)

        (at ?object ?field)
        (CONNESSO ?field1 ?field2)

        (arato ?field)
        (seminato ?field)
        (innaffiato ?field)
    )

    (:action moveOnTractor
        :parameters (?farmer ?tractor ?field)
        :precondition 
        (and
            (contadino ?farmer)          ; Verifica che ?farmer sia un contadino
            (TRA ?tractor)               ; Verifica che ?tractor sia un trattore
            (CAMPO ?field)               ; Verifica che ?field sia un campo
            (not(occupiedForFarmer ?tractor))    ; il trattore non ha un contadino sopra
            
            (at ?farmer ?field)          ; Il contadino si trova nel campo
            (at ?tractor ?field)         ; Il trattore si trova nello stesso campo
        )
        :effect (and
            (occupiedForFarmer ?tractor)    ; il trattore diventa un trattore con contadino
            (together ?farmer ?tractor)  ; il contadino si lega al trattore
            (not (at ?farmer ?field))    ; il contadino non è più sul campo
        )
    )


    (:action moveOffTractor
        :parameters (?farmer ?tractor ?field)
        :precondition 
        (and 
            (contadino ?farmer)           ; ?farmer è un contadino
            (CAMPO ?field)                ; ?field è un campo
            (TRA ?tractor)
            (at ?tractor ?field)          ; Il trattore si trova nel campo

            (together ?farmer ?tractor)
        )
        :effect 
        (and
            (not(occupiedForFarmer ?tractor)) ; Il trattore ora è libero
            (not(together ?farmer ?tractor))    ; il contadino si slega dal trattore
            (at ?farmer ?field)                   ; Il contadino si trova nel campo
        )
    )

   

    (:action attachPlow
        :parameters (?tractor ?plow ?farmer ?field)
        :precondition 
        (and
            (contadino ?farmer)           ; ?farmer è un contadino
            (TRA-ARA ?tractor)            ; ?tractor è un trattore per aratri
            (ARATRO ?plow)                ; ?plow è un aratro
            (CAMPO ?field)                ; ?field è un campo

            (not(occupiedForPlow ?tractor))          ; non ci sono altri aratro attaccati
            (not(occupiedForSower ?tractor))         ; non ci sono altri seminatori attaccati (contemplando il caso in cui ci sia un trattore sia ARA che SEMINA)

            (at ?farmer ?field)           ; Il contadino si trova nel campo
            (at ?tractor ?field)          ; Il trattore si trova nel campo
            (at ?plow ?field)             ; L'aratro si trova nel campo
        )
        :effect 
        ( and
            (occupiedForPlow ?tractor)    ; il trattore non è più libero da un aratro
            (together ?plow ?tractor )      ; L'aratro è attaccato al trattore
            )
    )

    

    (:action detachPlow
        :parameters (?tractor ?plow ?farmer ?field)
        :precondition 
        (and
            (contadino ?farmer)           ; ?farmer è un contadino
            (TRA-ARA ?tractor)                ; ?tractor è un trattore
            (ARATRO ?plow)                ; ?plow è un aratro
            (CAMPO ?field)                ; ?field è un campo

            (together ?plow ?tractor)    ; il trattore è collegato all'aratro
            (at ?farmer ?field)           ; Il contadino si trova nel campo
            (at ?tractor ?field)          ; Il trattore si trova nel campo
        )
        :effect 
        (and
            (not(occupiedForPlow ?tractor))    ; Il trattore non ha più un aratro attaccato
            (not (together ?plow ?tractor )) 
        )
    )

    (:action attachSower
        :parameters (?tractor ?sower ?farmer ?field)
        :precondition 
        (and
            (contadino ?farmer)              ; ?farmer è un contadino
            (TRA-SEMINA ?tractor)                   ; ?tractor è un trattore
            (SEMINATORE ?sower)              ; ?sower è un seminatore
            (CAMPO ?field)                   ; ?field è un campo

            (not(occupiedForPlow ?tractor))          ; non ci sono altri aratro attaccati (contemplando il caso in cui ci sia un trattore sia ARA che SEMINA)
            (not(occupiedForSower ?tractor))         ; non ci sono altri seminatori attaccati 

            (at ?farmer ?field)              ; Il contadino si trova nel campo
            (at ?tractor ?field)             ; Il trattore si trova nel campo
            (at ?sower ?field)               ; Il seminatore si trova nel campo
        )
        :effect 
        (and
        (occupiedForSower ?tractor)
        (together ?sower ?tractor )
         ) ; Il trattore ha agganciato un seminatore
    )


    (:action detachSower
        :parameters (?tractor ?sower ?farmer ?field)
        :precondition 
        (and
            (contadino ?farmer)           ; ?farmer è un contadino
            (TRA-SEMINA ?tractor)         ; ?tractor è un trattore
            (SEMINATORE ?sower)           ; ?sower è un seminatore
            (CAMPO ?field)                ; ?field è un campo

            (together ?sower ?tractor) ; Il trattore ha un seminatore attaccato

            (at ?farmer ?field)           ; Il contadino si trova nel campo
            (at ?tractor ?field)          ; Il trattore si trova nel campo
        )
        :effect 
        (and
            (not(occupiedForSower ?tractor))    ; Il trattore non ha più un seminatore attaccato
            (not (together ?sower ?tractor )) 
        )
    )

    (:action plowField
        :parameters (?tractor ?plow ?farmer ?field)
        :precondition 
        (and
            (contadino ?farmer)           ; ?farmer è un contadino
            (TRA-ARA ?tractor)            ; ?tractor è un trattore
            (occupiedForFarmer ?tractor)

            (ARATRO ?plow)                ; ?plow è un aratro
            (CAMPO ?field)                ; ?field è un campo

            (at ?tractor ?field)          ; Il trattore si trova nel campo
            (not (arato ?field))          ; Il campo non è ancora arato
            (together ?farmer ?tractor)
            (together ?plow ?tractor)
        )
        :effect 
        (arato ?field) ; Il campo è stato arato
    )

    (:action sowField
        :parameters (?tractor ?sower ?farmer ?field)
        :precondition 
        (and
            (contadino ?farmer)              ; ?farmer è un contadino
            (TRA-SEMINA ?tractor)                   ; ?tractor è un trattore
            (occupiedForFarmer ?tractor); Il contadino è associato al trattore
            (SEMINATORE ?sower)              ; ?sower è un seminatore
            (CAMPO ?field)                   ; ?field è un campo
    
            (at ?tractor ?field)             ; Il trattore si trova nel campo
            (arato ?field)                   ; Il campo è già stato arato
            (not (seminato ?field))          ; Il campo non è ancora seminato
            (together ?farmer ?tractor)
            (together ?sower ?tractor)
        )
        :effect 
        (seminato ?field) ; Il campo è stato seminato
    )

    (:action waterField
        :parameters (?farmer ?field)
        :precondition 
        (and
            (contadino ?farmer)           ; ?farmer è un contadino
            (CAMPO ?field)                ; ?field è un campo
            (seminato ?field)             ; Il campo è stato seminato
            (at ?farmer ?field)           ; Il contadino si trova nel campo
            (not (innaffiato ?field))     ; Il campo non è ancora innaffiato
        )
        :effect 
        (innaffiato ?field) ; Il campo è stato innaffiato
    )

    (:action moveFarmer
        :parameters (?farmer ?fromField ?toField)
        :precondition 
        (and
            (contadino ?farmer)           ; ?farmer è un contadino
            (CAMPO ?fromField)            ; ?fromField è un campo
            (CAMPO ?toField)              ; ?toField è un campo
            (at ?farmer ?fromField)       ; Il contadino si trova nel campo di partenza
            (or(CONNESSO ?fromField ?toField)
                (CONNESSO ?toField ?fromField)) ; I campi sono connessi
        )
        :effect 
        (and
            (at ?farmer ?toField)         ; Il contadino si trova nel campo di arrivo
            (not (at ?farmer ?fromField)) ; Il contadino non si trova più nel campo di partenza
        )
    )

    (:action moveTractor
        :parameters (?tractor ?farmer ?fromField ?toField)
        :precondition 
        (and
            (contadino ?farmer)           ; ?farmer è un contadino
            (TRA ?tractor)                ; ?tractor è un trattore
            (CAMPO ?fromField)            ; ?fromField è un campo
            (CAMPO ?toField)              ; ?toField è un campo

            (occupiedForFarmer ?tractor) ; Il contadino è associato al trattore
            (together ?farmer ?tractor)
            (at ?tractor ?fromField)      ; Il trattore si trova nel campo di partenza
            (or(CONNESSO ?fromField ?toField)
                (CONNESSO ?toField ?fromField))  ; I campi sono connessi
        )
        :effect 
        (and
            (at ?tractor ?toField)         ; Il trattore si trova nel campo di arrivo
            (not (at ?tractor ?fromField)) ; Il trattore non si trova più nel campo di partenza
        )
    )


            
)
