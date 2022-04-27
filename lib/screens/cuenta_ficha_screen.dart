// ignore_for_file: avoid_print
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/bloc/blocs.dart';
import 'package:fl_control_gastos/widgets/widgets.dart';

class CuentaFichaScreen extends StatefulWidget {
  @override
  State<CuentaFichaScreen> createState() => _CuentaFichaScreenState();
}

class _CuentaFichaScreenState extends State<CuentaFichaScreen> {
  
  String nombreCuenta = '';

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CuentasBloc, CuentasState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            return !state.isWorking;
          },
      child: Container(
        decoration: gradientePropia(),
        child: Scaffold(
          appBar: const CustomAppBarWidget(title: 'Nueva cuenta'),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: BlocBuilder<CuentasBloc, CuentasState>(
                  builder: (context, state) {
                    return Form(
                      child: Column(
                        children: [
                          campoNomCuentaFichaWidget(state),
                          const SizedBox(height: 10,),
                          btnGuardarCuentaFichaWidget(nombreCuenta, state, context),
                        ],
                      ),
                    );
                  },
                )
              )
            )
          ),
      ),
        );
      }
    );
  }

  TextFormField campoNomCuentaFichaWidget(CuentasState state) {
    return TextFormField(
        decoration: const InputDecoration(
          labelStyle: TextStyle(color: Colors.white),
          labelText: 'Nombre de la Cuenta',
        ),
        initialValue: state.cuenta.nombreCuenta,
        onChanged: (value) {
          nombreCuenta = value;
          setState(() {
            nombreCuenta;
          });
        },
      );
  }

  ElevatedButton btnGuardarCuentaFichaWidget(String nombreCuenta, CuentasState state, BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black.withOpacity(0.05)),
      ),
      child: const SizedBox(
        width: double.infinity,
        child: Center(child: Text('Guardar'))
      ),
      onPressed: () {
        if(nombreCuenta.isEmpty){nombreCuenta = state.cuenta.nombreCuenta;}
        context
          .read<CuentasBloc>()
          .add(ValidateCuenta(nombreCuenta));
      }
    );
  }
}
