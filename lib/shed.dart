import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:victor_hugo_app_prototype/boxesFloor.dart';
import 'package:victor_hugo_app_prototype/generalData.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

//ignore: must_be_immutable
class Shed extends StatefulWidget {
  FloorBoxesAmount boxesAmount = new FloorBoxesAmount(0, 0, 0);
  var clients = new List<List<ClientData>>.generate(3, (i)=> new List<ClientData>());
  var tiles = new List<List<Widget>>.generate(3, (i) => new List<Widget>());

  @override
  _ShedState createState() => _ShedState();
}

class _ShedState extends State<Shed> {
  int counter = 0;
  @override
  void initState() {

    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    for(int i = 1; i < 4; i++){
      readShedData(i).then((data){
        if(data != null){
          // print("Stored data: $data");
          // print(this.mounted);
          var decodedData = json.decode(data);
          for(int j = 0; j < decodedData.length; j++){
            decodedData[j]["reasons"] = decodedData[j]["reasons"].cast<String>().toList();
            setState((){
              setState((){
                widget.clients[i-1].add(ClientData(decodedData[j]["name"], decodedData[j]["reasons"], decodedData[j]["content"],decodedData[j]["isPallet"]));
              });
            });
          }
        }

        counter += 1;
      });

    }
    print("Finalizando!");

  }

  Widget firstFloor(){
    return (counter == 3) ? BoxesFloor(totalClients: widget.clients, shedTiles: widget.tiles,floor: 1,boxesAmount: widget.boxesAmount) : CircularProgressIndicator();
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
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
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
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
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
                firstFloor(),
                BoxesFloor(totalClients: widget.clients, shedTiles: widget.tiles,floor: 2,boxesAmount: widget.boxesAmount),
                BoxesFloor(totalClients: widget.clients,shedTiles: widget.tiles,floor: 3,boxesAmount: widget.boxesAmount)
              ]
          ),
        )
    );
  }
}




