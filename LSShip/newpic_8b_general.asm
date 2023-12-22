;*******************************************************************************
; MAIN PROGRAM	P2_FA
;*******************************************************************************

    LIST P=PIC18F4321   F=INHX32
    #include <p18f4321.inc>
    
; CONFIGS ----------------------------------------------------------------------
    
    CONFIG  OSC=HSPLL   ; L'oscil.lador (10MHz x 4 = 40MHz) --> Tinst = 1 / (40MHz) = 25nS
    CONFIG  PBADEN=DIG  ; Volem que el PORTB sigui DIGital
    CONFIG  WDT=OFF	; Desactivem el Watch Dog Timer
    CONFIG  LVP=OFF
    
; VARIABLES --------------------------------------------------------------------

MODE_ACTUAL    	    EQU	0x01	    ; Guardem el Mode Actual
M_MANUAL    	    EQU	0x02	    ; Variable de Mode Manual
M_CREUER    	    EQU	0x03	    ; Variable de Mode Creuer
M_RECORD    	    EQU	0x04	    ; Variable de Mode Record
M_PILOT    	    EQU	0x05	    ; Variable de Mode Pilot Automàtic
POS_JOY		    EQU 0x06	    ; Posició Joystick
JOYx_POS	    EQU 0x07	    ; Posició Joystick DIR
JOYy_POS	    EQU 0x08	    ; Posició Joystick VEL
POS_SERVO	    EQU 0x09	    ; Posició Servo
INC_PWM		    EQU	0x10	    ; Increment PWM
LOW_TIME_S	    EQU	0x11	    ; Temps a 0 PWM Servomotor
HIGH_TIME_S	    EQU	0x12	    ; Temps a 1 PWM Servomotor
LOW_TIME_M	    EQU	0x13	    ; Temps a 0 PWM Motor DC
HIGH_TIME_M	    EQU	0x14	    ; Temps a 1 PWM Motor DC
LOW_TIME_aux	    EQU	0x15	    ; Auxiliar PWM Motor
VEL_ACTUAL	    EQU 0x16	    ; Velocitat actual Motor DC
UP_DOWN		    EQU 0x17	    ; Direcció Motor DC (Endavant/Enrrere)
POS_RAM		    EQU 0x18	    ; Úiltima posicio escrita de la RAM
POS_RAM_AUX	    EQU 0x29	    ; Auxiliar posició RAM
HYPHEN		    EQU 0x30	    ; ASCII Hyphen (Guión)
REBOTS		    EQU 0x31	    ; Control de Rebots
COUNT_1S	    EQU 0x32	    ; Counter per comptar 1 segon
COUNT_ALARM	    EQU 0x33	    ; Counter per fer Alarm 1/2 segon
DELAY		    EQU 0x34	    ; Delay entre Save
DELAY_AUX	    EQU 0x35	    ; Auxiliar Delay Save
COUNT_1M	    EQU 0x37	    ; Count per comptar 1 minut Record
COUNT_AUX	    EQU 0x38	    ; Auxiliar del count 1 minut Record
EPILEPSY	    EQU 0x39	    ; Count de Led ALARM
COUNT_BOSS	    EQU 0x40	    ; Count 1 minut Alarm
FINAL_BOSS	    EQU 0x41	    ; Variable controla inactivitat 1min
POS_ACTUAL	    EQU 0x42	    ; Rang de posició del Servo	    
	    
	    
NUM7		    EQU 0x19	    ; Número a mostrar al 7-Segments
TAULA7S		    EQU 0X20	    ; Taula 7-Segments
		    
    ORG 0x0000
    GOTO    MAIN
    ORG 0x0008
    GOTO    HIGH_RSI
    ORG 0x0018
    RETFIE  FAST
    
    ORG TAULA7S
    ;Segments del 0, segments del L
    DB 0x3F, 0x38
    ;Segments del M, segments del H
    DB 0x37, 0x76
    
;*******************************************************************************
; INICIALITZACIONS
;*******************************************************************************
    
