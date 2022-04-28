import 'package:fl_control_gastos/bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BtnRefreshMovWidget extends StatelessWidget{

  BtnRefreshMovWidget({
    Key? key,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        child: const Icon(Icons.refresh),
        onPressed: (){
          context.read<MovimientosBloc>().add(GetMovimientosList());
        },
      ),
    );
  }
}