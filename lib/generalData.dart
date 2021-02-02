import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

Future<File> _getFile(int floor) async{
  final directory = await getApplicationDocumentsDirectory();
  return File("${directory.path}/data_$floor.json");
}

saveShedData(List<ClientData>clients, int floor) async{
  var file = await _getFile(floor);

  List formattedData = [];

  for(int i = 0; i < clients.length; i++){
    Map<String, dynamic> element = Map();
    element["name"] = clients[i].name;
    element["reasons"] = clients[i].reasons;

    formattedData.add(element);
  }

  String data = json.encode(formattedData);

  file.writeAsStringSync(data);

}

readShedData(int floor) async{
  try{
    var file = await _getFile(floor);
    if(await file.exists()){
      return file.readAsString();
    }else{
      return null;
    }
  }catch(e){
    return null;
  }
}


class ClientData{
  String name;
  List<String> reasons;

  ClientData(String name, List<String>reasons){
    this.name = name;
    this.reasons = reasons;
  }
}

class FloorBoxesAmount{
  int floor_1;
  int floor_2;
  int floor_3;

  FloorBoxesAmount(this.floor_1, this.floor_2, this.floor_3);

  void moveSecToFirst(){
    this.floor_2-=1;
    this.floor_1+=1;
  }


  void addToFirst(){
    print("floor_1: ${this.floor_1}");
    this.floor_1 += 1;
  }

  void removeToFirst(){
    print("floor_1: ${this.floor_1}");
    this.floor_1 -= 1;
  }

  void addToSecond(){
    print("floor_2: ${this.floor_2}");
    this.floor_2 += 1;
  }

  void removeToSecond(){
    print("floor_2: ${this.floor_2}");
    this.floor_2 -= 1;
  }

  void addToThird(){
    print("floor_3: ${this.floor_3}");
    this.floor_3 += 1;
  }

  void removeToThird(){
    print("floor_3: ${this.floor_3}");
    this.floor_3 -= 1;
  }

}

