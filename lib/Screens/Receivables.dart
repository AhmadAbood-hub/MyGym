import 'package:flutter/material.dart';
import 'package:my_gym/Screens/profile_user.dart';
import '../configuration.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_gym/provider/users.dart';
import 'package:provider/provider.dart';

class Receivables extends StatefulWidget {
  @override
  _ReceivablesState createState() => _ReceivablesState();
}

class _ReceivablesState extends State<Receivables> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    List<Widget> containers = [
      Container(
        child: ListView.builder(
          itemCount: Provider.of<UsersProvider>(context).userList.length,
          itemBuilder: (context, index) {
            return userItem(
                Provider.of<UsersProvider>(context, listen: true)
                    .userList[index]
                    .imgUrl,
                Provider.of<UsersProvider>(context, listen: true)
                    .userList[index]
                    .title,
                Provider.of<UsersProvider>(context, listen: true)
                    .userList[index]
                    .subTitle,
                context,
                index);
          },
        ),
      ),
      Container(
        child: ListView.builder(
          itemCount: Provider.of<UsersProvider>(context).userList.length,
          itemBuilder: (context, index) {
            return userItem(
                Provider.of<UsersProvider>(context, listen: true)
                    .userList[index]
                    .imgUrl,
                Provider.of<UsersProvider>(context, listen: true)
                    .userList[index]
                    .title,
                Provider.of<UsersProvider>(context, listen: true)
                    .userList[index]
                    .subTitle,
                context,
                index);
          },
        ),
      )
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: containers,
        ),
        appBar: appBarMyReceivables(context),
        backgroundColor: accentColor,
      ),
    );
  }
}

Widget appBarMyReceivables(context) {
  return AppBar(
    bottom: TabBar(
      labelStyle: TextStyle(fontSize: SizeConfig.meduim2Text),
      unselectedLabelColor: Colors.grey,
      labelColor: buttonColor,
      tabs: <Widget>[
        Tab(
          text: 'Subscriber\'s expired',
        ),
        Tab(
          text: 'Subscribers',
        ),
      ],
    ),
    leading: IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(Icons.arrow_back),
      color: PrimaryColor,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    title: Text('Receivables',
        style: TextStyle(
            fontSize: SizeConfig.meduimText,
            fontWeight: FontWeight.bold,
            color: PrimaryColor)),
    centerTitle: true,
  );
}

Widget userItem(
    String urlImage, String title, String subTitle, context, index) {
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => ProfileUser(true, index)));
        },
        child: ListTile(
          trailing: GestureDetector(
            onTap: () {
              _create(context);
            },
            child: Icon(
              Icons.sync,
              color: buttonColor,
              size: SizeConfig.largText,
            ),
          ),
          subtitle: Text(
            title,
            style: TextStyle(fontSize: SizeConfig.meduimText),
          ),
          title: Text(
            subTitle,
            style: TextStyle(fontSize: SizeConfig.meduim2Text),
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12.0), //or 15.0
            child: Container(
              width: SizeConfig.xlargText * 2,
              color: Color(0xffFF0E58),
              child: Image.asset(
                urlImage,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      Divider()
    ],
  );
}

void _create(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.screenWidth * 0.05,
                    right: SizeConfig.screenWidth * 0.05),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: SizeConfig.screenHeight * 0.025),
                    Row(
                      children: [
                        Text("Update Subscription",
                            style: GoogleFonts.montserrat(
                                color: Color.fromRGBO(59, 57, 60, 1),
                                fontSize: SizeConfig.meduimText,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.025),
                    Container(
                      child: Center(
                        child: Text(
                          "Do you want to update subscription for jerry ?",
                          style: TextStyle(fontSize: SizeConfig.meduimText),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.025),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                            onTap: () => Navigator.of(context).pop(false),
                            child: cancelButton),
                        SizedBox(
                          width: SizeConfig.meduimText,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: btn)
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.025),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

var btn = Text('Continue',
    style: GoogleFonts.montserrat(
        color: buttonColor,
        fontSize: SizeConfig.smallText,
        fontWeight: FontWeight.bold));

var cancelButton = Text('Cancel',
    style: GoogleFonts.montserrat(
        color: PrimaryColor,
        fontSize: SizeConfig.smallText,
        fontWeight: FontWeight.bold));
