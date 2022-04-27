
class CategoriaModel {
  int? id;
  String nombreCategoria;
  int esGasto;

  CategoriaModel({
    this.id,
    required this.nombreCategoria,
    required this.esGasto
    });

  CategoriaModel copyWith({
    int? id,
    String nombreCategoria = '',
    int esGasto = 1,
  }) =>
      CategoriaModel(
          id: id ?? this.id,
          nombreCategoria: nombreCategoria,
          esGasto: esGasto,
          );

  factory CategoriaModel.fromJson(Map<String, dynamic> json) => CategoriaModel(
        id: json["id"],
        nombreCategoria: json["nombreCategoria"],
        esGasto: json["esGasto"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "nombreCategoria": nombreCategoria, "esGasto": esGasto};
}
