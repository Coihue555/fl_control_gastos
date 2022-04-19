class CuentaModel {
  int? id;
  String nombreCuenta;

  CuentaModel({
    this.id,
    required this.nombreCuenta,
    });

  CuentaModel copyWith({
    int? id,
    String nombreCuenta = '',
  }) =>
      CuentaModel(
          id: id ?? this.id,
          nombreCuenta: nombreCuenta,
          );

  factory CuentaModel.fromJson(Map<String, dynamic> json) => CuentaModel(
        id: json["id"],
        nombreCuenta: json["nombreCuenta"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "nombreCuenta": nombreCuenta,};
}
