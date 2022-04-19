class CategoriaModel {
  int? id;
  String nombreCategoria;
  String tipoCategoria;

  CategoriaModel({
    this.id,
    required this.nombreCategoria,
    required this.tipoCategoria
    });

  CategoriaModel copyWith({
    int? id,
    String nombreCategoria = '',
    String tipoCategoria = '',
  }) =>
      CategoriaModel(
          id: id ?? this.id,
          nombreCategoria: nombreCategoria,
          tipoCategoria: tipoCategoria,
          );

  factory CategoriaModel.fromJson(Map<String, dynamic> json) => CategoriaModel(
        id: json["id"],
        nombreCategoria: json["nombreCategoria"],
        tipoCategoria: json["tipoCategoria"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "nombreCategoria": nombreCategoria, "tipoCategoria": tipoCategoria};
}
