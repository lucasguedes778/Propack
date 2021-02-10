import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:victor_hugo_app_prototype/customized_widgets/add_box_dialog.dart';
import 'package:victor_hugo_app_prototype/customized_widgets/reasonsSelector.dart';
import '../generalData.dart';

//ignore: must_be_immutable
class BoxInfoDialog extends StatefulWidget {
  List<List<ClientData>> clients;
  int clientIndex;
  int floor;
  final VoidCallback onRemovePressed;
  bool editMode = false;

  BoxInfoDialog({Key key, this.clients, this.clientIndex, @required this.floor , @required this.onRemovePressed}) : super(key: key);

  @override
  _BoxInfoDialogState createState() => _BoxInfoDialogState();
}

class _BoxInfoDialogState extends State<BoxInfoDialog> {

  List<Padding> getReasons(){
    List<Padding> reasons = List<Padding>();

    for(int i = 0; i < widget.clients[widget.floor-1][widget.clientIndex].reasons.length; i++){
      var iconColor;

      switch(widget.clients[widget.floor-1][widget.clientIndex].reasons[i]){
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
              " ${widget.clients[widget.floor-1][widget.clientIndex].reasons[i]}",
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
        height: 500,
        child: Stack(
          children: [
            SingleChildScrollView(
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
                                  "Name: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                (widget.editMode == null || widget.editMode == false) ? Text(
                                  " ${widget.clients[widget.floor-1][widget.clientIndex].name}",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ) : Expanded(
                                  child: TextField(
                                    controller: TextEditingController()..text = "${widget.clients[widget.floor-1][widget.clientIndex].name}",
                                    onChanged: (text){
                                      widget.clients[widget.floor-1][widget.clientIndex].name = text;
                                    },
                                    style: TextStyle(
                                        color: Colors.black
                                    ),
                                    decoration: InputDecoration(
                                      // border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            color: Colors.grey
                                        ),
                                        hintText: "."
                                    ),),
                                ),
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
                              (widget.editMode == null || widget.editMode == false ) ? Row(
                                children:  getReasons(),
                              ) : ReasonsSelector(reasons: widget.clients[widget.floor-1][widget.clientIndex].reasons)

                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:EdgeInsets.only(top:10,bottom:10.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
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
                                  child: (widget.editMode == null || widget.editMode == false) ? Text("${(widget.clients[widget.floor-1][widget.clientIndex].content != null) ? widget.clients[widget.floor-1][widget.clientIndex].content : "Unknow"}") :  TextField(
                                      controller: TextEditingController()..text = "${(widget.clients[widget.floor-1][widget.clientIndex].content != null) ? widget.clients[widget.floor-1][widget.clientIndex].content : "Unknow"}",
                                      onChanged: (text){
                                        widget.clients[widget.floor-1][widget.clientIndex].content = text;
                                      },
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                          labelText: "Type the content that is inside the box.",
                                          border: OutlineInputBorder()
                                      )
                                  )
                              ),
                              (widget.editMode == true) ? Align(
                                alignment: Alignment.bottomLeft,
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        Switch(
                                          onChanged: (value){
                                            setState(() {
                                              widget.clients[widget.floor-1][widget.clientIndex].isPallet = value;
                                              print("here: ${widget.clients[widget.floor-1][widget.clientIndex].isPallet}");
                                            });
                                          },
                                          value: widget.clients[widget.floor-1][widget.clientIndex].isPallet,
                                        ),
                                        Text("Is a pallet",),

                                      ],
                                    )
                                ),
                              ) : Container(),

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
                              // Navigator.pop(context);
                              setState(() {
                                if(widget.editMode == null)
                                  widget.editMode = true;
                                else{
                                  if(widget.editMode == true){
                                    saveShedData(widget.clients[widget.floor-1], widget.floor);
                                  }
                                  widget.editMode = !widget.editMode;
                                }


                              });
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
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
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

                            setState(() {
                              saveShedData(widget.clients[widget.floor-1], widget.floor);
                            });

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
                  ),
                )
            ),

          ],
        ),
      ),
    );
  }
}
