;P2_FA
    
    LIST P=PIC18F4321   F=INHX32
    #include <p18f4321.inc>
    
; CONFIGS ----------------------------------------------------------------------

    CONFIG  OSC=HSPLL   ; L'oscil.lador
    CONFIG  PBADEN=DIG  ; Volem que el PORTB sigui DIGital
    CONFIG  WDT=OFF	; Desactivem el Watch Dog Timer
    CONFIG  LVP=OFF
   
; VARIABLES --------------------------------------------------------------------

COUNT_PWM	    EQU	0x00	    ; Pulse (10uS)
COUNT_PWM1	    EQU	0x01	    ; ECHO (58uS)
CASE1		    EQU	0x02	    ; Mode Digital
CASE2		    EQU	0x03	    ; Mode Analogic Single
CASE3		    EQU	0x04	    ; Mode Analogic Realtime
CASE4		    EQU	0x05	    ; Mode Singleshot
CASE5		    EQU	0x06	    ; Mode Auto
CASE6		    EQU	0x07	    ; Mode Inserir nom
CASE7		    EQU	0x08	    ; Mode Mostrar nom i 200 mesures
CASE8		    EQU	0x09	    ; Mode Mostrar última mesura
CASE9		    EQU	0x10	    ; Mode Auto-scan
PART_LOW	    EQU	0x11	    ; Interrupción T0 Low (20ms)
PART_HIGH	    EQU	0x12	    ; Interrupción T0 Low (20ms)
INC_PWM		    EQU	0x13	    ; Increment PWM
nTIMES		    EQU	0x14	    ; Posició Servo
PWM_FIRST_TIME	    EQU 0x15	    ; Posició inicial Servomotor
SERVO_POS	    EQU 0x16	    ; Posició Servo
REBOTS		    EQU 0x17	    ; Control de Rebots
MODE		    EQU 0x18	    ; Control de Mode
SECONDS_ECHO	    EQU 0x19	    ; Control Echo
POS_REALTIME	    EQU 0x30	    ; Calcular Posició Realtime
JT_UP		    EQU 0x31	    ; Joystick UP
JT_DOWN		    EQU 0x32	    ; Joystick DOWN
NUM7		    EQU 0x33	    ; Número a mostrar al 7-Segments
nLETRAS		    EQU 0x34	    ; Numero de lletres escrites
nLETRAS_AUX	    EQU 0x35	    ; Numero de lletres auxiliar
EXIT_WR		    EQU 0x36	    ; Flag acabar de escriure
INIT_AUTO	    EQU 0x37	    ; Flag Inici Mode Auto
EEPROM_SIZE	    EQU 0x38	    ; Mida EEPROM
SALTO_LINEA	    EQU 0x39	    ; ASCII Salto de línea
GUION		    EQU 0x40	    ; ASCII GUION
ENTER		    EQU 0x41	    ; ASCII Enter (retorn de carro)
MESURA		    EQU 0x42	    ; Guardar mesura realitzada
MESURA_AUX	    EQU	0x43	    ; Variable Auxiliar de Mesura
UNITATS		    EQU 0x44	    ; Xifra Unitats Mesura
DECENAS		    EQU 0x45	    ; Xifra Decenes Mesura
CENTENAS	    EQU 0x46	    ; Xifra Centenes Mesura
POS_RAM		    EQU 0x47	    ; Úiltima posicio escrita de la RAM
POS_RAM_AUX	    EQU 0x48	    ; Varuable Auxiliar posició RAM  
HAY_MUESTRA	    EQU	0x49	    ; Flag si tenim alguna mostre guardada
NOM_GUARDAT	    EQU	0x50	    ; Flag si tenim algun nom guardar
POS_MAX		    EQU 0x51	    ; Guardem valor màxim mesura
nTIMES_MAX	    EQU	0x52	    ; Guardem posició de la màxima mesura
FER_MESURA_SINGLE   EQU 0x53	    ; Flag de mode Singleshot
AUTO_ACTIVAT	    EQU 0x54	    ; Flag de mode Auto
AGAFA_MESURES	    EQU	0x55	    ; Flag de activar mesura de mostres Auto
	    
TAULA7S EQU 0x20

    ORG 0x0000
    GOTO    MAIN
    ORG 0x0008
    GOTO    HIGH_RSI
    ORG 0x0018
    RETFIE  FAST
 
    ORG TAULA7S
    ;Segments del 0, segments del 1
    DB 0xCF, 0x41
    ;Segments del 2, segments del 3
    DB 0x1F, 0x57
    ;Segments del 4, segments del 5
    DB 0xD1, 0xD6
    ;Segments del 6, segments del 7
    DB 0xDE, 0x43
    ;Segments del 8, EXTRA
    DB 0xDF, 0xFF

   
; INITS ------------------------------------------------------------------------
    
