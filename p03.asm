
; Brandon Ponce Aragon
; Practica 2
; Rotabit
#include "p16f628.inc"
 __CONFIG _FOSC_INTOSCIO & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF
 ;//////////////////////////////////////
CONST1		EQU	    0X04
CONST2		EQU	    0XFF
CONST3		EQU	    0XFF
k_TODO_UNOS	EQU	    0X55
k_CERO		EQU	    0X00
k_TABLA1_CONT	EQU	    0X12

;-----------VARIABLES---------

VAR1		EQU	    0X20
VAR2		EQU	    0X21
VAR3		EQU	    0X22
VAR_TABLA1	EQU	    0X23


RES_VECT  CODE    0x0000
    GOTO    START
    
MAIN_PROG CODE
 
START
    ;//////////////CONFIGURACION///////////////
    BSF STATUS,RP0  ;CAMBIO EL BANCO A B1
    CLRF TRISB	    ;CAMBIO EL REGISTRO A TRISB
    BCF STATUS,RP0  ;REGRESO AL BANCO B0
    CLRF PORTB	    ;INICIALIZO PUERTO B EN 0
    ;//////////////////////////////////////////
MAIN_PROG
    
    MOVLW k_TABLA1_CONT
    MOVWF VAR_TABLA1
AGAIN
    MOVF  VAR_TABLA1,W
    CALL  TABLA1
    MOVWF PORTB
    CALL  sub_delay
    DECF  VAR_TABLA1
    MOVLW k_CERO
    XORWF VAR_TABLA1
    BTFSS STATUS,Z
    GOTO  AGAIN
    GOTO  MAIN_PROG
    ;/////////////////////////////////////////////
TABLA1
    ADDWF PCL,F
    NOP
    RETLW b'00110111';N
    RETLW b'00111111';O
    RETLW b'01011110';D
    RETLW b'00110111';N
    RETLW b'01110111';A
    RETLW b'01010000';R
    RETLW b'01111100';B
    RETLW b'00000000';
    RETLW b'00111111';O
    RETLW b'01011110';D
    RETLW b'00110111';N
    RETLW b'00111110';U
    RETLW b'01111001';M
    RETLW b'00000000';
    RETLW b'01110111';A
    RETLW b'00111000';L
    RETLW b'00111111';O
    RETLW b'01110110';H
    ;/////////////////////////////////////////////
sub_delay
LOOP1
    MOVLW   CONST1
    MOVWF   VAR1
DEC1
    DECFSZ  VAR1
    GOTO    LOOP2
    RETURN
LOOP2
    MOVLW   CONST2
    MOVWF   VAR2
DECL2
    DECFSZ  VAR2
    GOTO    LOOP3
    GOTO    DEC1
LOOP3
    MOVLW   CONST3
    MOVWF   VAR3
DECL3
    DECFSZ  VAR3
    GOTO    DECL3
    GOTO    DECL2
    
    
    END