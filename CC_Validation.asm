; CC_Validation.asm
;
#include C:\68HCS12\registers.inc
;
; Professor:  Khadidja Kaci Taouch
; Author(s):    Hojhan Siavash Glolani, Andrew Moses
; Student Number(s):  040735001, 041083922
; Date:   2023-08-10
;
; Purpose:      Credit Card Number Validation

; Address Constants - Do NOT change
STORAGE1        equ     $1000                   ; Storage starts here for original cards
FINALRESULTS    equ     $1030                   ; Final number of valid and invalid cards
PROGRAMSTART    equ     $2000                   ; Executable code starts here

; Hardware Configuration - Complete the Constant values
DIGIT3_PP0      equ    %1110                    ; HEX Display MSB (left most digit)
DIGIT0_PP3      equ    %0111                    ; Display LSB (right most digit)


; Program Constants - Do not change these values
NUMBERSOFCARDS  equ     6                       ; Six Cards to process
NUMDIGITS       equ     4                       ; Each Card has 4 digits

; You may add other Constant here if needed



; DO NOT CHANGE THE DELAY_VALUE; OTHERWISE THE VALUES WILL INCORRECTLY BE DISPLAYED
; IN THE SIMULATOR
DELAY_VALUE     equ     64                      ; HEX Display Multiplexing Delay
ZERO            equ     0
                org STORAGE1                    ; Note: a Label cannot be placed
Cards                                           ; on same line as org statement
#include        Sec_302_CC_Numbers.txt          ; substitute the appropriate file name here.
EndCards


; Do not change this code.
; Place your results here as you loop through your solution
                org  FINALRESULTS
InvalidResult   ds      1                       ; Count of Invalid CARDs processed
ValidResult     ds      1                       ; Count of Valid CARDs processed
; end of do not change

                org     ProgramStart            ; program start
                lds     #ProgramStart           ; Stack used to protect values
; --- Your code starts here

                 ldx    #Cards                  ; loading the address of the array of credit cards
ReadCards
                 ldaa   1,x+                    ; loading the value that x points to into A and then moving on to next element of array
                 cpx   #EndCards                ; have we reached the end of the array?
                 bne    ReadCards               ; if not, continue to loading next element

                 clra                           ; clearing A
                 clrb                           ; clearing B
                 ldx    #Cards                  ; loading the address of the array of credit cards

CheckCards
                 psha                           ; Saving the number of invalid credit cards on the stack
                 pshb                           ; Saving the number of valid credit cards on the stack
                 ldaa   #NUMDIGITS              ; loading the number of digits in each card in A
                 pshx                           ; Saving the address of current card onto the stack
                 jsr     Add_Even               ; Adding even-indexed digits using Add_Even
                 pulx                           ; Retrieving the address of current card from the stack
                 pshb                           ; Pushing the sum of even-indexed digits onto the stack
                 ldaa   #NUMDIGITS              ; loading the number of digits in each card which is 4
                 jsr    Add_Odd                 ; Adding odd-indexed digits using Add_Odd
                 pula                           ; Retrieving the sum of the even-indexed digits
                 pshx                           ; Saving the address of the next card onto the stack
                 jsr    Validate_CC             ; Validating the credit card using the sums of even-indexed and odd-indexed digits stored in B and A
                 pulx                           ; Retrieving the address of the next card from the stack
                 cmpb   ZERO                    ; See if the remainder by 10 is 0
                 beq    Valid                   ; if 0, jump to Valid
                 
                 pulb                           ; Retreiving the number of valid credit cards from the stack
                 pula                           ; Retrieving the number of invalid credit cards from the stack
                 inca                           ; increment the number of invalid credit cards
                 bra    NextCheck               ; jump to NextCheck to process the next card
Valid
                 pulb                           ; Retreiving the number of valid credit cards from the stack
                 pula                           ; Retrieving the number of invalid credit cards from the stack
                 incb                           ; increment the number of valid credit cards
NextCheck
                 cpx    #EndCards               ; Checking if there are more cards to process
                 bne    CheckCards              ; if yes, jump back to CheckCards to process the next card

                 staa   InValidResult           ; Store the number of invalid credit cards in InValidResult
                 stab   ValidResult             ; Store the number of valid credit cards in ValidResult

; Do not change and code below here
Finished        jsr     Config_HEX_Displays
Display         ldaa    ValidResult
                ldab    #DIGIT3_PP0             ; Select MSB
                jsr     Hex_Display             ; Display the value
                ldaa    #DELAY_VALUE
                jsr     Delay_ms                ; Delay for DELAY_VALUE milliseconds
                ldaa    InValidResult
                ldab    #DIGIT0_PP3             ; Select LSB
                jsr     Hex_Display             ; Display the value
                ldaa    #DELAY_VALUE
                jsr     Delay_ms                ; Delay for DELAY_VALUE milliseconds
                bra     Display                 ; Endless loop


; Filenames without a "C:\68HCS12\Lib\" path MUST be placed in the SOURCE FOLDER
#include Add_Odd.asm                            ; you write this one
#include Add_Even.asm                           ; you write this one
#include Validate_CC.asm                        ; you write this one
#include Config_HEX_Displays.asm                ; provided to you - no changes permitted
#include HEX_Display.asm                        ; provided to you - no changes permitted
#include C:\68HCS12\Lib\Delay_ms.asm            ; Library File    - no changes permitted

                end

************************* No Code Past Here ****************************