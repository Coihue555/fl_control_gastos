import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fl_control_gastos/bloc/blocs.dart';
import 'package:fl_control_gastos/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: gradientePropia(),
      child: Scaffold(
        drawer: const CustomDrawer(),
        appBar: const AppBarPropio(title: 'Movimientos',),
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
                physics: const BouncingScrollPhysics(),
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
                  child: FadeIn(
                    duration: const Duration(seconds: 2),
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(left: 25, right: 15),
                      title: Text(state.lista[i].categoria + ' - ' + state.lista[i].descripcion),
                      subtitle: Text(state.lista[i].fecha),
                      trailing: Container(
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('\$' +state.lista[i].valor.toString(),
                                  style: TextStyle(
                                    color:Colors.green[300], 
                                    fontWeight: FontWeight.bold, 
                                    fontSize: 15
                                  ),
                                ),
                                Text(state.lista[i].cuenta),
                              ],
                            ),
                            const SizedBox(width: 5,),
                            const Icon(Icons.chevron_right, color: Colors.white,),
                          ],
                        ),
                      ),
                      onTap: () {
                        context.read<MovimientosBloc>().add(UpdateMovimiento(state.lista[i].id!));
                      }
                    ),
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
      ),
    );
  }
}