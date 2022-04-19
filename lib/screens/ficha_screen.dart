// ignore_for_file: avoid_print
import 'package:fl_control_gastos/widgets/custom_Dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/bloc/movimientos/movimientos_bloc.dart';

class FichaScreen extends StatefulWidget {
  @override
  State<FichaScreen> createState() => _FichaScreenState();
}

class _FichaScreenState extends State<FichaScreen> {
  @override
  Widget build(BuildContext context) {
    String spCategoria = '';
    String dropdownValue = 'Efectivo';
    String spDescripcion = '';
    double spValor = 0.0;

    return BlocListener<MovimientosBloc, MovimientosState>(
      listenWhen: (previous, current) => !current.isWorking,
      listener: (context, state) {
        if (state.accion == 'GuardarMovimiento' && state.error.isEmpty) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Nueva transaccion'),
          ),
          body: SingleChildScrollView(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: BlocBuilder<MovimientosBloc, MovimientosState>(
                    builder: (context, state) {
                      return Form(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        labelText: 'Categoria',
                                      ),
                                      initialValue: state.movimiento.categoria,
                                      onChanged: (value) {
                                        spCategoria = value;
                                      },
                                    ),


                                    DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      underline: Container(
        height: 2,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Santander', 'Efectivo', 'Macro', 'MPago']
          .map<DropdownMenuItem<String>>((String value) {
            
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
          
        );
      }).toList(),

    ),





                                    
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        labelText: 'Descripcion',
                                      ),
                                      initialValue: state.movimiento.descripcion,
                                      onChanged:( value ) {spDescripcion = value; },
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        labelText: 'Valor',
                                      ),
                                      initialValue: state.movimiento.valor.toString(),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                                      ],
                                      onChanged: (value) {
                                       state.movimiento.valor = double.tryParse(value) ?? 0;
                                      },
                                    ),
                                    ElevatedButton(
                                        child: const SizedBox(
                                            width: double.infinity,
                                            child: Center(child: Text('Guardar'))),
                                        onPressed: () {
                                          if(spCategoria.isEmpty){spCategoria = state.movimiento.categoria;}
                                          if(spDescripcion.isEmpty){spDescripcion = state.movimiento.descripcion;}
                                          
                                          context
                                              .read<MovimientosBloc>()
                                              .add(ValidateMovimiento(spCategoria, dropdownValue, spDescripcion, spValor));
                                        }),
                                  ],
                                ),
                              );
                    },
                  )
                )
            )
          ),
    );
  }
}
