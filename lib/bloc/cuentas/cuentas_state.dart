part of 'cuentas_bloc.dart';

@immutable
class CuentasState {
  final bool isWorking;
  final CuentaModel cuenta;
  final List<CuentaModel> lista;
  final String error;
  final String accion;

  CuentasState(
      {this.isWorking = false,
      CuentaModel? cuenta,
      List<CuentaModel>? lista,
      this.error = '',
      this.accion = ''})
      : lista = lista ?? [],
        cuenta = cuenta ?? CuentaModel(nombreCuenta: '',);

  CuentasState copyWith({
    final bool? isWorking,
    final CuentaModel? cuenta,
    final List<CuentaModel>? lista,
    final String? error,
    final String? accion,
  }) =>
      CuentasState(
          isWorking: isWorking ?? this.isWorking,
          cuenta: cuenta ?? this.cuenta,
          lista: lista ?? this.lista,
          error: error ?? this.error,
          accion: accion ?? this.accion);
}