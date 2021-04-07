import 'package:flutter/material.dart';
import 'package:my_gym/Screens/add_new_user.dart';
import 'package:my_gym/provider/users.dart';
import 'package:provider/provider.dart';
import '../configuration.dart';
import '../components/coustom_bottom_nav_bar.dart';
import '../enums.dart';
import '../components/coustom_drawer.dart';
import '../components/bottom_sheet_filter_user.dart';
import '../Screens/profile_user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/rendering.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  ScrollController _hideButtonController;
  TextEditingController controllerSearch = new TextEditingController();

  var _isVisible;

  @override
  initState() {
    super.initState();
    _isVisible = true;
    _hideButtonController = new ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible == true) {
          /* only set when the previous state is false
             * Less widget rebuilds 
             */
          print("**** ${_isVisible} up"); //Move IO away from setState
          setState(() {
            _isVisible = false;
          });
        }
      } else {
        if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isVisible == false) {
            /* only set when the previous state is false
               * Less widget rebuilds 
               */
            print("**** ${_isVisible} down"); //Move IO away from setState
            setState(() {
              _isVisible = true;
            });
          }
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _hideButtonController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      key: drawerKey, // assign key to Scaffold
      drawer: MyDrawer(),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.users,
      ),
      appBar: appBarUsers(context, drawerKey),
      backgroundColor: accentColor,
      floatingActionButton: Visibility(
        visible: _isVisible,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => AddNewUser()));
          },
          child: Icon(
            Icons.add,
            color: accentColor,
            size: SizeConfig.xlargText + SizeConfig.smallText,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
        ),
      ),
      body: Center(
        child: new CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            new SliverPadding(
              padding: EdgeInsets.only(
                  left: SizeConfig.meduimText, right: SizeConfig.meduimText),
              sliver: new SliverList(
                delegate: new SliverChildListDelegate(
                  <Widget>[
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.02,
                    ),
                    searchUser(context, controllerSearch),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.02,
                    ),
                    Container(
                      height: SizeConfig.screenHeight * 0.65,
                      child: Provider.of<UsersProvider>(context, listen: false).searchResult.length != 0 ||
                              controllerSearch.text.isNotEmpty
                          ? ListView.builder(
                              controller: _hideButtonController,
                              itemCount:
                                  Provider.of<UsersProvider>(context, listen: true)
                                      .searchResult
                                      .length,
                              itemBuilder: (BuildContext contex, index) => userItem(
                                  Provider.of<UsersProvider>(context, listen: true)
                                      .searchResult[index]
                                      .imgUrl,
                                  Provider.of<UsersProvider>(context, listen: true)
                                      .searchResult[index]
                                      .title,
                                  Provider.of<UsersProvider>(context, listen: true)
                                      .searchResult[index]
                                      .subTitle,
                                  context,
                                  index))
                          : ListView.builder(
                              controller: _hideButtonController,
                              itemCount: Provider.of<UsersProvider>(context, listen: true).userList.length,
                              itemBuilder: (BuildContext contex, index) => userItem(Provider.of<UsersProvider>(context, listen: true).userList[index].imgUrl, Provider.of<UsersProvider>(context, listen: true).userList[index].title, Provider.of<UsersProvider>(context, listen: true).userList[index].subTitle, context, index)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget appBarUsers(context, drawerKey) {
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
    title: Text('Users',
        style: TextStyle(
            fontSize: SizeConfig.meduim2Text,
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
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ProfileUser(false, index))),
        child: ListTile(
          trailing: GestureDetector(
            onTap: () {
              Provider.of<UsersProvider>(context, listen: false).loginChange(
                  !Provider.of<UsersProvider>(context, listen: false)
                      .userList[index]
                      .isAuth,
                  index);
              Provider.of<UsersProvider>(context, listen: false)
                      .userList[index]
                      .isAuth
                  ? doneLoginDialog(context)
                  : doneLogoutDialog(context);
            },
            child: Icon(
              Provider.of<UsersProvider>(context, listen: true)
                      .userList[index]
                      .isAuth
                  ? Icons.logout
                  : Icons.login,
              color: buttonColor,
              size: SizeConfig.largText,
            ),
          ),
          subtitle: Text(subTitle),
          title: Text(title),
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

Widget searchUser(context, TextEditingController controllerSearch) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    color: accentColor,
    child: new TextFormField(
      controller: controllerSearch,
      onChanged: Provider.of<UsersProvider>(context, listen: false)
          .onSearchTextChanged,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Search here..',
        hintStyle:
            TextStyle(fontSize: SizeConfig.smallText, color: Colors.grey),
        contentPadding: EdgeInsets.only(
            left: SizeConfig.screenHeight * 0.033,
            top: SizeConfig.screenHeight * 0.02),
        suffixIcon: InkWell(
          onTap: () {
            controllerSearch.text = "";
            Provider.of<UsersProvider>(context, listen: false)
                .searchResult
                .clear();
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: BottomSheetFilterUser(),
                ),
              ),
            );
          },
          child: Icon(Icons.filter_alt_rounded, color: Colors.grey),
        ),
        prefixIcon: Icon(Icons.search),
      ),
    ),
  );
}

void doneLoginDialog(context) {
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
                    padding: EdgeInsets.all(SizeConfig.meduimText),
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
                        SizedBox(height: 30.0),
                        Icon(
                          Icons.done_outline,
                          color: buttonColor,
                          size: SizeConfig.xlargText + SizeConfig.smallText,
                        ),
                        SizedBox(height: 30.0),
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
                              style: TextStyle(
                                  color: accentColor,
                                  fontSize: SizeConfig.meduimText),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
}

void doneLogoutDialog(context) {
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
                    padding: EdgeInsets.all(SizeConfig.meduimText),
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
                          size: SizeConfig.smallText + SizeConfig.xlargText,
                        ),
                        SizedBox(height: SizeConfig.xlargText),
                        Center(
                          child: Text("Your user is logout successfully",
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
                            style: TextStyle(
                                color: accentColor,
                                fontSize: SizeConfig.meduimText),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
}
