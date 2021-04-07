import 'package:flutter/material.dart';
import '../provider/sport.dart';
import './sport.dart';

class User {
  int id;
  String title;
  String subTitle;
  String imgUrl;
  bool check;
  List<Sport> sportList;
  bool isAuth;
  User(
      {@required this.id,
      @required this.imgUrl,
      @required this.title,
      @required this.subTitle,
      @required this.sportList,
      @required this.check,
      @required this.isAuth});
}

class UsersProvider with ChangeNotifier {
  SportProvider sportProvider;

  UsersProvider(this.sportProvider);

  List<User> userList = [
    new User(
        id: 0,
        imgUrl: "images/man.jpg",
        subTitle: "Coache",
        title: "Ahmad",
        check: false,
        sportList: [
          new Sport(
              colorIsCheck: Colors.grey,
              id: 0,
              imgUrl: "images/logo.png",
              title: "Football"),
        ],
        isAuth: false),
    new User(
        id: 1,
        imgUrl: "images/logo.png",
        subTitle: "Player",
        title: "Mohamad",
        check: false,
        sportList: [
          new Sport(
              colorIsCheck: Colors.grey,
              id: 0,
              imgUrl: "images/logo.png",
              title: "Fitness"),
        ],
        isAuth: false),
    new User(
        id: 2,
        imgUrl: "images/man.jpg",
        subTitle: "Coache",
        title: "Ahmad",
        check: false,
        sportList: [
          new Sport(
              colorIsCheck: Colors.grey,
              id: 0,
              imgUrl: "images/logo.png",
              title: "Fitness"),
          new Sport(
              colorIsCheck: Colors.grey,
              id: 1,
              imgUrl: "images/logo.png",
              title: "Fitness"),
          new Sport(
              colorIsCheck: Colors.grey,
              id: 2,
              imgUrl: "images/logo.png",
              title: "Fitness"),
          new Sport(
              colorIsCheck: Colors.grey,
              id: 3,
              imgUrl: "images/logo.png",
              title: "Fitness"),
        ],
        isAuth: false),
    new User(
        id: 3,
        imgUrl: "images/logo.png",
        subTitle: "Player",
        title: "Mohamad",
        check: false,
        sportList: [
          new Sport(
              colorIsCheck: Colors.grey,
              id: 0,
              imgUrl: "images/logo.png",
              title: "Fitness"),
          new Sport(
              colorIsCheck: Colors.grey,
              id: 1,
              imgUrl: "images/logo.png",
              title: "Fitness"),
          new Sport(
              colorIsCheck: Colors.grey,
              id: 2,
              imgUrl: "images/logo.png",
              title: "Fitness"),
          new Sport(
              colorIsCheck: Colors.grey,
              id: 3,
              imgUrl: "images/logo.png",
              title: "Fitness"),
        ],
        isAuth: false),
    new User(
        id: 4,
        imgUrl: "images/man.jpg",
        subTitle: "Coache",
        title: "Ahmad",
        check: false,
        sportList: [
          new Sport(
              colorIsCheck: Colors.grey,
              id: 0,
              imgUrl: "images/logo.png",
              title: "Fitness"),
          new Sport(
              colorIsCheck: Colors.grey,
              id: 1,
              imgUrl: "images/logo.png",
              title: "Fitness"),
          new Sport(
              colorIsCheck: Colors.grey,
              id: 2,
              imgUrl: "images/logo.png",
              title: "Fitness"),
          new Sport(
              colorIsCheck: Colors.grey,
              id: 3,
              imgUrl: "images/logo.png",
              title: "Fitness"),
        ],
        isAuth: false),
    new User(
        id: 5,
        imgUrl: "images/logo.png",
        subTitle: "Player",
        title: "Mohamad",
        check: false,
        sportList: [
          new Sport(
              colorIsCheck: Colors.grey,
              id: 0,
              imgUrl: "images/logo.png",
              title: "Fitness"),
          new Sport(
              colorIsCheck: Colors.grey,
              id: 1,
              imgUrl: "images/logo.png",
              title: "Fitness"),
          new Sport(
              colorIsCheck: Colors.grey,
              id: 2,
              imgUrl: "images/logo.png",
              title: "Fitness"),
          new Sport(
              colorIsCheck: Colors.grey,
              id: 3,
              imgUrl: "images/logo.png",
              title: "Fitness"),
        ],
        isAuth: false),
    new User(
        id: 6,
        imgUrl: "images/man.jpg",
        subTitle: "Coache",
        title: "Ahmad",
        check: false,
        sportList: [
          new Sport(
              colorIsCheck: Colors.grey,
              id: 0,
              imgUrl: "images/logo.png",
              title: "Fitness"),
          new Sport(
              colorIsCheck: Colors.grey,
              id: 1,
              imgUrl: "images/logo.png",
              title: "Fitness"),
          new Sport(
              colorIsCheck: Colors.grey,
              id: 2,
              imgUrl: "images/logo.png",
              title: "Fitness"),
          new Sport(
              colorIsCheck: Colors.grey,
              id: 3,
              imgUrl: "images/logo.png",
              title: "Fitness"),
        ],
        isAuth: false),
    new User(
        id: 7,
        imgUrl: "images/logo.png",
        subTitle: "Player",
        title: "Mohamad",
        check: false,
        sportList: [
          new Sport(
              colorIsCheck: Colors.grey,
              id: 0,
              imgUrl: "images/logo.png",
              title: "Fitness"),
          new Sport(
              colorIsCheck: Colors.grey,
              id: 1,
              imgUrl: "images/logo.png",
              title: "Fitness"),
          new Sport(
              colorIsCheck: Colors.grey,
              id: 2,
              imgUrl: "images/logo.png",
              title: "Fitness"),
          new Sport(
              colorIsCheck: Colors.grey,
              id: 3,
              imgUrl: "images/logo.png",
              title: "Fitness"),
        ],
        isAuth: false),
  ];

