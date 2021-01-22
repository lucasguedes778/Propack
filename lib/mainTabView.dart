import 'package:flutter/material.dart';
import 'package:victor_hugo_app_prototype/boxesFloor.dart';
import 'package:victor_hugo_app_prototype/generalData.dart';
import 'package:flutter/services.dart';

//ignore: must_be_immutable
class MainTabView extends StatelessWidget{

  List<ClientData> clients = <ClientData>[
    ClientData("Guedes",["Fire"], 0,1),
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
                children: [
                  Text("Side bar"),
                ],
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
                BoxesFloor(clients: clients,),
                Container(),
                Container()
              ]
          ),
        )
    );
  }
}



