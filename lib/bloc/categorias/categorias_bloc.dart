import 'package:bloc/bloc.dart';
import 'package:fl_control_gastos/db/db.dart';
import 'package:meta/meta.dart';

part 'categorias_event.dart';
part 'categorias_state.dart';

class CategoriasBloc extends Bloc<CategoriasEvent, CategoriasState> {
  CategoriasBloc() : super(CategoriasState()) {
    on<GetCategoriaList>(_getCategoriasList);
    on<NewCategoria>(_newCategoria);
    on<GuardarCategoria>(_guardarCategoria);
    on<UpdateCategoria>(_updateCategoria);
    on<ValidateCategoria>(_validateCategoria);
    on<DeleteCategoria>(_deleteCategoria);
  }
  Future<void> _guardarCategoria(GuardarCategoria event, Emitter emit) async {
    emit(state.copyWith( isWorking: true, error: '', accion: 'GuardarCategoria', ));

    //Guardar nuevo o Modificacion
   final idCategoria =( state.categoria.id == null)
      ?  await DBProvider.db.nuevaCategoria(state.categoria)
      : await DBProvider.db.updateCategoria(state.categoria);

    String error = '';
    List<CategoriaModel> lista = state.lista;

    if (idCategoria < 1) {
      error = 'No se pudo guardar el registro';
    }
    if (error.isEmpty) {
      lista = await DBProvider.db.getCategorias();
    }
    emit(state.copyWith( isWorking: false, accion: 'GuardarCategoria', error: error, lista: lista ));
  }

  Future<void> _getCategoriasList(GetCategoriaList event, Emitter emit) async {
    emit(state.copyWith(
      isWorking: true,
      accion: 'GetCategoriasList',
      lista: [],
      error: '',
      categoria: CategoriaModel(nombreCategoria: '', tipoCategoria: '', ),
    ));
    final List<CategoriaModel> lst = await DBProvider.db.getCategorias();
    emit(state.copyWith(
      lista: lst,
      accion: 'GetCategoriaList',
      error: '',
      isWorking: false,
    ));
  }

  Future<void> _newCategoria(NewCategoria event, Emitter emit) async {
    emit(state.copyWith(
        isWorking: false, accion: 'NewCategoria', categoria: CategoriaModel(nombreCategoria: '', tipoCategoria: ''), error: ''));
  }

  Future<void> _updateCategoria(UpdateCategoria event, Emitter emit) async {
    emit(state.copyWith(isWorking: true, accion: 'UpdateCategoria', error: ''));
    
    final CategoriaModel categoria = await DBProvider.db.getCategoriaById(event.id);    

    emit(state.copyWith(
        isWorking: false, accion: 'UpdateCategoria', categoria: categoria, error: ''));
  }

  Future<void> _validateCategoria(ValidateCategoria event, Emitter emit) async {
    emit(state.copyWith(isWorking: true, accion: 'ValidateCategoria', error: ''));
    String error = '';
    final CategoriaModel categoria = state.categoria;
    if (event.nombreCategoria.isEmpty) {
      error = 'Debe ingresar un nombre para la categoria';
    }
    if (error.isEmpty) {
      if (event.nombreCategoria.length < 3) {
        error = 'El nombre debe ser mas largo';
      } else {
        categoria.tipoCategoria = event.tipoCategoria;
      }
    }

    emit(state.copyWith(
      isWorking: false,
      accion: 'ValidateCategoria',
      categoria: categoria,
      error: error,
    ));
  }

  Future<void> _deleteCategoria(DeleteCategoria event, Emitter emit) async {
    emit(state.copyWith(isWorking: true, accion: 'DeleteCategoria', error: ''));
    await DBProvider.db.deleteDato(event.id);

    // final List<MovimientosModel> lst = await DBProvider.db.getTodos();

    emit(state.copyWith(
        isWorking: false,
        accion: 'DeleteCategoria',
        lista: state.lista.where((e) => e.id != event.id).toList(),
        error: ''));
  }
}
