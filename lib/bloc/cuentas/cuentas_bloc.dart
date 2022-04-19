import 'package:bloc/bloc.dart';
import 'package:fl_control_gastos/db/db.dart';
import 'package:meta/meta.dart';

part 'cuentas_event.dart';
part 'cuentas_state.dart';

class CuentasBloc extends Bloc<CuentasEvent, CuentasState> {
  CuentasBloc() : super(CuentasState()) {
    on<GetCuentasList>(_getCuentasList);
    on<NewCuenta>(_newCuenta);
    on<GuardarCuenta>(_guardarCuenta);
    on<UpdateCuenta>(_updateCuenta);
    on<ValidateCuenta>(_validateCuenta);
    on<DeleteCuenta>(_deleteCuenta);
  }
  Future<void> _guardarCuenta(GuardarCuenta event, Emitter emit) async {
    emit(state.copyWith( isWorking: true, error: '', accion: 'GuardarCuenta', ));

    //Guardar nuevo o Modificacion
   final idCuenta =( state.cuenta.id == null)
      ?  await DBProvider.db.nuevaCuenta(state.cuenta)
      : await DBProvider.db.updateCuenta(state.cuenta);

    String error = '';
    List<CuentaModel> lista = state.lista;

    if (idCuenta < 1) {
      error = 'No se pudo guardar el registro';
    }
    if (error.isEmpty) {
      lista = await DBProvider.db.getCuentas();
    }
    emit(state.copyWith( isWorking: false, accion: 'GuardarCuenta', error: error, lista: lista ));
  }

  Future<void> _getCuentasList(GetCuentasList event, Emitter emit) async {
    emit(state.copyWith(
      isWorking: true,
      accion: 'GetCuentasList',
      lista: [],
      error: '',
      cuenta: CuentaModel(nombreCuenta: '', ),
    ));
    final List<CuentaModel> lst = await DBProvider.db.getCuentas();
    emit(state.copyWith(
      lista: lst,
      accion: 'GetCuentasList',
      error: '',
      isWorking: false,
    ));
  }

  Future<void> _newCuenta(NewCuenta event, Emitter emit) async {
    emit(state.copyWith(
        isWorking: false, accion: 'NewCuenta', cuenta: CuentaModel(nombreCuenta: ''), error: ''));
  }

  Future<void> _updateCuenta(UpdateCuenta event, Emitter emit) async {
    emit(state.copyWith(isWorking: true, accion: 'UpdateCuenta', error: ''));
    
    final CuentaModel cuenta = await DBProvider.db.getCuentaById(event.id);    

    emit(state.copyWith(
        isWorking: false, accion: 'UpdateCuenta', cuenta: cuenta, error: ''));
  }

  Future<void> _validateCuenta(ValidateCuenta event, Emitter emit) async {
    emit(state.copyWith(isWorking: true, accion: 'ValidateCuenta', error: ''));
    String error = '';
    final CuentaModel cuenta = state.cuenta;
    if (event.nombreCuenta.isEmpty) {
      error = 'Debe ingresar un nombre para la cuenta';
    }
    if (error.isEmpty) {
      if (event.nombreCuenta.length < 3) {
        error = 'El nombre debe ser mas largo';
      } 
    }
    cuenta.nombreCuenta = event.nombreCuenta;

    emit(state.copyWith(
      isWorking: false,
      accion: 'ValidateCuenta',
      cuenta: cuenta,
      error: error,
    ));
  }

  Future<void> _deleteCuenta(DeleteCuenta event, Emitter emit) async {
    emit(state.copyWith(isWorking: true, accion: 'DeleteCuenta', error: ''));
    await DBProvider.db.deleteCuenta(event.id);

    // final List<MovimientosModel> lst = await DBProvider.db.getTodos();

    emit(state.copyWith(
        isWorking: false,
        accion: 'DeleteCuenta',
        lista: state.lista.where((e) => e.id != event.id).toList(),
        error: ''));
  }
}
