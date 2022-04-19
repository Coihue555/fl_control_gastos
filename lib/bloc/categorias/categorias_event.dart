part of 'categorias_bloc.dart';

@immutable
abstract class CategoriasEvent {
  
}

class GetCategoriaList extends CategoriasEvent{
  GetCategoriaList();
}

class NewCategoria extends CategoriasEvent{
NewCategoria();
}

class UpdateCategoria extends CategoriasEvent{
  final int id;
  UpdateCategoria(this.id);
}

class GuardarCategoria extends CategoriasEvent{
  GuardarCategoria();
}

class ValidateCategoria extends CategoriasEvent{
  final String nombreCategoria;
  final String tipoCategoria;
  
  ValidateCategoria(this.nombreCategoria, this.tipoCategoria);
}

class DeleteCategoria extends CategoriasEvent{
  final int id;
  DeleteCategoria(this.id);
}