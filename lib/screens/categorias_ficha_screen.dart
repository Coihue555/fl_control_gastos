// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/widgets/widgets.dart';
import 'package:fl_control_gastos/bloc/blocs.dart';

class CategoriasFichaScreen extends StatefulWidget {
  @override
  State<CategoriasFichaScreen> createState() => _CategoriasFichaScreenState();
}

class _CategoriasFichaScreenState extends State<CategoriasFichaScreen> {

  String nombreCategoria = '';
  int esGasto = 1;

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<CategoriasBloc, CategoriasState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            return !state.isWorking;
          },
      
      child: Container(
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
                            Switch(
                              value: (state.categoria.esGasto == 1) ? true : false,
                              activeColor: Colors.deepPurple,
                              onChanged: (value){
                                esGasto = (value) ? 1 : 0;
                                setState(() {
                                  esGasto;
                                });
                                print(esGasto);
                              }
                            )
                          ],
                        ),
                        //campoTipoCatFichaWidget(state),
                        const SizedBox(height: 10,),
                        btnGuardarCatFicha(nombreCategoria: nombreCategoria, esGasto: esGasto)
                      ],
                    ),
                  );
                },
              )
            )
          )
        ),
      ),
        );
      }
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