INIT_PORTS   ; Configura els ports I/O
    ; PORTA
    BSF	    TRISA,0,0	    ; Configurem el bit AN0 d'entrada	(ADC Joystick eix X)
    BSF	    TRISA,1,0	    ; Configurem el bit AN1 d'entrada	(ADC Joystick eix Y)
    BCF     TRISA,2,0	    ; Configurem el bit RA2 de sortida	(LED RGB ManualMode)
    BCF     TRISA,3,0	    ; Configurem el bit RA3 de sortida	(LED RGB CreuerMode)
    BCF     TRISA,4,0	    ; Configurem el bit RA4 de sortida	(LED Alarm)
    BCF     TRISA,5,0	    ; Configurem el bit RA5 de sortida	(LED RGB RecordMode)
    CLRF    LATA,0
    ; PORTB
    BSF     TRISB,0,0	    ; Configurem el bit RB0 d'entrada	(Manual/Creuer Mode)
    BSF     TRISB,1,0	    ; Configurem el bit RB1 d'entrada	(RecordMode)
    BSF     TRISB,2,0	    ; Configurem el bit RB2 d'entrada	(Save)
    BCF     TRISB,3,0	    ; Configurem el bit RB3 de sortida	(LED CurrentDir[9])
    BCF     TRISB,4,0	    ; Configurem el bit RB4 de sortida	(PWM DIR)
    BCF	    LATB,3,0
    BCF	    TRISB,5,0
    BCF	    INTCON2,RBPU,0  ; Activem els pull-ups del port B.
    ; PORTC
    CLRF    TRISC,0	    ; Configurem port C de sortida  (LED CurrentDir[7..0])
    CLRF    LATC,0
    ; PORTD
    CLRF    TRISD,0	    ; Configurem port D de sortida  (7S CurrentSpeed[6..0])
    CLRF    LATD,0
    ; PORTE
    BCF     TRISE,0,0	    ; Configurem el bit RE0 de sortida	(LED CurrentDir[8])
    BCF     TRISE,1,0	    ; Configurem el bit RE1 de sortida	(PWM Speed_UP)
    BCF     TRISE,2,0	    ; Configurem el bit RE2 de sortida	(PWM Speed_DOWN)
    CLRF    LATE,0
    RETURN
    
INIT_INTERRUPTS		    ; Activamos las interrupciones
    BCF RCON,IPEN,0	    
    BSF INTCON,GIE,0
    BSF INTCON,PEIE,0
    BSF INTCON,TMR0IE,0	    ; Timer0
    RETURN
    
INIT_VARS
    MOVLW   .0	    ; Mode Actual
    MOVWF   MODE_ACTUAL,0
    MOVLW   .0	    ; Mode Manual
    MOVWF   M_MANUAL,0
    MOVLW   .1	    ; Mode Creuer
    MOVWF   M_CREUER,0
    MOVLW   .2	    ; Mode Record
    MOVWF   M_RECORD,0
    MOVLW   .3	    ; Mode Pilot Automàtic
    MOVWF   M_PILOT,0
    
    CLRF    POS_JOY,0
    CLRF    POS_SERVO,0
    CLRF    NUM7,0
    CLRF    VEL_ACTUAL,0 
    CLRF    HIGH_TIME_S,0
    CLRF    LOW_TIME_S,0
    CLRF    HIGH_TIME_M,0
    CLRF    LOW_TIME_M,0
    CLRF    POS_RAM,0
    CLRF    POS_RAM_AUX,0
    CLRF    COUNT_1S,0
    CLRF    COUNT_ALARM,0
    CLRF    DELAY,0
    CLRF    DELAY_AUX,0
    CLRF    COUNT_1M,0
    CLRF    COUNT_AUX,0
    CLRF    EPILEPSY,0
    CLRF    POS_ACTUAL,0
    
    CLRF    COUNT_BOSS,0
    CLRF    FINAL_BOSS,0

    MOVLW   .45
    MOVWF   HYPHEN
    RETURN
    
INIT_ADC ; Configura el módul A/D
    MOVLW   b'00000001'	; A/D Input channel
    MOVWF   ADCON0,0
    MOVLW   b'00001110'	; A/D Adquisition time
    MOVWF   ADCON1,0
    MOVLW   b'00001001'	; A/D Conversion time
    MOVWF   ADCON2,0
    RETURN
    
INIT_T0	; Congigura Timer0 -->  65536 - (T * fosc) / (4 * prescaler) --> 65536 - (0.02 * 40MHz) / (4 * 256) = 31250
    MOVLW   b'10010001'	    ; Valores TOCON
    MOVWF   T0CON,0
    MOVLW   HIGH(.15536)    ; Carga el byte más significativo del valor en TMR0
    MOVWF   TMR0H,0
    MOVLW   LOW(.15536)	    ; Carga el byte menos significativo del valor en TMR0
    MOVWF   TMR0L,0
    RETURN 
    
