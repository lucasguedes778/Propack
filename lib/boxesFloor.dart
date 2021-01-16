import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:victor_hugo_app_prototype/generalData.dart';

Container getBoxItems(String clientName){
  return Container(
    padding: EdgeInsets.all(3),
    child: Center(
      child: Text(
          clientName,
          style: TextStyle(fontSize: 10)
      ),
    ),
    width: 47,
    height: 47,
    decoration: BoxDecoration(
        border: Border.all(color: Colors.black)
    ),
  );
}


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
    ClientData("Cliente 1", 0,1),
    ClientData("Cliente 2", 0,2),
    ClientData("Cliente 3", 0,3),
    ClientData("Cliente 4", 0,3),
    ClientData("Cliente 5", 0,3),
    ClientData("Cliente 6", 0,3),
    ClientData("Cliente 7", 0,3),
  ];

  @override
  void initState() {
    super.initState();

    _tiles = <Widget>[];

    for(int i = 0; i < clients.length; i++){
      _tiles.add(getBoxItems(clients[i].name));
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

    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        wrap,
        Padding(
          padding: EdgeInsets.all(16.0),
          child: TextField(
            onChanged: (text){
              newClientName = text;
            },
            decoration: InputDecoration(
//              border: InputBorder.none,
                hintText: 'Digite o nome do cliente'
            ),) ,
        ),
        ButtonBar(
          alignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              iconSize: 50,
              icon: Icon(Icons.add_circle),
              color: Colors.blue,
              padding: const EdgeInsets.all(0.0),
              onPressed: () {
                var newTile = getBoxItems(newClientName);
                newClientName = "";
                setState(() {
                  _tiles.add(newTile);
                });
              },
            ),
//            IconButton(
//              iconSize: 50,
//              icon: Icon(Icons.remove_circle),
//              color: Colors.teal,
//              padding: const EdgeInsets.all(0.0),
//              onPressed: () {
//                setState(() {
//                  _tiles.removeAt(0);
//                });
//              },
//            ),
          ],
        ),
      ],
    );

    return SingleChildScrollView(
        child: column,
    );
  }
}