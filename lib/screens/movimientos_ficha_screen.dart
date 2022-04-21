// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/widgets/drop3.dart';
import 'package:fl_control_gastos/bloc/blocs.dart';

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
                            controller: dateinput,
                            decoration: const InputDecoration( 
                              icon: Icon(Icons.calendar_today),
                              labelText: "Elija fecha"
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2030)
                              );
                                if(pickedDate != null ){
                                    print(pickedDate);  //formato de salida => 2022-04-21 00:00:00.000
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    print(formattedDate); //formato de salida luego de usar el package intl  =>  2022-04-21
                                    setState(() {
                                      dateinput.text = formattedDate;
                                    });
                                }else{
                                    print("No se selecciono fecha");
                                }
                              },
                          ),
                        ),
                        
                        const SizedBox(width: 10,),

                        Expanded(
                          child: TextFormField(
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
                        ),
                      ],
                    ),

                    
                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Categoria',
                            ),
                            initialValue: state.movimiento.categoria,
                            onChanged: (value) {
                              spCategoria = value;
                            },
                          ),
                        ),

                        const SizedBox(width: 10,),

                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Cuenta',
                            ),
                            initialValue: state.movimiento.cuenta,
                            onChanged:( value ) {spCuenta = value; },
                          ),
                        ),
                      ],
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
                    DropdownItem(),
                    

                    
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
