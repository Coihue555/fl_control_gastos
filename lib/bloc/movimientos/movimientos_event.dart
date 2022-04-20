part of 'movimientos_bloc.dart';

@immutable
abstract class MovimientosEvent {
  
}

class GetMovimientosList extends MovimientosEvent{
  GetMovimientosList();
}

class NewMovimiento extends MovimientosEvent{
NewMovimiento();
}

class UpdateMovimiento extends MovimientosEvent{
  final int id;
  UpdateMovimiento(this.id);
}

class GuardarMovimiento extends MovimientosEvent{
  GuardarMovimiento();
}

class ValidateMovimiento extends MovimientosEvent{
  final String categoria;
  final String cuenta;
  final String fecha;
  final String descripcion;
  final double valor;
  
  ValidateMovimiento(this.categoria, this.cuenta, this.fecha, this.descripcion, this.valor);
}

class DeleteMovimiento extends MovimientosEvent{
  final int id;
  DeleteMovimiento(this.id);
}