# LSControlTower
Se utilizará el mismo microcontrolador PIC18F4321 y la metodología de sistemas cooperativos. El sistema incluye un joystick, un altavoz, un micrófono con amplificador, un teclado matricial 3x4, una pantalla LCD y una conexión serie a un dispositivo externo (una computadora portátil) que ejecutará una aplicación Java para proporcionar una interfaz gráfica al sistema.
Primero, se muestra en el LCD un menú de acceso para seleccionar la torre de control con la que se desea comunicar. El usuario debe ingresar un código de tres letras mediante el teclado matricial. El sistema genera efectos sonoros para indicar la pulsación de teclas. Una vez que el usuario ha ingresado el código del puerto, se muestra un menú en el LCD con cinco opciones: Iniciar Grabación, Reproducir Grabaciones, Modificar Hora Actual, Mostrar Hora Actual y Finalizar Comunicación.
El LCD solo puede mostrar dos opciones del menú a la vez, pero el usuario puede moverse por las opciones utilizando el joystick en la dirección vertical. Para seleccionar una opción, el usuario debe presionar la tecla (#). Si las opciones son demasiado largas para mostrarse en el LCD, se mostrarán en formato de marquesina.

## Funciones
1. Iniciar Grabación: Permite al usuario realizar grabaciones de voz a través del micrófono para comunicarse con las torres de control. Cuando se activa este modo, la aplicación comienza a grabar inmediatamente.
2. Reproducir Grabaciones: En el modo "Iniciar Grabación", se muestra una lista de las grabaciones, y el usuario puede moverse por la lista mediante el joystick. Al seleccionar una grabación, se reproducen los 8 segundos de grabación a través de los altavoces de la computadora.
3. Modificar Hora Actual: Permite al usuario modificar la hora actual del sistema ingresando la hora a través del teclado matricial en formato MM:SS. La tecla (*) regresa al menú principal sin guardar cambios, y la tecla (#) guarda la hora y vuelve al menú principal.
4. Mostrar Hora Actual: Muestra en el LCD los minutos y segundos transcurridos desde que se estableció la comunicación con el puerto.
5. Finalizar Comunicación: Muestra un mensaje de despedida e informa que se ha finalizado la comunicación con la torre de control, luego regresa al menú de acceso para permitir el establecimiento de comunicación con otra torre.

## Diseño del Sistema

El diseño del sistema sigue la metodología de sistemas cooperativos e está implementado en el microcontrolador PIC18F4321. El programa principal, escrito en C y editado a través de MPLAB, sigue una estructura básica que comienza con las inicializaciones de todos los TADs (trabajadores autónomos del diseño). Luego, se ejecutan los motores en un bucle 'while'.

Los motores incluyen el motor del menú, el motor del teclado, el motor ADC y otros motores necesarios para el funcionamiento del sistema. Estos motores se ejecutan en secuencia y se encargan de gestionar diferentes partes del sistema.

En resumen, el diseño del sistema está basado en una estructura modular que utiliza diferentes motores para gestionar las diversas partes del sistema, permitiendo una gestión eficiente y el cumplimiento de los requisitos de la práctica.


## Esquema Eléctrico

El esquema eléctrico muestra las conexiones y la organización de pines del microcontrolador, así como otros componentes como resistencias, displays, circuito de reset, oscilador y conexiones para el control del pickit, joystick, USB to TTL, display LCD y teclado matricial.

Para los niveles de pines y puertos del microcontrolador, se especifican las conexiones, como la entrada del joystick, muestras del micrófono, señal del altavoz, cristal de cuarzo, pines del display LCD, pines del teclado, y otros.


## TADs (Trabajadores Autónomos del Diseño)
Se ha diseñado un diagrama de TADs que sigue un diseño completamente cooperativo. Cada TAD cumple una funcionalidad diferente y se comunican entre ellos para cumplir todas las funciones del sistema correctamente.

El TAD Central recopila toda la información y llama a las funciones que el usuario desea realizar en el sistema. Se comunica con otros TADs para obtener datos necesarios. En particular, se comunica con el TAD Menú, que a su vez se comunica con el TAD LCD para controlar lo que se debe mostrar en el display.

Otros TADs incluyen el TAD Teclado, el TAD SMS, el TAD Sound, el TAD Hora, el TAD Rom, el TAD ADC y el TAD SIO, cada uno con funciones específicas como el control del teclado, la gestión de las teclas presionadas, el control del altavoz, el conteo de tiempo y la gestión de la memoria ROM.

## Motores
Cada motor cumple una función específica en el programa para realizar tareas autónomas y/o repetitivas. Los motores están diseñados para ejecutarse en paralelo, coordinados por el programa principal en un bucle 'while'. Cada motor realiza su tarea de manera autónoma, mientras que el programa principal se encarga de coordinarlos y asegurar que todos los motores funcionen correctamente y que los datos se transmitan correctamente entre ellos.

Los motores incluyen el Motor Teclado (para la detección de teclas), Motor Menú (para mostrar opciones en el LCD), Motor TX y RX (para la comunicación con la interfaz Java), Motor ADC (para controlar el joystick), Motor Micro (para tomar muestras del micrófono), Motor Sound (para controlar el altavoz), Motor Hora (para contar el tiempo) y Motor ROM (para gestionar la memoria ROM y almacenar grabaciones).

## Problemams Observados
Durante la realización del proyecto, se observaron varios problemas, como la gestión limitada de memoria del microcontrolador, el diseño inicial de los TADs, el control del altavoz, la interpretación del joystick, la conexión USB-to-TTL y el manejo del display LCD. Se necesitaron soluciones específicas para cada uno de estos problemas, incluyendo ajustes en la lógica de generación de sonido, configuración de comunicaciones USB y diseño cuidadoso de menús, entre otros.

## Conclusiones
El proyecto fue un desafío, pero también una experiencia enriquecedora. Se aprendió sobre la importancia del diseño en sistemas cooperativos, la modularidad y la reutilización de código. La práctica permitió aplicar conceptos vistos en clase y desarrollar habilidades de trabajo en equipo. A pesar de las dificultades, el resultado final fue satisfactorio y se considera que las habilidades y conocimientos adquiridos serán útiles en proyectos futuros y en el ámbito laboral.
