import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:victor_hugo_app_prototype/customized_widgets/add_box_dialog.dart';
import 'package:victor_hugo_app_prototype/generalData.dart';
import 'customized_widgets/items_box.dart';

//ignore: must_be_immutable
class BoxesFloor extends StatefulWidget{
  final Offset offset;
  List<ClientData> clients;


  BoxesFloor({Key key, this.offset, this.clients}) : super(key: key);

  @override
  _BoxesFloorState createState() => _BoxesFloorState();
}

class _BoxesFloorState extends State<BoxesFloor>{

  final double _iconSize = 90;
  List<Widget> _tiles;
  double zoomScale = 4.5;
  TransformationController controller = TransformationController();


  _addClientBox(String clientName, String damageType){
    _tiles.add(ItemsBox(clientName: clientName, context: context, damageType: damageType));
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

    controller.value = Matrix4(
      zoomScale,0,0,0,
      0,zoomScale,0,0,
      0,0,zoomScale,0,
      0,0,0,1.0,
    );

    _tiles = <Widget>[];

    for(int i = 0; i < widget.clients.length; i++){
      _addClientBox(widget.clients[i].name, widget.clients[i].damageType);
    }

  }



  @override
  Widget build(BuildContext context) {
    String newClientName;

    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        Widget row = _tiles.removeAt(oldIndex);
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
        }
    );

    var component = Stack(
      children: <Widget>[
        Positioned.fill(
            child: InteractiveViewer(
                minScale: 1.0,
                maxScale: 4.5,
                onInteractionUpdate: (value){
                  print(controller.value);
                },
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
                      // var newTile = getBoxItems(newClientName);
                      // newClientName = "";
                      // setState(() {
                      //   _tiles.add(newTile);
                      // });
                      showDialog(
                          context: context,
                          builder: (context){
                            var dialogContext = context;
                            return Dialog(
                              child: AddBoxDialog(
                                dialogContext: dialogContext,
                                onConfirm: (String newClientName, String damageType){
                                  setState(() {
                                    _addClientBox(newClientName, damageType);
                                    widget.clients.add(ClientData(newClientName,damageType, 0, 1));

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


