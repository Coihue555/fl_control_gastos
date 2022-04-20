import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({Key? key}) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? _selectedDate;
  String? fechaElegida;

  String _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return null;
      }
      setState(() {
        _selectedDate = pickedDate;
        String fechaElegida = DateFormat('yyyy-MM-dd').format(_selectedDate!);
        print(fechaElegida);
      });
    });

    return fechaElegida ?? '';
  }
  

  @override
  Widget build(BuildContext context) {

    
    return ElevatedButton(
            onPressed: _presentDatePicker, child: const Text('Fecha')
    );
  }
}