// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/bloc/blocs.dart';
import 'package:fl_control_gastos/models/models.dart';

class MovimientosFichaScreen extends StatefulWidget {
  @override
  State<MovimientosFichaScreen> createState() => _MovimientosFichaScreenState();
}

class _MovimientosFichaScreenState extends State<MovimientosFichaScreen> {

  TextEditingController dateinput = TextEditingController(); 
  
  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String spCategoria = '';
    String spDescripcion = '';
    double spValor = 0.0;
    String dropdownCuenta = 'Efectivo';
    String dropdownCategoria = 'Comida';

    return BlocListener<MovimientosBloc, MovimientosState>(
      listenWhen: (previous, current) => !current.isWorking,
      listener: (context, state) {
        if (state.accion == 'GuardarMovimiento' && state.error.isEmpty) {
          Navigator.pushNamed(context, 'Home');
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.orange]
          )
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(0, 92, 39, 39),
            shadowColor: Colors.transparent,
            title: const Text('Nueva transaccion'),
          ),
          body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: BlocBuilder<MovimientosBloc, MovimientosState>(
              builder: (context, state) {
                return Form(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: const TextStyle(fontSize: 20,),
                              controller: dateinput,
                              decoration: const InputDecoration( 
                                icon: Icon(Icons.calendar_today),
                                labelStyle: TextStyle(color: Colors.white),
                                labelText: "Elija fecha"
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: (state.movimiento.fecha == '' ) ? DateTime.now() : DateTime.parse(state.movimiento.fecha),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2030)
                                );
                                  if(pickedDate != null ){
                                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                      setState(() {
                                        dateinput.text = formattedDate;
                                      });
                                  }else{
                                      print('No se eligio fecha');
                                  }
                                },
                            ),
                          ),
                          
                          const SizedBox(width: 10,),

                          Expanded(
                            child: TextFormField(
                              style: const TextStyle(fontSize: 20,),
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(color: Colors.white),
                                labelText: 'Valor',
                              ),
                              initialValue: state.movimiento.valor.toString(),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                              ],
                              onChanged: (value) {
                              spValor = double.tryParse(value) ?? 0;
                              },
                            ),
                          ),
                        ],
                      ),

                      
                      const SizedBox(
                        height: 20,
                      ),

                      Row(
                        children: [
                          BlocConsumer<CategoriasBloc, CategoriasState>(
                            listenWhen: (previous, current) => !current.isWorking,
                            listener: (context, state) {  },
                            builder: (context, state) {

                              if (state.lista.isNotEmpty) {
                                return DropdownButton<String>(
                                  value: dropdownCategoria,
                                  dropdownColor: Colors.black87,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 10,
                                  style: const TextStyle(fontSize: 25, ),
                                  onChanged: (String? newValue) {
                                    dropdownCategoria = newValue!;
                                  },

                                  items: state.lista
                                    .map<DropdownMenuItem<String>>((CategoriaModel value) {
                                      return DropdownMenuItem<String>(
                                        value: value.nombreCategoria,
                                        child: Text(value.nombreCategoria,),
                                      );
                                    }).toList(),
                                );
                              } else {
                                return const Center(
                                    child: Text('Aun no hay Categorias creadas'),
                                  );
                              }
                            },
                          ),

                          Expanded(child: Container(width: 10,)),
                          
                          
                          BlocConsumer<CuentasBloc, CuentasState>(
                            listenWhen: (previous, current) => !current.isWorking,
                            listener: (context, state) {  },
                            builder: (context, state) {

                              if (state.lista.isNotEmpty) {
                                return DropdownButton<String>(
                                  value: dropdownCuenta,
                                  dropdownColor: Colors.black87,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 10,
                                  style: const TextStyle(fontSize: 25,),
                                  onChanged: (String? newValue) {
                                    dropdownCuenta = newValue!;
                                  },

                                  items: state.lista
                                    .map<DropdownMenuItem<String>>((CuentaModel value) {
                                      return DropdownMenuItem<String>(
                                        value: value.nombreCuenta,
                                        child: Text(value.nombreCuenta),
                                      );
                                    }).toList(),
                                );
                              } else {
                                return const Center(
                                    child: Text('Aun no hay Cuentas creadas'),
                                  );
                              }
                            },
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      TextFormField(
                        style: const TextStyle(fontSize: 25,),
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Descripcion',
                        ),
                        initialValue: state.movimiento.descripcion,
                        onChanged:( value ) {
                            spDescripcion = value;
                          },
                      ),
                      
                      

                      
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.black.withOpacity(0.05)),
                        ),
                        child: const SizedBox(
                                width: double.infinity,
                                child: Center(child: Text('Guardar'))
                              ),
                        onPressed: () {          
                            if(spCategoria.isEmpty){spCategoria = state.movimiento.categoria;}
                            if(spDescripcion.isEmpty){spDescripcion = state.movimiento.descripcion;}
                            if(spValor == 0.0){spValor = state.movimiento.valor;}
                            if(dateinput.text.isEmpty){dateinput.text = state.movimiento.fecha;}
                            context
                                .read<MovimientosBloc>()
                                .add(ValidateMovimiento(dropdownCategoria, dropdownCuenta, dateinput.text, spDescripcion, spValor));
                          }
                      ),
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
}
