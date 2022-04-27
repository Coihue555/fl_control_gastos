import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:fl_control_gastos/db/db.dart';

part 'movimientos_event.dart';
part 'movimientos_state.dart';

class MovimientosBloc extends Bloc<MovimientosEvent, MovimientosState> {
  MovimientosBloc() : super(MovimientosState()) {
    on<GetMovimientosList>(_getMovimientosList);
    on<NewMovimiento>(_newMovimiento);
    on<GuardarMovimiento>(_guardarMovimiento);
    on<UpdateMovimiento>(_updateMovimiento);
    on<ValidateMovimiento>(_validateMovimiento);
    on<DeleteMovimiento>(_deleteMovimiento);
    on<SoloGastos>(_soloGastos);
  }
  Future<void> _guardarMovimiento(GuardarMovimiento event, Emitter emit) async {
    emit(state.copyWith( isWorking: true, error: '', accion: 'GuardarMovimiento', ));
    
    //Guardar nuevo o Modificacion
   final idMovimiento =( state.movimiento.id == null)
      ?  await DBProvider.db.nuevoDato(state.movimiento)
      : await DBProvider.db.updateDato(state.movimiento);

    String error = '';
    List<MovimientosModel> lista = state.lista;

    if (idMovimiento < 1) {
      error = 'No se pudo guardar el registro';
    }
    if (error.isEmpty) {
      lista = await DBProvider.db.getTodos();
    }
    emit(state.copyWith( isWorking: false, accion: 'GuardarMovimiento', error: error, lista: lista ));
  }

  Future<void> _getMovimientosList(GetMovimientosList event, Emitter emit) async {
    emit(state.copyWith(
      isWorking: true,
      accion: 'GetMovimientosList',
      lista: [],
      error: '',
      movimiento: MovimientosModel(categoria: '', cuenta: '', fecha: ''),
    ));
    final List<MovimientosModel> lst = await DBProvider.db.getTodos();
    emit(state.copyWith(
      lista: lst,
      accion: 'GetMovimientosList',
      error: '',
      isWorking: false,
    ));
  }

    Future<void> _soloGastos(SoloGastos event, Emitter emit) async {
    emit(state.copyWith(
      isWorking: true,
      accion: 'SoloGastos',
      lista: [],
      error: '',
      movimiento: MovimientosModel(categoria: '', cuenta: '', fecha: ''),
    ));
    final List<MovimientosModel> lst = await DBProvider.db.isGasto();
    emit(state.copyWith(
      lista: lst,
      accion: 'SoloGastos',
      error: '',
      isWorking: false,
    ));
  }

  Future<void> _newMovimiento(NewMovimiento event, Emitter emit) async {
    emit(state.copyWith(
        isWorking: false, accion: 'NewMovimiento', movimiento: MovimientosModel(categoria: '', fecha: '', cuenta: ''), error: ''));
  }

  Future<void> _updateMovimiento(UpdateMovimiento event, Emitter emit) async {
    emit(state.copyWith(isWorking: true, accion: 'UpdateMovimiento', error: ''));
    
    final MovimientosModel modelo = await DBProvider.db.getDatosById(event.id);    

    emit(state.copyWith(
        isWorking: false, accion: 'UpdateMovimiento', movimiento: modelo, error: ''));
  }

  Future<void> _validateMovimiento(ValidateMovimiento event, Emitter emit) async {
    emit(state.copyWith(isWorking: true, accion: 'ValidateMovimiento', error: ''));
    String error = '';
    final MovimientosModel modelo = state.movimiento;

    if (event.descripcion == ''){ error = 'Debe ingresar una Descripcion'; }
    if (event.valor == 0.0)     { error = 'Debe ingresar un Valor'; }
    if (event.fecha == '')      { error = 'Debe ingresar una Fecha'; }
    if (event.cuenta == '')     { error = 'Debe ingresar una Cuenta'; }
    if (event.categoria == '')  { error = 'Debe ingresar una Categoria'; }


    if (error.isEmpty) {
     
        modelo.categoria = event.categoria;
        modelo.descripcion = event.descripcion;
        modelo.cuenta = event.cuenta;
        modelo.fecha = event.fecha;
        modelo.valor = event.valor;
      
    }

    

    emit(state.copyWith(
      isWorking: false,
      accion: 'ValidateMovimiento',
      movimiento: modelo,
      error: error,
    ));
  }

  Future<void> _deleteMovimiento(DeleteMovimiento event, Emitter emit) async {
    emit(state.copyWith(isWorking: true, accion: 'DeleteMovimiento', error: ''));
    await DBProvider.db.deleteItem('transacciones', event.id);

    // final List<MovimientosModel> lst = await DBProvider.db.getTodos();

    emit(state.copyWith(
        isWorking: false,
        accion: 'DeleteMovimiento',
        lista: state.lista.where((e) => e.id != event.id).toList(),
        error: ''));
  }
}
