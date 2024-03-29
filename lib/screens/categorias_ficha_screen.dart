import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/widgets/widgets.dart';
import 'package:fl_control_gastos/bloc/blocs.dart';

class CategoriasFichaScreen extends StatefulWidget {
  const CategoriasFichaScreen({Key? key}) : super(key: key);

  @override
  State<CategoriasFichaScreen> createState() => _CategoriasFichaScreenState();
}

class _CategoriasFichaScreenState extends State<CategoriasFichaScreen> {
  String nombreCategoria = '';
  int esGasto = 1;

  @override
  void initState() {
    super.initState();
    esGasto = context.read<CategoriasBloc>().state.categoria.esGasto;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriasBloc, CategoriasState>(builder: (context, state) {
      return Container(
        decoration: gradientePropia(),
        child: Scaffold(
            appBar: const CustomAppBarWidget(title: 'Nueva categoria'),
            body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: BlocBuilder<CategoriasBloc, CategoriasState>(
                      builder: (context, state) {
                        return Form(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  campoNombreCatFichaWidget(state),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  esGastoWidget()
                                ],
                              ),
                              //campoTipoCatFichaWidget(state),
                              const SizedBox(
                                height: 10,
                              ),
                              BtnGuardarCatFicha(nombreCategoria: nombreCategoria, esGasto: esGasto)
                            ],
                          ),
                        );
                      },
                    )))),
      );
    });
  }

  Widget esGastoWidget() {
    return SizedBox(
      width: 70,
      child: Column(
        children: [
          Switch(
              value: (esGasto == 1) ? true : false,
              activeColor: Colors.deepPurple,
              onChanged: (value) {
                esGasto = (value) ? 1 : 0;
                setState(() {});
              }),
          (esGasto == 1) ? const Text('Es Gasto') : const Text('Es Ingreso')
        ],
      ),
    );
  }

  Widget campoNombreCatFichaWidget(CategoriasState state) {
    return Expanded(
      child: TextFormField(
        decoration: const InputDecoration(
          labelStyle: TextStyle(color: Colors.white),
          labelText: 'Nombre de la categoria',
        ),
        initialValue: state.categoria.nombreCategoria,
        onChanged: (value) {
          nombreCategoria = value;
          setState(() {
            nombreCategoria;
          });
        },
      ),
    );
  }
}
