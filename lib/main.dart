import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/screens/screens.dart';
import 'package:fl_control_gastos/bloc/blocs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MovimientosBloc()),
        BlocProvider(create: (_) => CuentasBloc()),
      ],
      child: Builder(builder: (context) {
        context.read<MovimientosBloc>().add(GetMovimientosList());
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Movimientos',
            initialRoute: 'Home',
            routes: {
              'Home'            : (_) => const HomeScreen(),
              'MovimientosFicha': (_) => MovimientosFichaScreen(),
              'CuentasFicha'    : (_) => CuentaFichaScreen(),
              'Cuentas'         : (_) => const CuentasScreen(),
            });
      }),
    );
  }
}
