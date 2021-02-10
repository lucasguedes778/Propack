import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:victor_hugo_app_prototype/customized_widgets/add_box_dialog.dart';
import 'package:victor_hugo_app_prototype/customized_widgets/reasonsSelector.dart';
import '../generalData.dart';

//ignore: must_be_immutable
class BoxInfoDialog extends StatefulWidget {
  ClientData client;
  int floor;
  final VoidCallback onRemovePressed;
  bool editMode = false;

  BoxInfoDialog({Key key, this.client, @required this.floor , @required this.onRemovePressed}) : super(key: key);

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
        height: 450,
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
                                  "Name:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                (widget.editMode == null || widget.editMode == false) ? Text(
                                  " ${widget.client.name}",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ) : Expanded(
                                  child: TextField(
                                    controller: TextEditingController()..text = " ${widget.client.name}",
                                    onChanged: (text){

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
                              ) : ReasonsSelector(reasons: widget.client.reasons)

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
                                  child: (widget.editMode == null || widget.editMode == false) ? Text("${(widget.client.content != null) ? widget.client.content : "Unknow"}") :  TextField(
                                      controller: TextEditingController()..text = "${(widget.client.content != null) ? widget.client.content : "Unknow"}",
                                      onChanged: (text){
                                      },
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                          labelText: "Type the content that is inside the box.",
                                          border: OutlineInputBorder()
                                      )
                                  )
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
                              // Navigator.pop(context);
                              setState(() {
                                if(widget.editMode == null)
                                  widget.editMode = true;
                                else
                                  widget.editMode = !widget.editMode;
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
