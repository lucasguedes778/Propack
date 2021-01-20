import 'package:flutter/material.dart';

//ignore: must_be_immutable
class ItemsBox extends StatefulWidget {
  String clientName;
  String damageType;
  var context;
  int width;
  int height;

  ItemsBox({Key key,this.clientName, this.context, this.damageType}) : super(key: key);

  @override
  _ItemsBoxState createState() => _ItemsBoxState();
}

class _ItemsBoxState extends State<ItemsBox> {

  getBoxColor(){
    switch(widget.damageType){
      case "Fire":{
        return Colors.deepOrange;
      }
      break;
      case "Water":{
        return Colors.blue;
      }
      break;
      case "Mold":{
        return Colors.green;
      }
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(

          child: InkWell(
            onDoubleTap: () {
              showDialog(
                  context: context,
                  builder: (context){
                    return Dialog(
                      child: Container(
                        width: 300,
                        height: 400,
                        child: Text(widget.clientName),
                      ),
                    );
                  }
              );
            },
            child: Text(
                widget.clientName,
                style: TextStyle(
                  fontSize: 7,
                  color: Colors.white
                ),
            ),
          )
      ),
      width: 29,
      height: 29,
      decoration: BoxDecoration(
          color: getBoxColor(),
          border: Border.all(color: Colors.black)
      ),
    );
  }
}