INIT_POINTERS	; Iniciem el punter de la taula Flash
    CLRF    TBLPTRU,0
    CLRF    TBLPTRH,0
    MOVLW   TAULA7S
    MOVWF   TBLPTRL,0
    TBLRD*
    MOVFF   TABLAT,LATD
    RETURN    
    
;*******************************************************************************
; INTERRUPCIONS
;*******************************************************************************
    
VEL_DIRECCIO	; Determina la direcció del Motor DC
    MOVLW   .1
    CPFSEQ  UP_DOWN,0
    BSF	    LATE,1,0
    MOVLW   .0
    CPFSEQ  UP_DOWN,0
    BSF	    LATE,2,0
    RETURN
    
TIME_VEL_0  ; DC: 2,5%
    MOVLW   .250
    MOVF    HIGH_TIME_M
    MOVLW   .5
    MOVF    LOW_TIME_M
    MOVFF   LOW_TIME_M,LOW_TIME_aux
    BSF	    LATE,1,0
    GOTO    LOOP_MOTOR
    
TIME_VEL_1  ; DC: 25%
    CALL    VEL_DIRECCIO
    MOVLW   .190
    MOVF    HIGH_TIME_M
    MOVLW   .65
    MOVF    LOW_TIME_M
    MOVFF   LOW_TIME_M,LOW_TIME_aux
    GOTO    LOOP_MOTOR
    
TIME_VEL_2  ; DC: 50%
    CALL    VEL_DIRECCIO
    MOVLW   .127
    MOVF    HIGH_TIME_M
    MOVLW   .128
    MOVF    LOW_TIME_M
    MOVFF   LOW_TIME_M,LOW_TIME_aux
    GOTO    LOOP_MOTOR
    
TIME_VEL_3  ; DC: 75%
    CALL    VEL_DIRECCIO
    MOVLW   .63
    MOVF    HIGH_TIME_M
    MOVLW   .192
    MOVF    LOW_TIME_M
    MOVFF   LOW_TIME_M,LOW_TIME_aux
    GOTO    LOOP_MOTOR
	
MOVE_SERVO  ; Determina la posició del Servomotor
    MOVLW   .40
    ;MOVLW   .36
    MOVWF   INC_PWM
LOOP_INC_PWM:
    DECFSZ  INC_PWM,1,0
    GOTO    LOOP_INC_PWM
    DECFSZ  POS_SERVO,1,0
    GOTO    MOVE_SERVO  
    RETURN
    
PARTY	; Toggle LED Alarm
    BTG	    LATA,4,0
    CLRF    EPILEPSY,0
    RETURN
    
FINAL_FIGHT2	; Quan EPILEPSY arriba a 0,5 segons anem al toggle (bucle 1 min)
    MOVLW   .25
    CPFSLT  EPILEPSY,0
    CALL    PARTY
    
    MOVLW   .12	; Quan cambiem de mode o fem algo, sortim del bucle
    CPFSLT  FINAL_BOSS,0
    RETURN
    GOTO    FINAL_FIGHT2
    
INCREMENT_COUNT
    INCF    COUNT_1M,1,0
    CLRF    DELAY,0
    RETURN
   
INCREMENT_BOSS
    INCF    FINAL_BOSS,1,0
    CLRF    COUNT_BOSS,0
    RETURN

HIGH_RSI     ; Quan detectem una interrupció, baixem el flag i anem a al procediment adecuat.
    BTFSC   INTCON,TMR0IF
    GOTO    RSI_T0
    RETFIE  FAST   
    
RSI_T0	    ; Interrupción T0
    ; Resetejem el T0
    MOVLW   HIGH(.15536)
    MOVWF   TMR0H,0
    MOVLW   LOW(.15536)
    MOVWF   TMR0L,0
    BCF	    INTCON,TMR0IF,0
    
    INCF    DELAY,1,0
    INCF    COUNT_BOSS,1,0
    INCF    REBOTS,1,0
    INCF    COUNT_1S,1,0
    INCF    COUNT_ALARM,1,0
    INCF    EPILEPSY,1,0
 
    MOVLW   .250
    CPFSLT  DELAY,0
    CALL    INCREMENT_COUNT
    
    MOVLW   .250
    CPFSLT  COUNT_BOSS,0
    CALL    INCREMENT_BOSS
    
    MOVLW   .12
    CPFSLT  FINAL_BOSS,0
    CALL    FINAL_FIGHT2
    
    ; PWM Servomotor
    MOVLW   .165   
    MOVWF   LOW_TIME_S
    MOVLW   .10          
    MOVWF   HIGH_TIME_S
    
    BSF	    LATB,4,0		; PWM DIR - 1
