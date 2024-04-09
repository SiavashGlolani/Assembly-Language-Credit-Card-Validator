; Add_Odd.asm

; Purpose: -
        ; Adding odd-indexed digits of the given array -
        ; -

; Source: -
        ; Written by Siavash Golani
        ; Part of credit card validation task

;Precondition: -
        ; -
        ; - Index Register X loaded with
        ; - the pointer to the array, which hold the given credit card digits
        ; - Accumulator A is loaded with the number of elements in the array
        ; -

; Library Subroutine -
        ; -

; Use: -
        ; ldx #credit_card
        ; lda #number_of_digits
        ; jsr Add_Odd

; Postcondition: -
        ; Accumulator B holds the sum of even-indexed digits of the credit card
        ; - X destroyed
        ; - A destroyed
        ; - B destroyed

ZO      equ      $00
NINE    equ      $09


Add_Odd
        clrb
OLoop
        cmpa    #ZO    ; checking if there are still more elements to process
        beq     ONext  ; exit the loop if not
        lsl     0,x    ; multiplying the value that X points to by 2 using logical shift left
        psha           ; pushing the value in A onto the stack so we can store it temporarily
        ldaa    0,x    ; loading the first odd-element of the array that X points to into A
        cmpa    #NINE  ; after multiplying the value of the odd element by 2, is it greater than > 9?
        blo     Skip   ; if not, jump to Skip
        suba    #NINE  ; if it is > 9 then we subtract 9 from the value
        staa    0,x    ; stroing the applied value of the odd-indexed element into A
Skip
        pula           ; retrieving the value from that stack that we pushed from OLoop into A
        addb    1,x+   ; adding the applied odd-indexed element to the sum of odd-indexed elements, then moving to next element
        deca           ; after adding, we go down from length-1 to zero in order to complete traversal of array
        cmpa    #ZO    ; have we traversed through every element?
        beq     ONext  ; if yes, jump to ONext and end the program
        deca           ; if not, continue traversing the array from length-1 to zero
        inx            ; X now points to next index
        bra     OLoop  ; start another iteration from beginning if we aren't done
ONext
        rts            ; Sum of odd-indexed digits is stored in B and we return

        end
