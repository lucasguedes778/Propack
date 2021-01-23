import 'package:flutter/material.dart';

//ignore: must_be_immutable
class BoxInfoDialog extends StatefulWidget {
  String clientName;
  List<String> reasons;

  BoxInfoDialog({Key key, this.clientName, this.reasons}) : super(key: key);

  @override
  _BoxInfoDialogState createState() => _BoxInfoDialogState();
}

class _BoxInfoDialogState extends State<BoxInfoDialog> {

  List<Padding> getReasons(){
    List<Padding> reasons = List<Padding>();

    for(int i = 0; i < widget.reasons.length; i++){
      var iconColor;

      switch(widget.reasons[i]){
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
              " ${widget.reasons[i]}",
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
                              " ${widget.clientName}",
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
                    )
                  ],
                )
              ),
              Align(
                alignment: Alignment.bottomCenter,
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
              )
          ],
        ),
      ),
    );
  }
}