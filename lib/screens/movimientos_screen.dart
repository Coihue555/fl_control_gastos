import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/bloc/blocs.dart';
import 'package:fl_control_gastos/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: gradientePropia(),
      child: Scaffold(
        drawer: const CustomDrawerWidget(),
        appBar: const CustomAppBarWidget( title: 'Movimientos',  ),
        body: const MovBodyWidget(),

        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            context.read<MovimientosBloc>().add(NewMovimiento());
          },
        ),
      ),
    );
  }
}