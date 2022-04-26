import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/bloc/blocs.dart';
import 'package:fl_control_gastos/widgets/widgets.dart';

class MovBodyWidget extends StatelessWidget {
  const MovBodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovimientosBloc, MovimientosState>(
      listenWhen: (previous, current) => !current.isWorking,
      listener: (context, state) {
        if (state.accion == 'NewMovimiento' ||
            state.accion == 'UpdateMovimiento') {
          Navigator.pushNamed(context, 'MovimientosFicha');
        }
        if (state.accion == 'GuardarMovimiento' && state.error.isEmpty) {
          Navigator.pop(context);
        }
        if (state.error.isNotEmpty) {
            final snackBar = SnackBar(
            duration: const Duration(milliseconds: 500),
            content: Text(state.error),
            backgroundColor: Colors.red,
            action: SnackBarAction(            
                label: 'Ok',
                onPressed: () {},
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        if (state.accion == 'ValidateMovimiento' && state.error.isEmpty) {
          context.read<MovimientosBloc>().add(GuardarMovimiento());
        }
      },
      builder: (context, state) {
        if (state.lista.isNotEmpty) {
          return Listado(lista: state.lista);
        } else {
          return const Center(
            child: Text('Aun no hay Movimientos cargados'),
          );
        }
      },
    );
  }
}
