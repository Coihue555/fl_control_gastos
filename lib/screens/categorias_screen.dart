import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/widgets/widgets.dart';
import 'package:fl_control_gastos/bloc/blocs.dart';

class CategoriasScreen extends StatelessWidget {
  const CategoriasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: gradientePropia(),
      child: Scaffold(
        drawer: CustomDrawerWidget(),
        appBar: const CustomAppBarWidget(title: 'Categorias'),
        body: const CategoriasBodyWidget(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            context.read<CategoriasBloc>().add(NewCategoria());
          },
        ),
      ),
    );
  }
}
