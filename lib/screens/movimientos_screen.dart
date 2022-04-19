import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/bloc/movimientos/movimientos_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Control de Gastos', style: TextStyle(fontSize: 30, color: Colors.white)),
            ),
            ListTile(
              title: const Text('Cuentas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
              onTap: () {
                Navigator.pushNamed(context, 'Cuentas');
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Categorias', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
              onTap: () {
                Navigator.pushNamed(context, 'Categorias');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Movimientos'),
      ),
      body: BlocConsumer<MovimientosBloc, MovimientosState>(
        listenWhen: (previous, current) => !current.isWorking,
        listener: (context, state) {
          if (state.accion == 'NewMovimiento' || state.accion == 'UpdateMovimiento') {
            Navigator.pushNamed(context, 'MovimientosFicha');
          }
          if (state.error.isNotEmpty) {
            print(state.error);
          }
          if (state.accion == 'ValidateMovimiento' && state.error.isEmpty) {
            context.read<MovimientosBloc>().add(GuardarMovimiento());
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
                                context.read<MovimientosBloc>().add(DeleteMovimiento(state.lista[i].id!));
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
                              leading: const Icon(Icons.attach_money_outlined, color: Colors.blue),
                              title: Text(state.lista[i].categoria),
                              subtitle: Text(state.lista[i].descripcion,),
                              trailing: Container(
                                width: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('\$' +state.lista[i].valor.toString(), style: TextStyle(color:Colors.green[300], fontWeight: FontWeight.bold, fontSize: 20),),
                                    const Icon(Icons.chevron_right),
                                  ],
                                ),
                              ),
                              onTap: () {
                                context.read<MovimientosBloc>().add(UpdateMovimiento(state.lista[i].id!));
                              }
                            ),
                  ),
                );
          } else {
            return const Center(
                child: Text('Aun no hay Movimientos cargados'),
              );
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.read<MovimientosBloc>().add(NewMovimiento());
        },
      ),
    );
  }
}
