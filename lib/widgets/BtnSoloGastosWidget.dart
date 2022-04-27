import 'package:fl_control_gastos/bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BtnSoloGastosWidget extends StatelessWidget {
  const BtnSoloGastosWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Solo Gastos'),
      onPressed: (){
        context.read<MovimientosBloc>().add(SoloGastos());
      },
    );
  }
}