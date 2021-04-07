import 'package:flutter/material.dart';

class Sport {
  int id;
  String title;
  String imgUrl;
  Color colorIsCheck;

  Sport(
      {@required this.id,
      @required this.imgUrl,
      @required this.title,
      @required this.colorIsCheck});
}

class SportProvider with ChangeNotifier {
  List<Sport> sportList = [
    new Sport(
        id: 0,
        imgUrl: "images/man.jpg",
        title: "Football",
        colorIsCheck: Colors.grey),
    new Sport(
        id: 1,
        imgUrl: "images/logo.png",
        title: "Basket",
        colorIsCheck: Colors.grey),
    new Sport(
        id: 2,
        imgUrl: "images/man.jpg",
        title: "Tenise",
        colorIsCheck: Colors.grey),
    new Sport(
        id: 3,
        imgUrl: "images/logo.png",
        title: "Airobic",
        colorIsCheck: Colors.grey),
    new Sport(
        id: 4,
        imgUrl: "images/man.jpg",
        title: "vollyball",
        colorIsCheck: Colors.grey),
  ];

  List<Sport> searchResult = [];

  List<Sport> sportHorizantalList = [];

  List<Sport> sportFilterlList = [];

  void addToFilter(Sport sport) {
    print(sport.title);
    sportFilterlList.add(Sport(
        id: sport.id,
        imgUrl: sport.imgUrl,
        title: sport.title,
        colorIsCheck: sport.colorIsCheck));
    notifyListeners();
  }

  void deleteToFilter(Sport sport) {
    sportFilterlList.removeWhere((elemnt) => elemnt.id == sport.id);
    notifyListeners();
  }

  void add(Sport sport) {
    sportHorizantalList.add(Sport(
        id: sport.id,
        imgUrl: sport.imgUrl,
        title: sport.title,
        colorIsCheck: sport.colorIsCheck));
    notifyListeners();
  }

  void delete(int id) {
    sportHorizantalList.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  onSearchTextChanged(String text) async {
    searchResult.clear();
    notifyListeners();
    if (text.isEmpty) {
      return;
    }

    sportList.forEach((sportDetail) {
      if (sportDetail.title.contains(text)) {
        searchResult.add(sportDetail);
        notifyListeners();
      }
    });
  }

  void itemChange(Color color, int index) {
    sportList[index].colorIsCheck = color;
    notifyListeners();
  }

  List<Sport> getFilterList() {
    return [...sportFilterlList];
  }
}
