__CONFIG _CP_OFF & _WDT_OFF & _BODEN_ON & _PWRTE_ON & _INTOSC_OSC_CLKOUT & _MCLRE_OFF & _LVP_OFF

Contador    EQU 0x20
Repite10    EQU 0x21  

            BSF     STATUS, RP0
            BCF     STATUS, RP1
            BCF     TRISB,  0
            BCF     TRISB,  1
            BCF     TRISB,  2
            BCF     TRISB,  3

            MOVLW   B'00000111'     
            MOVWF   OPTION_REG
            BCF     STATUS, RP0

INICIO
            BCF     PORTB,0
            BCF     PORTB,1
            BCF     PORTB,2
            BCF     PORTB,3
            CALL    RETARDO_10S

            MOVLW   D'10'
            MOVWF   Repite10


CICLO_10_VECES
            BSF     PORTB,0
            CALL    RETARDO_10S
            BCF     PORTB,0  
            CALL    RETARDO_10S

            BSF     PORTB,1
            CALL    RETARDO_10S
            BCF     PORTB,1
            CALL    RETARDO_10S
            
            DECFSZ  Repite10, f
            GOTO    CICLO_10_VECES

            BSF     PORTB,0
            BSF     PORTB,1
            BSF     PORTB,2
            BSF     PORTB,3

FIN_PROGRAMA
            GOTO    FIN_PROGRAMA    

RETARDO_10S
            MOVLW   D'152'
            MOVWF   Contador

BUCLE_152
            CLRF    TMR0            
            BCF     INTCON, T0IF

ESPERA_1
            BTFSS   INTCON, T0IF  
            GOTO    ESPERA_1
            DECFSZ  Contador, F     
            GOTO    BUCLE_152

            MOVLW   D'105'
            MOVWF   TMR0
            BCF     INTCON, T0IF

ESPERA_2
            BTFSS   INTCON, T0IF  
            GOTO    ESPERA_2
            RETURN

END