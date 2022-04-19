import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({Key? key}) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String dropdownValue = 'Efectivo';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      underline: Container(
        height: 2,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Santander', 'Efectivo', 'Macro', 'MPago']
          .map<DropdownMenuItem<String>>((String value) {
            
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
          
        );
      }).toList(),

    );
  }
  
}
