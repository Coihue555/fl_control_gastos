import 'package:fl_control_gastos/db/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/bloc/blocs.dart';

class CuentasDropScreen extends StatefulWidget {
  const CuentasDropScreen({Key? key}) : super(key: key);

  @override
  State<CuentasDropScreen> createState() => _CuentasDropScreenState();
}

class _CuentasDropScreenState extends State<CuentasDropScreen> {
  @override
  Widget build(BuildContext context) {

    const String dropdownValue = 'One';
    

    return Scaffold(
      body: BlocConsumer<CuentasBloc, CuentasState>(
        
        listenWhen: (previous, current) => !current.isWorking,
        listener: (context, state) {
          if (state.accion == 'NewCuenta' || state.accion == 'UpdateCuenta') {
            Navigator.pushNamed(context, 'CuentasFicha');
          }
          if (state.error.isNotEmpty) {
            print(state.error);
          }
          
        },
        builder: (context, state) {

          

          if (state.lista.isNotEmpty) {
            return DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              
            },
            
            

            items: state.lista
                .map<DropdownMenuItem<String>>((CuentaModel value) {
              return DropdownMenuItem<String>(
                value: value.nombreCuenta,
                child: Text(value.nombreCuenta),
              );
            }).toList(),
          );
          } else {
            return const Center(
                child: Text('Aun no hay Cuentas creadas'),
              );
          }
        },
      )
    );
  }
}
