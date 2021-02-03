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
  List<List<ClientData>>totalClients;
  List<List<Widget>>shedTiles;
  List<ClientData> clients;
  int floor;
  FloorBoxesAmount boxesAmount;

  BoxesFloor({Key key, this.offset,@required this.totalClients,@required this.shedTiles,@required this.floor, @required this.boxesAmount}) : super(key: key);

  @override
  _BoxesFloorState createState() => _BoxesFloorState();
}

class _BoxesFloorState extends State<BoxesFloor>{
  double zoomScale = 4.5;
  TransformationController controller = TransformationController();

  _addClientBox(String clientName, List<String> damageTypes, String boxContent, bool isPallet){
    final int lastIndex = widget.shedTiles[widget.floor-1].length;
    widget.shedTiles[widget.floor-1].add(ItemsBox(
        clientName: clientName,
        context: context,
        damageTypes: damageTypes,
        isPallet: isPallet,
        onDoubleTap: (){
          showDialog(
              context: context,
              builder: (context){
                return BoxInfoDialog(
                    clientName: clientName,
                    reasons: damageTypes,
                    boxContent: boxContent,
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
                                                if(widget.floor < 3){
                                                  if(widget.totalClients[widget.floor].length < widget.totalClients[widget.floor-1].length){
                                                    setState(() {
                                                      widget.shedTiles[widget.floor-1].removeAt(lastIndex);
                                                      widget.totalClients[widget.floor-1].removeAt(lastIndex);
                                                    });
                                                  }else{
                                                    setState(() {
                                                      widget.shedTiles[widget.floor-1].removeAt(lastIndex);
                                                      widget.totalClients[widget.floor-1].removeAt(lastIndex);

                                                      var element_2 = widget.totalClients[widget.floor].removeAt(lastIndex);
                                                      widget.totalClients[widget.floor-1].insert(lastIndex, element_2);
                                                      _addClientBox(element_2.name, element_2.reasons, element_2.content, element_2.isPallet);

                                                      if(widget.floor == 1){
                                                        if(widget.totalClients[widget.floor+1].length > widget.totalClients[widget.floor].length){
                                                          var element_3 = widget.totalClients[widget.floor+1].removeAt(lastIndex);
                                                          widget.totalClients[widget.floor].insert(lastIndex,element_3);
                                                        }
                                                      }
                                                    });
                                                  }
                                                }else{
                                                  setState(() {
                                                    widget.shedTiles[widget.floor-1].removeAt(lastIndex);
                                                    widget.totalClients[widget.floor-1].removeAt(lastIndex);
                                                  });
                                                }
                                                for(int i = widget.floor; i < 4; i++){
                                                  saveShedData(widget.totalClients[i-1], i);
                                                }
                                                Navigator.pop(context,true);
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
      if(widget.shedTiles[widget.floor-1].length > 2){
        zoomScale = zoomScale/1.3;
      }
    }else{
      zoomScale = 1.0;
    }

  }

  isAbleToAdd(){
    return widget.floor == 1 || widget.totalClients[widget.floor - 2].length > widget.totalClients[widget.floor - 1].length;
  }

  showAddBoxDialog(){
    if(isAbleToAdd())
      return () {
        showDialog(
            context: context,
            builder: (context){
              var dialogContext = context;
              return Dialog(
                child: AddBoxDialog(
                  boxesAmount: widget.boxesAmount,
                  floor: widget.floor,
                  dialogContext: dialogContext,
                  onConfirm: (String newClientName, List<String>newClientReasons, String newClientContent, bool isPallet){
                    saveShedData(widget.totalClients[widget.floor-1], widget.floor);
                    setState(() {
                      _addClientBox(newClientName, newClientReasons, newClientContent,isPallet);
                      widget.totalClients[widget.floor-1].add(ClientData(newClientName,newClientReasons,newClientContent, isPallet));

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
      };

    return null;
  }

  @override
  void initState() {
    super.initState();

    widget.shedTiles[widget.floor-1] = <Widget>[];

    widget.clients = widget.totalClients[widget.floor-1];

    // print("floor: ${widget.floor}");
    // print("Clients:");
    // print(widget.clients);

    for(int i = 0; i < widget.totalClients[widget.floor-1].length; i++){
      _addClientBox(widget.totalClients[widget.floor-1][i].name, widget.totalClients[widget.floor-1][i].reasons,widget.totalClients[widget.floor-1][i].content,widget.totalClients[widget.floor-1][i].isPallet);
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
        Widget row = widget.shedTiles[widget.floor-1].removeAt(oldIndex);
        ClientData element = widget.totalClients[widget.floor-1].removeAt(oldIndex);
        widget.totalClients[widget.floor-1].insert(newIndex,element);
        widget.shedTiles[widget.floor-1].insert(newIndex, row);
      });
    }

    var wrap = ReorderableWrap(
        maxMainAxisCount: 11,
        spacing: 2.0,
        runSpacing: 4.0,
        padding: const EdgeInsets.all(8),
        children: widget.shedTiles[widget.floor-1],
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
                    onPressed: showAddBoxDialog(),
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


