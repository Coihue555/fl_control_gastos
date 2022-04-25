import 'package:fl_control_gastos/bloc/blocs.dart';
import 'package:fl_control_gastos/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriasBodyWidget extends StatelessWidget {
  const CategoriasBodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriasBloc, CategoriasState>(
      listenWhen: (previous, current) => !current.isWorking,
      listener: (context, state) {
        if (state.accion == 'NewCategoria' || state.accion == 'UpdateCategoria') {
          Navigator.pushReplacementNamed(context, 'CategoriasFicha');
        }
        if (state.error.isNotEmpty) {
          print(state.error);
        }
        if (state.accion == 'ValidateCategoria' && state.error.isEmpty) {
          context.read<CategoriasBloc>().add(GuardarCategoria());
        }
      },
      builder: (context, state) {
        return ListadoCategorias(lista: state.lista,);
      },
    );
  }
}

class ListadoCategorias extends StatelessWidget {
  const ListadoCategorias({
    Key? key,
    required this.lista
  }) : super(key: key);

  final List<CategoriaModel> lista;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: lista.length,
      itemBuilder: (context, i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) {
          context.read<CategoriasBloc>().add(DeleteCategoria(lista[i].id!));
          final snackBar = SnackBar(
            content: const Text('Registro eliminado'),
            action: SnackBarAction(
              label: 'Entendido',
              onPressed: () {  },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: ListTile(
          title: Text(lista[i].nombreCategoria),
          subtitle: Text(lista[i].tipoCategoria,),
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
            context.read<CategoriasBloc>().add(UpdateCategoria(lista[i].id!));
          }
        ),
      ),
    );
  }
}