  List<User> searchResult = [];

  List<User> userHorizantalList = [];

  String isPlayerOrCoach = "";

  void add({int id, String imgUrl, String title, String subTitle, bool check}) {
    userHorizantalList.add(User(
        sportList: [
          new Sport(
              colorIsCheck: Colors.grey,
              id: 0,
              imgUrl: "images/logo.png",
              title: "Fitness"),
          new Sport(
              colorIsCheck: Colors.grey,
              id: 1,
              imgUrl: "images/logo.png",
              title: "Fitness"),
          new Sport(
              colorIsCheck: Colors.grey,
              id: 2,
              imgUrl: "images/logo.png",
              title: "Fitness"),
          new Sport(
              colorIsCheck: Colors.grey,
              id: 3,
              imgUrl: "images/logo.png",
              title: "Fitness"),
        ],
        id: id,
        imgUrl: imgUrl,
        title: title,
        subTitle: subTitle,
        check: check,
        isAuth: false));
    notifyListeners();
  }

  void delete(int id) {
    userHorizantalList.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  onSearchTextChanged(String text) async {
    searchResult.clear();
    notifyListeners();
    if (text.isEmpty) {
      return;
    }

    if (sportProvider.sportFilterlList.length == 0) {
      if (isPlayerOrCoach == "") {
        userList.forEach((userDetail) {
          {
            searchResult.add(userDetail);
            notifyListeners();
            return;
          }
        });
      }

      if (isPlayerOrCoach == "Player") {
        userList.forEach((userDetail) {
          if (userDetail.title.contains(text) &&
              userDetail.subTitle == "Player") {
            searchResult.add(userDetail);
            notifyListeners();
            return;
          }
        });
      }

      if (isPlayerOrCoach == "Coache") {
        userList.forEach((userDetail) {
          if (userDetail.title.contains(text) &&
              userDetail.subTitle == "Coache") {
            searchResult.add(userDetail);
            notifyListeners();
            return;
          }
        });
      }
    } else {
      if (isPlayerOrCoach == "") {
        userList.forEach((userDetail) {
          sportProvider.sportFilterlList.forEach((sportDetail) {
            userDetail.sportList.forEach((userSportDetail) {
              if (userDetail.title.contains(text) &&
                  sportDetail.title == userSportDetail.title) {
                searchResult.add(userDetail);
                notifyListeners();
                return;
              }
            });
          });
        });
      }

      if (isPlayerOrCoach == "Player") {
        userList.forEach((userDetail) {
          sportProvider.sportFilterlList.forEach((sportDetail) {
            userDetail.sportList.forEach((userSportDetail) {
              if (userDetail.title.contains(text) &&
                  sportDetail.title == userSportDetail.title &&
                  userDetail.subTitle == "Player") {
                searchResult.add(userDetail);
                notifyListeners();
                return;
              }
            });
          });
        });
      }

      if (isPlayerOrCoach == "Coache") {
        userList.forEach((userDetail) {
          sportProvider.sportFilterlList.forEach((sportDetail) {
            userDetail.sportList.forEach((userSportDetail) {
              if (userDetail.title.contains(text) &&
                  sportDetail.title == userSportDetail.title &&
                  userDetail.subTitle == "Coache") {
                searchResult.add(userDetail);
                notifyListeners();
                return;
              }
            });
          });
        });
      }
    }
  }

  void checkChange(bool val, int index) {
    userList[index].check = val;

    notifyListeners();
  }

  void loginChange(bool val, int index) {
    userList[index].isAuth = val;

    notifyListeners();
  }

  void setPlayerOrCoach(String text) {
    isPlayerOrCoach = text;
    notifyListeners();
  }
}
