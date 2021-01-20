import 'package:flutter/material.dart';

//ignore: must_be_immutable
class DamageSelector extends StatefulWidget {
  Function onSelected;
  DamageSelector({Key key, this.onSelected}) : super(key: key);

  @override
  _DamageSelectorState createState() => _DamageSelectorState();
}

class _DamageSelectorState extends State<DamageSelector> {
  String dropdownValue = "None";

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
          widget.onSelected(dropdownValue);
        });
      },
      items: <String>['Fire', 'Water', 'Mold', "None"]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}