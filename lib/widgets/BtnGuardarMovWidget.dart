import 'package:fl_control_gastos/bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BtnGuardarMovWidget extends StatelessWidget {
  BtnGuardarMovWidget({
    Key? key,
    required this.dropdownCategoria,
    required this.dropdownCuenta,
    required this.dateinput,
    required this.spDescripcion,
    required this.spValor,
  }) : super(key: key);

  String dropdownCategoria;
  String dropdownCuenta;
  TextEditingController dateinput;
  String spDescripcion;
  double spValor;

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
        final movState = BlocProvider.of<MovimientosBloc>(context).state.movimiento;

        if(dropdownCategoria.isEmpty) {dropdownCategoria  = movState.categoria;}
        if(dropdownCuenta.isEmpty)    {dropdownCuenta     = movState.cuenta;}
        if(dateinput.text.isEmpty)    {dateinput.text     = movState.fecha;}
        if(spDescripcion.isEmpty)     {spDescripcion      = movState.descripcion;}
        if(spValor == 0.0)            {spValor            = movState.valor;}


        context
          .read<MovimientosBloc>()
          .add(ValidateMovimiento(dropdownCategoria, dropdownCuenta, dateinput.text, spDescripcion, spValor));
      }
    );
  }
}