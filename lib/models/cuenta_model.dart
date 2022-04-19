class CuentaModel {
  int? id;
  String nombreCuenta;
  String tipoCuenta;

  CuentaModel({
    this.id,
    required this.nombreCuenta,
    required this.tipoCuenta
    });

  CuentaModel copyWith({
    int? id,
    String nombreCuenta = '',
    String tipoCuenta = '',
  }) =>
      CuentaModel(
          id: id ?? this.id,
          nombreCuenta: nombreCuenta,
          tipoCuenta: tipoCuenta,
          );

  factory CuentaModel.fromJson(Map<String, dynamic> json) => CuentaModel(
        id: json["id"],
        nombreCuenta: json["nombreCuenta"],
        tipoCuenta: json["tipoCuenta"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "nombreCuenta": nombreCuenta, "tipoCuenta": tipoCuenta};
}
