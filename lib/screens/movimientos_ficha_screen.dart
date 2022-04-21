// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/bloc/movimientos/movimientos_bloc.dart';
import 'package:intl/intl.dart';

class MovimientosFichaScreen extends StatefulWidget {
  @override
  State<MovimientosFichaScreen> createState() => _MovimientosFichaScreenState();
}

class _MovimientosFichaScreenState extends State<MovimientosFichaScreen> {

  TextEditingController dateinput = TextEditingController(); 
  //text editing controller for text field
  
  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String spCategoria = '';
    String spCuenta = '';
    String spDescripcion = '';
    double spValor = 0.0;




    return BlocListener<MovimientosBloc, MovimientosState>(
      listenWhen: (previous, current) => !current.isWorking,
      listener: (context, state) {
        if (state.accion == 'GuardarMovimiento' && state.error.isEmpty) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Nueva transaccion'),
          ),
          body: SingleChildScrollView(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: BlocBuilder<MovimientosBloc, MovimientosState>(
                    builder: (context, state) {
                      return Form(
                                child: Column(
                                  children: [

                                        TextField(
                                            controller: dateinput, //editing controller of this TextField
                                            decoration: const InputDecoration( 
                                              icon: Icon(Icons.calendar_today), //icon of text field
                                              labelText: "Enter Date" //label text of field
                                            ),
                                            readOnly: true,  //set it true, so that user will not able to edit text
                                            onTap: () async {
                                              DateTime? pickedDate = await showDatePicker(
                                                  context: context, initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                                  lastDate: DateTime(2101)
                                              );
                                              
                                              if(pickedDate != null ){
                                                  print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                                                  print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                                    //you can implement different kind of Date Format here according to your requirement

                                                  setState(() {
                                                    dateinput.text = formattedDate; //set output date to TextField value. 
                                                  });
                                              }else{
                                                  print("Date is not selected");
                                              }
                                            },
                                        ),




                                    TextFormField(
                                      decoration: const InputDecoration(
                                        labelText: 'Categoria',
                                      ),
                                      initialValue: state.movimiento.categoria,
                                      onChanged: (value) {
                                        spCategoria = value;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        labelText: 'Cuenta',
                                      ),
                                      initialValue: state.movimiento.cuenta,
                                      onChanged:( value ) {spCuenta = value; },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        labelText: 'Descripcion',
                                      ),
                                      initialValue: state.movimiento.descripcion,
                                      onChanged:( value ) {spDescripcion = value; },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
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
                                    ElevatedButton(
                                        child: const SizedBox(
                                            width: double.infinity,
                                            child: Center(child: Text('Guardar'))),
                                        onPressed: () {
                                          // if(spCategoria.isEmpty){spCategoria = state.movimiento.categoria;}
                                          // if(spDescripcion.isEmpty){spDescripcion = state.movimiento.descripcion;}
                                          
                                          context
                                              .read<MovimientosBloc>()
                                              .add(ValidateMovimiento(spCategoria, spCuenta, dateinput.text, spDescripcion, spValor));
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
