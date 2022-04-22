import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fl_control_gastos/widgets/widgets.dart';
import 'package:fl_control_gastos/bloc/blocs.dart';

class CategoriasScreen extends StatelessWidget {
  const CategoriasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: gradientePropia(),
      child: Scaffold(
        drawer: const CustomDrawer(),
        appBar: const AppBarPropio(title: 'Categorias'),
        body: BlocConsumer<CategoriasBloc, CategoriasState>(
          listenWhen: (previous, current) => !current.isWorking,
          listener: (context, state) {
            if (state.accion == 'NewCategoria' || state.accion == 'UpdateCategoria') {
              Navigator.pushNamed(context, 'CategoriasFicha');
            }
            if (state.error.isNotEmpty) {
              print(state.error);
            }
            if (state.accion == 'ValidateCategoria' && state.error.isEmpty) {
              context.read<CategoriasBloc>().add(GuardarCategoria());
            }
          },
          builder: (context, state) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.lista.length,
              itemBuilder: (context, i) => Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.red,
                ),
                onDismissed: (DismissDirection direction) {
                  context.read<CategoriasBloc>().add(DeleteCategoria(state.lista[i].id!));
                  final snackBar = SnackBar(
                    content: const Text('Registro eliminado'),
                    action: SnackBarAction(
                      label: 'Entendido',
                      onPressed: () {  },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: FadeIn(
                  duration: const Duration(seconds: 2),
                  child: ListTile(
                    //leading: const Icon(Icons.calculate, color: Colors.blue),
                    title: Text(state.lista[i].nombreCategoria),
                    subtitle: Text(state.lista[i].tipoCategoria,),
                    trailing: Container(
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(Icons.chevron_right, color: Colors.white),
                        ],
                      ),
                    ),
                    onTap: () {
                      context.read<CategoriasBloc>().add(UpdateCategoria(state.lista[i].id!));
                    }
                  ),
                ),
              ),
            );
          },
        ),
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
