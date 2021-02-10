import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import '../generalData.dart';

//ignore: must_be_immutable
class BoxInfoDialog extends StatefulWidget {
  ClientData client;
  final VoidCallback onRemovePressed;


  BoxInfoDialog({Key key, this.client , @required this.onRemovePressed}) : super(key: key);

  @override
  _BoxInfoDialogState createState() => _BoxInfoDialogState();
}

class _BoxInfoDialogState extends State<BoxInfoDialog> {

  List<Padding> getReasons(){
    List<Padding> reasons = List<Padding>();

    for(int i = 0; i < widget.client.reasons.length; i++){
      var iconColor;

      switch(widget.client.reasons[i]){
        case "Fire":{
          iconColor = Colors.deepOrange;
        }
        break;
        case "Water":{
          iconColor = Colors.blue;
        }
        break;
        case "Mold":{
          iconColor = Colors.green;
        }
        break;
        case "Floor change":{
          iconColor = Colors.grey;
        }
        break;
      }

      reasons.add(Padding(
        padding: EdgeInsets.only(right:10.0),
        child: Row(
          children: [
            Icon(Icons.circle,size: 15, color:iconColor),
            Text(
              " ${widget.client.reasons[i]}",
              style: TextStyle(
                fontSize: 9
              ),
            )
          ],
        ),
      ));
    }

    return reasons;

  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        width: 300,
        height: 400,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom:10),
                      child: Row(
                        children: [
                          Text(
                            "Name:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            " ${widget.client.name}",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding:EdgeInsets.only(bottom:10.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Reasons:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: getReasons(),
                        )

                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding:EdgeInsets.only(top:10,bottom:10.0),
                          child: Align(
                            alignment: Alignment.
                            topLeft,
                            child: Text(
                              "Content:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("${(widget.client.content != null) ? widget.client.content : "Unknow"}")
                        )

                      ],
                    )
                  ],
                )
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.all(3),
                child: InkWell(
                  onTap: (){
                    print("Editando...");
                  },
                  child: Text(
                      "EDIT",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline,
                      )
                ),
                )
              )
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: (){
                        widget.onRemovePressed();
                      },
                      padding: EdgeInsets.all(0),
                      child: Container(
                        color: Colors.red,
                        width: 100,
                        height: 50,
                        child: Center(
                          child: Text(
                            "Remove",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left:10.0),
                      child: RaisedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.all(0),
                        child: Container(
                          color: Colors.blue,
                          width: 100,
                          height: 50,
                          child: Center(
                            child: Text(
                              "OK",
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
