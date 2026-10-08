# Prompts de la sesión

Los siguientes son los mensajes que envié al agente, en orden cronológico. Se conserva el texto de cada solicitud; se omite el contexto automático del IDE.

## Prompt 1

```text
En este archivo prueba1_reservas_diaz, en specs\001-reservas-sala\spec.md, esta en sttus draft, entonces agrega 3 escenario mas de acceptance scenarios, puede ser uno como, si ya esta reservada, sale un mensaje de error diciendo que no se puede, y que reserve en un horario disponible, el segundo puede ser dado que elijo como inicio las 10:00 y como fin las 10:00, cuando intento reservar, entonces sale "La hora de inicio no puede ser la misma que la hora de fin", y el tercero dado que elijo una sala y sus horas estan correctas pero todas estan llenas, cuando intento reservar, entonces sale un mensaje" no hay salas disponibles"
```

## Prompt 2

```text
hola
```

## Prompt 3

```text
ademas en edge cases puedes poner como respuesta a ¿Qué pasa si la sala ya está ocupada en ese horario?, que pasa a revisar otras salas hasta que encuentre una que este disponible, si no, puedes poner un mensaje que diga, las salas estan llenas, como en el caso 3 que te die antes
```

## Prompt 4

```text
que crees que hay que poner en requirements?
```

## Prompt 5

```text
okok puedes poner esas en requirements? otra cosa, si estan losacceptance scenarios que te dije?
```

## Prompt 6

```text
Puedes hacer un primer commit de la spec, simplemente poniendo tipo cambios en spec o algo asi, ademas puedes ver si hay una prueba que falla? no la corrijas hasta que te diga
```

## Prompt 7

```text
Verifica que en lib/domain/crear_reserva.dart` y sus pruebas en `test/` | La regla se cumple en todos los casos que la regla implica, no solo en los escenarios que escribiste. El mismo mensaje en la spec, en la prueba y en el código.
```

## Prompt 8

```text
si hay un error en una prueba haz un commit, no importa que sea error solo mandalo el commit
```

## Prompt 9

```text
en respuestas md, puedes poner esto Tres secciones con estos títulos exactos: \`## Escenarios que elegí y por qué\`, \`## Riesgo más grave del repositorio\`, \`## ¿La regla protege la app real?\`. Cada afirmación cita la evidencia como \`ruta:línea\` (por ejemplo, \`lib/domain/crear_reserva.dart:12\`) y explica qué muestra esa línea. Extensión recomendada: hasta **\*\*400 palabras\*\*** en total.
```

## Prompt 10

```text
ahora verifica de nuevo las pruebas, si no pasa una arreglala y haz un commit cuando ya sirva
```

## Prompt 11

```text
\`prompts.md\`, en la raíz del repositorio (lo creas tú), y \`sesion-<apellido>.zip\`, **\*\*fuera\*\*** del repositorio | En \`prompts.md\`, los prompts que le diste al agente, en orden, copiados tal cual. El \`.zip\` tiene los archivos de sesión de Codex de la prueba (ver abajo). **\*\*El \`.zip\` no se sube a GitHub\*\***: solo al aula virtual. |
```

## Prompt 12

```text
Esta instruccion que quiere decir?
```

## Prompt 13

```text
puedes crear el prompts.md y hacer lo que pide ahi
```

## Prompt 14

```text
puedes crear el prompts.md y hacer lo que pide ahi
```

## Prompt 15

````text
puedes verificar si esto esta bie? | 1 | `specs/001-reservas-sala/spec.md` | Describe solo el QUÉ: sin widgets, `setState`, paquetes ni carpetas. Tiene **al menos tres escenarios nuevos**, en Dado/Cuando/Entonces, dedicados a la regla de solapamiento: los que consideres necesarios para que la regla no quede ambigua. Los dos escenarios que la spec ya trae no cuentan. Fija un mensaje de rechazo exacto. |
\| 2 | Historial de git | Demuestra este orden: primero la spec, después una prueba que falla, después el código que la hace pasar. Como mínimo, **tres commits separados**: uno con la spec, otro con la prueba en rojo y otro con el código en verde. Puedes hacer más commits, pero esos tres momentos no se mezclan en un mismo commit. Las aserciones de ese commit de la prueba siguen iguales en el commit final. Un error de compilación no cuenta como falla de la prueba. |
\| 3 | `lib/domain/crear_reserva.dart` y sus pruebas en `test/` | La regla se cumple en todos los casos que la regla implica, no solo en los escenarios que escribiste. El mismo mensaje en la spec, en la prueba y en el código. |
````

## Prompt 16

```text
puedes solucionar eso
```

## Prompt 17

````text
en el respuestas.md no incluyas citas, si este y promts ya estan bien, haz un ultimo commit, y Sube la rama: `git push -u origin prueba/solapamiento`.
3. En **tu** repositorio de GitHub, abre un pull request de `prueba/solapamiento` hacia `main`.
   No hagas merge.
4. Genera el archivo de entrega. En la raíz de tu repositorio, cambia `<apellido>` por tu
   apellido (por ejemplo, `prueba1-perez.bundle`):
   ```bash
   git bundle create prueba1-<apellido>.bundle --all
   ```
   Ese archivo guarda tu repositorio completo, con todo el historial de commits. **No lo agregues
   a git**: es lo último que haces.
5. Genera `sesion-<apellido>.zip` (ver "Cómo guardar la sesión de Codex").
6. Antes de que termine la hora, sube al aula virtual **los dos archivos**, el `.bundle` y el
   `.zip`, y pega en el comentario el enlace de tu repositorio.
````

## Prompt 18

````text
en el respuestas.md no incluyas citas, si este y promts ya estan bien, haz un ultimo commit, y Sube la rama: \`git push -u origin prueba/solapamiento\`.\
3\. En **\*\*tu\*\*** repositorio de GitHub, abre un pull request de \`prueba/solapamiento\` hacia \`main\`.\
   No hagas merge.\
4\. Genera el archivo de entrega. En la raíz de tu repositorio, cambia \`\<apellido>\` por tu\
   apellido (por ejemplo, \`prueba1-perez.bundle\`):
   \`\`\`bash\
   git bundle create prueba1-\<apellido>.bundle --all\
   \`\`\`
   Ese archivo guarda tu repositorio completo, con todo el historial de commits. \*\*No lo agregues\
   a git\*\*: es lo último que haces.\
5\. Genera \`sesion-\<apellido>.zip\` (ver "Cómo guardar la sesión de Codex").\
6\. Antes de que termine la hora, sube al aula virtual **\*\*los dos archivos\*\***, el \`.bundle\` y el\
   \`.zip\`, y pega en el comentario el enlace de tu repositorio.
````
