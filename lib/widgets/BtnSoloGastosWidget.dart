import 'package:fl_control_gastos/bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BtnTipoCuentasWidget extends StatelessWidget{

  int tipo;

  BtnTipoCuentasWidget({
    Key? key,
    required this.tipo
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        child: ( tipo==1 ) ? const Text('Solo Gastos') : const Text('Solo Ingresos'),
        onPressed: (){
          context.read<MovimientosBloc>().add(SoloGastos(tipo));
        },
      ),
    );
  }
}