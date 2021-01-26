import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:victor_hugo_app_prototype/customized_widgets/add_box_dialog.dart';
import 'package:victor_hugo_app_prototype/generalData.dart';
import 'customized_widgets/items_box.dart';
import 'customized_widgets/box_info_dialog.dart';

//ignore: must_be_immutable
class BoxesFloor extends StatefulWidget{
  final Offset offset;
  List<ClientData> clients;
  int floor;
  FloorBoxesAmount boxesAmount;

  BoxesFloor({Key key, this.offset,@required this.clients,@required this.floor, @required this.boxesAmount}) : super(key: key);

  @override
  _BoxesFloorState createState() => _BoxesFloorState();
}

class _BoxesFloorState extends State<BoxesFloor>{

  List<Widget> _tiles;
  double zoomScale = 4.5;
  TransformationController controller = TransformationController();

  _addClientBox(String clientName, List<String> damageTypes){
    final int lastIndex = _tiles.length;

    _tiles.add(ItemsBox(
        clientName: clientName,
        context: context,
        damageTypes: damageTypes,
        onDoubleTap: (){
          showDialog(
              context: context,
              builder: (context){
                return BoxInfoDialog(
                    clientName: clientName,
                    reasons: damageTypes,
                    onRemovePressed: (){
                      showDialog(
                          context: context,
                          builder: (context){
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
                                                switch(widget.floor){
                                                  case 1:{
                                                    if(widget.boxesAmount.floor_2 < widget.boxesAmount.floor_1){
                                                      setState(() {
                                                        _tiles.removeAt(lastIndex);
                                                        widget.clients.removeAt(lastIndex);
                                                        widget.boxesAmount.removeToFirst();
                                                        Navigator.pop(context,true);
                                                      });
                                                    }else{
                                                      Navigator.pop(context,false);
                                                    }
                                                  }
                                                  break;
                                                  case 2:{
                                                    if(widget.boxesAmount.floor_3 < widget.boxesAmount.floor_2){
                                                      setState(() {
                                                        _tiles.removeAt(lastIndex);
                                                        widget.clients.removeAt(lastIndex);
                                                        widget.boxesAmount.removeToSecond();
                                                        Navigator.pop(context,true);
                                                      });
                                                    }else{
                                                      Navigator.pop(context,false);
                                                    }
                                                  }
                                                  break;
                                                  case 3:{
                                                    setState(() {
                                                      _tiles.removeAt(lastIndex);
                                                      widget.clients.removeAt(lastIndex);
                                                      widget.boxesAmount.removeToThird();
                                                      Navigator.pop(context,true);
                                                    });
                                                  }
                                                  break;
                                                }
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
                      ).then((value) {
                        if(value){
                          Navigator.pop(context);
                        }
                      });
                    },
                );
              }
          );
        }
    ));
    if(zoomScale/1.3 >= 1.0){
      if(_tiles.length > 2){
        zoomScale = zoomScale/1.3;
      }
    }else{
      zoomScale = 1.0;
    }

  }

  @override
  void initState() {
    super.initState();

    _tiles = <Widget>[];

    for(int i = 0; i < widget.clients.length; i++){
      _addClientBox(widget.clients[i].name, widget.clients[i].reasons);
    }

    controller.value = Matrix4(
      zoomScale,0,0,0,
      0,zoomScale,0,0,
      0,0,zoomScale,0,
      0,0,0,1.0,
    );

  }



  @override
  Widget build(BuildContext context) {

    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        Widget row = _tiles.removeAt(oldIndex);
        ClientData element = widget.clients.removeAt(oldIndex);
        widget.clients.insert(newIndex,element);
        _tiles.insert(newIndex, row);
      });
    }

    var wrap = ReorderableWrap(
        maxMainAxisCount: 11,
        spacing: 2.0,
        runSpacing: 4.0,
        padding: const EdgeInsets.all(8),
        children: _tiles,
        onReorder: _onReorder,
        onNoReorder: (int index) {
          //this callback is optional
          debugPrint('${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
        },
        onReorderStarted: (int index) {
          //this callback is optional
          debugPrint('${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
        },
    );

    var component = Stack(
      children: <Widget>[
        Positioned.fill(
            child: InteractiveViewer(
                minScale: 1.0,
                maxScale: 4.5,
                transformationController: controller,
                child: wrap
            )
        ),
          Positioned(
              bottom: 0.0,
              right: 0.0,
              child: ButtonBar(
                alignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    iconSize: 50,
                    icon: Icon(Icons.add_circle),
                    color: Colors.blue,
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context){
                            var dialogContext = context;
                            return Dialog(
                              child: AddBoxDialog(
                                boxesAmount: widget.boxesAmount,
                                floor: widget.floor,
                                dialogContext: dialogContext,
                                onConfirm: (String newClientName, List<String>newClientReasons){
                                  setState(() {
                                    _addClientBox(newClientName, newClientReasons);
                                    widget.clients.add(ClientData(newClientName,newClientReasons, 0, 1));

                                    setState(() {
                                      controller.value = Matrix4(
                                        zoomScale,0,0,0,
                                        0,zoomScale,0,0,
                                        0,0,zoomScale,0,
                                        0,0,0,1.0,
                                      );
                                    });

                                  });
                                },
                              ),
                            );
                          }
                      );
                    },
                  ),
                ],
              )
          )

      ],
    );

    return Container(
        child: component
    );
  }
}


