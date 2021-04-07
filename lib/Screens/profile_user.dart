import 'package:flutter/material.dart';
import 'package:my_gym/configuration.dart';
import '../components/coustom_drawer.dart';
import '../components/coustom_bottom_nav_bar.dart';
import '../enums.dart';
import '../Screens/edit_profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/users.dart';
import '../components/coustom_drawer.dart';

class ProfileUser extends StatefulWidget {
  final bool btnUpdate;
  final int index;
  ProfileUser(this.btnUpdate, this.index);

  @override
  _ProfileUserState createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      backgroundColor: Colors.white,
      drawer: MyDrawer(),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                  expandedHeight: SizeConfig.screenHeight * 0.45,
                  pinned: true,
                  leading: GestureDetector(
                      onTap: () {
                        drawerKey.currentState.openDrawer();
                      },
                      child: Icon(Icons.notes)),
                  actions: [
                    widget.btnUpdate
                        ? IconButton(
                            icon: Icon(
                              Icons.phone,
                              color: Colors.transparent,
                            ),
                            onPressed: null)
                        : IconButton(
                            onPressed: () {
                              print(widget.index);
                              Provider.of<UsersProvider>(context, listen: false)
                                  .loginChange(
                                      !Provider.of<UsersProvider>(context,
                                              listen: false)
                                          .userList[widget.index]
                                          .isAuth,
                                      widget.index);

                              Provider.of<UsersProvider>(context, listen: false)
                                      .userList[widget.index]
                                      .isAuth
                                  ? loginSuccsesDialog(context)
                                  : logoutSuccsesDialog(context);
                            },
                            icon: Provider.of<UsersProvider>(context,
                                        listen: true)
                                    .userList[widget.index]
                                    .isAuth
                                ? Icon(Icons.logout)
                                : Icon(
                                    Icons.login,
                                  ),
                          )
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      "My Profile",
                      style: TextStyle(fontSize: SizeConfig.meduim2Text),
                    ),
                    centerTitle: true,
                    background: InteractiveViewer(
                      child: Image.asset(
                        "images/man.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  )),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.3),
                              Colors.orange.withOpacity(0.1),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [0, 1])),
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.meduim2Text),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ahmad Abood",
                            style: TextStyle(
                                fontSize: SizeConfig.meduim2Text,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: SizeConfig.meduimText,
                          ),
                          Text(
                            "+(963991224361)",
                            style: TextStyle(
                                fontSize: SizeConfig.meduimText,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                          SizedBox(
                            height: SizeConfig.meduimText,
                          ),
                          Text(
                            "Manger",
                            style: TextStyle(
                                fontSize: SizeConfig.meduimText,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                          SizedBox(
                            height: SizeConfig.largText,
                          ),
                          Text(
                            "Ahmad Sports",
                            style: TextStyle(
                                fontSize: SizeConfig.meduim2Text,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: SizeConfig.meduimText,
                          ),
                          Text(
                            "3 sports subscribed",
                            style: TextStyle(
                                fontSize: SizeConfig.meduimText,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                          SizedBox(
                            height: SizeConfig.meduimText,
                          ),
                          Container(
                            height: SizeConfig.screenHeight * 0.35,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                itemSports(),
                                itemSports(),
                                itemSports(),
                                itemSports(),
                                itemSports(),
                                itemSports(),
                                itemSports(),
                                itemSports(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.meduim2Text,
                          ),
                          Text(
                            "My Scheduling History",
                            style: TextStyle(
                                fontSize: SizeConfig.meduim2Text,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: SizeConfig.meduimText,
                          ),
                          Text(
                            "Today is Saturday, 7 August 2021",
                            style: TextStyle(
                                fontSize: SizeConfig.meduimText,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                          SizedBox(
                            height: SizeConfig.meduimText,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        icon:
                                            Icon(Icons.arrow_back_ios_outlined),
                                        onPressed: null),
                                    Text(
                                      "August",
                                      style: TextStyle(
                                          fontSize: SizeConfig.meduimText),
                                    ),
                                    IconButton(
                                        icon: Icon(
                                            Icons.arrow_forward_ios_outlined),
                                        onPressed: null),
                                  ],
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: _photos().length,
                                  itemBuilder: (context, index) {
                                    return Item(photo: _photos()[index]);
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
              ]))
            ],
          ),
          Positioned(
            top: SizeConfig.screenHeight * 0.85,
            left: SizeConfig.largText,
            right: SizeConfig.largText,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.largText),
                child: widget.btnUpdate
                    ? GestureDetector(
                        onTap: () {
                          _create(context);
                        },
                        child: Container(
                            height: (SizeConfig.meduimText * 2) +
                                SizeConfig.largText,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                              child: Text(
                                "Update subscription",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: accentColor,
                                    fontSize: SizeConfig.meduimText),
                              ),
                            )),
                      )
                    : null,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: FittedBox(
        child: Image.asset("images/man.jpg"),
        fit: BoxFit.cover,
      ),
    );
  }
}

class Item extends StatelessWidget {
  Item({
    Key key,
    @required this.photo,
  }) : super(key: key);

  final _Photo photo;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.smallText),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(15),
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.smallText,
                      height: SizeConfig.xlargText * 2,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15))),
                    ),
                    Column(
                      children: [
                        Text(
                          "Aug",
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: SizeConfig.meduimText),
                        ),
                        Text("05",
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.meduim2Text))
                      ],
                    ),
                  ],
                )),
            SizedBox(
              width: SizeConfig.meduim2Text,
            ),
            Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fri, Holiday",
                      style: TextStyle(fontSize: SizeConfig.meduimText),
                    ),
                    Text(
                      "(-h)",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.3),
                          fontSize: SizeConfig.meduimText),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class _Photo {
  _Photo({
    this.imageURL,
    this.title,
    this.subtitle,
  });

  final String imageURL;
  final String title;
  final String subtitle;
}

