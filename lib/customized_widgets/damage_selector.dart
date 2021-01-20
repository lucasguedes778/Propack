import 'package:flutter/material.dart';

class DamageSelector extends StatefulWidget {
  @override
  _DamageSelectorState createState() => _DamageSelectorState();
}

class _DamageSelectorState extends State<DamageSelector> {
  String dropdownValue = "Fire";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_drop_down_circle_outlined),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Fire', 'Water', 'Mold']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}