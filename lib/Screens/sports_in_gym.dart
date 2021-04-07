import 'package:flutter/material.dart';
import '../configuration.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_gym/provider/sport.dart';
import 'package:provider/provider.dart';

String _name = "";

class SportsInGym extends StatefulWidget {
  @override
  _SportsInGymState createState() => _SportsInGymState();
}

class _SportsInGymState extends State<SportsInGym> {
  TextEditingController controllerSearch = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: appBarSportsInGym(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _create(context);
        },
        child: Icon(
          Icons.add,
          color: accentColor,
          size: SizeConfig.smallText + SizeConfig.xlargText,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
      ),
      body: Column(
        children: [
          searchSports(context, controllerSearch),
          Expanded(
              child: Provider.of<SportProvider>(context, listen: false).searchResult.length !=
                          0 ||
                      controllerSearch.text.isNotEmpty
                  ? ListView.builder(
                      itemCount: Provider.of<SportProvider>(context, listen: true)
                          .searchResult
                          .length,
                      itemBuilder: (BuildContext contex, index) => itemSports(
                          Provider.of<SportProvider>(context, listen: true)
                              .searchResult[index]))
                  : ListView.builder(
                      itemCount: Provider.of<SportProvider>(context, listen: true)
                          .sportList
                          .length,
                      itemBuilder: (BuildContext contex, index) =>
                          itemSports(Provider.of<SportProvider>(context, listen: true).sportList[index])))
        ],
      ),
    );
  }
}

Widget appBarSportsInGym(context) {
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
    title: Text('SPORTS IN GYM',
        style: TextStyle(
            fontSize: SizeConfig.meduimText,
            fontWeight: FontWeight.bold,
            color: PrimaryColor)),
    centerTitle: true,
  );
}

Widget searchSports(context, TextEditingController controllerSearch) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: accentColor,
      child: new TextFormField(
        controller: controllerSearch,
        onChanged: Provider.of<SportProvider>(context, listen: false)
            .onSearchTextChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search here..',
          hintStyle:
              TextStyle(fontSize: SizeConfig.smallText, color: Colors.grey),
          contentPadding: EdgeInsets.only(
              left: SizeConfig.screenHeight * 0.033,
              top: SizeConfig.screenHeight * 0.02),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    ),
  );
}

Widget itemSports(Sport sport) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Column(
      children: [
        Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight * 0.35,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(SizeConfig.smallText),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0), //or 15.0
                  child: Container(
                    width: SizeConfig.screenWidth * 0.2,
                    color: Color(0xffFF0E58),
                    child: Image.asset(
                      sport.imgUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: SizeConfig.meduimText,
                left: SizeConfig.meduimText,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.meduimText),
                      child: Text(
                        sport.title,
                        style: TextStyle(
                            fontFamily: 'AirbnbCerealBold',
                            fontSize: SizeConfig.meduim2Text,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        )
      ],
    ),
  );
}

Widget addAnImage() {
  return Container(
      height: SizeConfig.screenHeight * 0.2,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image,
            ),
            SizedBox(height: SizeConfig.smallText),
            Text(
              "Add an image",
              style: TextStyle(
                fontSize: SizeConfig.meduimText,
              ),
            )
          ],
        ),
      ));
}

Widget textFieldTitle(String hint) {
  return Container(
    height: SizeConfig.xlargText + SizeConfig.largText,
    width: SizeConfig.screenWidth,
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: accentColor,
      child: Center(
        child: new TextFormField(
          onChanged: (value) {
            _name = value;
          },
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle:
                TextStyle(fontSize: SizeConfig.smallText, color: Colors.grey),
            contentPadding:
                EdgeInsets.only(left: SizeConfig.screenHeight * 0.033),
          ),
        ),
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
                  // To make the card compact
                  children: <Widget>[
                    SizedBox(height: SizeConfig.screenHeight * 0.025),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text("ADD NEW SPORT",
                              style: GoogleFonts.montserrat(
                                  color: Color.fromRGBO(59, 57, 60, 1),
                                  fontSize: SizeConfig.meduimText,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Spacer())
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.025),
                    Container(
                        child: Column(
                      children: [
                        addAnImage(),
                        SizedBox(height: SizeConfig.screenHeight * 0.025),
                        textFieldTitle("Price"),
                      ],
                    )),
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
