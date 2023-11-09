; Validate_CC.asm

; Purpose: -
        ; Validate the credit card number using the sum of even-indexed
        ; and odd-indexed digits -
        ; -

; Source: -
        ; Written by Siavash Golani and Andrew Moses for assignment 4 of CST
        ; Part of credit card validation task

;Precondition: -
        ; -
        ; - Accumulator A is loaded with the sum of even-indexed
        ; - Accumulator B is loaded with the sum of odd-indexed

; Library Subroutine -
        ; -

; Use: -
        ; jsr Add_Even
        ; tfr b,a
        ; jsr Add_Odd
        ; jsr Validate_CC

; Postcondition: -
        ; Accumulator B holds the remainder of sum of digits by 10
        ; - X destroyed
        ; - A destroyed
        ; - B destroyed

TEN     equ      10

Validate_CC
        aba                     ; Adding the sum of odd-indexed and even-indexed elements stored in B and A
        exg     a,b             ; Adjusting the sum to be in B
        clra                    ; Clearing A to make D having the sum
        ldx     #TEN            ; Dividing D by 10
        idiv

        rts                     ; The remainder is stored in B, which shows if the credit card is valid and we return

        end