class MovimientosModel {
  int? id;
  String categoria;
  String cuenta;
  String descripcion;
  double valor;

  MovimientosModel({
    this.id,
    required this.categoria,
    required this.cuenta,
    this.descripcion = '',
    this.valor = 0.0});

  MovimientosModel copyWith({
    int? id,
    String categoria = '',
    String cuenta = '',
    String? descripcion,
    double? valor
  }) =>
      MovimientosModel(
          id: id ?? this.id,
          categoria: categoria,
          cuenta: cuenta,
          descripcion: descripcion ?? this.descripcion,
          valor: valor ?? this.valor);

  factory MovimientosModel.fromJson(Map<String, dynamic> json) => MovimientosModel(
        id: json["id"],
        categoria: json["categoria"],
        cuenta: json["cuenta"],
        descripcion: json["descripcion"],
        valor: json["valor"]
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "categoria": categoria, "cuenta": cuenta, "descripcion": descripcion, "valor": valor};
}
