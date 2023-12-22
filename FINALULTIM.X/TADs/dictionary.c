//DICCIONARI
//INT 0 -->TMR
char TiGetTimer(void);
//Pre: Hi ha timers disponibles.
//Post: Retorna un handler i el marca com a ocupat.
void TiResetTics(char handler);
//Pre: El handler ha estat retornat per TiGetTimer().
//Post: Iguala tics del handler als tics universals.
long TiGetTics(char handler);
//Pre: El handler ha estat retornat per TiGetTimer().
//Post: Retorna els tics del handler des de l'últim TiResetTics(handler).

//INT 1 MENU-LCD
void LcClear(void);
//Pre: -
//Post: Neteja el display i posa el cursor a la posició zero en l'estat en el que estava. (la propera ordre pot trigar fins a 1.6ms)
void LcCursorOff(void);
//Post: Apaga el cursor. (La propera ordre pot trigar fins a 40us)
void LcCursorOn(void);
//Pre: -
//Post: Encén el cursor. (La propera ordre pot trigar fins a 40us)
void LcPutChar(char c);
//Pre: -
// Post: Printa el char en l'actual poscició del cursor i incrementa  la seva posició. (si la columna arriba a 39, salta a 0 tot incrementant la fila)
void LcGotoXY(char column, char row);
//Pre : Columna entre 0 i 39, Fila entre 0 i 3
//Post: Posiciona el cursor en aquestes coordenades. (La propera ordre pot trigar fins a 40us)

//INT 2 CENTRAL-MENU
void cleanMarquesina(void);
//Pre: Rebem un canvi en el que mostrar per la pantalla
//Post: Neteja pantalla i reinicia posició (tambe de la marquesina).
void changeJoystick(void);
//Pre: Rebem senyal de moviment del Joystick eix Y.
//Post: Canvia les opcions del menú que mostrarem per el display LCD.
void printLetter(unsigned char key, unsigned char numChars);
//Pre: S'ha premut alguna tecla en el teclat matriu.
//Post: Envia la lletra al LCD
void cleanPortName(void);
//Pre: Rep la senyal de que s'ha pres * en el menú inicial
//Post: Neteja cadena del PortName
void changeMenu(unsigned char mode);
//Pre: Rep un canvi de mode/menu
//Post: Envia el index del menú que ha de mostrar
void updateHora(unsigned char pos, unsigned char hora, unsigned char mod);
//Pre: S'ha actualitzat el valor de la hora
//Post: Envia la hora per a poder mostrar-la.
void writeName(unsigned char* towerName);
//Pre: S'ha introduit el towerName complet.
//Post: L'envia per a poder printar el End_MSG
void initMenu(void);
//Pre: Hem entrat al 'End-Communication'
//Post: Tornem a inicialitzar el TAD Menu

//INT 3 TECLAT-SMS
void manageKeySMS(void);
//Pre: Detectem que ens apreten una tecla
//Post: Enviem la tecla premuda.

//INT 4 SMS-CENTRAL
void manageKey(void);
//Pre: Rep la senyal de que s'ha polsat una tecla.
//Post: Envia la tecla que s'ha premut i les repeticions.

//INT 5 ADC-CENTRAL
void changePos(void);
//Pre: Moviment del Joystick en el EixY
//Post: Avisem si s'ha mogut amunt o avall

//INT 6 CENTRAL-SOUND
void pressSound(unsigned char nota);
//Pre: M'han avisat que s'ha premut una tecla.
//Post: Activem la senyal PWM segons la nota de la tecla per fer sonar l'altaveu.
void initSound(void);
//Pre: Hem entrat al 'End-Communication'
//Post: Tornem a inicialitzar el TAD Sound

//INT 7 CENTRAL-SIO
void enviaDada(unsigned char c, unsigned char* portName);
//Pre: Ens apreten '#' quan ens han introduit el PortName
//Post: Avisem al modul ADC que ha de enviar una acció pel canal serie.
void activaRecording(void);
//Pre: Volem gravar un nou recording
//Post: Avtivem el flag per grabar mostres
void enviaMostra(unsigned char sound);
//Pre: Volem enviar un now recording.
//Post: Avisem al TAD SIO de que volem enviar mostres
void setMode(unsigned char m);
//Pre: Hi ha un canvi de mode
//Post: Avisa al TAD de quin mode estem actualment
void selectSound(unsigned char ind);
//Pre: Volem fer un 'Play Recording'
//Post: Avisa de quin recording volem reproduir i activa el flag
void initSIO(void);
//Pre: Hem entrat al 'End-Communication'
//Post: Tornem a inicialitzar el TAD SIO

//INT 8 CENTRAL-ROM
void getNT(void);
//Pre: Volem tenir en compte el index de recordings
//Post: Enviem el valor actual del index de recordings
void getPT(void);
//Pre: Volem tenir en compte el valor de total recordinggs
//Post: Enviem el valor actual del total recordings

//INT 9 CENTRAL-HORA
void initHora(void);
//Pre: Hem registrat correctament la torre de control
//Post: Inicialitzem el TAD Hora per a que començi a comptar

//INT 10 SIO-ROM
void activeWritting(void);
//Pre: Hem guardat un recording
//Post: Avtivem el flag per escriure'l a la Rom
char getNT(void);
//Pre: Volem tenir en compte el index de recordings
//Post: Enviem el valor actual del index de recordings
void updateNT(void);
//Pre: Hem rebut un nou recording
//Post: Volem actualitzar el index de recordings
void updatePT(void);
//Pre: Hem rebut un nou recording
//Post: Volem actualitzar el valor del total recordings

//INT 11 MENU-HORA
void actHora(unsigned char pos, unsigned char hora);
//Pre: Hem rebut de Central la Hora Modificada
//Post: Actualitzem el rellotge del sistema per la nova hora