# LSSONO
Este proyecto se centra en la implementación de un sistema en un microcontrolador PIC18F4321 programado en ensamblador. El sistema está diseñado para medir distancias a objetos cercanos mediante un sensor ultrasónico, utilizando un servomotor para posicionar el sensor en la ubicación deseada. El control del sistema se realiza a través de diversas interfaces, como un joystick, tres pulsadores y el puerto serie de la computadora. Además, se incluyen visualizadores como un display de 7 segmentos y dos LEDs.
## Modos de Operación

El sistema tiene diferentes modos de operación, seleccionados a través del canal serie de la computadora:
1. Inserción de Nombre (I): Permite al usuario ingresar su nombre y apellidos, que se almacenan en la memoria EEPROM.
2. Mostrar Nombre y Últimas Distancias (R): Muestra el nombre del usuario y las últimas doscientas medidas de distancia realizadas.
3. Mostrar Última Medida (M): Muestra el valor en centímetros de la última medida realizada en el sistema.
4. Mover Servomotor Digitalmente (D): Permite mover el servomotor digitalmente, incrementando o decrementando la posición en intervalos de 5°.
5. Mover Servomotor Analógicamente con Joystick (S): Mueve el servomotor en intervalos de 5° utilizando el joystick.
6. Mover Servomotor Analógicamente en Tiempo Real con Joystick (T): Mueve el servomotor en tiempo real según la posición actual del joystick.
7. Modo SingleShot de Medición (U): Realiza una única medida utilizando el sensor ultrasónico.
8. Modo Automático de Medición (A): Realiza medidas automáticas cada 20 ms. Puede activarse o desactivarse mediante el botón de medida o la entrada por serie.
9. Modo Escaneo Automático (N): Realiza un escaneo de todas las posiciones del servomotor, realizando una medida en cada grado y posicionando el servomotor donde la distancia es mayor.


## Estructura del Software
El software se organiza en diversas partes, incluyendo inicializaciones, configuraciones del microcontrolador, y bucles para cada modo de operación. Se utilizan interrupciones, como el TIMER0 para generar el PWM del servomotor y el control del sensor ultrasónico.

## Configuraciones del Microcontrolador
Se utiliza un oscilador externo de 10MHz para lograr un tiempo de instrucción de 100ns mediante el uso de PLL. Se configuran los puertos del microcontrolador para entradas y salidas específicas, y se establecen interrupciones utilizando el TIMER0.

## Conclusión y Problemas Observados
La práctica ha sido fundamental para aplicar los conocimientos adquiridos en telelabs. La gestión de recursos del PIC y la coordinación de diversas funciones simultáneas fueron desafíos notables. Se destacó la necesidad de alternar acciones para lograr la simultaneidad. Se menciona un problema específico relacionado con la escritura y lectura en la memoria RAM, que se resolvió corrigiendo las llamadas de funciones asociadas.
