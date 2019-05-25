; Brandon Ponce Aragon
; Practica 4 HOLA MUNDO 14 SEGMENTOS

   ;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
; PIC16F628 Configuration Bit Settings

; Assembly source line config statements

#include "p16f628.inc"

; CONFIG
; __config 0xFF18
 __CONFIG _FOSC_INTOSCIO & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF

 
 
;VARIABLES
;COUNTERS FOR DELAY SUBROUTINE
rub_cont1	 EQU	    0x20
rub_cont2	 EQU	    0x21
rub_cont3	 EQU	    0x22
;Contadores de subrutina de las tablas
rub_conttabla1	 EQU	    0x24 
rub_conttabla2	 EQU	    0x25 
;
;CONSTANTS
cub_const1	 EQU	    0x4
cub_const2	 EQU	    0xDF
cub_const3	 EQU	    0xFF
;Constantes de subrutina de las tablas
cub_conttabla1	EQU	    0x00 ;CREATES 1ST TABLA DELAY CONSTANT
cub_conttabla2	EQU	    0x12 ;CREATES 2ND TABLA DELAY CONSTANT 
;
;*******************************************************************************
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; goes to beginning of program

; TODO ADD INTERRUPTS HERE IF USED

MAIN_PROG CODE                      ; let linker place main program
;-------------------------------------------------------------------------------

START
 
;PORT CONFIG
    BSF	    STATUS,RP0		    ;SETS POINTER IN BANK 0 TO ACCESS PORTB	    
    CLRF    TRISB		    ;TURNS ALL SPACES IN TRISB TO 0 ENABLING IT AS OUTPUT 
    CLRF    TRISA		    ;TURNS ALL SPACES IN TRISB TO 0 ENABLING IT AS OUTPUT 
    BCF	    STATUS,RP0		    ;Regresamos el puntero al banco 0 para volver a tener acceso a PORTB	 
 ;------------------------------------------------------------------------------
 PRINCIPAL
    MOVLW   cub_conttabla1		    ;MOVES CUB TABLA TO WORKING REGISTRY 
    MOVWF   rub_conttabla1		    ;MOVES VALYE IN W REGISTRY TO RUB TABLA
    MOVLW   cub_conttabla2		    ;MOVES CUB TABLA TO WORKING REGISTRY 
    MOVWF   rub_conttabla2		    
DE_NUEVO_TABLA 
    MOVFW   rub_conttabla1		    ;MAIN COUNTER 
    CALL    TABLA1			    ;CALLS TABLA 
    MOVWF   PORTB			    ;PRINTS VALUE IN ACC 
    MOVFW   rub_conttabla1		    ;ASIGNS COUNTER FOR FUTURE USAGE 
    CALL    TABLA2			    ;CALL FUNCTION
    MOVWF   PORTA			    ;PRINTS VALUE FOR CERTAIN LETTER ON TRISA 
    CALL    DELAY			    ;DELAY OF ACTIAVTION 
    INCF    rub_conttabla1		    ;INCREASES FILE THAT WILL BE PASSED, TO PCL 
    DECFSZ  rub_conttabla2		    ;DECREASES COUNTER AND CHECKS CONDITION
    GOTO    DE_NUEVO_TABLA		    ;IETRATES DE NUEVO CODE TO PRINT TO 7 SEGMENTS
    GOTO    PRINCIPAL			    

 ;-------------------------*****************************************************
 ;  Rutina de tabla1
 ;  Parametros
 ;	IN: W
 ;	OT: w
 ;-------------------------*****************************************************
TABLA1
    ADDWF   PCL,F		    ;CHANGES PCL VALUE TO EXECUTE INDICATED LINE IN CONTTABLA
    RETLW   b'01101100'		    ;SENDS TO 7 SEGMENT THE FIRST PART OF LETTER "H" IN BINARY	
    RETLW   b'11111100'		    ;SENDS TO 7 SEGMENT THE FIRST PART OF LETTER "0" IN BINARY	
    RETLW   b'00011100'		    ;SENDS TO 7 SEGMENT THE FIRST PART OF LETTER "L" IN BINARY
    RETLW   b'11101100'		    ;SENDS TO 7 SEGMENT THE FIRST PART OF LETTER "A" IN BINARY
    RETLW   b'00000000'		    ;SENDS TO 7 SEGMENT A NULL VALUE TO EXPRESS A SPACE 
    RETLW   b'01101110'		    ;SENDS TO 7 SEGMENT THE FIRST PART OF LETTER "M" IN BINARY
    RETLW   b'01111100'		    ;SENDS TO 7 SEGMENT THE FIRST PART OF LETTER "U" IN BINARY
    RETLW   b'01101110'		    ;SENDS TO 7 SEGMENT THE FIRST PART OF LETTER "N" IN BINARY
    RETLW   b'11110001'		    ;SENDS TO 7 SEGMENT THE FIRST PART OF LETTER "D" IN BINARY
    RETLW   b'11111100'		    ;SENDS TO 7 SEGMENT THE FIRST PART OF LETTER "0" IN BINARY
    RETLW   b'00000000'		    ;SENDS TO 7 SEGMENT A NULL VALUE TO EXPRESS A SPACE 
    RETLW   b'00111100'		    ;SENDS TO 7 SEGMENT THE FIRST PART OF LETTER "B" IN BINARY
    RETLW   b'11001110'		    ;SENDS TO 7 SEGMENT THE FIRST PART OF LETTER "R" IN BINARY
    RETLW   b'11101100'		    ;SENDS TO 7 SEGMENT THE FIRST PART OF LETTER "A" IN BINARY
    RETLW   b'01101110'		    ;SENDS TO 7 SEGMENT THE FIRST PART OF LETTER "N" IN BINARY
    RETLW   b'11110001'		    ;SENDS TO 7 SEGMENT THE FIRST PART OF LETTER "D" IN BINARY
    RETLW   b'11111100'		    ;SENDS TO 7 SEGMENT THE FIRST PART OF LETTER "O" IN BINARY
    RETLW   b'01101110'		    ;SENDS TO 7 SEGMENT THE FIRST PART OF LETTER "N" IN BINARY
    RETLW   b'00000000'		    ;SENDS TO 7 SEGMENT A NULL VALUE TO EXPRESS A SPACE 
 ;-------------------------*****************************************************
 ;  Rutina de tabla2
 ;  Parametros
 ;	IN: W
 ;	OT: w
 ;-------------------------*****************************************************
