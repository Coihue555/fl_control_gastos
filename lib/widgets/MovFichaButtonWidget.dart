import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/blocs.dart';

class MovFichaButtonWidget extends StatelessWidget {
  const MovFichaButtonWidget({
    Key? key,
    required this.dropdownCategoria,
    required this.dropdownCuenta,
    required this.dateinput,
    required this.spDescripcion,
    required this.spValor,
  }) : super(key: key);

  final String dropdownCategoria;
  final String dropdownCuenta;
  final TextEditingController dateinput;
  final String spDescripcion;
  final double spValor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black.withOpacity(0.05)),
      ),
      child: const SizedBox(
        width: double.infinity,
        child: Center(child: Text('Guardar'))
      ),
      onPressed: () {
        context
          .read<MovimientosBloc>()
          .add(ValidateMovimiento(dropdownCategoria, dropdownCuenta, dateinput.text, spDescripcion, spValor));
      }
    );
  }
}