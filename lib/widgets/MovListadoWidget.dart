import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/bloc/blocs.dart';
import 'package:fl_control_gastos/models/models.dart';

class Listado extends StatelessWidget {
  const Listado({
    Key? key,
    required this.lista,
  }) : super(key: key);
  
  final List<MovimientosModel> lista;

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
          context.read<MovimientosBloc>().add(DeleteMovimiento(lista[i].id!));
          final snackBar = SnackBar(
            duration: const Duration(milliseconds: 500),
            content: const Text('Registro eliminado'),
            action: SnackBarAction(
              label: 'Entendido',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: ListTile(
            contentPadding: const EdgeInsets.only(left: 25, right: 15),
            title: Text(lista[i].categoria + ' - ' + lista[i].descripcion),
            subtitle: Text(lista[i].fecha),
            trailing: Container(
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$' + lista[i].valor.toString(),
                        style: TextStyle(
                            color: Colors.green[300],
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(lista[i].cuenta),
                    ],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            onTap: () {
              context
                  .read<MovimientosBloc>()
                  .add(UpdateMovimiento(lista[i].id!));
            }),
      ),
    );
  }
}