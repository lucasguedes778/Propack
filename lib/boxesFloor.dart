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
    ClientData("2", 0,2),
    ClientData("3", 0,3),
    ClientData("4", 0,3),
    ClientData("5", 0,3),
    ClientData("6", 0,3),
    ClientData("7", 0,3),
    ClientData("8", 0,3),
    ClientData("9", 0,3),
    ClientData("10", 0,3),
    ClientData("11", 0,3),
    ClientData("12", 0,1),
    ClientData("13", 0,2),
    ClientData("14", 0,3),
    ClientData("15", 0,3),
    ClientData("16", 0,3),
    ClientData("17", 0,3),
    ClientData("18", 0,3),
    ClientData("19", 0,3),
    ClientData("20", 0,3),
    ClientData("21", 0,3),
    ClientData("22", 0,3),
    ClientData("23", 0,1),
    ClientData("24", 0,2),
    ClientData("25", 0,3),
    ClientData("26", 0,3),
    ClientData("27", 0,3),
    ClientData("28", 0,3),
    ClientData("29", 0,3),
    ClientData("30", 0,3),
    ClientData("31", 0,3),
    ClientData("32", 0,3),
    ClientData("33", 0,3),

  ];

  @override
  void initState() {
    super.initState();

    _tiles = <Widget>[];

    for(int i = 0; i < clients.length; i++){
      _tiles.add(ItemsBox(clientName: clients[i].name, context: context));
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
                              child: AddBoxDialog(dialogContext: dialogContext),
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


