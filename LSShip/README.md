# LSShip
Este proyecto consiste en un simulador de operación de barco implementado con un PIC18F4321 programado en ensamblador. Ofrece modos como Manual, Crucero y Grabación. En el Modo Manual, el usuario controla la dirección y velocidad con un Joystick. El Modo Crucero simula una ruta constante, y el Modo Grabación permite almacenar y reproducir rutas.
## Estructura del Software
El programa, escrito en ensamblador y desarrollado en MPLAB, aborda configuraciones iniciales, manejo de modos y funciones de temporización. Se utilizan botones, LED RGB, Joystick, motor DC, servomotor y otros componentes. La lógica de cambio de modo y el control del sistema se gestionan mediante escaneo continuo.
## Configuraciones del Microcontrolador
Se detallan las configuraciones de los puertos (PORTA, PORTB, PORTC, PORTD, PORTE) y otros ajustes, como la configuración del oscilador (HSPLL a 40MHz), configuración del ADC para el Joystick, y la configuración del temporizador Timer0 para el control del sistema.

## Ejecución del Programa
1. Cargue el código ensamblador en el PIC18F4321 mediante MPLAB.
2. Conecte los componentes según el esquema eléctrico proporcionado.
3. Inicie el sistema y cambie entre modos mediante botones.
4. En el Modo Manual, controle el barco con el Joystick.
5. En los Modos Crucero y Grabación, experimente con rutas automatizadas.

## Conclusiones
En esta práctica, aprendimos a programar el microcontrolador PIC18F4321 en ensamblador, integrándolo con componentes electrónicos para crear un sistema funcional. Destacamos la importancia de configurar registros y programar interrupciones para funciones de temporización. La coordinación eficiente fue crucial, ya que el microcontrolador no permite ejecutar múltiples acciones simultáneamente.

Aunque implementar todos los requisitos fue desafiante, consideramos que la experiencia fue valiosa para fortalecer nuestros conocimientos en programación de microcontroladores y electrónica.

## Problemmas Observados
Enfrentamos desafíos, como comprender el módulo A/D para la conversión de voltajes del joystick y coordinar acciones simultáneas. La planificación cuidadosa fue esencial para cumplir con los requisitos de delay en la lectura de valores de la RAM. A pesar de los desafíos, superamos obstáculos y aprendimos a integrar módulos del microcontrolador, desarrollando habilidades en programación y resolución de problemas.
