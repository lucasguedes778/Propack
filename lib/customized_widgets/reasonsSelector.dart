import 'package:flutter/material.dart';

//ignore: must_be_immutable
class ReasonsSelector extends StatefulWidget {

  List<String> reasons;

  ReasonsSelector({Key key,@required this.reasons}) : super(key: key);

  @override
  _ReasonsSelectorState createState() => _ReasonsSelectorState();
}

class _ReasonsSelectorState extends State<ReasonsSelector> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Row(
                  children: [
                    Checkbox(
                        value: widget.reasons.where((element) => element == "Fire").length == 1,
                        onChanged: (value){
                          setState(() {
                            if(value == true){
                              widget.reasons.add("Fire");
                            }else{
                              widget.reasons.remove("Fire");
                            }
                          });

                        }
                    ),
                    Text(
                      "Fire",
                      style: TextStyle(
                          fontSize: 12
                      ),
                    ),
                  ],
                )
            ),
            Expanded(
                child: Row(
                  children: [
                    Checkbox(
                        value: widget.reasons.where((element) => element == "Water").length == 1,
                        onChanged: (value){
                          setState(() {
                            if(value == true){
                              widget.reasons.add("Water");
                            }else{
                              widget.reasons.remove("Water");
                            }
                          });

                        }
                    ),
                    Text(
                      "Water",
                      style: TextStyle(
                          fontSize: 12
                      ),
                    )
                  ],
                )
            )
          ],
        ),
        Row(
          children: [
            Expanded(
                child: Row(
                  children: [
                    Checkbox(
                        value: widget.reasons.where((element) => element == "Mold").length == 1,
                        onChanged: (value){
                          setState(() {
                            if(value == true){
                              widget.reasons.add("Mold");
                            }else{
                              widget.reasons.remove("Mold");
                            }
                          });

                        }
                    ),
                    Text(
                      "Mold",
                      style: TextStyle(
                          fontSize: 12
                      ),
                    ),
                  ],
                )
            ),
            Expanded(
                child: Row(
                  children: [
                    Checkbox(
                        value: widget.reasons.where((element) => element == "Floor change").length == 1,
                        onChanged: (value){
                          setState(() {
                            if(value == true){
                              widget.reasons.add("Floor change");
                            }else{
                              widget.reasons.remove("Floor change");
                            }
                          });

                        }
                    ),
                    Text(
                      "Floor change",
                      style: TextStyle(
                          fontSize: 12
                      ),
                    )
                  ],
                )
            )
          ],
        )
      ],
    );
  }
}
