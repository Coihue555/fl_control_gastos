class MovimientosModel {
  int? id;
  String categoria;
  String cuenta;
  String fecha;
  String descripcion;
  double valor;

  MovimientosModel({
    this.id,
    required this.categoria,
    required this.cuenta,
    required this.fecha,
    this.descripcion = '',
    this.valor = 0.0});

  MovimientosModel copyWith({
    int? id,
    String categoria = 'Comida',
    String cuenta = 'Efectivo',
    String fecha ='',
    String? descripcion,
    double? valor
  }) =>
      MovimientosModel(
          id: id ?? this.id,
          categoria: categoria,
          cuenta: cuenta,
          fecha: fecha,
          descripcion: descripcion ?? this.descripcion,
          valor: valor ?? this.valor);

  factory MovimientosModel.fromJson(Map<String, dynamic> json) => MovimientosModel(
        id: json["id"],
        categoria: json["categoria"],
        cuenta: json["cuenta"],
        fecha: json["fecha"],
        descripcion: json["descripcion"],
        valor: json["valor"]
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "categoria": categoria, "cuenta": cuenta, "fecha": fecha, "descripcion": descripcion, "valor": valor};
}
