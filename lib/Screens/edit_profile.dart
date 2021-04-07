import 'package:flutter/material.dart';
import '../configuration.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

var image;

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarEditProfile(context),
      body: SingleChildScrollView(
        child: Container(
          height: SizeConfig.screenHeight,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.grey.withOpacity(0.3),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0, 1])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.meduimText,
              ),
              GestureDetector(
                onTap: () {
                  var ad = AlertDialog(
                    title: Text("Choose Picture from:"),
                    content: Container(
                      height: SizeConfig.screenHeight * 0.3,
                      child: Column(
                        children: [
                          Divider(color: Colors.black),
                          buildDialogItem(context, "Camera",
                              Icons.add_a_photo_outlined, ImageSource.camera),
                          SizedBox(
                            height: SizeConfig.meduimText,
                          ),
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
                  margin: EdgeInsets.all(SizeConfig.meduimText),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.meduimText,
              ),
              NameEditProfile(
                title: "Name",
                hint: "Ahmad Abood",
              ),
              FatherEditProfile(
                title: "Father\s Name",
                hint: "Mahmod",
              ),
              PhoneEditProfile(
                title: "Phone",
                hint: "+(963991224361)",
              ),
              GenderEditProfile(
                title: "Gender",
              )
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
    title: Text('EDIT PROFILE',
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

class NameEditProfile extends StatelessWidget {
  final String title;
  final String hint;
  NameEditProfile({this.title, this.hint});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.largText),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: SizeConfig.xlargText,
                  decoration: BoxDecoration(
                      color: PrimaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8))),
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.white, fontSize: SizeConfig.smallText),
                    ),
                  ),
                ),
              ),
              Expanded(child: SizedBox())
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.meduimText, right: SizeConfig.meduimText),
          child: NameTextField(
            hint: hint,
          ),
        ),
        SizedBox(
          height: SizeConfig.meduimText,
        ),
      ],
    );
  }
}

class FatherEditProfile extends StatelessWidget {
  final String title;
  final String hint;
  FatherEditProfile({this.title, this.hint});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.largText),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: SizeConfig.xlargText,
                  decoration: BoxDecoration(
                      color: PrimaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8))),
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.white, fontSize: SizeConfig.smallText),
                    ),
                  ),
                ),
              ),
              Expanded(child: SizedBox())
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.meduimText, right: SizeConfig.meduimText),
          child: FatherTextField(
            hint: hint,
          ),
        ),
        SizedBox(
          height: SizeConfig.meduimText,
        ),
      ],
    );
  }
}

class PhoneEditProfile extends StatelessWidget {
  final String title;
  final String hint;
  PhoneEditProfile({this.title, this.hint});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.largText),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: SizeConfig.xlargText,
                  decoration: BoxDecoration(
                      color: PrimaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8))),
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.white, fontSize: SizeConfig.smallText),
                    ),
                  ),
                ),
              ),
              Expanded(child: SizedBox())
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.meduimText, right: SizeConfig.meduimText),
          child: PhoneTextField(
            hint: hint,
          ),
        ),
        SizedBox(
          height: SizeConfig.meduimText,
        ),
      ],
    );
  }
}

class GenderEditProfile extends StatelessWidget {
  final String title;
  GenderEditProfile({this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.largText),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: SizeConfig.xlargText,
                  decoration: BoxDecoration(
                      color: PrimaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8))),
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.white, fontSize: SizeConfig.smallText),
                    ),
                  ),
                ),
              ),
              Expanded(child: SizedBox())
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.meduimText, right: SizeConfig.meduimText),
          child: DropDownGender(),
        ),
        SizedBox(
          height: SizeConfig.meduimText,
        ),
      ],
    );
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
  List<String> _sex = ['Male', 'Female'];
  String _selectedsex;
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
                'male',
                style: TextStyle(fontSize: SizeConfig.smallText),
                overflow: TextOverflow.ellipsis,
              ),
              value: _selectedsex,
              onChanged: (newValue) {
                setState(() {
                  _selectedsex = newValue;
                });
              },
              items: _sex.map((location) {
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
