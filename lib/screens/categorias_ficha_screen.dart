// ignore_for_file: avoid_print
import 'dart:developer';

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
  String tipoCategoria = '';
  bool esGasto = true;

  @override
  Widget build(BuildContext context) {
    
    return BlocListener<CategoriasBloc, CategoriasState>(
      listenWhen: (previous, current) => !current.isWorking,
      listener: (context, state) {
        if (state.accion == 'GuardarCategoria' && state.error.isEmpty) {
          Navigator.pushNamed(context, 'Categorias');
          log('======>Navigator.pushNamed(context, Categorias)');
        }
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
                        CampoNombreCatFichaWidget(state),
                        const SizedBox(height: 10,),
                        CampoTipoCatFichaWidget(state),
                        //esGastoWidget(),
                        const SizedBox(height: 10,),
                        BtnGuardarCatFicha(nombreCategoria: nombreCategoria, tipoCategoria: tipoCategoria)
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

  Switch esGastoWidget() {
    return Switch(
      value: esGasto,
      activeColor: Colors.deepPurple,
      onChanged: (value){
        esGasto = value;
        setState(() {
          esGasto;
        });
        print(esGasto);
      }
    );
  }




  TextFormField CampoNombreCatFichaWidget(CategoriasState state) {
    return TextFormField(
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
    );
  }

  TextFormField CampoTipoCatFichaWidget(CategoriasState state) {

    return TextFormField(
      decoration: const InputDecoration(
        labelStyle: TextStyle(color: Colors.white),
        labelText: 'Tipo de categoria',
      ),
      initialValue: state.categoria.tipoCategoria,
      onChanged: (value) {
        tipoCategoria = value;
        setState(() {
          tipoCategoria;
        });
        
      },
    );
  }
  
}

class BtnGuardarCatFicha extends StatelessWidget {
  const BtnGuardarCatFicha({
    Key? key,
    required this.nombreCategoria,
    required this.tipoCategoria,
  }) : super(key: key);

  final String nombreCategoria;
  final String tipoCategoria;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black.withOpacity(0.05)),
      ),
      child: const SizedBox(
        width: double.infinity,
        child: Center(child: Text('Guardar'))
      ),
      onPressed: () {
                        
        context
            .read<CategoriasBloc>()
            .add(ValidateCategoria(nombreCategoria, tipoCategoria));
      }
    );
  }
}
