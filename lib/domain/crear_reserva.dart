import 'reserva.dart';
import 'reservas_repository.dart';

class CrearReserva {
  CrearReserva(
    this.repositorio, {
    this.salas = const ['Sala A', 'Sala B', 'Sala C'],
  }) : assert(salas.isNotEmpty);

  final ReservasRepository repositorio;
  final List<String> salas;

  Future<ResultadoReserva> call(SolicitudReserva solicitud) async {
    if (solicitud.fin.isAtSameMomentAs(solicitud.inicio)) {
      return ResultadoReserva.rechazada(
        'La hora de inicio no puede ser la misma que la hora de fin',
      );
    }
    if (!solicitud.fin.isAfter(solicitud.inicio)) {
      return ResultadoReserva.rechazada(
        'La hora de fin debe ser posterior a la de inicio',
      );
    }

    final candidatas = <String>[
      solicitud.salaId,
      ...salas.where((salaId) => salaId != solicitud.salaId),
    ];

    for (final salaId in candidatas) {
      final reservas = await repositorio.reservasDeSala(salaId);
      final ocupada = reservas.any((reserva) =>
          solicitud.inicio.isBefore(reserva.fin) &&
          solicitud.fin.isAfter(reserva.inicio));
      if (ocupada) {
        continue;
      }

      final reserva = await repositorio.guardar(SolicitudReserva(
        salaId: salaId,
        usuarioId: solicitud.usuarioId,
        inicio: solicitud.inicio,
        fin: solicitud.fin,
      ));
      return ResultadoReserva.aceptada(reserva);
    }

    return ResultadoReserva.rechazada('No hay salas disponibles');
  }
}
