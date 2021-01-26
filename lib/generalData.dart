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

