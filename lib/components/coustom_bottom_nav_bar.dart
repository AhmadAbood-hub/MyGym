import 'package:flutter/material.dart';
import 'package:my_gym/Screens/profile.dart';
import '../configuration.dart';
import '../enums.dart';
import '../Screens/home.dart';
import '../Screens/users.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Card(
      child: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight * 0.08,
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.meduimText, right: SizeConfig.meduimText),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 19,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Home()));
                        },
                        child: Container(
                          child: Center(
                            child: Text(
                              "Home",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.meduimText,
                                  color: PrimaryColor),
                            ),
                          ),
                        ),
                      )),
                  MenuState.home == selectedMenu
                      ? Expanded(
                          flex: 1,
                          child: Container(
                            width:
                                SizeConfig.xlargText + SizeConfig.meduim2Text,
                            decoration: new BoxDecoration(
                                color: buttonColor,
                                borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(40.0),
                                    topRight: const Radius.circular(40.0),
                                    bottomRight: const Radius.circular(40.0),
                                    bottomLeft: const Radius.circular(40.0))),
                          ),
                        )
                      : Container()
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 19,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Users()));
                        },
                        child: Container(
                          child: Center(
                            child: Text(
                              "Users",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.meduimText,
                                  color: PrimaryColor),
                            ),
                          ),
                        ),
                      )),
                  MenuState.users == selectedMenu
                      ? Expanded(
                          flex: 1,
                          child: Container(
                            width:
                                SizeConfig.xlargText + SizeConfig.meduim2Text,
                            decoration: new BoxDecoration(
                                color: buttonColor,
                                borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(40.0),
                                    topRight: const Radius.circular(40.0),
                                    bottomRight: const Radius.circular(40.0),
                                    bottomLeft: const Radius.circular(40.0))),
                          ),
                        )
                      : Container()
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 19,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Profile()));
                        },
                        child: Container(
                          child: Center(
                            child: Text(
                              "Profile",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.meduimText,
                                  color: PrimaryColor),
                            ),
                          ),
                        ),
                      )),
                  MenuState.profile == selectedMenu
                      ? Expanded(
                          flex: 1,
                          child: Container(
                            width:
                                SizeConfig.xlargText + SizeConfig.meduim2Text,
                            decoration: new BoxDecoration(
                                color: buttonColor,
                                borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(40.0),
                                    topRight: const Radius.circular(40.0),
                                    bottomRight: const Radius.circular(40.0),
                                    bottomLeft: const Radius.circular(40.0))),
                          ),
                        )
                      : Container()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