LOOP_SERVO:	; Determinem el temps a 1 del nostre senyal PWM.
    DECFSZ  LOW_TIME_S,1,0
    GOTO    LOOP_SERVO
    MOVLW   .165
    MOVWF   LOW_TIME_S
    DECFSZ  HIGH_TIME_S,1,0
    GOTO    LOOP_SERVO
    CALL    MOVE_SERVO
    BCF	    LATB,4,0		; PWM DIR - 0
    
    ; PWM Motor DC    
    MOVLW   .3
    CPFSLT  VEL_ACTUAL,0
    GOTO    TIME_VEL_3  
    MOVLW   .2
    CPFSLT  VEL_ACTUAL,0
    GOTO    TIME_VEL_2
    MOVLW   .1
    CPFSLT  VEL_ACTUAL,0
    GOTO    TIME_VEL_1

    GOTO    TIME_VEL_0    
        
LOOP_MOTOR:
    DECFSZ  LOW_TIME_M,1,0
    GOTO    LOOP_MOTOR
    MOVF    LOW_TIME_aux
    MOVWF   LOW_TIME_M
    DECFSZ  HIGH_TIME_M,1,0
    GOTO    LOOP_MOTOR
    BCF     LATE,1,0
    BCF	    LATE,2,0
    
    RETFIE FAST
    
;*******************************************************************************
; PROCEDIMENTS
;*******************************************************************************
    
SAVE_ROUTE       
    BTG	    LATB,5,0

    MOVFF   COUNT_1M,POSTINC0    
    INCF    POS_RAM,1,0
    MOVFF   DELAY,POSTINC0    
    INCF    POS_RAM,1,0
    MOVFF   JOYx_POS,POSTINC0
    INCF    POS_RAM,1,0
    MOVFF   JOYy_POS,POSTINC0
    INCF    POS_RAM,1,0
    
    CLRF    TMR0,0
    CLRF    DELAY,0
    CLRF    COUNT_1M,0
    
    MOVLW   .120
    CPFSLT  POS_RAM,0
    GOTO    MODE_MANUAL	    ; SKIP
    
    RETURN
    
READ_RAM       
    CALL    ESPERA_REBOTS

    MOVFF   POSTINC0,COUNT_AUX
    INCF    POS_RAM_AUX,1,0  
    MOVFF   POSTINC0,DELAY_AUX
    INCF    POS_RAM_AUX,1,0  
    MOVFF   POSTINC0,JOYx_POS
    INCF    POS_RAM_AUX,1,0
    MOVFF   POSTINC0,JOYy_POS
    INCF    POS_RAM_AUX,1,0
    
    CLRF    DELAY,0
    CLRF    COUNT_1M,0
    CLRF    TMR0,0
WAIT_COUNT:
    MOVF    COUNT_AUX,0
    CPFSEQ  COUNT_1M,0
    GOTO    WAIT_COUNT
WAIT_DELAY:
    MOVF    DELAY_AUX,0
    CPFSEQ  DELAY,0
    GOTO    WAIT_DELAY
    
    BTG	    LATB,5,0
    
    CALL    LEDS_CONTROL
    CALL    DIR_SERVO
    CALL    VEL_7S
    
    MOVF    POS_RAM,0
    CPFSEQ  POS_RAM_AUX,0
    GOTO    READ_RAM
    RETURN
    
TOGGLE_MANUAL	; Si estem en ModeManual, anirem a ModeCreuer i viceversa.
    MOVF    MODE_ACTUAL,0
    CPFSLT  M_MANUAL,0
    GOTO    MODE_CREUER
    CPFSLT  M_CREUER,0
    GOTO    MODE_MANUAL
    CPFSLT  M_RECORD,0
    GOTO    MODE_RECORD
    GOTO    MODE_PILOT
    
PRE_RECORD
    CALL    INIT_RAM
    CLRF    DELAY,0
    CLRF    COUNT_1M,0
    CLRF    TMR0,0
    GOTO    MODE_RECORD
    
TOGGLE_RECORD   
    MOVF    MODE_ACTUAL,0
    CPFSLT  M_MANUAL,0
    GOTO    PRE_RECORD
    CPFSLT  M_CREUER,0
    GOTO    MODE_CREUER
    GOTO    MODE_MANUAL
    
CHECK_RECORD
    MOVF    MODE_ACTUAL,0
    CPFSEQ  M_MANUAL,0
    GOTO    TOGGLE_RECORD
    GOTO    MODE_PILOT
    
