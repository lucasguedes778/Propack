import 'package:flutter/material.dart';

//ignore: must_be_immutable
class ItemsBox extends StatefulWidget {
  String clientName;
  var context;
  int width;
  int height;

  ItemsBox({Key key,this.clientName, this.context}) : super(key: key);

  @override
  _ItemsBoxState createState() => _ItemsBoxState();
}

class _ItemsBoxState extends State<ItemsBox> {

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
                ),
            ),
          )
      ),
      width: 29,
      height: 29,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black)
      ),
    );
  }
}
