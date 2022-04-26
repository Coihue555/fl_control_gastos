// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_control_gastos/widgets/widgets.dart';
import 'package:fl_control_gastos/bloc/blocs.dart';
import 'package:fl_control_gastos/models/models.dart';

class MovimientosFichaScreen extends StatefulWidget {
  const MovimientosFichaScreen({Key? key}) : super(key: key);

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

  String? dropdownCuenta;
  String? dropdownCategoria;
  String spDescripcion = '';
  double spValor = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovimientosBloc, MovimientosState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            return !state.isWorking;
          },
          child: Container(
            decoration: gradientePropia(),
            child: Scaffold(
                
                appBar: const CustomAppBarWidget(
                  title: 'Nueva transaccion',
                ),
                body: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: BlocBuilder<MovimientosBloc, MovimientosState>(
                          builder: (context, state) {
                            
                            return Form(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      dropCategoriaMovFichaWidget(),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      dropCuentasMovFicha()
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: campoFechaMovFichaWidget(
                                              state, context)),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child:
                                              campoValorMovFichaWidget(state)),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  campoDescMovFichaWidget(state),
                                  BtnGuardarMovWidget(
                                      dropdownCategoria:
                                          dropdownCategoria ?? '',
                                      dropdownCuenta: dropdownCuenta ?? '',
                                      dateinput: dateinput ,
                                      spDescripcion: spDescripcion,
                                      spValor: spValor)
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
      },
    );
  }

  Widget dropCategoriaMovFichaWidget() {
    return BlocBuilder<CategoriasBloc, CategoriasState>(
      builder: (context, state) {
        if (state.lista.isNotEmpty) {
          return DropdownButton<String>(
            dropdownColor: const Color.fromARGB(221, 35, 23, 37),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white,),
            elevation: 10,
            hint: const Text('Categoria', style: TextStyle(color: Colors.white),),
            style: const TextStyle(
              fontSize: 25,
            ),
            value: (BlocProvider.of<MovimientosBloc>(context)
                        .state
                        .movimiento
                        .categoria ==
                    '')
                ? dropdownCategoria
                : BlocProvider.of<MovimientosBloc>(context)
                    .state
                    .movimiento
                    .categoria,
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
                child: Text(
                  value.nombreCategoria,
                ),
              );
            }).toList(),
          );
        } else {
          return Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'Categorias');
                },
                child: const Text('Aun no hay Categorias creadas')),
          );
        }
      },
    );
  }

  Widget dropCuentasMovFicha() {
    return BlocBuilder<CuentasBloc, CuentasState>(
      builder: (context, state) {
        return DropdownButton<String>(
          value: (BlocProvider.of<MovimientosBloc>(context)
                      .state
                      .movimiento
                      .cuenta ==
                  '')
              ? dropdownCuenta
              : BlocProvider.of<MovimientosBloc>(context)
                  .state
                  .movimiento
                  .cuenta,
          dropdownColor: const Color.fromARGB(221, 35, 23, 37),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white,),
          elevation: 10,
          hint: const Text('Cuenta', style: TextStyle(color: Colors.white),),
          style: const TextStyle(
            fontSize: 25,
          ),
          onChanged: (String? newValue) {
            dropdownCuenta = newValue!;
            setState(() {
              dropdownCuenta;
            });
          },
          items: state.lista.map<DropdownMenuItem<String>>((CuentaModel value) {
            return DropdownMenuItem<String>(
              value: value.nombreCuenta,
              child: Text(value.nombreCuenta),
            );
          }).toList(),
        );
      },
    );
  }

  campoFechaMovFichaWidget(MovimientosState state, BuildContext context) {
    return TextField(
      style: const TextStyle(
        fontSize: 20,
      ),
      controller: dateinput,
      decoration: InputDecoration(
          icon: const Icon(Icons.calendar_today, color: Colors.white,),
          labelStyle: const TextStyle(color: Colors.white),
          labelText: (state.movimiento.fecha == '')
              ? "Elija fecha"
              : state.movimiento.fecha),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: (state.movimiento.fecha == '')
                ? DateTime.now()
                : DateTime.parse(state.movimiento.fecha),
            firstDate: DateTime(2020),
            lastDate: DateTime(2030));
        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          setState(() {
            dateinput.text = formattedDate;
          });
        } else {
          print('No se eligio fecha');
        }
      },
    );
  }

  TextFormField campoValorMovFichaWidget(MovimientosState state) {
    return TextFormField(
      style: const TextStyle(
        fontSize: 20,
      ),
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
        setState(() {
          spValor;
        });
      },
    );
  }

  TextFormField campoDescMovFichaWidget(MovimientosState state) {
    return TextFormField(
      style: const TextStyle(
        fontSize: 25,
      ),
      decoration: const InputDecoration(
        labelStyle: TextStyle(color: Colors.white),
        labelText: 'Descripcion',
      ),
      initialValue: state.movimiento.descripcion,
      onChanged: (value) {
        spDescripcion = value;
        setState(() {
          spDescripcion;
        });
      },
    );
  }
}
