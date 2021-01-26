import 'package:flutter/material.dart';

//ignore: must_be_immutable
class ItemsBox extends StatefulWidget {
  String clientName;
  List<String> damageTypes;
  var context;
  final VoidCallback onDoubleTap;

  ItemsBox({Key key,this.clientName, this.context, this.damageTypes, this.onDoubleTap}) : super(key: key);

  @override
  _ItemsBoxState createState() => _ItemsBoxState();
}

class _ItemsBoxState extends State<ItemsBox> {

  Row getDamageIndicators(){

    List<Icon> indicators = List<Icon>();

    if(widget.damageTypes.contains("Fire")){
      indicators.add(Icon(Icons.circle,size: 4,color: Colors.deepOrange));
    }

    if(widget.damageTypes.contains("Water")){
      indicators.add(Icon(Icons.circle,size: 4,color: Colors.blue));
    }

    if(widget.damageTypes.contains("Mold")){
      indicators.add(Icon(Icons.circle,size: 4,color: Colors.green));
    }

    if(widget.damageTypes.contains("Floor change")){
      indicators.add(Icon(Icons.circle,size: 4,color: Colors.grey));
    }

    return Row(
        children: indicators);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(

          child: InkWell(
            onDoubleTap: () {
              widget.onDoubleTap();
            },
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.clientName,
                    style: TextStyle(
                        fontSize: 5,
                        color: Colors.black
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: getDamageIndicators(),
                  ),

              ],
            )
          )
      ),
      width: 29,
      height: 29,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black)
      ),
    );
  }
}
