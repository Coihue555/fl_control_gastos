import 'package:fl_control_gastos/bloc/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/screens/screens.dart';
import 'package:fl_control_gastos/widgets/widgets.dart';
import 'package:fl_control_gastos/bloc/blocs.dart';

void main() => BlocOverrides.runZoned(() async {
      runApp(const MyApp());
    }, blocObserver: SimpleBlocObserver());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MovimientosBloc()),
        BlocProvider(create: (_) => CuentasBloc()),
        BlocProvider(create: (_) => CategoriasBloc()),
        BlocProvider(create: (_) => NavBloc()),
      ],
      child: Builder(builder: (context) {
        context.read<MovimientosBloc>().add(GetMovimientosList());
        context.read<CuentasBloc>().add(GetCuentasList());
        context.read<CategoriasBloc>().add(GetCategoriaList());
        context.read<NavBloc>().add(GetScreen('Home'));

        return MaterialApp(
            theme: themePropio(),
            debugShowCheckedModeBanner: false,
            title: 'Movimientos',
            initialRoute: 'Home',
            routes: {
              'Home': (_) => const HomeScreen(),
              'MovimientosFicha': (_) => const MovimientosFichaScreen(),
              'Cuentas': (_) => const CuentasScreen(),
              'CuentasFicha': (_) => CuentaFichaScreen(),
              'Categorias': (_) => const CategoriasScreen(),
              'CategoriasFicha': (_) => CategoriasFichaScreen(),
            });
      }),
    );
  }
}
