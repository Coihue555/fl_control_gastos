import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/widgets/widgets.dart';
import 'package:fl_control_gastos/bloc/blocs.dart';

class CuentasScreen extends StatelessWidget {
  const CuentasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: gradientePropia(),
      child: Scaffold(
        drawer: const CustomDrawer(),
        appBar: const AppBarPropio(title: 'Cuentas',),
        body: BlocConsumer<CuentasBloc, CuentasState>(
          listenWhen: (previous, current) => !current.isWorking,
          listener: (context, state) {
            if (state.accion == 'NewCuenta' || state.accion == 'UpdateCuenta') {
              Navigator.pushNamed(context, 'CuentasFicha');
            }
            if (state.error.isNotEmpty) {
              print(state.error);
            }
            if (state.accion == 'ValidateCuenta' && state.error.isEmpty) {
              context.read<CuentasBloc>().add(GuardarCuenta());
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
                    context.read<CuentasBloc>().add(DeleteCuenta(state.lista[i].id!));
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
                      //leading: const Icon(Icons.attach_money_outlined, color: Colors.blue),
                      title: Text(state.lista[i].nombreCuenta),
                      trailing: const Icon(Icons.chevron_right, color: Colors.white,),
                      onTap: () {
                        context.read<CuentasBloc>().add(UpdateCuenta(state.lista[i].id!));
                      }
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text('Crea tu primer cuenta con el boton +'),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            context.read<CuentasBloc>().add(NewCuenta());
          },
        ),
      ),
    );
  }
}
