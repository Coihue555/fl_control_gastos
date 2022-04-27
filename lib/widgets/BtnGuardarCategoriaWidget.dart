import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/bloc/blocs.dart';

class btnGuardarCatFicha extends StatelessWidget {
  btnGuardarCatFicha({
    Key? key,
    required this.nombreCategoria,
    required this.esGasto,
  }) : super(key: key);

  String nombreCategoria;
  bool esGasto;

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
        final catState = BlocProvider.of<CategoriasBloc>(context).state.categoria;
        if(nombreCategoria.isEmpty) {nombreCategoria = catState.nombreCategoria;}
        if(esGasto) {esGasto = (catState.esGasto);}
                        
        context
            .read<CategoriasBloc>()
            .add(ValidateCategoria(nombreCategoria, esGasto));
      }
    );
  }
}