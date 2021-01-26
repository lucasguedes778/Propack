import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:victor_hugo_app_prototype/boxesFloor.dart';
import 'package:victor_hugo_app_prototype/generalData.dart';
import 'package:flutter/services.dart';

//ignore: must_be_immutable
class MainTabView extends StatelessWidget{

  List<ClientData> clients_1st = <ClientData>[
    ClientData("Lucas",["Fire"], 0,1),
  ];

  List<ClientData> clients_2th = <ClientData>[
    ClientData("Guedes",["Fire"], 0,1),
  ];

  List<ClientData> clients_3th = <ClientData>[
    ClientData("Silva",["Fire"], 0,1),
  ];

  @override
  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

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
                BoxesFloor(clients: clients_1st,),
                BoxesFloor(clients: clients_2th),
                BoxesFloor(clients: clients_3th,)
              ]
          ),
        )
    );
  }
}



