import 'package:flutter/material.dart';
import 'package:my_gym/Screens/select_sports.dart';
import '../configuration.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

var image;

class AddNewUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: appBarEditProfile(context),
      body: SingleChildScrollView(
        child: Container(
          height: SizeConfig.screenHeight -
              AppBar().preferredSize.height -
              MediaQuery.of(context).padding.top,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.grey.withOpacity(0.3),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0, 1])),
          child: ListView(
            children: [
              SizedBox(
                height: SizeConfig.meduimText,
              ),
              GestureDetector(
                onTap: () {
                  var ad = AlertDialog(
                    title: Text(
                      "Choose Picture from:",
                      style: TextStyle(fontSize: SizeConfig.meduimText),
                    ),
                    content: Container(
                      height: SizeConfig.screenHeight * 0.3,
                      child: Column(
                        children: [
                          Divider(color: Colors.black),
                          buildDialogItem(context, "Camera",
                              Icons.add_a_photo_outlined, ImageSource.camera),
                          SizedBox(height: SizeConfig.meduimText),
                          buildDialogItem(context, "Gallery",
                              Icons.image_outlined, ImageSource.gallery),
                        ],
                      ),
                    ),
                  );
                  showDialog(context: context, child: ad);
                },
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 12.0,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: SizeConfig.meduimText,
                                  color: Color(0xFF404040),
                                ),
                              ),
                            ),
                            radius: 38.0,
                            backgroundImage: AssetImage('images/logo.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.all(SizeConfig.largText),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.meduimText,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.largText, right: SizeConfig.largText),
                child: NameTextField(
                  hint: "Name",
                ),
              ),
              SizedBox(
                height: SizeConfig.meduimText,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.largText, right: SizeConfig.largText),
                child: FatherTextField(hint: "Father\'s Name "),
              ),
              SizedBox(
                height: SizeConfig.meduimText,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.largText, right: SizeConfig.largText),
                child: PhoneTextField(hint: "Phone"),
              ),
              SizedBox(
                height: SizeConfig.meduimText,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.largText, right: SizeConfig.largText),
                child: DropDownGender(),
              ),
              SizedBox(
                height: SizeConfig.meduimText,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.largText, right: SizeConfig.largText),
                child: DropDownUserType(),
              ),
              SizedBox(
                height: SizeConfig.meduimText,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => SelectSports()));
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.largText, right: SizeConfig.largText),
                  child: SelectSportsButton(
                    hint: "Select The Sports",
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.meduimText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget appBarEditProfile(context) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(Icons.arrow_back),
      color: PrimaryColor,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    title: Text('Add User',
        style: TextStyle(
            fontSize: SizeConfig.meduim2Text,
            fontWeight: FontWeight.bold,
            color: PrimaryColor)),
    centerTitle: true,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.save),
        onPressed: () {},
        color: buttonColor,
      )
    ],
  );
}

Builder buildDialogItem(
    BuildContext context, String text, IconData icon, ImageSource src) {
  return Builder(
    builder: (innerContext) => Container(
      decoration: BoxDecoration(
        color: PrimaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: accentColor),
        title: Text(
          text,
          style: TextStyle(color: accentColor, fontSize: SizeConfig.smallText),
        ),
        onTap: () {
          getImage(src);
          Navigator.of(innerContext).pop();
        },
      ),
    ),
  );
}

Future getImage(ImageSource src) async {
  final pickedFile = await ImagePicker().getImage(source: src);

  if (pickedFile != null) {
    image = File(pickedFile.path);
    print('Image selected.');
  } else {
    print('No image selected.');
  }
}

class NameTextField extends StatelessWidget {
  final String hint;
  NameTextField({this.hint});

  @override
  Widget build(BuildContext context) {
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
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(
                  fontSize: SizeConfig.smallText, color: PrimaryColor),
              contentPadding:
                  EdgeInsets.only(left: SizeConfig.screenHeight * 0.033),
            ),
          ),
        ),
      ),
    );
  }
}

class FatherTextField extends StatelessWidget {
  final String hint;
  FatherTextField({this.hint});

  @override
  Widget build(BuildContext context) {
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
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(
                  fontSize: SizeConfig.smallText, color: PrimaryColor),
              contentPadding:
                  EdgeInsets.only(left: SizeConfig.screenHeight * 0.033),
            ),
          ),
        ),
      ),
    );
  }
}

class PhoneTextField extends StatelessWidget {
  final String hint;
  PhoneTextField({this.hint});

  @override
  Widget build(BuildContext context) {
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
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(
                  fontSize: SizeConfig.smallText, color: PrimaryColor),
              contentPadding:
                  EdgeInsets.only(left: SizeConfig.screenHeight * 0.033),
            ),
          ),
        ),
      ),
    );
  }
}

class DropDownGender extends StatefulWidget {
  @override
  _DropDownGenderState createState() => _DropDownGenderState();
}

class _DropDownGenderState extends State<DropDownGender> {
  List<String> _locations = ['Male', 'Female'];
  String _selectedLocation;
  @override
  Widget build(BuildContext context) {
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
          child: Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.screenHeight * 0.033,
                right: SizeConfig.screenHeight * 0.033),
            child: DropdownButton(
              underline: SizedBox(),
              hint: Text(
                'Gender',
                style: TextStyle(fontSize: SizeConfig.smallText),
              ),
              value: _selectedLocation,
              isExpanded: true,
              onChanged: (newValue) {
                setState(() {
                  _selectedLocation = newValue;
                });
              },
              items: _locations.map((location) {
                return DropdownMenuItem(
                  child: new Text(
                    location,
                    style: TextStyle(
                        fontSize: SizeConfig.smallText, color: PrimaryColor),
                  ),
                  value: location,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class DropDownUserType extends StatefulWidget {
  @override
  _DropDownUserTypeState createState() => _DropDownUserTypeState();
}

class _DropDownUserTypeState extends State<DropDownUserType> {
  List<String> _locations = ['Player', 'Coache'];
  String _selectedLocation;
  @override
  Widget build(BuildContext context) {
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
          child: Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.screenHeight * 0.033,
                right: SizeConfig.screenHeight * 0.033),
            child: DropdownButton(
              isExpanded: true,
              underline: SizedBox(),
              hint: Text(
                'User Type',
                style: TextStyle(fontSize: SizeConfig.smallText),
                overflow: TextOverflow.ellipsis,
              ),
              value: _selectedLocation,
              onChanged: (newValue) {
                setState(() {
                  _selectedLocation = newValue;
                });
              },
              items: _locations.map((location) {
                return DropdownMenuItem(
                  child: new Text(
                    location,
                    style: TextStyle(
                        fontSize: SizeConfig.smallText, color: PrimaryColor),
                  ),
                  value: location,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectSportsButton extends StatelessWidget {
  final String hint;
  SelectSportsButton({this.hint});

  @override
  Widget build(BuildContext context) {
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
          child: new Container(
            child: Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: SizeConfig.screenHeight * 0.033),
                  child: Text(
                    hint,
                    style: TextStyle(
                        fontSize: SizeConfig.smallText, color: PrimaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
