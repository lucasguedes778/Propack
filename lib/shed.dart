import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'boxesFloor.dart';
import 'generalData.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:async/async.dart';

//ignore: must_be_immutable
class Shed extends StatefulWidget {
  FloorBoxesAmount boxesAmount = new FloorBoxesAmount(0, 0, 0);
  var clients = new List<List<ClientData>>.generate(3, (i)=> new List<ClientData>());
  var tiles = new List<List<Widget>>.generate(3, (i) => new List<Widget>());
  int shedIndex;

  Shed({Key key, this.shedIndex}) : super(key: key);

  @override
  _ShedState createState() => _ShedState();
}

class _ShedState extends State<Shed> {
  int counter = 0;
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  @override
  void initState() {

    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

  }

  Widget floor(int floor){
    if(counter == 3)
      return BoxesFloor(shedIndex:  widget.shedIndex,totalClients: widget.clients, shedTiles: widget.tiles,floor: floor,boxesAmount: widget.boxesAmount);

    return Center(
      child: Container(
        width: 70,
        height: 70,
        child: CircularProgressIndicator(),
      ),
    );
  }

  _fetchData() {
    return this._memoizer.runOnce(() async {
      for(int i = 1; i < 4; i++){
        await readShedData(i,widget.shedIndex).then((data){
          if(data != null){
            print("Stored data: $data");
            var decodedData = json.decode(data);
            for(int j = 0; j < decodedData.length; j++){
              decodedData[j]["reasons"] = decodedData[j]["reasons"].cast<String>().toList();
              print("${decodedData[j]}");
              setState((){
                setState((){
                  widget.clients[i-1].add(ClientData(decodedData[j]["name"], decodedData[j]["reasons"], decodedData[j]["content"],decodedData[j]["isPallet"]));
                });
              });
            }
          }
        });
      }

      return 'completed';

    });
  }



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  child: Text(
                    "Sheds",
                    style: TextStyle(
                        fontSize: 36,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    // image: DecorationImage(
                    //   image: AssetImage("images/background_01.jpg"),
                    //   fit: BoxFit.cover
                    // ),
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.dashboard),
                      Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Text("Shed 1"),
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration.zero,
                        pageBuilder: (_, __, ___) => Shed(shedIndex: 1),
                      ),
                    );

                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.dashboard),
                      Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Text("Shed 2"),
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration.zero,
                        pageBuilder: (_, __, ___) => Shed(shedIndex: 2),
                      ),
                    );
                  },
                ),
              ]
              ,
            ),
          ),
          appBar: AppBar(
            title: Text("Propack"),
            bottom: TabBar(
              tabs: [
                Tab(text: "1st floor"),
                Tab(text: "2th floor"),
                Tab(text: "3th floor"),
              ],
            ),),
          body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children:[
                FutureBuilder(
                    future: this._fetchData(),
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        return BoxesFloor(shedIndex: widget.shedIndex,totalClients: widget.clients, shedTiles: widget.tiles,floor: 1,boxesAmount: widget.boxesAmount);
                      }
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator()
                        )
                      );
                    }),
                  FutureBuilder(
                      future: this._fetchData(),
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          return BoxesFloor(shedIndex: widget.shedIndex,totalClients: widget.clients, shedTiles: widget.tiles,floor: 2,boxesAmount: widget.boxesAmount);
                        }
                        return Container(
                            child: Center(
                                child: CircularProgressIndicator()
                            )
                        );
                      }),
                  FutureBuilder(
                      future: this._fetchData(),
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          return BoxesFloor(shedIndex: widget.shedIndex,totalClients: widget.clients, shedTiles: widget.tiles,floor: 3,boxesAmount: widget.boxesAmount);
                        }
                        return Container(
                            child: Center(
                                child: CircularProgressIndicator()
                            )
                        );
                      }),
              ]
          ),
        )
    );
  }
}




