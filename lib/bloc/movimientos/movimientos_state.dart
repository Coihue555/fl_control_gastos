part of 'movimientos_bloc.dart';

@immutable
class MovimientosState {
  final bool isWorking;
  final MovimientosModel movimiento;
  final List<MovimientosModel> lista;
  final String error;
  final String accion;

  MovimientosState(
      {this.isWorking = false,
      MovimientosModel? movimiento,
      List<MovimientosModel>? lista,
      this.error = '',
      this.accion = ''})
      : lista = lista ?? [],
        movimiento = movimiento ?? MovimientosModel(categoria: '', cuenta: '');

  MovimientosState copyWith({
    final bool? isWorking,
    final MovimientosModel? movimiento,
    final List<MovimientosModel>? lista,
    final String? error,
    final String? accion,
  }) =>
      MovimientosState(
          isWorking: isWorking ?? this.isWorking,
          movimiento: movimiento ?? this.movimiento,
          lista: lista ?? this.lista,
          error: error ?? this.error,
          accion: accion ?? this.accion);
}