INIT_PORTS   ; Configura els ports I/O
    ; PORTA
    BSF	    TRISA,0,0	    ; Configurem el bit AN0 d'entrada	(ADC)
    BCF     TRISA,3,0	    ; Configurem el bit RA3 de sortida	(LED Status1)
    BCF     TRISA,4,0	    ; Configurem el bit RA4 de sortida	(LED Status2)
    CLRF    LATA,0	    ; Configurem port A de sortida	(RSI)
    ; PORTB
    BSF     TRISB,0,0	    ; Configurem el port RB0 d'entrada (Pos +)
    BSF	    TRISB,1,0	    ; Configurem el port RB1 d'entrada (Pos -)
    BSF	    TRISB,2,0	    ; Configurem el port RB2 d'entrada (Mesure)
    BCF     TRISB,4,0	    ; Configurem el bit RB4 de sortida
    BCF	    INTCON2,RBPU,0  ; Activem els pull-ups del port B.
    ; PORTC
    BSF	    TRISC,RC0,0	    ; Configurem el port RC0 d'entrada (echo)
    BCF	    TRISC,RC1,0	    ; Configurem el port RC1 d'entrada (trigger)
    BSF	    TRISC,RC6,0	    ; Configurem el port RC6 d'entrada (TX)
    BSF	    TRISC,RC7,0	    ; Configurem el port RC7 d'entrada (RX)
    ; PORTD
    CLRF    TRISD,0	    ; Configurem port D de sortida
    RETURN
    
INIT_INTERRUPTS		    ; Activamos las interrupciones
    BCF RCON,IPEN,0	    
    BSF INTCON,GIE,0
    BSF INTCON,PEIE,0
    BSF INTCON,TMR0IE,0	    ; Timer0
    RETURN
    
INIT_VARS
    MOVLW   b'01000100'	    ; 'D'	Mode Digital
    MOVWF   CASE1,0
    MOVLW   b'01010011'	    ; 'S'	Mode Analogic Single
    MOVWF   CASE2,0
    MOVLW   b'01010100'	    ; 'T'	Mode Analogic Real-Time
    MOVWF   CASE3,0
    MOVLW   b'01010101'	    ; 'U'	Mode Singleshot
    MOVWF   CASE4,0
    MOVLW   b'01000001'	    ; 'A'	Mode Auto
    MOVWF   CASE5,0
    MOVLW   b'01001001'	    ; 'I'	Inserir nom
    MOVWF   CASE6,0
    MOVLW   b'01010010'	    ; 'R'	Mostrar nom i 200 mesures
    MOVWF   CASE7,0
    MOVLW   b'01001101'	    ; 'M'	Mostrar última mesura
    MOVWF   CASE8,0
    MOVLW   b'01001110'	    ; 'N'	Mode Auto-scan
    MOVWF   CASE9,0
    CLRF    nTIMES,0
    CLRF    PWM_FIRST_TIME,0
    CLRF    MODE,0
    CLRF    SECONDS_ECHO,0
    CLRF    POS_REALTIME,0
    CLRF    JT_UP,0
    CLRF    JT_DOWN,0
    CLRF    NUM7,0
    CLRF    nLETRAS,0
    CLRF    nLETRAS_AUX,0
    CLRF    INIT_AUTO,0
    CLRF    MESURA,0
    CLRF    MESURA_AUX,0
    CLRF    CENTENAS,0
    CLRF    DECENAS,0
    CLRF    UNITATS,0
    CLRF    POS_RAM,0
    CLRF    HAY_MUESTRA,0
    CLRF    NOM_GUARDAT,0
    CLRF    AUTO_ACTIVAT,0
    CLRF    FER_MESURA_SINGLE,0
    CLRF    AGAFA_MESURES,0
    MOVLW   .13
    MOVWF   ENTER,0
    MOVLW   .255
    MOVWF   EEPROM_SIZE,0
    MOVLW   .10
    MOVWF   SALTO_LINEA
    MOVLW   .45
    MOVWF   GUION
    RETURN
    
INIT_POINTERS	; Iniciem punter taula Flash
    CLRF    TBLPTRU,0
    CLRF    TBLPTRH,0
    MOVLW   TAULA7S
    MOVWF   TBLPTRL,0
    TBLRD*
    MOVFF   TABLAT,LATD
    RETURN
    
INIT_EUSART
    MOVLW   b'00100100' ;Valores TXSTA
    MOVWF   TXSTA,0
    MOVLW   b'10010000' ;Valores RCSTA
    MOVWF   RCSTA,0
    MOVLW   b'00000010' ;Valores BAUDCON
    MOVWF   BAUDCON,0
    MOVLW   .255	; SYNC 0, BRGH = 1, BRG16 = 0, 40Mhz --> 255
    MOVWF   SPBRG,0
    RETURN

INIT_T0	; Congigura Timer0
    MOVLW   b'10010001' ;Valores TOCON
    MOVWF   T0CON,0
    MOVLW   HIGH(.15536)
    MOVWF   TMR0H,0
    MOVLW   LOW(.15536)
    MOVWF   TMR0L,0
    RETURN
    
INIT_ADC ; Configura el módul A/D
    MOVLW   b'00000001'	; A/D Input channel
    MOVWF   ADCON0,0
    MOVLW   b'00001110'	; A/D Adquisition time
    MOVWF   ADCON1,0
    MOVLW   b'00001001'	; A/D Conversion time
    MOVWF   ADCON2,0
    RETURN
    
