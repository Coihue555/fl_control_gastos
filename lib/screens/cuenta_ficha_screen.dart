// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/bloc/blocs.dart';

class CuentaFichaScreen extends StatefulWidget {
  @override
  State<CuentaFichaScreen> createState() => _CuentaFichaScreenState();
}

class _CuentaFichaScreenState extends State<CuentaFichaScreen> {
  @override
  Widget build(BuildContext context) {
    String nombreCuenta = '';

    return BlocListener<CuentasBloc, CuentasState>(
      listenWhen: (previous, current) => !current.isWorking,
      listener: (context, state) {
        if (state.accion == 'GuardarCuenta' && state.error.isEmpty) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Cuentas'),
          ),
          body: SingleChildScrollView(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: BlocBuilder<CuentasBloc, CuentasState>(
                    builder: (context, state) {
                      return Form(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        labelText: 'Nombre de la Cuenta',
                                      ),
                                      initialValue: state.cuenta.nombreCuenta,
                                      onChanged: (value) {
                                        nombreCuenta = value;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    
                                    ElevatedButton(
                                        child: const SizedBox(
                                            width: double.infinity,
                                            child: Center(child: Text('Guardar'))),
                                        onPressed: () {
                                          if(nombreCuenta.isEmpty){nombreCuenta = state.cuenta.nombreCuenta;}
                                          
                                          context
                                              .read<CuentasBloc>()
                                              .add(ValidateCuenta(nombreCuenta));
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
