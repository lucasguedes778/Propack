import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:victor_hugo_app_prototype/customized_widgets/add_box_dialog.dart';
import 'package:victor_hugo_app_prototype/generalData.dart';
import 'customized_widgets/items_box.dart';

class BoxesFloor extends StatefulWidget{
  final Offset offset;

  BoxesFloor({Key key, this.offset}) : super(key: key);

  @override
  _BoxesFloorState createState() => _BoxesFloorState();
}

class _BoxesFloorState extends State<BoxesFloor>{

  final double _iconSize = 90;
  List<Widget> _tiles;
  List<ClientData> clients = <ClientData>[
    ClientData("1", 0,1),
  ];

  _addClientBox(String clientName, String damageType, double width, double height){
    _tiles.add(ItemsBox(clientName: clientName, context: context, damageType: damageType, width: width, height: height));
  }

  @override
  void initState() {
    super.initState();

    _tiles = <Widget>[];

    for(int i = 0; i < clients.length; i++){
      _addClientBox(clients[i].name,"Fire", 60,29);
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
                                    _addClientBox(newClientName, damageType, 29,80);
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


