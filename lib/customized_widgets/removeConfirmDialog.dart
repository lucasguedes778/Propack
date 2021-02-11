import 'package:flutter/material.dart';
import '../generalData.dart';

//ignore: must_be_immutable
class RemoveConfirmation extends StatefulWidget {
  List<List<ClientData>> totalClients;
  List<List<Widget>> shedTiles;
  VoidCallback onRemovePressed;
  Function addBox;
  int floor;
  int index;

  RemoveConfirmation({Key key,this.onRemovePressed,this.addBox, this.totalClients, this.shedTiles, this.floor, this.index}) : super(key: key);

  @override
  _RemoveConfirmationState createState() => _RemoveConfirmationState();
}

class _RemoveConfirmationState extends State<RemoveConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
            padding: EdgeInsets.all(20),
            width: 250,
            height: 200,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Are you sure?",
                    style: TextStyle(
                        fontSize: 22
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          onPressed: (){
                            Navigator.pop(context,false);
                          },
                          padding: EdgeInsets.all(0),
                          child: Container(
                            color: Colors.grey,
                            width: 100,
                            height: 50,
                            child: Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                        RaisedButton(
                          onPressed: (){
                            widget.onRemovePressed();
                            Navigator.pop(context,true);
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
                      ],
                    )
                ),
              ],
            )
        )
    );
  }
}
