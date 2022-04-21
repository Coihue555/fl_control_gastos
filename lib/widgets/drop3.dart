import 'package:flutter/material.dart';


class DropdownItem extends StatefulWidget {
  DropdownItem({Key? key}) : super(key: key);

  @override
  State<DropdownItem> createState() => DropdownItemState();
}

class DropdownItemState extends State<DropdownItem> {
  String? selectedValue;
  final _dropdownFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _dropdownFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButtonFormField(
                hint: const Text('Cuenta'),
                validator: (value) => value == null ? "Elija una cuenta" : null,
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                onTap: (){
                    if (_dropdownFormKey.currentState!.validate()) {  }
                  },
                items: dropdownItems
            ),
          ],
        ));
  }
}

List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = const [
    DropdownMenuItem(child: Text("USA"),value: "USA"),
    DropdownMenuItem(child: Text("Canada"),value: "Canada"),
    DropdownMenuItem(child: Text("Brazil"),value: "Brazil"),
    DropdownMenuItem(child: Text("England"),value: "England"),
  ];
  return menuItems;
}