List<_Photo> _photos() {
  return [
    _Photo(
        imageURL:
            'https://cdn.pixabay.com/photo/2017/06/09/09/39/adler-2386314_960_720.jpg',
        title: 'Eagle',
        subtitle: 'Eagle subtitle'),
    _Photo(
        imageURL:
            'https://cdn.pixabay.com/photo/2016/07/15/15/55/dachshund-1519374_960_720.jpg',
        title: 'Cute Dog',
        subtitle: 'cute cute'),
    _Photo(
        imageURL:
            'https://cdn.pixabay.com/photo/2016/05/02/13/17/wildlife-1367217_960_720.jpg',
        title: 'deer',
        subtitle: 'looks kind'),
    _Photo(
        imageURL:
            'https://cdn.pixabay.com/photo/2020/02/05/15/19/zoo-4821484_960_720.jpg',
        title: 'mongoose',
        subtitle: 'hug'),
    _Photo(
        imageURL:
            'https://cdn.pixabay.com/photo/2012/10/06/22/18/horse-60153_960_720.jpg',
        title: 'Horse',
        subtitle: 'yummy'),
  ];
}

Widget itemSports() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Column(
      children: [
        Container(
          width: SizeConfig.screenWidth * 0.85,
          height: SizeConfig.screenHeight * 0.3,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(SizeConfig.smallText),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0), //or 15.0
                  child: Container(
                    width: SizeConfig.xlargText * 2,
                    color: Color(0xffFF0E58),
                    child: Image.asset(
                      "images/logo.png",
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
                      padding: EdgeInsets.all(SizeConfig.smallText),
                      child: Text(
                        "Jerusalem",
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
          height: SizeConfig.smallText,
        )
      ],
    ),
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
                          "Do you want to update subscription for jerry",
                          style: TextStyle(fontSize: SizeConfig.meduimText),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.025),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

void loginSuccsesDialog(context) {
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
                    padding: EdgeInsets.all(SizeConfig.meduim2Text),
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
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min, // To make the card compact
                      children: <Widget>[
                        SizedBox(height: SizeConfig.xlargText),
                        Icon(
                          Icons.done_outline,
                          color: buttonColor,
                          size: SizeConfig.xlargText + SizeConfig.meduimText,
                        ),
                        SizedBox(
                            height:
                                SizeConfig.xlargText + SizeConfig.meduimText),
                        Center(
                          child: Text("Your user is login successfully",
                              style: GoogleFonts.montserrat(
                                  color: Color.fromRGBO(59, 57, 60, 1),
                                  fontSize: SizeConfig.meduimText,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: SizeConfig.xlargText),
                        FlatButton(
                            onPressed: () => Navigator.of(context).pop(),
                            color: buttonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Ok",
                              style: TextStyle(color: accentColor),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
  ;
}

void logoutSuccsesDialog(context) {
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
                    padding: EdgeInsets.all(SizeConfig.meduim2Text),
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
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min, // To make the card compact
                      children: <Widget>[
                        SizedBox(height: SizeConfig.xlargText),
                        Icon(
                          Icons.done_outline,
                          color: buttonColor,
                          size: SizeConfig.xlargText + SizeConfig.meduimText,
                        ),
                        SizedBox(height: SizeConfig.xlargText),
                        Center(
                          child: Text("Your user is logout successfully",
                              style: GoogleFonts.montserrat(
                                  color: Color.fromRGBO(59, 57, 60, 1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: SizeConfig.xlargText),
                        FlatButton(
                            onPressed: () => Navigator.of(context).pop(),
                            color: buttonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Ok",
                              style: TextStyle(color: accentColor),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
}
