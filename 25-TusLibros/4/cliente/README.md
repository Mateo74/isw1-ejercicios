# Substrings Finder 6000

## Servidor

En la carpeta `server-services` se encuentra el archivo `StringServer-cors.st` con el servidor en Smalltalk. Para crear el servidor abrir un workspace y ejecutar:

```smalltalk
server := StringServerController listeningOn: 8082.
```

El servidor se queda escuchando en el puerto `8082` (se puede verificar desde el browser ingresando la url `http://localhost:8082/sayhi`)
En caso de querer detener el servidor:

```smalltalk
server stopListening.
```

Los servicios que brinda el servidor:
- `substrings?sentence=${text}`
- `firstletter?word=${substring}`
- `touppercase?word=${substring}`
- `vowels?word=${substring}`

## Cliente
Hay dos formas de ejecutar/modificar el cliente:

### file://
Se puede abrir el archivo `index.html` directamente en el browser. En este archivo está todo el código JavaScript.
Ante una modificación en el código se debe refrescar el browser.

### http://
Con esta forma se puede utilizar el proyecto de manera modularizada. Es decir, el código JavaScript está en la carpeta `/src`. Los componentes (React Components) están en `/src/components`. El archivo (template) `html` está en `templates/_index.html`.
Todo esto se _compila_ ejecutando `python ./scripts/compiler.py` y el resultado es el archivo `index.html`

#### Requisitos
- Python3
- El paquete [`websockets`](https://websockets.readthedocs.io/en/stable/intro.html)

#### Servidor del cliente
Para ejecutar el servidor (del cliente) desde una terminal ejecutar:
```shell-session
./server.sh
```
El cliente se accede desde `http://localhost:8081`

#### Ciclo de desarrollo
Hasta aquí, cada vez que se modifica un archivo (ya sea `JavaScript` o el template `HTML`), debemos compilar el proyecto y refrescar el browser.

Para automatizar este ciclo se puede ejecturar:

```shell-session
./client.sh
```

De esta manera queda un `watch` sobre la carpeta y ante la modificación de un archivo:
- se ejecuta automáticamente la compilación del proyecto (recordar que el resultado es el archivo `index.html`)
- se refresca automáticamente el browser.

