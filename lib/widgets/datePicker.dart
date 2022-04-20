import 'package:flutter/material.dart';



class CustomDatePicker extends StatefulWidget {
  @override
  _CustomDatePickerState createState()
  {
    return _CustomDatePickerState();
  }
}

class _CustomDatePickerState extends State<CustomDatePicker> {
String date = "";
DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  _selectDate(context);
                },
              child: const Text("Choose Date"),
            ),
            Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}")
          ],
        ),
      );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025), 
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }
}