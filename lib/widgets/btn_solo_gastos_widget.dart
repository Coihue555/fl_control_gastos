// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fl_control_gastos/bloc/blocs.dart';

class BtnTipoCuentasWidget extends StatelessWidget {
  const BtnTipoCuentasWidget({
    Key? key,
    required this.tipo,
  }) : super(key: key);
  final int tipo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        child: (tipo == 1) ? const Text('Solo Gastos') : const Text('Solo Ingresos'),
        onPressed: () {
          context.read<MovimientosBloc>().add(SoloGastos(tipo));
        },
      ),
    );
  }
}
