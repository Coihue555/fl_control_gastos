// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/bloc/blocs.dart';

class CategoriasFichaScreen extends StatefulWidget {
  @override
  State<CategoriasFichaScreen> createState() => _CategoriasFichaScreenState();
}

class _CategoriasFichaScreenState extends State<CategoriasFichaScreen> {
  @override
  Widget build(BuildContext context) {
    String nombreCategoria = '';
    String tipoCategoria = '';

    return BlocListener<CategoriasBloc, CategoriasState>(
      listenWhen: (previous, current) => !current.isWorking,
      listener: (context, state) {
        if (state.accion == 'GuardarCategoria' && state.error.isEmpty) {
          Navigator.pushNamed(context, 'Categorias');
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Categorias'),
          ),
          body: SingleChildScrollView(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: BlocBuilder<CategoriasBloc, CategoriasState>(
                    builder: (context, state) {
                      return Form(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        labelText: 'Nombre de la categoria',
                                      ),
                                      initialValue: state.categoria.nombreCategoria,
                                      onChanged: (value) {
                                        nombreCategoria = value;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        labelText: 'Tipo de categoria',
                                      ),
                                      initialValue: state.categoria.tipoCategoria,
                                      onChanged: (value) {
                                        tipoCategoria = value;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    
                                    ElevatedButton(
                                        child: const SizedBox(
                                            width: double.infinity,
                                            child: Center(child: Text('Guardar'))),
                                        onPressed: () {
                                          if(nombreCategoria.isEmpty){nombreCategoria = state.categoria.nombreCategoria;}
                                          if(tipoCategoria.isEmpty){tipoCategoria = state.categoria.tipoCategoria;}
                                          
                                          context
                                              .read<CategoriasBloc>()
                                              .add(ValidateCategoria(nombreCategoria, tipoCategoria));
                                        }),
                                  ],
                                ),
                              );
                    },
                  )
                )
            )
          ),
    );
  }
}