INIT_EEPROM
    MOVFF   GUION,EEDATA	; Data Memory Value to write
    BSF	    EECON1, WREN	; Enable writes
    BCF	    INTCON, GIE		; Disable Interrupts
    MOVLW   55h
    MOVWF   EECON2		; Write 55h
    MOVLW   0AAh
    MOVWF   EECON2		; Write 0AAh
    BSF	    EECON1, WR		; Set WR bit to begin write
ESPERA_EE
    BTFSC   EECON1,WR,0
    GOTO    ESPERA_EE
    BSF	    INTCON, GIE		; Enable Interrupts
    BCF	    EECON1, WREN	; Disable writes on write complete (EEIF set)
    INCF    EEADR,1,0
    DECFSZ  EEPROM_SIZE,1,0
    GOTO    INIT_EEPROM
    RETURN
    
CARREGA_RAM		;Inicialitzem els punters de la RAM.
    CLRF    FSR0L,0
    MOVLW   0x01
    MOVWF   FSR0H,0
LOOP_RAM		;Bucle per a l?escriptura de la RAM.
    MOVFF   GUION,POSTINC0  ;Escribim un '-' en les 200 primeres adreces.
    INCF    POS_RAM,1,0
    MOVLW   .200
    CPFSGT  POS_RAM,0 
    GOTO    LOOP_RAM
    CLRF    FSR0L,0	    ;Una vegada s?han guardat totes les dades
    MOVLW   0x01	    ;es tornen a inicialitzar els punters. 
    MOVWF   FSR0H,0
    CLRF    POS_RAM,0
    RETURN
    
; ------------------------------------------------------------------------------
; Quan detectem una interrupció, baixem el flag i anem a al procediment adecuat.
HIGH_RSI 
    BTFSC   INTCON,TMR0IF
    GOTO    RSI_T0
    RETFIE  FAST   
   
RSI_T0 ; Interrupción T0 --> Generem un senyal de 20 ms de període.
    MOVLW   HIGH(.15536)
    MOVWF   TMR0H,0
    MOVLW   LOW(.15536)
    MOVWF   TMR0L,0
    BCF	    INTCON,TMR0IF,0
    INCF    REBOTS,1,0
    BSF	    LATB,4,0
    MOVLW   .165      
    MOVWF   PART_LOW
    MOVLW   .10          
    MOVWF   PART_HIGH
LOOP_SERVO ; Determinem el temps a 1 del nostre senyal PWM.
    DECFSZ  PART_LOW,1,0
    GOTO    LOOP_SERVO
    MOVLW   .165
    MOVWF   PART_LOW
    DECFSZ  PART_HIGH,1,0
    GOTO    LOOP_SERVO
    BTFSC   PWM_FIRST_TIME,0,0
    CALL    POS_SERVO
    BCF	    LATB,4,0
    BTFSC   AGAFA_MESURES,0	    ; Comprovem si mode Auto està activat i hem de agafar mostres.
    CALL    MESURE		    ; Si ho està fem un Mesure cada 20ms.
    RETFIE  FAST
    
HUMANS
    CLRF    POS_RAM,0
    CLRF    FSR0L,0
    RETURN
    
MESURE
    CALL    PULSE_10uS
    INCF    POS_RAM,1,0
    MOVLW   .200
    CPFSLT  POS_RAM,0
    CALL    HUMANS
    MOVFF   SECONDS_ECHO,POSTINC0
    SETF    HAY_MUESTRA,0	    ; Marquem que ja hem fet una mostra
    RETURN
    
PULSE_10uS	    ; Procediment d?espera
    CLRF    SECONDS_ECHO,0
    BSF	    LATC,1,0
    MOVLW   .32
    MOVWF   COUNT_PWM	    ; Comptador <- W (Comptador)
ESPERA_10uS
    DECFSZ  COUNT_PWM,1,0
    GOTO    ESPERA_10uS
    BCF	    LATC,1,0
    CALL    ECHO
    RETURN

ECHO		    ; Procediment d?espera
    ;BTFSS   PORTC,0,0
    MOVLW   .66      
    MOVWF   PART_LOW
    MOVLW   .110          
    MOVWF   PART_HIGH
    LOOP_ECHO_2 ; Determinem el temps a 1 del nostre senyal PWM.
    DECFSZ  PART_LOW,1,0
    GOTO    LOOP_ECHO_2
    MOVLW   .66
    MOVWF   PART_LOW
    DECFSZ  PART_HIGH,1,0
    GOTO    LOOP_ECHO_2
    ;GOTO    ECHO
LOOP_ECHO
    BTFSS   PORTC,0,0 
    RETURN
    MOVLW   .192
    MOVWF   COUNT_PWM1	    ; Comptador <- W (Comptador)
ESPERA_58uS
    DECFSZ  COUNT_PWM1,1,0
    GOTO    ESPERA_58uS
    INCF    SECONDS_ECHO,1,0
    GOTO    LOOP_ECHO
    
ESPERA_REBOTS
    CLRF    REBOTS,0
ESPERA
    MOVLW   .10
    CPFSEQ  REBOTS,0
    GOTO    ESPERA
    RETURN

NUM_7S	    ; Mostrem Número del Mode per el display 7-Segments
    MOVWF   NUM7,0
    CLRF    TBLPTRU,0
    CLRF    TBLPTRH,0
    MOVLW   TAULA7S
    MOVWF   TBLPTRL,0
