part of 'cuentas_bloc.dart';

@immutable
abstract class CuentasEvent {
  
}

class GetCuentasList extends CuentasEvent{
  GetCuentasList();
}

class NewCuenta extends CuentasEvent{
NewCuenta();
}

class UpdateCuenta extends CuentasEvent{
  final int id;
  UpdateCuenta(this.id);
}

class GuardarCuenta extends CuentasEvent{
  GuardarCuenta();
}

class ValidateCuenta extends CuentasEvent{
  final String nombreCuenta;
  
  ValidateCuenta(this.nombreCuenta);
}

class DeleteCuenta extends CuentasEvent{
  final int id;
  DeleteCuenta(this.id);
}