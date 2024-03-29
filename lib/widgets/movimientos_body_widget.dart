import 'dart:developer';
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
        if (state.accion == 'NewMovimiento' || state.accion == 'UpdateMovimiento') {
          Navigator.pushNamed(context, 'MovimientosFicha');
          log('======>Navigator.pushNamed(context, movimientosFicha)');
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
        return Column(
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Expanded(child: BtnTipoCuentasWidget(tipo: 1)), Expanded(child: BtnTipoCuentasWidget(tipo: 0)), BtnRefreshMovWidget()],
            ),
            (state.lista.isNotEmpty)
                ? Expanded(child: Listado(lista: state.lista))
                : const Center(
                    heightFactor: 30,
                    child: Text('Aun no hay Movimientos cargados'),
                  )
          ],
        );
      },
    );
  }
}
