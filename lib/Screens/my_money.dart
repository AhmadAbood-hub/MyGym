import 'package:flutter/material.dart';
import '../configuration.dart';
import '../Screens/payments.dart';
import '../Screens/Receivables.dart';
import '../Screens/scheduling.dart';

class MyMoney extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: accentColor,
      appBar: appBarMyMoney(context),
      body: ListView(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.05,
          ),
          userItem(Icons.money, "Payments", context),
          SizedBox(
            height: SizeConfig.screenHeight * 0.05,
          ),
          userItem(Icons.money_off_csred_rounded, "Receivables", context),
          SizedBox(
            height: SizeConfig.screenHeight * 0.05,
          ),
          userItem(Icons.schedule, "Scheduling", context),
        ],
      ),
    );
  }
}

Widget appBarMyMoney(context) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(Icons.arrow_back),
      color: PrimaryColor,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    title: Text('My Money',
        style: TextStyle(
            fontSize: SizeConfig.meduim2Text,
            fontWeight: FontWeight.bold,
            color: PrimaryColor)),
    centerTitle: true,
  );
}

Widget userItem(IconData icon, String title, context) {
  return GestureDetector(
    onTap: () {
      if (title == "Payments") {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => Payments()));
      } else if (title == "Receivables") {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => Receivables()));
      } else {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => Scheduling()));
      }
    },
    child: Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.screenWidth * 0.0526315789473,
          right: SizeConfig.screenWidth * 0.0526315789473),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              height: SizeConfig.screenHeight * 0.11666666666,
              child: Center(
                  child: Icon(
                icon,
                color: buttonColor,
              )),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
              ),
              child: ListTile(
                trailing: Icon(
                  Icons.exit_to_app,
                  color: PrimaryColor,
                  size: SizeConfig.largText,
                ),
                title: Text(
                  title,
                  style: TextStyle(
                      fontSize: SizeConfig.meduim2Text, color: PrimaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
