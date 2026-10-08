## Escenarios que elegí y por qué

- Elegí los solapamientos parciales porque una reserva puede empezar antes o terminar después del horario solicitado; ambos casos deben hacer que el sistema busque otra sala.
- También incluí el caso en que una reserva existente contiene por completo el horario nuevo, para asegurar que ese intervalo se rechace como ocupado.
- El escenario en que todas las salas están ocupadas comprueba el resultado final de la búsqueda: mostrar «No hay salas disponibles».

## Riesgo más grave del repositorio

- La protección contra dos reservas concurrentes depende de aplicar la migración de base de datos en Supabase. Si no se ejecuta, la base real no tendrá la restricción que impide intervalos solapados.
- Las pruebas verifican la lógica del dominio con un repositorio en memoria y una colisión simulada; no comprueban una instalación real de PostgreSQL.

## ¿La regla protege la app real?

- Sí. El formulario usa el caso de uso de reservas, que intenta otras salas cuando encuentra un conflicto, y el repositorio Supabase convierte el rechazo por solapamiento en un conflicto que el dominio puede manejar.
- Para que la protección también cubra solicitudes simultáneas en la base real, hay que aplicar la migración en el proyecto Supabase.
