import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:victor_hugo_app_prototype/boxesFloor.dart';
import 'package:victor_hugo_app_prototype/generalData.dart';
import 'package:flutter/services.dart';

//ignore: must_be_immutable
class Shed extends StatefulWidget {

  FloorBoxesAmount boxesAmount = new FloorBoxesAmount(0, 0, 0);

  List<ClientData> clients_1st = new List<ClientData>();

  List<ClientData> clients_2th = new List<ClientData>();

  List<ClientData> clients_3th = new List<ClientData>();

  @override
  _ShedState createState() => _ShedState();
}

class _ShedState extends State<Shed> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    readShedData().then((data){
      print("Stored data: $data");
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
                BoxesFloor(clients: widget.clients_1st,floor: 1,boxesAmount: widget.boxesAmount),
                BoxesFloor(clients: widget.clients_2th,floor: 2,boxesAmount: widget.boxesAmount),
                BoxesFloor(clients: widget.clients_3th,floor: 3,boxesAmount: widget.boxesAmount)
              ]
          ),
        )
    );
  }
}



