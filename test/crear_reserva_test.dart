import 'package:flutter_test/flutter_test.dart';
import 'package:reservas_sala/domain/crear_reserva.dart';
import 'package:reservas_sala/domain/reserva.dart';

import 'support/reservas_en_memoria.dart';

DateTime hora(int h, [int m = 0]) => DateTime(2026, 10, 14, h, m);
const salas = ['Sala A', 'Sala B', 'Sala C'];

void main() {
  late ReservasEnMemoria repositorio;
  late CrearReserva crearReserva;

  setUp(() {
    repositorio = ReservasEnMemoria();
    crearReserva = CrearReserva(repositorio);
  });

  test('acepta una reserva válida y la guarda', () async {
    final resultado = await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u1',
      inicio: hora(9),
      fin: hora(10),
    ));

    expect(resultado.aceptada, isTrue);
    expect(repositorio.reservas, hasLength(1));
  });

  test('rechaza una reserva cuyo fin no es posterior al inicio', () async {
    final resultado = await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u1',
      inicio: hora(10),
      fin: hora(9),
    ));

    expect(resultado.aceptada, isFalse);
    expect(
        resultado.mensaje, 'La hora de fin debe ser posterior a la de inicio');
    expect(repositorio.reservas, isEmpty);
  });

  test('rechaza horas iguales con el mensaje de la especificacion', () async {
    final resultado = await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u1',
      inicio: hora(10),
      fin: hora(10),
    ));

    expect(resultado.aceptada, isFalse);
    expect(
      resultado.mensaje,
      'La hora de inicio no puede ser la misma que la hora de fin',
    );
    expect(repositorio.reservas, isEmpty);
  });

  Future<void> verificaSalaAlternativa(
    DateTime inicioExistente,
    DateTime finExistente,
  ) async {
    repositorio.reservas.add(Reserva(
      id: 'ocupada',
      salaId: 'Sala A',
      usuarioId: 'u0',
      inicio: inicioExistente,
      fin: finExistente,
    ));

    final resultado = await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u1',
      inicio: hora(9),
      fin: hora(10),
    ));

    expect(resultado.aceptada, isTrue);
    expect(resultado.reserva?.salaId, 'Sala B');
    expect(repositorio.reservas.last.salaId, 'Sala B');
  }

  test('busca otra sala si la reserva existente se solapa al inicio', () async {
    await verificaSalaAlternativa(hora(8, 30), hora(9, 30));
  });

  test('busca otra sala si la reserva existente se solapa al final', () async {
    await verificaSalaAlternativa(hora(9, 30), hora(10, 30));
  });

  test('busca otra sala si la reserva existente contiene el horario', () async {
    await verificaSalaAlternativa(hora(8), hora(11));
  });

  test('continua buscando hasta encontrar la ultima sala disponible', () async {
    for (final salaId in salas.take(2)) {
      repositorio.reservas.add(Reserva(
        id: 'ocupada-$salaId',
        salaId: salaId,
        usuarioId: 'u0',
        inicio: hora(9),
        fin: hora(10),
      ));
    }

    final resultado = await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u1',
      inicio: hora(9),
      fin: hora(10),
    ));

    expect(resultado.aceptada, isTrue);
    expect(resultado.reserva?.salaId, 'Sala C');
  });

  test('permite reservas consecutivas sin solapamiento', () async {
    repositorio.reservas.add(Reserva(
      id: 'anterior',
      salaId: 'Sala A',
      usuarioId: 'u0',
      inicio: hora(9),
      fin: hora(10),
    ));

    final resultado = await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u1',
      inicio: hora(10),
      fin: hora(11),
    ));

    expect(resultado.aceptada, isTrue);
    expect(resultado.reserva?.salaId, 'Sala A');
  });

  test('una reserva de otra fecha no bloquea el horario', () async {
    repositorio.reservas.add(Reserva(
      id: 'otro-dia',
      salaId: 'Sala A',
      usuarioId: 'u0',
      inicio: DateTime(2026, 10, 14, 9),
      fin: DateTime(2026, 10, 14, 10),
    ));

    final resultado = await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u1',
      inicio: DateTime(2026, 10, 15, 9),
      fin: DateTime(2026, 10, 15, 10),
    ));

    expect(resultado.aceptada, isTrue);
    expect(resultado.reserva?.salaId, 'Sala A');
  });

  test(
      'rechaza y muestra el mensaje de la especificacion si todas estan ocupadas',
      () async {
    for (var i = 0; i < salas.length; i++) {
      repositorio.reservas.add(Reserva(
        id: 'ocupada-$i',
        salaId: salas[i],
        usuarioId: 'u0',
        inicio: hora(9),
        fin: hora(10),
      ));
    }

    final resultado = await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u1',
      inicio: hora(9, 30),
      fin: hora(10, 30),
    ));

    expect(resultado.aceptada, isFalse);
    expect(resultado.mensaje, 'No hay salas disponibles');
    expect(repositorio.reservas, hasLength(3));
  });
}
