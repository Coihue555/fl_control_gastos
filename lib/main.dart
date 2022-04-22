import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/screens/screens.dart';
import 'package:fl_control_gastos/widgets/widgets.dart';
import 'package:fl_control_gastos/bloc/blocs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MovimientosBloc()),
        BlocProvider(create: (_) => CuentasBloc()),
        BlocProvider(create: (_) => CategoriasBloc()),
      ],
      child: Builder(builder: (context) {
        context.read<MovimientosBloc>().add(GetMovimientosList());
        context.read<CuentasBloc>().add(GetCuentasList());
        context.read<CategoriasBloc>().add(GetCategoriaList());

        return MaterialApp(
            theme: themePropio(),
            debugShowCheckedModeBanner: false,
            title: 'Movimientos',
            initialRoute: 'Home',
            routes: {
              'Home'            : (_) => const HomeScreen(),
              'MovimientosFicha': (_) => MovimientosFichaScreen(),
              'Cuentas'         : (_) => const CuentasScreen(),
              'CuentasFicha'    : (_) => CuentaFichaScreen(),
              'Categorias'      : (_) => const CategoriasScreen(),
              'CategoriasFicha' : (_) => CategoriasFichaScreen(),
            });
      }),
    );
  }
}