import 'package:flutter/material.dart';
import 'package:victor_hugo_app_prototype/boxesFloor.dart';

class MainTabView extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return DefaultTabController(
        length: 3,
        child: Scaffold(
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
                BoxesFloor(),
                Container(),
                Container()
              ]
          ),
        )
    );
  }
}