LOOP_NUM7   ; Segons el número del mode incrementem les direccions de la taula flash.
    INCF    TBLPTRL,1,0
    DECFSZ  NUM7,1,0
    GOTO    LOOP_NUM7
    TBLRD*
    MOVFF   TABLAT,LATD
    RETURN
    
SALTO_Y_ENTER
    MOVFF   SALTO_LINEA, TXREG	; Fem un salt de línea
    CALL    WAIT_TX
    MOVFF   ENTER, TXREG	; Fem un retorn de carro
    CALL    WAIT_TX
    RETURN
    
; MODES ------------------------------------------------------------------------
    
; Escriu en la EEPROM el nom i cognom que introdueix l'usuari per el canal série. (max. 120 caràcters)
MODE_INSERIR_NOM
    ; Primer de tot mostrem un '0' per el display 7-Segments.
    MOVLW   .0
    CALL    NUM_7S
    SETF    NOM_GUARDAT,0	    ; Flag marcant que hem guardat un nom.
    CALL    SALTO_Y_ENTER	    ; Fem salt de línea i retorn de carro.
    CLRF    nLETRAS,0
    CLRF    EXIT_WR
    MOVLW   0x00
    MOVWF   EEADR		    ; Data Memory Address to write
LOOP_ESCRIPTURA			    ; Esperem a tenir una lletra
    BTFSS   PIR1,RCIF,0
    GOTO    LOOP_ESCRIPTURA
    CALL    CHECK_ENTER		    ; Hem de comprovar que la lletra no sigui un ENTER
    CALL    CHECK_MAX_CARACTER	    ; Comprobem si hem arribat al màxim de caracters.
    BTFSS   EXIT_WR,0,0		    ; Comprovem si hem de sortir de la escriptura
    GOTO    ESCRIBE_LETRA	    ; Si no sortim de la escriptura seguim.
    CALL    SALTO_Y_ENTER	    ; Fem salt de línea i retorn de carro.
    RETURN
    
CHECK_ENTER		; Comprovar si la lletra introduida és un 'ENTER'.
    MOVF    RCREG,0
    CPFSEQ  ENTER,0
    RETURN
    SETF    EXIT_WR,0
    RETURN
    
CHECK_MAX_CARACTER	; Comprovem que no haguem escrit 120 caràcters. (màxim)
    MOVLW   .120
    CPFSEQ  nLETRAS,0
    RETURN
    SETF    EXIT_WR,0
    RETURN
    
ESCRIBE_LETRA		; Guardem la lletra escrita en la memòria EEPROM
    INCF    nLETRAS,1,0
    MOVFF   RCREG, TXREG
    CALL    WAIT_TX
    MOVFF   RCREG,EEDATA    ; Data Memory Value to write
    BSF	    EECON1, WREN    ; Enable writes
    BCF	    INTCON, GIE	    ; Disable Interrupts
    MOVLW   55h
    MOVWF   EECON2	    ; Write 55h
    MOVLW   0AAh
    MOVWF   EECON2	    ; Write 0AAh
    BSF	    EECON1, WR	    ; Set WR bit to begin write
ESPERA_EE1
    BTFSC   EECON1,WR,0
    GOTO    ESPERA_EE1
    BSF	    INTCON, GIE	    ; Enable Interrupts
    BCF	    EECON1, WREN    ; Disable writes on write complete (EEIF set)
    INCF    EEADR,1,0
    GOTO    LOOP_ESCRIPTURA

    
;-------------------------------------------------------------------------------

    
; Mostra el nom i cognom del usuari guardat en la EEPROM i les últimes 200 mesures de distància guardades en la memòria RAM que s'han fet. (o les que tinguem si són < 200)
MODE_MOSTRA_NOM
    ; Primer de tot mostrem un '1' per el display 7-Segments.
    MOVLW   .1
    CALL    NUM_7S
    BTFSS   NOM_GUARDAT,0,0	; Comprovem si tenim un nom guardat.
    RETURN		; Sino, no mostrem res.
    CALL    SALTO_Y_ENTER	; Fem salt de línea i retorn de carro.
    CALL    MOSTRA_NOM		; Mostrem nom guardat.
    CALL    SALTO_Y_ENTER	; Fem salt de línea i retorn de carro.
    CALL    MOSTRAR_200_MESURES	; Mostrem les 200 mesures (o les que tinguem)
    RETURN  
    
MOSTRA_NOM
    MOVLW   0x00
    MOVWF   EEADR		; Data Memory Address to read
    BCF	    EECON1, EEPGD	; Point to DATA memory
    BCF	    EECON1, CFGS	; Access EEPROM
    MOVFF   nLETRAS,nLETRAS_AUX	; Guardem les , lletres que tenim en una auxiliar.
LOOP_LECTURA_EEPROM
    BSF	    EECON1, RD		; EEPROM Read
    MOVFF   EEDATA, TXREG	; W = EEDATA
    CALL    WAIT_TX
    INCF    EEADR,1,0
    DECFSZ  nLETRAS_AUX,1,0
    GOTO    LOOP_LECTURA_EEPROM
    RETURN
    
