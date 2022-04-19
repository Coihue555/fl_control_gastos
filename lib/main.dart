import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/screens/ficha_screen.dart';
import 'package:fl_control_gastos/screens/home_screen.dart';
import 'package:fl_control_gastos/bloc/movimientos/movimientos_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => MovimientosBloc())],
      child: Builder(builder: (context) {
        context.read<MovimientosBloc>().add(GetMovimientosList());
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Movimientos',
            initialRoute: 'Home',
            routes: {
              'Home': (_) => const HomeScreen(),
              'Ficha': (_) => FichaScreen(),
            });
      }),
    );
  }
}
