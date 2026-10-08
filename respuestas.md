## Escenarios que elegí y por qué

- El solapamiento parcial activa la búsqueda alternativa en `specs/001-reservas-sala/spec.md:24`; `test/crear_reserva_test.dart:86` comprueba el caso al inicio del intervalo y `test/crear_reserva_test.dart:90` el caso al final. Los elegí para cubrir ambos límites de una reserva conflictiva.
- La reserva existente que contiene el horario se especifica en `specs/001-reservas-sala/spec.md:27` y se prueba en `test/crear_reserva_test.dart:94`; comprueba que el sistema no acepte un intervalo ocupado por completo.
- El rechazo cuando todas las salas se solapan aparece en `specs/001-reservas-sala/spec.md:33`; `test/crear_reserva_test.dart:160` prepara todas las salas ocupadas y `test/crear_reserva_test.dart:181` verifica «No hay salas disponibles».

## Riesgo más grave del repositorio

- La protección ante carreras depende de ejecutar la migración: `supabase/migracion.sql:2` indica que se debe ejecutar en Supabase y `supabase/migracion.sql:24` a `supabase/migracion.sql:29` agrega la restricción contra intervalos solapados. Si no se aplica, la base real no tendrá esa defensa.
- Las pruebas usan un repositorio en memoria: `test/support/reservas_en_memoria.dart:4` lo identifica como falso y `test/crear_reserva_test.dart:185` simula una colisión. Esto prueba el reintento del dominio, no la instalación real de la restricción en PostgreSQL.

## ¿La regla protege la app real?

- El formulario llama al caso de uso en `lib/presentation/reserva_page.dart:61`; `lib/main.dart:13` crea el repositorio Supabase y `lib/main.dart:15` lo conecta con la aplicación. El repositorio traduce el error de exclusión en `lib/data/supabase_reservas_repository.dart:31` y `lib/data/supabase_reservas_repository.dart:33`; el dominio busca la siguiente sala en `lib/domain/crear_reserva.dart:47`.
- Con la migración aplicada, PostgreSQL impide el solapamiento concurrente en `supabase/migracion.sql:25` a `supabase/migracion.sql:29`. La migración aún debe ejecutarse en el proyecto Supabase para activar esa protección.
