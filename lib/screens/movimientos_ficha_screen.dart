// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/widgets/widgets.dart';
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
    String dropdownCuenta = 'Efectivo';
    String dropdownCategoria = 'Comida';

  @override
  Widget build(BuildContext context) {
    String spCategoria = '';
    String spDescripcion = '';
    double spValor = 0.0;


    return BlocListener<MovimientosBloc, MovimientosState>(
      listenWhen: (previous, current) => !current.isWorking,
      listener: (context, state) {
        if (state.accion == 'GuardarMovimiento' && state.error.isEmpty) {
          Navigator.pushNamed(context, 'Home');
        }
      },
      child: Container(
        decoration: gradientePropia(),
        child: Scaffold(
          appBar: const AppBarPropio(title: 'Nueva transaccion',),
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
                            BlocConsumer<CategoriasBloc, CategoriasState>(
                              listenWhen: (previous, current) => !current.isWorking,
                              listener: (context, state) {  },
                              builder: (context, state) {
                                if (state.lista.isNotEmpty) {
                                  return DropdownButton<String>(
                                    dropdownColor: const Color.fromARGB(221, 35, 23, 37),
                                    icon: const Icon(Icons.arrow_drop_down),
                                    elevation: 10,
                                    style: const TextStyle(fontSize: 25, ),
                                    value: dropdownCategoria,
                                    onChanged: (String? newValue) {
                                      dropdownCategoria = newValue!;
                                      setState(() {
                                        dropdownCategoria;
                                      });
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
                                  return Center(
                                    child: ElevatedButton(
                                      onPressed: (){
                                        Navigator.pushNamed(context, 'Categorias');
                                      },
                                      child: const Text('Aun no hay Categorias creadas')
                                    ),
                                  );
                                }
                              },
                            ),
                          Expanded(child: Container(width: 10,)),
                          BlocConsumer<CuentasBloc, CuentasState>(
                            listenWhen: (previous, current) => !current.isWorking,
                            listener: (context, state) {  },
                            builder: (context, state) {
                              return DropdownButton<String>(
                                value: dropdownCuenta,
                                dropdownColor: const Color.fromARGB(221, 35, 23, 37),
                                icon: const Icon(Icons.arrow_drop_down),
                                elevation: 10,
                                style: const TextStyle(fontSize: 25,),
                                onChanged: (String? newValue) {
                                  dropdownCuenta = newValue!;
                                  setState(() {
                                    dropdownCuenta;
                                  });
                                  
                                },
                                items: state.lista
                                  .map<DropdownMenuItem<String>>((CuentaModel value) {
                                    return DropdownMenuItem<String>(
                                      value: value.nombreCuenta,
                                      child: Text(value.nombreCuenta),
                                    );
                                  }).toList(),
                                );
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                style: const TextStyle(fontSize: 20,),
                                controller: dateinput,
                                decoration: InputDecoration( 
                                  icon: const Icon(Icons.calendar_today),
                                  labelStyle: const TextStyle(color: Colors.white),
                                  labelText: (state.movimiento.fecha == '') ? "Elija fecha" : state.movimiento.fecha 
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
                        
                        const SizedBox( height: 10, ),
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