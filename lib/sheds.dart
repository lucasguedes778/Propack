import 'package:flutter/material.dart';
import 'shed.dart';

class Sheds extends StatefulWidget {
  @override
  _ShedsState createState() => _ShedsState();
}

class _ShedsState extends State<Sheds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: Shed(),
    );
  }
}
