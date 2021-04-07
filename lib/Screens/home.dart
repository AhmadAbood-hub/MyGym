import 'package:flutter/material.dart';
import 'package:my_gym/Screens/my_messages.dart';
import '../configuration.dart';
import 'package:pie_chart/pie_chart.dart';
import '../components/coustom_bottom_nav_bar.dart';
import '../enums.dart';
import '../components/coustom_drawer.dart';
import '../Screens/QR/qr_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        key: drawerKey, // assign key to Scaffold

        backgroundColor: accentColor,
        appBar: appBarHome(context, drawerKey),
        drawer: MyDrawer(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Card(
                  elevation: 4,
                  child: Container(
                    height: SizeConfig.screenHeight * 0.45,
                    child: PieChart(
                      dataMap: {
                        "Flutter": 5,
                        "Maths": 2,
                        "English": 10,
                        "Android": 4
                      },
                      chartRadius: SizeConfig.screenWidth * 0.5,
                      chartType: ChartType.ring,
                      centerText: "150 Persons",
                      colorList: [
                        Colors.red,
                        Colors.green,
                        Colors.grey,
                        Colors.orange
                      ],
                      chartValuesOptions: ChartValuesOptions(
                          chartValueStyle: TextStyle(
                              fontSize: SizeConfig.meduimText,
                              fontWeight: FontWeight.bold,
                              color: PrimaryColor),
                          showChartValueBackground: false,
                          showChartValuesOutside: true,
                          showChartValuesInPercentage: true),
                      legendOptions: LegendOptions(
                          legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.meduimText),
                          legendPosition: LegendPosition.top,
                          showLegends: false),
                      animationDuration: Duration(milliseconds: 2000),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                ),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.smallText,
                        right: SizeConfig.smallText),
                    child: Container(
                      height: SizeConfig.screenHeight * 0.5,
                      child: Column(
                        children: [
                          infPerItem(Colors.blue, "Male", 500),
                          Divider(color: Colors.grey),
                          infPerItem(Colors.yellow, "Female", 20),
                          Divider(color: Colors.grey),
                          infPerItem(PrimaryColor, "Employee", 40),
                          Divider(color: Colors.grey),
                          infPerItem(Colors.orange, "Coaches", 30),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.03,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => QRPage()));
          },
          child: Icon(
            Icons.qr_code,
            color: accentColor,
            size: SizeConfig.xlargText + SizeConfig.smallText,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
        ));
  }
}

Widget appBarHome(context, drawerKey) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        drawerKey.currentState.openDrawer();
      },
      icon: Icon(Icons.notes),
      color: PrimaryColor,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    title: Text('HOME',
        style: TextStyle(
            fontSize: SizeConfig.meduim2Text,
            fontWeight: FontWeight.bold,
            color: PrimaryColor)),
    centerTitle: true,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.message),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext contex) => MyMessages()));
        },
        color: PrimaryColor,
      )
    ],
  );
}

Widget infPerItem(Color color, String name, int num) {
  return Container(
      height: SizeConfig.screenHeight * 0.1,
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Row(
                children: [
                  Card(
                    color: color,
                    child: Container(
                      height: SizeConfig.meduimText,
                      width: SizeConfig.meduimText,
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.smallText,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: SizeConfig.meduimText, color: PrimaryColor),
                  )
                ],
              )),
          Expanded(
              flex: 1,
              child: Container(
                child: Center(
                  child: Text(
                    "$num Person",
                    style: TextStyle(
                        color: Colors.grey, fontSize: SizeConfig.smallText),
                  ),
                ),
              ))
        ],
      ));
}