ESPERA_REBOTS
    CLRF    FINAL_BOSS,0
    CLRF    COUNT_BOSS,0
    
    CLRF    REBOTS,0
    CLRF    TMR0,0
ESPERA:
    MOVLW   .1
    CPFSEQ  REBOTS,0
    GOTO    ESPERA
    RETURN

REBOTS_MANUAL	; Controla els rebots del botó ToggleManualMode
    CALL    ESPERA_REBOTS
WAIT_MANUAL
    BTFSS   PORTB,0,0		; Comprovem si segueix polsat el botó.
    GOTO    WAIT_MANUAL
    CALL    ESPERA_REBOTS
    GOTO    TOGGLE_MANUAL
    
REBOTS_RECORD	; Controla els rebots del botó ToggleRecordMode
    CLRF    COUNT_1S,0
    CALL    ESPERA_REBOTS
WAIT_RECORD
    BTFSS   PORTB,1,0		; Comprovem si segueix polsat el botó.
    GOTO    WAIT_RECORD
    CALL    ESPERA_REBOTS
    MOVLW   .50
    CPFSLT  COUNT_1S,0
    GOTO    CHECK_RECORD
    GOTO    TOGGLE_RECORD
    
REBOTS_SAVE	; Controla els rebots del botó ToggleRecordMode
    CALL    ESPERA_REBOTS
WAIT_SAVE
    BTFSS   PORTB,2,0		; Comprovem si segueix polsat el botó.
    GOTO    WAIT_SAVE
    CALL    ESPERA_REBOTS
    CALL    SAVE_ROUTE
    RETURN
    
; Control Velocitat ------------------------------------------------------------
    
CLEAR_MINUT
    CLRF    COUNT_BOSS,0
    CLRF    FINAL_BOSS,0
    RETURN
    
CLEAR_MINUT2
    CLRF    COUNT_BOSS,0
    CLRF    FINAL_BOSS,0
    
    CLRF    LATC,0
    BCF	    LATE,0,0
    BCF	    LATB,3,0
    RETURN
    
VEL_0
    MOVLW   .11
    CPFSGT  FINAL_BOSS,0
    BCF	    LATA,4,0
    
    MOVLW   .0
    CPFSEQ  VEL_ACTUAL
    CALL    CLEAR_MINUT
    
    MOVLW   .0
    MOVWF   UP_DOWN
    MOVLW   .0
    MOVWF   VEL_ACTUAL
    GOTO    SHOW_VEL_7S
VEL_1
    MOVLW   .11
    CPFSGT  FINAL_BOSS,0
    BSF	    LATA,4,0
    
    MOVLW   .1
    CPFSEQ  VEL_ACTUAL
    CALL    CLEAR_MINUT
    
    MOVLW   .0
    MOVWF   UP_DOWN
    MOVLW   .1
    MOVWF   VEL_ACTUAL
    GOTO    SHOW_VEL_7S
VEL_2   
    MOVLW   .11
    CPFSGT  FINAL_BOSS,0
    BSF	    LATA,4,0
    
    MOVLW   .2
    CPFSEQ  VEL_ACTUAL
    CALL    CLEAR_MINUT
    
    MOVLW   .0
    MOVWF   UP_DOWN
    MOVLW   .2
    MOVWF   VEL_ACTUAL
    GOTO    SHOW_VEL_7S
VEL_3    
    MOVLW   .11
    CPFSGT  FINAL_BOSS,0
    BSF	    LATA,4,0    
    
    MOVLW   .3
    CPFSEQ  VEL_ACTUAL
    CALL    CLEAR_MINUT
    
    MOVLW   .0
    MOVWF   UP_DOWN
    MOVLW   .3
    MOVWF   VEL_ACTUAL
    GOTO    SHOW_VEL_7S     
VEL_01    
    MOVLW   .11
    CPFSGT  FINAL_BOSS,0
    BCF	    LATA,4,0
    
    MOVLW   .1
    CPFSEQ  VEL_ACTUAL
    CALL    CLEAR_MINUT
    
    MOVLW   .1
    MOVWF   UP_DOWN
    MOVLW   .1
    MOVWF   VEL_ACTUAL
    GOTO    SHOW_VEL_7S
VEL_02   
    MOVLW   .11
    CPFSGT  FINAL_BOSS,0
    BCF	    LATA,4,0    
    
    MOVLW   .2
    CPFSEQ  VEL_ACTUAL
    CALL    CLEAR_MINUT
    
    MOVLW   .1
    MOVWF   UP_DOWN
    MOVLW   .2
    MOVWF   VEL_ACTUAL
    GOTO    SHOW_VEL_7S
