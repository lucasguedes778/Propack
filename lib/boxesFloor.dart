import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:victor_hugo_app_prototype/generalData.dart';

Container getBoxItems(String clientName, context){
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
                      child: Text(clientName),
                    ),
                  );
                }
            );
          },
        child: Text(clientName),
      )
    ),
    width: 29,
    height: 29,
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
      _tiles.add(getBoxItems(clients[i].name, context));
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
      // crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.end,

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
                              child: Container(
                                width: 300,
                                height: 400,
                                child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Container(
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              TextField(
                                                onChanged: (text){
                                                  newClientName = text;
                                                },
                                                style: TextStyle(
                                                    color: Colors.black
                                                ),
                                                decoration: InputDecoration(
                                                  // border: InputBorder.none,
                                                    prefixIcon: Icon(Icons.person_add_alt_1),
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey
                                                    ),
                                                    hintText: 'Digite o nome do cliente'
                                                ),) ,
                                              Padding(
                                                  padding: EdgeInsets.only(top:10.0),
                                                  child: Text(
                                                  "Tipo de dano:",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),

                                              )
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                RaisedButton(
                                                  onPressed: (){
                                                    Navigator.pop(dialogContext);
                                                  },
                                                  padding: EdgeInsets.all(0.0),
                                                  child: Container(
                                                    color: Colors.grey,
                                                    width: 100,
                                                    height: 50,
                                                    child: Center(
                                                      child: Text(
                                                        "Cancelar",
                                                        style: TextStyle(
                                                            color: Colors.white
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                RaisedButton(
                                                  padding: EdgeInsets.all(0.0),
                                                  child: Container(
                                                    color: Colors.blue,
                                                    width: 100,
                                                    height: 50,
                                                    child: Center(
                                                      child: Text(
                                                        "Confirmar",
                                                        style: TextStyle(
                                                            color: Colors.white
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    )
                                ),
                              ),
                            );
                          }
                      );
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
              )
          )

      ],
    );

    return Container(
        child: component
    );
  }
}