import 'package:flutter/material.dart';
import 'package:my_gym/Screens/sports_in_gym.dart';
import '../configuration.dart';
import 'package:google_fonts/google_fonts.dart';

String _name = "";

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: accentColor,
      appBar: appBarSettings(context),
      body: ListView(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.05,
          ),
          userItem(Icons.money, "Subscription price", context),
          SizedBox(
            height: SizeConfig.screenHeight * 0.05,
          ),
          userItem(Icons.money_off_csred_rounded, "Sports in gym", context),
          SizedBox(
            height: SizeConfig.screenHeight * 0.05,
          ),
          userItem(Icons.schedule, "Holliday in gym", context),
        ],
      ),
    );
  }
}

Widget appBarSettings(context) {
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
    title: Text('Settings',
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
      if (title == "Subscription price") {
        _create(context, textFieldSubscriptionPrice(), title);
      } else if (title == "Sports in gym") {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => SportsInGym()));
      } else {
        _create(context, DropDownGender(), title);
      }
    },
    child: Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.screenWidth * 0.0526315789473,
          right: SizeConfig.screenWidth * 0.0526315789473),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: ListTile(
          trailing: Icon(
            Icons.exit_to_app,
            color: PrimaryColor,
            size: SizeConfig.largText,
          ),
          title: Text(
            title,
            style:
                TextStyle(fontSize: SizeConfig.meduimText, color: PrimaryColor),
          ),
        ),
      ),
    ),
  );
}

Widget textFieldSubscriptionPrice() {
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
            hintText: "5000",
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

Widget textFielHollidayInGym() {
  return Container(
    height: SizeConfig.screenHeight * 0.1,
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
            hintText: "5000",
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
void _create(BuildContext context, var contain, String title) {
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
                          flex: 4,
                          child: Text(title,
                              style: GoogleFonts.montserrat(
                                  color: Color.fromRGBO(59, 57, 60, 1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Spacer())
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.025),
                    Container(child: contain),
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
                              Navigator.of(context).pop(true);
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

class DropDownGender extends StatefulWidget {
  @override
  _DropDownGenderState createState() => _DropDownGenderState();
}

class _DropDownGenderState extends State<DropDownGender> {
  List<String> deviceTypes = ['Sat', 'Sun', "Mon", "Tus", "Wed", "Thu", "Fri"];
  var currentSelectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text(
                  "select a day",
                  style: TextStyle(fontSize: SizeConfig.meduimText),
                ),
                value: currentSelectedValue,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    currentSelectedValue = newValue;
                  });
                  print(currentSelectedValue);
                },
                items: deviceTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: SizeConfig.meduimText),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
