# Feature Specification: Reservas de sala

**Feature Branch**: `001-reservas-sala`
**Created**: 2026-10-01
**Status**: Draft

## User Scenarios & Testing

### User Story 1 — Reservar una sala (Priority: P1)

Como estudiante autenticado, quiero reservar una sala de estudio por un intervalo de tiempo
para tener dónde trabajar con mi grupo.

**Why this priority**: sin reservas, la app no tiene propósito.

**Independent Test**: se puede probar creando una reserva y comprobando que queda registrada.

**Acceptance Scenarios**:

1. **Dado** que la sala A está libre, **Cuando** la reservo de 09:00 a 10:00, **Entonces** la
   reserva queda registrada a mi nombre.
2. **Dado** que elijo como inicio las 10:00 y como fin las 09:00, **Cuando** intento reservar,
   **Entonces** la reserva se rechaza con el mensaje «La hora de fin debe ser posterior a la de inicio».
3. **Dado** que la sala A tiene una reserva de 09:00 a 10:00 y la sala B está libre, **Cuando**
   solicito la sala A de 09:30 a 10:30, **Entonces** el sistema asigna la sala B para ese intervalo
   e informa cuál sala quedó reservada.
4. **Dado** que la sala A tiene una reserva de 08:00 a 11:00 y la sala B está libre, **Cuando**
   solicito la sala A de 09:00 a 10:00, **Entonces** el sistema considera ocupado el intervalo y
   asigna la sala B.
5. **Dado** que la sala A tiene una reserva de 09:00 a 10:00, **Cuando** solicito la sala A de
   10:00 a 11:00, **Entonces** el sistema permite reservar la sala A porque los intervalos solo
   coinciden en el límite.
6. **Dado** que todas las salas tienen una reserva que se solapa con el intervalo solicitado,
   **Cuando** intento reservar, **Entonces** el sistema rechaza la solicitud con el mensaje exacto
   «No hay salas disponibles».
7. **Dado** que elijo las 10:00 como hora de inicio y las 10:00 como hora de fin, **Cuando**
   intento reservar, **Entonces** se rechaza con el mensaje «La hora de inicio no puede ser la
   misma que la hora de fin».

### Edge Cases

- Si la sala elegida ya está ocupada, el sistema busca otra sala disponible para la misma fecha y
  horario; si ninguna está libre, rechaza la solicitud con «No hay salas disponibles».

## Requirements

- **FR-001**: El estudiante puede elegir la fecha, la sala y las horas de inicio y fin.
- **FR-002**: La hora de fin debe ser posterior a la hora de inicio; si ambas horas son iguales, el
  sistema muestra «La hora de inicio no puede ser la misma que la hora de fin».
- **FR-003**: Dos reservas de la misma sala no pueden ocupar intervalos que se solapen. Si una
  reserva termina justo cuando comienza otra, los intervalos no se solapan.
- **FR-004**: Si la sala elegida está ocupada durante parte o todo el intervalo, el sistema busca
  otra sala disponible para la misma fecha y horario, la asigna e informa cuál es.
- **FR-005**: Si ninguna sala está disponible para todo el intervalo, el sistema rechaza la
  solicitud con el mensaje exacto «No hay salas disponibles».
- **FR-006**: Al confirmar una reserva, el sistema informa la sala y el horario asignados.

### Key Entities

- **Reserva**: sala, estudiante, fecha, hora de inicio y hora de fin.
- **Sala**: espacio que puede reservarse por un intervalo de tiempo.

## Success Criteria

- **SC-001**: Un estudiante completa una reserva en menos de 30 segundos.
