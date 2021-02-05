import 'package:flutter/material.dart';
import '../generalData.dart';

//ignore: must_be_immutable
class AddBoxDialog extends StatefulWidget {
   List<List<ClientData>> totalClients;
   String _newClientName = "";
   List<String> _newClientReasons = List<String>();
   String _newClientContent;
   bool isPallet = false;
   FloorBoxesAmount boxesAmount;
   int floor;

   //Checkboxes variables
   var fireSelected = false, moldSelected=false,fcSelected=false,waterSelected=false;

   var dialogContext;
   Function onConfirm;

  AddBoxDialog({Key key,this.totalClients, this.dialogContext, this.onConfirm,@required this.floor, @required this.boxesAmount}) : super(key: key);

  @override
  _AddBoxDialogState createState() => _AddBoxDialogState();
}

class _AddBoxDialogState extends State<AddBoxDialog> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 450,
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
                            hintText: "Type the client's name"
                        ),) ,
                      Padding(
                        padding: EdgeInsets.only(top:10.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Reasons:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),

                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Checkbox(
                                          value: widget.fireSelected,
                                          onChanged: (value){
                                            setState(() {
                                              widget.fireSelected = value;
                                            });
                                            if(value == true){
                                              widget._newClientReasons.add("Fire");
                                            }else{
                                              widget._newClientReasons.remove("Fire");
                                            }
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
                                            value: widget.waterSelected,
                                            onChanged: (value){
                                              setState(() {
                                                widget.waterSelected = value;
                                              });
                                              if(value == true){
                                                widget._newClientReasons.add("Water");
                                              }else{
                                                widget._newClientReasons.remove("Water");
                                              }
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
                                            value: widget.moldSelected,
                                            onChanged: (value){
                                              setState(() {
                                                widget.moldSelected = value;
                                              });
                                              if(value == true){
                                                widget._newClientReasons.add("Mold");
                                              }else{
                                                widget._newClientReasons.remove("Mold");
                                              }
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
                                            value: widget.fcSelected,
                                            onChanged: (value){
                                              setState(() {
                                                widget.fcSelected = value;
                                              });
                                              if(value == true){
                                                widget._newClientReasons.add("Floor change");
                                              }else{
                                                widget._newClientReasons.remove("Floor change");
                                              }
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
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Content:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: TextField(
                                  onChanged: (text){
                                    print("$text");
                                    widget._newClientContent = text;
                                  },
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                      labelText: "Type the content that is inside the box.",
                                      border: OutlineInputBorder()
                                  )
                              )
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    Switch(
                                      onChanged: (value){
                                        setState(() {
                                          widget.isPallet = value;
                                        });
                                      },
                                      value: widget.isPallet,
                                    ),
                                    Text("Is a pallet",),

                                  ],
                                )
                            )
                          ],
                        ),

                      ),
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
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                        RaisedButton(
                          color: Colors.blue,
                          onPressed: (){
                            if(widget._newClientName != "" && widget._newClientReasons.length != 0){
                              switch(widget.floor){
                                case 1:{
                                  widget.onConfirm(widget._newClientName, widget._newClientReasons, widget._newClientContent, widget.isPallet);
                                }
                                break;
                                case 2:{
                                  if(widget.totalClients[widget.floor-2].length > widget.totalClients[widget.floor-1].length){
                                    widget.onConfirm(widget._newClientName, widget._newClientReasons, widget._newClientContent, widget.isPallet);
                                  }
                                }
                                break;
                                case 3:{
                                  if(widget.totalClients[widget.floor-2].length > widget.totalClients[widget.floor-1].length){
                                    widget.onConfirm(widget._newClientName, widget._newClientReasons, widget._newClientContent,widget.isPallet);
                                  }
                                }
                                break;
                              }
                              Navigator.pop(widget.dialogContext);
                            }
                          },
                          padding: EdgeInsets.all(0.0),
                          child: Container(
                            width: 100,
                            height: 50,
                            child: Center(
                              child: Text(
                                "Confirm",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              )
          )
      ),
    );
  }
}

