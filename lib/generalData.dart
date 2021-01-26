class ClientData{
  String name;
  List<String> reasons;
  int verticalPosition;
  int horizontalPosition;

  ClientData(String name, List<String>reasons, int verticalPosition, int horizontalPosition){
    this.name = name;
    this.reasons = reasons;
    this.verticalPosition = verticalPosition;
    this.horizontalPosition = horizontalPosition;
  }
}

class FloorBoxesAmount{
  int floor_1;
  int floor_2;
  int floor_3;

  FloorBoxesAmount(this.floor_1, this.floor_2, this.floor_3);

  void addToFirst(){
    this.floor_1 += 1;
  }

  void removeToFirst(){
    this.floor_1 -= 1;
  }

  void addToSecond(){
    this.floor_2 += 1;
  }

  void removeToSecond(){
    this.floor_2 -= 1;
  }

  void addToThird(){
    this.floor_3 += 1;
  }

  void removeToThird(){
    this.floor_3 -= 1;
  }

}