VEL_03    
    MOVLW   .11
    CPFSGT  FINAL_BOSS,0
    BCF	    LATA,4,0
    
    MOVLW   .3
    CPFSEQ  VEL_ACTUAL
    CALL    CLEAR_MINUT
    
    MOVLW   .1
    MOVWF   UP_DOWN
    MOVLW   .3
    MOVWF   VEL_ACTUAL
    GOTO    SHOW_VEL_7S
    
VEL_7S	    ; Controla el display 7-Segments de la Velocitat
    MOVLW   .1
    CPFSGT  JOYy_POS,0
    GOTO    VEL_03
    
    MOVLW   .62
    CPFSGT  JOYy_POS,0
    GOTO    VEL_02
    
    MOVLW   .123
    CPFSGT  JOYy_POS,0
    GOTO    VEL_01
    
    MOVLW   .255
    CPFSLT  JOYy_POS,0
    GOTO    VEL_3
    
    MOVLW   .194
    CPFSLT  JOYy_POS,0
    GOTO    VEL_2
    
    MOVLW   .135
    CPFSLT  JOYy_POS,0
    GOTO    VEL_1
    
    GOTO    VEL_0
    
SHOW_VEL_7S
    ; Segons la regió que ens trobem de l'ADC, apuntarem a una direcció de la taula.
    MOVFF    VEL_ACTUAL,NUM7
    ;MOVWF   NUM7,0
    CLRF    TBLPTRU,0
    CLRF    TBLPTRH,0
    MOVLW   TAULA7S
    MOVWF   TBLPTRL,0
    
LOOP_NUM7:   ; Segons la velocitat incrementem les direccions de la taula flash.
    INCF    TBLPTRL,1,0
    DECFSZ  NUM7,1,0
    GOTO    LOOP_NUM7
    TBLRD*  ; Llegim el valor de la taula i el copiem en TABLAT.
    MOVFF   TABLAT,LATD	    ; Un cop estem apuntant a la direcció dessitjada, ho mostrem per el 7s.
    
    RETURN
    
; Control Direcció -------------------------------------------------------------
        
DIR_SERVO	; Col·loquem el servomotor en la mateixa posició analógica del joystick actualitzant el gir a temps real.
    MOVFF   JOYx_POS, POS_JOY	; Agafem 5 bits del High.
    RRNCF   POS_JOY,1,0		; Rotem tres cops els bits.
    RRNCF   POS_JOY,1,0
    RRNCF   POS_JOY,1,0
    MOVLW   b'00011111'
    ANDWF   POS_JOY,1		; (Ens volem quedar amb els 5 MSB, que ja hem rotat, 0-180)
    MOVLW   .5
    MULWF   POS_JOY,0
    MOVFF   PRODL,POS_SERVO 
    RETURN
    
CENTRE_FUNC    
    MOVLW   .0
    CPFSEQ  POS_ACTUAL,0
    CALL    CLEAR_MINUT2
    
    BSF	    LATC,4,0
    BSF	    LATC,5,0
    
    MOVLW   .0
    MOVWF   POS_ACTUAL,0
    
    RETURN
DIR_0    
    MOVLW   .1
    CPFSEQ  POS_ACTUAL,0
    CALL    CLEAR_MINUT2
    
    BSF	    LATC,0,0
    
    MOVLW   .1
    MOVWF   POS_ACTUAL,0
    
    RETURN    
DIR_1        
    MOVLW   .2
    CPFSEQ  POS_ACTUAL,0
    CALL    CLEAR_MINUT2
    
    BSF	    LATC,1,0
    
    MOVLW   .2
    MOVWF   POS_ACTUAL,0
    
    RETURN  
DIR_2       
    MOVLW   .3
    CPFSEQ  POS_ACTUAL,0
    CALL    CLEAR_MINUT2
    
    BSF	    LATC,2,0
    
    MOVLW   .3
    MOVWF   POS_ACTUAL,0
    
    RETURN  
DIR_3        
    MOVLW   .1
    CPFSEQ  POS_ACTUAL,0
    CALL    CLEAR_MINUT2
    
    BSF	    LATC,3,0
    
    MOVLW   .1
    MOVWF   POS_ACTUAL,0
    
    RETURN  
DIR_6    
    
    MOVLW   .2
    CPFSEQ  POS_ACTUAL,0
    CALL    CLEAR_MINUT2
    
    BSF	    LATC,6,0
	
    MOVLW   .2
    MOVWF   POS_ACTUAL,0
    
    RETURN  