TABLA2
    ADDWF   PCL,F		    ;Te saltas una cantidad de lineas igual al contador conttabla1
    RETLW   b'01001000'		    ;SENDS TO 7 SEGMENT THE SECOND PART OF LETTER "H" IN BINARY	
    RETLW   b'00000000'		    ;SENDS TO 7 SEGMENT THE SECOND PART OF LETTER "0" IN BINARY		
    RETLW   b'00000000'		    ;SENDS TO 7 SEGMENT THE SECOND PART OF LETTER "L" IN BINARY	
    RETLW   b'01001000'		    ;SENDS TO 7 SEGMENT THE SECOND PART OF LETTER "A" IN BINARY	
    RETLW   b'00000000'		    ;SENDS TO 7 SEGMENT A NULL VALUE TO EXPRESS A SPACE 
    RETLW   b'10000000'		    ;SENDS TO 7 SEGMENT THE SECOND PART OF LETTER "M" IN BINARY	
    RETLW   b'00000000'		    ;SENDS TO 7 SEGMENT THE SECOND PART OF LETTER "U" IN BINARY	
    RETLW   b'00000001'		    ;SENDS TO 7 SEGMENT THE SECOND PART OF LETTER "N" IN BINARY	
    RETLW   b'00000100'		    ;SENDS TO 7 SEGMENT THE SECOND PART OF LETTER "D" IN BINARY	
    RETLW   b'00000000'		    ;SENDS TO 7 SEGMENT THE SECOND PART OF LETTER "0" IN BINARY		
    RETLW   b'00000000'		    ;SENDS TO 7 SEGMENT A NULL VALUE TO EXPRESS A SPACE 
    RETLW   b'01001000'		    ;SENDS TO 7 SEGMENT THE SECOND PART OF LETTER "B" IN BINARY	
    RETLW   b'01111001'		    ;SENDS TO 7 SEGMENT THE SECOND PART OF LETTER "R" IN BINARY	
    RETLW   b'01001000'		    ;SENDS TO 7 SEGMENT THE SECOND PART OF LETTER "A" IN BINARY	
    RETLW   b'00000001'		    ;SENDS TO 7 SEGMENT THE SECOND PART OF LETTER "N" IN BINARY	
    RETLW   b'00000100'		    ;SENDS TO 7 SEGMENT THE SECOND PART OF LETTER "D" IN BINARY	
    RETLW   b'00000000'		    ;SENDS TO 7 SEGMENT THE SECOND PART OF LETTER "O" IN BINARY	
    RETLW   b'00000001'		    ;SENDS TO 7 SEGMENT THE SECOND PART OF LETTER "N" IN BINARY	
    RETLW   b'00000000'		    ;SENDS TO 7 SEGMENT A NULL VALUE TO EXPRESS A SPACE 
 
DELAY
L1
    MOVLW   cub_const1		    ;MOVES CONSTANT TO WORKING R	    ;
    MOVWF   rub_cont1		    ;THEN BACK TO A FILE 
DEC_L1
    DECFSZ  rub_cont1		    ;DECREASES RUBCONT AND GOES BACK TO MAIN 
    GOTO    L2			    ;OPENS 2ND LOOP
    RETURN			    ;RETURNS TO MAIN
L2
    MOVLW   cub_const2		    ;MOVES CONSTANT TO WORKING R    |+;
    MOVWF   rub_cont2		    ;THEN VALUE TO FILE AGAIN 
DEC_L2
    DECFSZ  rub_cont2		    ;DECREASES RUBCONT AND GOES BACK TO DEC:L1
    GOTO    L3			    ;LOOPS A 3RD TIME
    GOTO    DEC_L1		    ;GOES TO DEC L1 
L3
    MOVLW   cub_const3		    ;MOVES CONSTANT TO WORKING R	
    MOVWF   rub_cont3		    ;THEN BACK TO A FILE 
DEC_L3
    DECFSZ  rub_cont3		    ;MOVES CONSTANT TO WORKING R	
    GOTO    DEC_L3		    ;GOES TO L3 DECREASE 
    GOTO    DEC_L2		    ;GOES TO DEC L2

        END			    ;FINISHES CODE 
 
 
 
 