import 'package:fl_control_gastos/widgets/customDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/bloc/blocs.dart';

class CategoriasScreen extends StatelessWidget {
  const CategoriasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Categorias'),
      ),
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
          if (state.lista.isNotEmpty) {
            return ListView.builder(
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
                    child: ListTile(
                              leading: const Icon(Icons.calculate, color: Colors.blue),
                              title: Text(state.lista[i].nombreCategoria),
                              subtitle: Text(state.lista[i].tipoCategoria,),
                              trailing: Container(
                                width: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    //Text('\$' +state.lista[i].valor.toString(), style: TextStyle(color:Colors.green[300], fontWeight: FontWeight.bold, fontSize: 20),),
                                    Icon(Icons.chevron_right),
                                  ],
                                ),
                              ),
                              onTap: () {
                                context.read<CategoriasBloc>().add(UpdateCategoria(state.lista[i].id!));
                              }
                            ),
                  ),
                );
          } else {
            return const Center(
                child: Text('Aun no hay Categorias cargadas'),
              );
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.read<CategoriasBloc>().add(NewCategoria());
        },
      ),
    );
  }
}