DIR_7    
    
    MOVLW   .3
    CPFSEQ  POS_ACTUAL,0
    CALL    CLEAR_MINUT2
    
    
    BSF	    LATC,7,0 
    
    MOVLW   .3
    MOVWF   POS_ACTUAL,0
    
    RETURN  
DIR_8        
    MOVLW   .1
    CPFSEQ  POS_ACTUAL,0
    CALL    CLEAR_MINUT2
    
    BSF	    LATE,0,0
    
    MOVLW   .1
    MOVWF   POS_ACTUAL,0
    
    RETURN      
DIR_9        
    MOVLW   .2
    CPFSEQ  POS_ACTUAL,0
    CALL    CLEAR_MINUT2
    
    MOVLW   .10
    MOVWF   JOYx_POS,0
    
    BSF	    LATB,3,0
    
    MOVLW   .2
    MOVWF   POS_ACTUAL,0
    RETURN  
    
LEDS_CONTROL   
    MOVLW   .1
    CPFSGT  JOYx_POS,0
    GOTO    DIR_9
    
    MOVLW   .10
    CPFSGT  JOYx_POS,0
    GOTO    DIR_9
    
    MOVLW   .33
    CPFSGT  JOYx_POS,0
    GOTO    DIR_8
    
    MOVLW   .65
    CPFSGT  JOYx_POS,0
    GOTO    DIR_7
    
    MOVLW   .97
    CPFSGT  JOYx_POS,0
    GOTO    DIR_6
    
    MOVLW   .255
    CPFSLT  JOYx_POS,0
    GOTO    DIR_0
    
    MOVLW   .225
    CPFSLT  JOYx_POS,0
    GOTO    DIR_1
    
    MOVLW   .193
    CPFSLT  JOYx_POS,0
    GOTO    DIR_2
    
    MOVLW   .161
    CPFSLT  JOYx_POS,0
    GOTO    DIR_3
    
    MOVLW   .128
    CPFSEQ  JOYx_POS,0
    GOTO    CENTRE_FUNC 
    RETURN
    
ADC_DIRECCIO
; Iniciem la conversió A/D del canal AN0 --> EixX (Direcció)
    MOVLW   b'00000001'	; A/D Input channel AN0(000)
    MOVWF   ADCON0,0
    BSF	    ADCON0,GO_NOT_DONE,0
WAIT_ADC
    BTFSC   ADCON0,GO_NOT_DONE,0
    GOTO    WAIT_ADC
    MOVFF   ADRESH,JOYx_POS
    CALL    LEDS_CONTROL	; Control LEDs DIR
    CALL    DIR_SERVO		; Control Servo DIR
    RETURN
    
ADC_VELOCITAT
; Iniciem la conversió A/D del canal AN1 --> EixY (Velocitat)
    MOVLW   b'00000101'	; A/D Input channel AN1(001)
    MOVWF   ADCON0,0
    BSF	    ADCON0,GO_NOT_DONE,0
WAIT_ADC1
    BTFSC   ADCON0,GO_NOT_DONE,0
    GOTO    WAIT_ADC1
    MOVFF   ADRESH,JOYy_POS
    CALL    VEL_7S		; Control 7s VEL
    RETURN
    
INIT_RAM		;Inicialitzem els punters de la RAM.
    CLRF    POS_RAM,0
    CLRF    FSR0L,0
    MOVLW   0x01
    MOVWF   FSR0H,0
LOOP_RAM:		;Bucle per a l?escriptura de la RAM.
    MOVFF   HYPHEN,POSTINC0  ;Escribim un '-' en les 30 primeres adreces.
    INCF    POS_RAM,1,0
    MOVLW   .120
    CPFSGT  POS_RAM,0 
    GOTO    LOOP_RAM
    CLRF    FSR0L,0	    ;Una vegada s?han guardat totes les dades
    MOVLW   0x01	    ;es tornen a inicialitzar els punters. 
    MOVWF   FSR0H,0
    CLRF    POS_RAM,0
    RETURN    
    
;*******************************************************************************
; MODES
;*******************************************************************************
        