MOSTRAR_200_MESURES
    MOVLW   .0
    CPFSGT  POS_RAM,0
    RETURN
    CLRF    POS_RAM_AUX,0
    MOVFF   POS_RAM_AUX,FSR0L
    MOVLW   0x01
    MOVWF   FSR0H,0
LOOP_LECTURA_RAM
    MOVFF   POSTINC0,MESURA
    INCF    POS_RAM_AUX,1,0
    CALL    CONVERT_CHAR_ASCII	; Hem de convertir la mesura que en fet per a mostrar els centímentres en ASCII per el canal série.
    MOVFF   MESURA_AUX,UNITATS	; Mesura_AUX serán les unitats que ens quedin.
    CALL    MOSTRAR_MESURA	; Mostrem mesura actual
    MOVF    POS_RAM,0
    CPFSEQ  POS_RAM_AUX,0
    CALL    SI_GUION		; Mostrem un guió entre mesures.
    MOVF    POS_RAM,0
    CPFSEQ  POS_RAM_AUX,0
    GOTO    LOOP_LECTURA_RAM
    RETURN
    
SI_GUION
    MOVFF   GUION, TXREG
    CALL    WAIT_TX
    RETURN
    
    
;-------------------------------------------------------------------------------

    
; Mostrem l'última mostra realitzada i guardada en la memòria RAM, si no s'ha fet cap mostrem un guió.
MODE_MOSTRA_ULTIMA
    ; Primer de tot mostrem un '2' per el display 7-Segments.
    MOVLW   .2
    CALL    NUM_7S
    CALL    SALTO_Y_ENTER	; Fem salt de línea i retorn de carro.
    BTFSS   HAY_MUESTRA,0	; Comprobem si tenim alguna mostra
    GOTO    NO_MOSTRAR
    DECF    POS_RAM,1,0
    MOVFF   POS_RAM,FSR0L
    MOVLW   0x01
    MOVWF   FSR0H,0
    MOVFF   POSTINC0,MESURA
    INCF    POS_RAM,1,0
    CALL    CONVERT_CHAR_ASCII	; Hem de convertir la mesura que en fet per a mostrar els centímentres en ASCII per el canal série.
    MOVFF   MESURA_AUX,UNITATS	; Mesura_AUX serán les unitats que ens quedin.
    CALL    MOSTRAR_MESURA	; Mostrem mesura per el canal serie.
FINAL_MOSTRA
    CALL    SALTO_Y_ENTER	; Fem salt de línea i retorn de carro.
    RETURN
NO_MOSTRAR			; Si no tenim cap mostre mostrem un '-'.
    MOVFF   GUION, TXREG
    CALL    WAIT_TX
    GOTO    FINAL_MOSTRA
    
