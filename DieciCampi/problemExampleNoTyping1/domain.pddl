(define (domain CAMPI) 
   (:requirements :strips :negative-preconditions :quantified-preconditions)
   ; sower (seminatore)  (aratro)
   ; i trattori stanno sempre su campi
   ; per assunto i campi nello stato iniziale sono tutti non arati 
   (:predicates 
        (CAMPO ?field)
        (TRA ?tractor)
        (TRA-ARA ?traAratro)
        (TRA-SEMINA ?traSemina)
        (TRA-CONTADINO ?traContadino)
        (SEMINATORE ?sower)
        (ARATRO ?plow)
        (contadino ?farmer)

        (at ?object ?field)
        (together ?object ?tractor)
        
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
            
            (at ?farmer ?field)          ; Il contadino si trova nel campo
            (at ?tractor ?field)         ; Il trattore si trova nello stesso campo
        )
        :effect (and
            (TRA-CONTADINO ?tractor )    ; il trattore diventa un trattore con contadino
            (together ?farmer ?tractor)  ; il contadino si lega al trattore
            (not (at ?farmer ?field))    ; il contadino non è più sul campo
        )
    )


    (:action moveOffTractor
        :parameters (?farmer ?tractor ?field)
        :precondition 
        (and 
            (contadino ?farmer)           ; ?farmer è un contadino
            (TRA-CONTADINO ?tractor)      ; ?tractor è un trattore con un contadino
            (CAMPO ?field)                ; ?field è un campo
            (at ?tractor ?field)          ; Il trattore si trova nel campo

            (together ?farmer ?tractor)
        )
        :effect 
        (and
            (not (TRA-CONTADINO ?tractor)) ; Il contadino ora non è sul trattore
            (not(together ?farmer ?tractor))    ; il contadino si slega dal trattore
            (at ?farmer ?field)                   ; Il contadino si trova nel campo
        )
    )

   

    (:action attachPlow
        :parameters (?tractor ?plow ?farmer ?field)
        :precondition 
        (and
            (contadino ?farmer)           ; ?farmer è un contadino
            (TRA ?tractor)                ; ?tractor è un trattore
            (ARATRO ?plow)                ; ?plow è un aratro
            (CAMPO ?field)                ; ?field è un campo

            (not (TRA-ARA ?tractor)) ; Il trattore non ha un aratro attaccato
            (not (TRA-SEMINA ?tractor)) ; Il trattore non ha un seminatore attaccato
            (at ?farmer ?field)           ; Il contadino si trova nel campo
            (at ?tractor ?field)          ; Il trattore si trova nel campo
            (at ?plow ?field)             ; L'aratro si trova nel campo
        )
        :effect 
        ( and
            (TRA-ARA ?tractor )            ; Il trattore ha agganciato l'aratro
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

            (together ?plow ?tractor)
            (at ?farmer ?field)           ; Il contadino si trova nel campo
            (at ?tractor ?field)          ; Il trattore si trova nel campo
        )
        :effect 
        (and
            (not (TRA-ARA ?tractor))    ; Il trattore non ha più un aratro attaccato
            (not (together ?plow ?tractor )) 
        )
    )

    (:action attachSower
        :parameters (?tractor ?sower ?farmer ?field)
        :precondition 
        (and
            (contadino ?farmer)              ; ?farmer è un contadino
            (TRA ?tractor)                   ; ?tractor è un trattore
            (SEMINATORE ?sower)              ; ?sower è un seminatore
            (CAMPO ?field)                   ; ?field è un campo

            (not (TRA-ARA ?tractor))  ; Il trattore non ha un aratro attaccato
            (not (TRA-SEMINA ?tractor)) ; Il trattore non ha un seminatore attaccato
            (at ?farmer ?field)              ; Il contadino si trova nel campo
            (at ?tractor ?field)             ; Il trattore si trova nel campo
            (at ?sower ?field)               ; Il seminatore si trova nel campo
        )
        :effect 
        (and
        (TRA-SEMINA ?tractor )
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
            (not (TRA-SEMINA ?tractor))    ; Il trattore non ha più un seminatore attaccato
            (not (together ?sower ?tractor )) 
        )
    )

    (:action plowField
        :parameters (?tractor ?plow ?farmer ?field)
        :precondition 
        (and
            (contadino ?farmer)           ; ?farmer è un contadino
            (TRA-ARA ?tractor)            ; ?tractor è un trattore
            (TRA-CONTADINO ?tractor )
            (ARATRO ?plow)                ; ?plow è un aratro
            (CAMPO ?field)                ; ?field è un campo

            (at ?tractor ?field)          ; Il trattore si trova nel campo
            (not (arato ?field))          ; Il campo non è ancora arato
            (together ?farmer ?tractor)
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
            (TRA-CONTADINO ?tractor ) ; Il contadino è associato al trattore
            (SEMINATORE ?sower)              ; ?sower è un seminatore
            (CAMPO ?field)                   ; ?field è un campo
    
            (at ?tractor ?field)             ; Il trattore si trova nel campo
            (arato ?field)                   ; Il campo è già stato arato
            (not (seminato ?field))          ; Il campo non è ancora seminato
            (together ?farmer ?tractor)
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
            (CONNESSO ?fromField ?toField) ; I campi sono connessi
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

            (TRA-CONTADINO ?tractor) ; Il contadino è associato al trattore
            (together ?farmer ?tractor)
            (at ?tractor ?fromField)      ; Il trattore si trova nel campo di partenza
            (CONNESSO ?fromField ?toField) ; I campi sono connessi
        )
        :effect 
        (and
            (at ?tractor ?toField)         ; Il trattore si trova nel campo di arrivo
            (not (at ?tractor ?fromField)) ; Il trattore non si trova più nel campo di partenza
        )
    )


            
)
