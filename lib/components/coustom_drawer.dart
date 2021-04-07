import 'package:flutter/material.dart';
import 'package:my_gym/Screens/profile.dart';
import 'package:my_gym/Screens/settings.dart';
import '../Screens/my_money.dart';
import '../Screens/home.dart';
import '../Screens/users.dart';
import '../configuration.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountEmail: Text("email"),
          accountName: Text("username"),
          currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
          decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                  image: AssetImage("images/man.jpg"), fit: BoxFit.cover)),
        ),
        ListTile(
          title: Text(
            "Home",
            style:
                TextStyle(color: PrimaryColor, fontSize: SizeConfig.meduimText),
          ),
          leading: Icon(
            Icons.home,
            color: PrimaryColor,
            size: SizeConfig.largText,
          ),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => Home()));
          },
        ),
        ListTile(
          title: Text("Users",
              style: TextStyle(
                  color: PrimaryColor, fontSize: SizeConfig.meduimText)),
          leading: Icon(
            Icons.person_search,
            color: PrimaryColor,
            size: SizeConfig.largText,
          ),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => Users()));
          },
        ),
        ListTile(
          title: Text("My money",
              style: TextStyle(
                  color: PrimaryColor, fontSize: SizeConfig.meduimText)),
          leading: Icon(
            Icons.money,
            color: PrimaryColor,
            size: SizeConfig.largText,
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => MyMoney()));
          },
        ),
        ListTile(
          title: Text("My profile",
              style: TextStyle(
                  color: PrimaryColor, fontSize: SizeConfig.meduimText)),
          leading: Icon(
            Icons.person,
            color: PrimaryColor,
            size: SizeConfig.largText,
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => Profile()));
          },
        ),
        ListTile(
          title: Text("Setting",
              style: TextStyle(
                  color: PrimaryColor, fontSize: SizeConfig.meduimText)),
          leading: Icon(
            Icons.settings,
            color: PrimaryColor,
            size: SizeConfig.largText,
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => Settings()));
          },
        ),
        ListTile(
          title: Text("Log out",
              style: TextStyle(
                  color: PrimaryColor, fontSize: SizeConfig.meduimText)),
          leading: Icon(
            Icons.exit_to_app,
            color: PrimaryColor,
            size: SizeConfig.largText,
          ),
          onTap: () {},
        ),
      ],
    ));
  }
}
