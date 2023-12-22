# LSSnake

## Periféricos del Microcontrolador
- Display LCD: Muestra menús de interacción con el usuario y durante el juego. Permite la navegación para registrar usuarios, crear partidas y obtener información relevante.
- Teclado Matricial (Keypad): Utilizado para la navegación en los menús y para que el usuario introduzca su nombre en modo SMS. También se utiliza para introducir la hora.
- Joystick: Permite jugar al "Snake" mediante los ejes 'X' e 'Y', interactuando con el ordenador.
- Altavoz (Speaker): Emite una melodía durante el juego.

## Interacción con el Ordenador
El microcontrolador se comunica con el PC a través del canal serie, utilizando un software Java en el ordenador.
Al iniciar una partida, el microcontrolador cuenta el tiempo desde el inicio y envía la información de usuario y tiempo al PC para ser mostrada en la pantalla del juego.
El ordenador envía puntuaciones actualizadas al microcontrolador. El juego se puede jugar con el Joystick, el teclado matricial o el teclado del ordenador.

## Funcionalidades Principales del Microcontrolador
1. New Game:
- Select User: Permite al usuario seleccionar su nombre registrado.
- New User: Permite al usuario introducir su nombre mediante el teclado matricial en modo SMS y crea un nuevo usuario.
2. Show top 5 scores:
- Muestra el nombre y puntuación de los usuarios con las cinco mejores puntuaciones en "Snake", con transición de marquesina.
3. Show Users:
- Muestra todos los usuarios registrados en el sistema en el display LCD, con transición de marquesina.
4. Modify Users:
- Permite editar o eliminar usuarios. Selecciona el usuario y ofrece opciones para editar el nombre o eliminarlo.
5. Show Time:
- Muestra la hora actual del sistema en tiempo real.
6. Modify Time:
- Permite al usuario cambiar la hora global del sistema.

## Diagrama de TADs (Tipos Abstractos de Datos)
Diseño completamente cooperativo con diferentes módulos TAD que cumplen funciones específicas y cooperan para lograr todas las funcionalidades.
TADs incluyen Central, Menú, Hora, Teclado, SMS, ADC, SIO, Timer, Altavoz, Musica, entre otros.

## Conclusión y Problemas Observados
La práctica permitió aplicar conceptos aprendidos en sistemas digitales y microprocesadores en un entorno más realista.
Se enfrentaron desafíos en la optimización del código para utilizar eficientemente la memoria limitada del microcontrolador.
Problemas destacados incluyeron la inicialización incorrecta de la pantalla LCD y la necesidad de detallada revisión de código para solucionar problemas.
El proyecto incluyó la traducción de la programación en ensamblador a C y la comunicación efectiva entre el microcontrolador y el entorno Java para la reproducción de música durante el juego.