; Funció que treurà cada Xifra de la Mesura i la posarà en ASCII per tal de mostrar-la per el canal série.
CONVERT_CHAR_ASCII
    MOVFF   MESURA,MESURA_AUX    ; Primer copiem la Mesura que tenim a una variable auxiliar
    CLRF    CENTENAS
    CLRF    DECENAS
    CLRF    UNITATS
    MOVLW   .100
    CPFSGT  MESURA_AUX,0	; Comprovem que la mesura sigui > 100 ((sino voldrà dir que no tenim centenes)
    GOTO    CALCULAR_DECENAS
LOOP_CENTENAS
    MOVLW   .100
    SUBWF   MESURA_AUX,1	; Restem 100 a la Mesura				Ex --> 256-100 = 156 ... LOOP
    INCF    CENTENAS		; Incrementem la Variable de Centenes			Ex --> LOOP 1..2.
    MOVLW   .101
    CPFSLT  MESURA_AUX,0	; Si la mesura és més petita de 100 sortim del bucle.	Ex --> Mesura_AUX = 056
    GOTO    LOOP_CENTENAS
CALCULAR_DECENAS
    MOVLW   .9
    CPFSGT  MESURA_AUX,0	; Comprovem que la mesura_aux sigui > 10 (sino voldrà dir que no tenim decenes)
    RETURN
LOOP_DECENAS
    MOVLW   .10
    SUBWF   MESURA_AUX,1	; Restem 10 a la Mesura_AUX que estem calculant		Ex --> 056-10 = 046 ... 035 ... LOOP
    INCF    DECENAS		; Incrementem la Variable de Decenes			Ex --> 1..2..3..4..5.
    MOVLW   .10			
    CPFSLT  MESURA_AUX,0	; Si la mesura és més petita de 10 sortim del bucle.	Ex --> Mesura_AUX = 006
    GOTO    LOOP_DECENAS
    RETURN
    
MOSTRAR_MESURA
    MOVLW   .48	
    ADDWF   CENTENAS,1		; Sumem 48 a les centenes per a mostrar en ASCII.
    MOVFF   CENTENAS,TXREG	; Mostrem xifra de les centenes per el canal série.
    CALL    WAIT_TX
    MOVLW   .48			
    ADDWF   DECENAS,1		; Sumem 48 a les decenes per a mostrar en ASCII.
    MOVFF   DECENAS,TXREG	; Mostrem xifra de les decenes per el canal série.
    CALL    WAIT_TX
    MOVLW   .48
    ADDWF   UNITATS,1		; Sumem 48 a les unitats per a mostrar en ASCII.
    MOVFF   UNITATS ,TXREG	; Mostrem xifra de les unitats per el canal série.
    CALL    WAIT_TX
    RETURN
    
    
;-------------------------------------------------------------------------------
    

; Utilitzarem els botóns per incrementar o decrementar la posició del Servomotor en 5º.
MODE_DIGITAL
    ; Primer de tot mostrem un '3' per el display 7-Segments.
    MOVLW   .3
    CALL    NUM_7S
LOOP_DIGITAL ; Polling entre els els 2 botons i rebre una tecla per el canal serie.
    BTFSS   PORTB,0,0		; Esperem a que es premi el polsador +.
    CALL    INCREMENTA_GRAUS	; Increment de 5 graus.
    BTFSS   PORTB,1,0		; Esperem a que es premi el polsador -.
    CALL    DECREMENTA_GRAUS	; Decrement de 5 graus.
    BTFSS   PORTB,2,0		; Esperem a que es premi el polsador MESURE.
    CALL    CHECK_MESURE	; Hem de comprobar si tenim algun mode de Mesura activat, i si en tenim, quin.
    BTFSS   PIR1,RCIF,0		; Esperem a que es premi una altre tecla per el canal serie.
    GOTO    LOOP_DIGITAL	; Si no tenim cap tecla seguim en el mateix mode.
    GOTO    CHECK_MODE 
    
    
;-------------------------------------------------------------------------------
    
    
; Utilitzarem el joystick per incrementar o decrementar la posició del Servomotor en 5º.
MODE_ANALOGIC_SINGLE
    ; Primer de tot mostrem un '4' per el display 7-Segments.
    MOVLW   .4
    CALL    NUM_7S
LOOP_ANALOGIC_SINGLE 
    BSF	    ADCON0,GO_NOT_DONE,0
WAIT_ADC
    BTFSC   ADCON0,GO_NOT_DONE,0
    GOTO    WAIT_ADC
    CALL    CHECK_JOYSTICK		; Comprovem posició Joystick
    BTFSS   PORTB,2,0			; Esperem a que es premi el polsador MESURE.
    CALL    CHECK_MESURE		; Hem de comprobar si tenim algun mode de Mesura activat, i si en tenim, quin.
    BTFSS   PIR1,RCIF,0			; Esperem a que es premi una altre tecla per el canal serie.
    GOTO    LOOP_ANALOGIC_SINGLE	; Si no tenim cap tecla seguim en el mateix mode.
    GOTO    CHECK_MODE			; Si no tenim cap tecla seguim en el mateix mode.
    

;-------------------------------------------------------------------------------
    

; Col·loquem el servomotor en la mateixa posició analógica del joystick actualitzant el gir a temps real.
MODE_ANALOGIC_REALTIME
    ; Primer de tot mostrem un '5' per el display 7-Segments.
    MOVLW   .5
    CALL    NUM_7S
LOOP_ANALOGIC_REALTIME
    BSF	    PWM_FIRST_TIME,0,0
    MOVLW   b'00001010' ; A/D Conversion time
    MOVWF   ADCON2,0
    BSF	    ADCON0,GO_NOT_DONE,0
WAIT_ADC2
    BTFSC   ADCON0,GO_NOT_DONE,0
    GOTO    WAIT_ADC2
    MOVFF   ADRESH, POS_REALTIME	; Agafem 5 bits del High.
    RRNCF   POS_REALTIME,1,0		; Rotem tres cops els bits.
    RRNCF   POS_REALTIME,1,0
    RRNCF   POS_REALTIME,1,0
    MOVLW   b'00011111'
    ANDWF   POS_REALTIME,1
    MOVLW   .5
    MULWF   POS_REALTIME,0
    MOVFF   PRODL,nTIMES
    BTFSS   PORTB,2,0			; Esperem a que es premi el polsador MESURE.
    CALL    CHECK_MESURE		; Hem de comprobar si tenim algun mode de Mesura activat, i si en tenim, quin.
    BTFSS   PIR1,RCIF,0			; Esperem a que es premi una altre tecla per el canal serie.
    GOTO    LOOP_ANALOGIC_REALTIME	; Si no tenim cap tecla seguim en el mateix mode.
    GOTO    CHECK_MODE			; Si no tenim cap tecla seguim en el mateix mode.
    
    
; MOURE SERVO ------------------------------------------------------------------
    
POS_SERVO	; Determina posició Servomotor
    MOVFF   nTIMES, SERVO_POS
LOOP_nTIMES
    MOVLW   .36
    MOVWF   INC_PWM
LOOP_INC_PWM
    DECFSZ  INC_PWM,1,0
    GOTO    LOOP_INC_PWM
    DECFSZ  SERVO_POS,1,0
    GOTO    LOOP_nTIMES
    RETURN
    
INCREMENTA_GRAUS
    CALL    ESPERA_REBOTS
    CLRF    JT_UP,0
    SETF    PWM_FIRST_TIME,0	; Marquem que ja hem mogut.
    MOVLW   .176		
    CPFSLT  nTIMES,0		; Si estem en una posició de menys de 176º podem fer els increments
    RETURN
    INCF    nTIMES,1		; Incrementem 5 cops --> 5º
    INCF    nTIMES,1
    INCF    nTIMES,1
    INCF    nTIMES,1
    INCF    nTIMES,1
    RETURN
    
ZERO
    CLRF PWM_FIRST_TIME,0
    RETURN
    
DECREMENTA_GRAUS
    CALL    ESPERA_REBOTS
    CLRF    JT_DOWN,0
    MOVLW   .4
    CPFSGT  nTIMES,0		; Si estem en una posició de més de 4º podem fer els decrement
    GOTO    ZERO
    DECF    nTIMES,1		; Decrementem 5 cops --> 5º
    DECF    nTIMES,1
    DECF    nTIMES,1
    DECF    nTIMES,1
    DECF    nTIMES,1
    RETURN   
    
    
CHECK_JOYSTICK ; Guardem moviments Joystick per a moure el Servo quan torni a la posició de repós.
    MOVLW   .200	; Mirem si la posició del Joystick és < 200. (Sino --> UP)
    CPFSLT  ADRESH,0
    SETF    JT_UP,0
    MOVLW   .50		; Mirem si la posició del Joystick és > 50. (Sino --> DOWN)
    CPFSGT  ADRESH,0
    SETF    JT_DOWN,0
    MOVLW   .128	; Mirem si la posició del Joystick és = 128. (Si --> Centre)
    CPFSEQ  ADRESH,0
    RETURN
    BTFSC   JT_UP,0	; Si hem detectat la posició UP incrementem 5º.
    CALL    INCREMENTA_GRAUS
    BTFSC   JT_DOWN,0	; Si hem detectat la posició DOWN decrementem 5º.
    CALL    DECREMENTA_GRAUS
    RETURN

    
;-------------------------------------------------------------------------------

    
; Realitzarem una sola mostra amb el detector de distàncies (ultrasons).
MODE_SINGLESHOT
    ; Primer de tot mostrem un '6' per el display 7-Segments.
    MOVLW   .6
    CALL    NUM_7S
    BSF	    LATA,3,0		; Encenem el LED de Status1.
    BCF	    LATA,4,0		; Apaguem el LED de Status2.  
    CLRF    AUTO_ACTIVAT,0	; Netejarem el Flag de mode Auto.
    CLRF    AGAFA_MESURES,0	; Deixarem de fer mesures Auto.
    CALL    CHECK_SINGLESHOT
    RETURN
    
CHECK_SINGLESHOT			
    BTFSC   FER_MESURA_SINGLE,1,0	; Comprovem si tenim el Mode Singleshot activat.
    CALL    MESURE			; Si el tenim, fem la mesura.
    SETF    FER_MESURA_SINGLE		; Si no el tenim actvat, l'activem.
    RETURN
    
CHECK_MESURE	; Entrarem a aquest mode mitjançant el botó Mesure.
    CALL    ESPERA_REBOTS
    BTFSC   FER_MESURA_SINGLE,1,0	; Comprovem si tenim el Mode Singleshot activat.
    CALL    MESURE			; Si el tenim, fem la mesura.
    BTFSC   AUTO_ACTIVAT,1,0		; Comprovem si tenim el Mode Auto Activat
    CALL    CHECK_MESURES_AUTO		; Si el tenim comprovem si estem fent mesures o no.
    RETURN
    
;-------------------------------------------------------------------------------
    
    
; Realitzarem mostres cada 20ms constantment.
MODE_AUTO
    ; Primer de tot mostrem un '7' per el display 7-Segments.
    MOVLW   .7
    CALL    NUM_7S
    BSF	    LATA,3,0		    ; Encenem el LED de Status1.
    BSF	    LATA,4,0		    ; Encenem el LED de Status2.
    CLRF    FER_MESURA_SINGLE,0	    ; Netejarem el flag de Singleshot.
    CALL    CHECK_AUTO
    RETURN
    
CHECK_AUTO
    BTFSC   AUTO_ACTIVAT,1,0	    ; Comprovem si tenim el mode Auto activat.
    CALL    CHECK_MESURES_AUTO	    ; Si el tenim, mirem si estem fent mesures o no.
    SETF    AUTO_ACTIVAT,0	    ; Si no el tenim, l'activem.
    RETURN
    
CHECK_MESURES_AUTO
    BTFSC   AGAFA_MESURES,1,0	    ; Comprovem si estem agafant mesures.
    GOTO    APAGA_AUTO		    ; Si si, ho desactivem.
    SETF    AGAFA_MESURES,0	    ; Si no, ho activem.
FINAL
    RETURN
    
APAGA_AUTO	; Deixem de agafar mesures i anem al final sense tornar a activar-les.
    CLRF    AGAFA_MESURES,0
    GOTO    FINAL    
    
;-------------------------------------------------------------------------------

    
; Movem el servo de un en un els 180º i realitzem una mesura en cada grau. Col·loquem el servomotor en la posició que ha determinat la mesura més gran.
MODE_AUTOSCAN
    ; Primer de tot mostrem un '8' per el display 7-Segments.
    MOVLW   .8
    CALL    NUM_7S
    CLRF    nTIMES,0		; Ens col·loquem a la posició d'inici del servomotor.
    CLRF    PWM_FIRST_TIME,0
    CLRF    POS_MAX,0
    CLRF    nTIMES_MAX,0
    CLRF    POS_RAM,0
    CLRF    FSR0L,0
LOOP_AUTOSCAN
    CALL    MESURE		; Realitzem una mesura.
    SETF    PWM_FIRST_TIME,0	; Marquem que ja hem mogut.
    INCF    nTIMES,1		; Incrementem 1º la posició.
    MOVF    POS_MAX,0
    CPFSLT  SECONDS_ECHO,0	; Comparem valor de distància actual amb valor màxim guardat.
    CALL    SAVE_MAX		; Guardem Valor de distància màxim i la seva posició. 
    MOVLW   .180
    CPFSEQ  nTIMES,0		; Si arribem a 180º hem acabat.
    GOTO    LOOP_AUTOSCAN
    MOVFF   nTIMES_MAX,nTIMES	; Un cop acabem movem al servo a la posició on hem trobat el valor de distància màxim.
    RETURN
    
SAVE_MAX
    MOVFF   SECONDS_ECHO,POS_MAX
    MOVFF   nTIMES,nTIMES_MAX
    RETURN
    
    
;-------------------------------------------------------------------------------
    
    
; Comprovem si hem de canviar de mode segons la lletra que ens han introduït per el canal série.
CHECK_MODE
    MOVFF   RCREG,TXREG
    
    ; Primer comprovem que la tecla sigui vàlida i la guardem o anem al mode en concret.
    MOVF    RCREG,0 
    XORWF   CASE1,0
    BTFSC   STATUS,Z
    MOVFF   RCREG, MODE		; Hem de guardar que estem en el mode Digital.
    
    MOVF    RCREG,0
    XORWF   CASE2,0
    BTFSC   STATUS,Z
    MOVFF   RCREG, MODE		; Hem de guardar que estem al mode Analogic Single.
    
    MOVF    RCREG,0
    XORWF   CASE3,0
    BTFSC   STATUS,Z
    MOVFF   RCREG, MODE		; Hem de guardar que estem al mode Analogic Realtime.
    
    MOVF    RCREG,0
    XORWF   CASE4,0
    BTFSC   STATUS,Z
    CALL    MODE_SINGLESHOT	; Hem de anar a mode Singleshot i tornarem al mode anterior (si teniem).
    
    MOVF    RCREG,0
    XORWF   CASE5,0
    BTFSC   STATUS,Z
    CALL    MODE_AUTO		; Hem de anar a mode Auto i tornarem al mode anterior (si teniem).
    
    MOVF    RCREG,0
    XORWF   CASE6,0
    BTFSC   STATUS,Z
    CALL    MODE_INSERIR_NOM	; Hem de anar al mode Inserir Nom, i netejarem els demés modes.
    
    MOVF    RCREG,0
    XORWF   CASE7,0
    BTFSC   STATUS,Z
    CALL    MODE_MOSTRA_NOM	; Hem de anar al mode Mostrar Nom i Mesures, i netejarem els demés modes.
    
    MOVF    RCREG,0
    XORWF   CASE8,0
    BTFSC   STATUS,Z
    CALL    MODE_MOSTRA_ULTIMA	; Hem de anar al mode Mostrar Ultima Mesura, i netejarem els demés modes.
    
    MOVF    RCREG,0
    XORWF   CASE9,0
    BTFSC   STATUS,Z
    CALL    MODE_AUTOSCAN   	; Hem de anar al mode Autoscan, i netejarem els demés modes.

    ; Anem al mode vàlid que s'hagui introduit
    MOVF    MODE,0
    XORWF   CASE1,0
    BTFSC   STATUS,Z
    GOTO    MODE_DIGITAL	    ; Tornarem al Mode Digital si el teniem guardat a la variable.
    
    MOVF    MODE,0
    XORWF   CASE2,0
    BTFSC   STATUS,Z
    GOTO    MODE_ANALOGIC_SINGLE    ; Tornarem al Mode Analogic Single si el teniem guardat a la variable.
    
    MOVF    MODE,0
    XORWF   CASE3,0
    BTFSC   STATUS,Z
    GOTO    MODE_ANALOGIC_REALTIME  ; Tornarem al Mode Analogic Realtime si el teniem guardat a la variable.

    RETURN
    
    
; ------------------------------------------------------------------------------

    
WAIT_RX
    BTFSS   PIR1,RCIF,0	    ; Esperem a que es premi una tecla per el canal serie.
    GOTO    WAIT_RX
    CALL    CHECK_MODE	    ; Mirarem si hem de fer alguna cosa amb la tecla introduida.

WAIT_TX
    BTFSS   TXSTA, TRMT,0   ; Esperarem a rebre el valor.
    GOTO    WAIT_TX
    RETURN
    
MAIN
    CALL    INIT_PORTS
    CALL    INIT_INTERRUPTS
    CALL    INIT_T0
    CALL    INIT_VARS
    CALL    INIT_POINTERS
    CALL    INIT_EUSART
    CALL    INIT_ADC
    CALL    CARREGA_RAM
    CALL    INIT_EEPROM
    CALL    MODE_SINGLESHOT
    MOVFF   CASE1,MODE
LOOP
    CALL    WAIT_RX
    CALL    WAIT_TX
    GOTO    LOOP
    END