; MODE MANUAL: Control del vaixell amb Joystick (Velocitat & Direcció).
MODE_MANUAL
; Primer de tot mostrem color verd el display LED RGB.
    BCF	    LATA,5,0		; Apaguem el bit RA5 (LED RecordMode) 
    BCF	    LATA,3,0		; Apaguem el bit RA3 (LED CreuerMode)
    BSF	    LATA,2,0		; Encenem el bit RA2 (LED ManualMode)
    MOVFF   M_MANUAL,MODE_ACTUAL	; Hem de guardar que estem al Mode Manual.
        
    CALL    ADC_DIRECCIO
    CALL    ADC_VELOCITAT
    
    CALL    LOOP_BUTTONS	; Fem Polling entre aquest mode i els botons de canvi de mode.
    GOTO    MODE_MANUAL
    
;-------------------------------------------------------------------------------
    
; MODE CREUER: Adquirir velocitat del vaixell abans de prémer el botó.
MODE_CREUER
    ; Primer de tot mostrem color blau el display LED RGB.
    BCF	    LATA,5,0		; Apaguem el bit RA5 (LED RecordMode)   
    BCF	    LATA,2,0		; Apaguem el bit RA2 (LED ManualMode)  
    BSF	    LATA,3,0		; Encenem el bit RA3 (LED CreuerMode)
    MOVFF   M_CREUER,MODE_ACTUAL	; Hem de guardar que estem al Mode Creuer.
    
    CALL    ADC_DIRECCIO
    CALL    VEL_7S
    
    CALL    LOOP_BUTTONS	; Fem Polling entre aquest mode i els botons de canvi de mode.
    GOTO    MODE_CREUER
    
;-------------------------------------------------------------------------------
    
; MODE RECORD: Usant el botó SAVE guardem Vel&Dir del vaixell (Max 30).
MODE_RECORD
    ; Primer de tot mostrem color vermell el display LED RGB.
    BCF	    LATA,2,0		; Apaguem el bit RA2 (LED ManualMode)   
    BCF	    LATA,3,0		; Apaguem el bit RA3 (LED CreuerMode)
    BSF	    LATA,5,0		; Encenem el bit RA5 (LED RecordMode) 
    MOVFF   M_RECORD,MODE_ACTUAL	; Hem de guardar que estem al Mode Record.
        
    CALL    ADC_DIRECCIO
    CALL    ADC_VELOCITAT
        
    BTFSS   PORTB,2,0		; Esperem a que es premi el polsador Save.
    CALL    REBOTS_SAVE
    
    CLRF    COUNT_BOSS,0
    CLRF    FINAL_BOSS,0
    
    MOVLW   .12
    CPFSLT  COUNT_1M,0
    GOTO    MODE_MANUAL
    
    CALL    LOOP_BUTTONS	; Fem Polling entre aquest mode i els botons de canvi de mode.
    GOTO    MODE_RECORD
    
;-------------------------------------------------------------------------------

; MODE PILOT AUTOMATIC: Reprodueix la última ruta guardada.
MODE_PILOT    
    ; Primer de tot mostrem color blanc el display LED RGB (Encenem els 3).
    BSF	    LATA,2,0		; Encenem el bit RA2 (LED ManualMode) 
    BSF	    LATA,3,0		; Encenem el bit RA3 (LED CreuerMode) 
    BSF	    LATA,5,0		; Encenem el bit RA5 (LED RecordMode)
    ;MOVFF   M_PILOT,MODE_ACTUAL	; Hem de guardar que estem al Mode Pilot Automàtic.
    
    CLRF    POS_RAM_AUX,0
    MOVFF   POS_RAM_AUX,FSR0L
    MOVLW   0x01
    MOVWF   FSR0H,0
    
    MOVLW   .0
    CPFSEQ  POS_RAM,0
    CALL    READ_RAM
    
    GOTO    MODE_MANUAL

;*******************************************************************************
; MAIN
;*******************************************************************************
    
LOOP_BUTTONS:	; Fem polling per consultar si ens premen algun dels polsadors.
    CLRF    COUNT_1S,0
    BTFSS   PORTB,0,0		; Esperem a que es premi el polsador ManualMode.
    GOTO    REBOTS_MANUAL
    BTFSS   PORTB,1,0		; Esperem a que es premi el polsador RecordMode.
    GOTO    REBOTS_RECORD 
    RETURN
    
MAIN
    CALL    INIT_PORTS
    CALL    INIT_INTERRUPTS
    CALL    INIT_VARS
    CALL    INIT_ADC
    CALL    INIT_T0
    CALL    INIT_POINTERS
    CALL    INIT_RAM
    GOTO    MODE_MANUAL		; Iniciem en sistema en el MODE MANUAL
LOOP:
    CALL    LOOP_BUTTONS
    GOTO    LOOP
    END