part of 'categorias_bloc.dart';

@immutable
class CategoriasState {
  final bool isWorking;
  final CategoriaModel categoria;
  final List<CategoriaModel> lista;
  final String error;
  final String accion;

  CategoriasState(
      {this.isWorking = false,
      CategoriaModel? categoria,
      List<CategoriaModel>? lista,
      this.error = '',
      this.accion = ''})
      : lista = lista ?? [],
        categoria = categoria ?? CategoriaModel(nombreCategoria: '', esGasto: 1);

  CategoriasState copyWith({
    final bool? isWorking,
    final CategoriaModel? categoria,
    final List<CategoriaModel>? lista,
    final String? error,
    final String? accion,
  }) =>
      CategoriasState(
          isWorking: isWorking ?? this.isWorking,
          categoria: categoria ?? this.categoria,
          lista: lista ?? this.lista,
          error: error ?? this.error,
          accion: accion ?? this.accion);
}