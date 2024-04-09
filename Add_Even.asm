; Add_Even.asm

; Purpose: -
        ; Adding even-indexed digits of the given array -
        ; -

; Source: -
        ; Written by Siavash Golani for final semester assignment 4 of CST
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
        ; jsr Add_Even

; Postcondition: -
        ; Accumulator B holds the sum of even-indexed digits of the credit card
        ; - X destroyed
        ; - A destroyed
        ; - B destroyed

ZE      equ        $00   ; value $00 will be used for comparison


Add_Even
        clrb             ; clear B
ELoop
        cmpa    #ZE      ; Checking if there are still more elements to process
        beq     ENext    ; Finish the loop if there are not
        inx              ; skipping the odd-indexed element
        deca             ; going down the elements of array from length-1 to zero
        cmpa    #ZE      ; Checking if there are still more elements to process
        beq     ENext    ; Finish the loop if there are not
        addb    1,x+     ; Add this element to the sum of even-indexed elements
        deca             ; again going down the elements of array from lengh-1 to zero
        bra     ELoop    ; if we are not done then we begin the loop again
ENext
        rts              ; Sum of even-indexed digits are stored in B and we return

        end
