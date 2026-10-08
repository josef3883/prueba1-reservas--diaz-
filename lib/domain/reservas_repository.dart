import 'reserva.dart';

/// La base de datos rechazó la reserva porque otra solicitud ocupó el intervalo.
class ReservaSolapadaException implements Exception {
  const ReservaSolapadaException();
}

abstract class ReservasRepository {
  /// Todas las reservas registradas de una sala.
  Future<List<Reserva>> reservasDeSala(String salaId);

  /// Guarda la solicitud y devuelve la reserva creada.
  Future<Reserva> guardar(SolicitudReserva solicitud);
}
