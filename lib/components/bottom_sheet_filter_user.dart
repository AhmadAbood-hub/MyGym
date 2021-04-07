import 'package:flutter/material.dart';
import 'package:my_gym/configuration.dart';
import 'package:my_gym/provider/users.dart';
import 'package:provider/provider.dart';
import '../provider/sport.dart';

class BottomSheetFilterUser extends StatefulWidget {
  @override
  _BottomSheetFilterUserState createState() => _BottomSheetFilterUserState();
}

class _BottomSheetFilterUserState extends State<BottomSheetFilterUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(SizeConfig.largText),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Filter By ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SizeConfig.meduim2Text,
                fontWeight: FontWeight.bold,
                color: PrimaryColor,
              ),
            ),
            SizedBox(
              height: SizeConfig.largText,
            ),
            Text(
              'Sport',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SizeConfig.meduimText,
                color: PrimaryColor,
              ),
            ),
            SizedBox(
              height: SizeConfig.meduimText,
            ),
            Container(
              height: SizeConfig.screenHeight * 0.25,
              width: double.infinity,
              child: Provider.of<SportProvider>(context).sportList.isEmpty
                  ? Center(
                      child: Text(
                        "There is not products!",
                        style: TextStyle(fontSize: SizeConfig.meduimText),
                      ),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemCount:
                          Provider.of<SportProvider>(context, listen: false)
                              .sportList
                              .length,
                      itemBuilder: (ctx, index) => sportItem(
                          Provider.of<SportProvider>(context)
                              .sportList[index]
                              .title,
                          context,
                          index),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 20,
                          childAspectRatio: 3,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10)),
            ),
            SizedBox(
              height: SizeConfig.largText,
            ),
            Text(
              'User Type',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SizeConfig.meduimText,
                color: PrimaryColor,
              ),
            ),
            SizedBox(
              height: SizeConfig.meduim2Text,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: SizeConfig.largText * 2,
                    width: SizeConfig.screenWidth * 0.4,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Provider.of<UsersProvider>(context,
                                            listen: true)
                                        .isPlayerOrCoach ==
                                    'Coache'
                                ? buttonColor
                                : Colors.grey),
                        color: accentColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<UsersProvider>(context, listen: false)
                            .setPlayerOrCoach("Coache");
                      },
                      child: Center(
                        child: Text(
                          'Coache',
                          style: TextStyle(
                              fontSize: SizeConfig.meduimText,
                              color: Provider.of<UsersProvider>(context,
                                              listen: true)
                                          .isPlayerOrCoach ==
                                      'Coache'
                                  ? buttonColor
                                  : PrimaryColor),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: SizeConfig.largText * 2,
                    width: SizeConfig.screenWidth * 0.4,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Provider.of<UsersProvider>(context,
                                            listen: true)
                                        .isPlayerOrCoach ==
                                    'Player'
                                ? buttonColor
                                : Colors.grey),
                        color: accentColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<UsersProvider>(context, listen: false)
                            .setPlayerOrCoach("Player");
                      },
                      child: Center(
                        child: Text(
                          'Player',
                          style: TextStyle(
                              fontSize: SizeConfig.meduimText,
                              color: Provider.of<UsersProvider>(context,
                                              listen: true)
                                          .isPlayerOrCoach ==
                                      'Player'
                                  ? buttonColor
                                  : PrimaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.largText,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: SizeConfig.largText * 2,
                    width: SizeConfig.screenWidth * 0.35,
                    decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: PrimaryColor,
                              fontSize: SizeConfig.meduimText),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: SizeConfig.largText * 2,
                    width: SizeConfig.screenWidth * 0.35,
                    decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Center(
                        child: Text(
                          'Continue',
                          style: TextStyle(
                              color: accentColor,
                              fontSize: SizeConfig.meduimText),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget sportItem(String name, context, index) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(
            color: Provider.of<SportProvider>(context, listen: false)
                .sportList[index]
                .colorIsCheck),
        color: accentColor,
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: GestureDetector(
      onTap: () {
        Provider.of<SportProvider>(context, listen: false)
                    .sportList[index]
                    .colorIsCheck ==
                Colors.grey
            ? Provider.of<SportProvider>(context, listen: false)
                .itemChange(buttonColor, index)
            : Provider.of<SportProvider>(context, listen: false)
                .itemChange(Colors.grey, index);

        Provider.of<SportProvider>(context, listen: false)
                    .sportList[index]
                    .colorIsCheck ==
                Colors.grey
            ? Provider.of<SportProvider>(context, listen: false).deleteToFilter(
                Provider.of<SportProvider>(context, listen: false)
                    .sportList[index])
            : Provider.of<SportProvider>(context, listen: false).addToFilter(
                Provider.of<SportProvider>(context, listen: false)
                    .sportList[index]);
      },
      child: Center(
        child: Text(
          Provider.of<SportProvider>(context).sportList[index].title,
          style: TextStyle(
              fontSize: SizeConfig.meduimText,
              color: Provider.of<SportProvider>(context, listen: false)
                  .sportList[index]
                  .colorIsCheck),
        ),
      ),
    ),
  );
}
