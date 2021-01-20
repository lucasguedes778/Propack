import 'package:flutter/material.dart';
import 'damage_selector.dart';

//ignore: must_be_immutable
class AddBoxDialog extends StatefulWidget {
   String _newClientName;
  var dialogContext;
  Function onConfirm;

  AddBoxDialog({Key key, this.dialogContext, this.onConfirm}) : super(key: key);

  @override
  _AddBoxDialogState createState() => _AddBoxDialogState();
}

class _AddBoxDialogState extends State<AddBoxDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 400,
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        onChanged: (text){
                          widget._newClientName = text;
                        },
                        style: TextStyle(
                            color: Colors.black
                        ),
                        decoration: InputDecoration(
                          // border: InputBorder.none,
                            prefixIcon: Icon(Icons.person_add_alt_1),
                            hintStyle: TextStyle(
                                color: Colors.grey
                            ),
                            hintText: 'Digite o nome do cliente'
                        ),) ,
                      Padding(
                        padding: EdgeInsets.only(top:10.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right:10.0),
                              child: Text(
                                "Tipo de dano:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DamageSelector(),
                          ],
                        ),

                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          onPressed: (){
                            Navigator.pop(widget.dialogContext);
                          },
                          padding: EdgeInsets.all(0.0),
                          child: Container(
                            color: Colors.grey,
                            width: 100,
                            height: 50,
                            child: Center(
                              child: Text(
                                "Cancelar",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                        RaisedButton(
                          onPressed: (){
                            widget.onConfirm(widget._newClientName);
                            Navigator.pop(widget.dialogContext);
                          },
                          padding: EdgeInsets.all(0.0),
                          child: Container(
                            color: Colors.blue,
                            width: 100,
                            height: 50,
                            child: Center(
                              child: Text(
                                "Confirmar",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
          )
      ),
    );
  }
}

