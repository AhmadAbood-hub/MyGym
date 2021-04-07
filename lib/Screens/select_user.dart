import 'package:flutter/material.dart';
import 'package:my_gym/configuration.dart';
import 'package:provider/provider.dart';
import '../provider/users.dart';

class SelectUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: appBarSelectUser(context),
      body: Container(
          child: Column(
        children: [
          if (Provider.of<UsersProvider>(context).userHorizantalList.isNotEmpty)
            Expanded(flex: 1, child: ListHorizontal()),
          Expanded(flex: 4, child: ListVertical())
        ],
      )),
    );
  }
}

Widget appBarSelectUser(context) {
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
    title: Text('Select Users',
        style: TextStyle(
            fontSize: SizeConfig.meduim2Text,
            fontWeight: FontWeight.bold,
            color: PrimaryColor)),
    centerTitle: true,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.done),
        onPressed: () {},
        color: buttonColor,
      )
    ],
  );
}

class ListHorizontal extends StatelessWidget {
  Widget _itemsHorizontal(int index, context) {
    return new CircleAvatar(
      radius: 40.0,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        child: Align(
          alignment: Alignment.bottomRight,
        ),
        radius: 38.0,
        backgroundImage: AssetImage(
            Provider.of<UsersProvider>(context, listen: false)
                .userHorizantalList[index]
                .imgUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.smallText),
      child: Container(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: Provider.of<UsersProvider>(context, listen: true)
                .userHorizantalList
                .length,
            itemBuilder: (BuildContext context, int index) {
              return _itemsHorizontal(index, context);
            }),
      ),
    );
  }
}

class ListVertical extends StatelessWidget {
  Widget _itemsVertical(context, int index) {
    return Card(
      child: new Container(
        padding: new EdgeInsets.all(SizeConfig.meduimText),
        child: Column(
          children: <Widget>[
            new CheckboxListTile(
                activeColor: buttonColor,
                dense: true,
                //font change
                title: Text(
                  Provider.of<UsersProvider>(context, listen: false)
                          .userList[index]
                          .title ??
                      "",
                  style: TextStyle(
                      fontSize: SizeConfig.meduim2Text,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                subtitle: Text(
                  Provider.of<UsersProvider>(context, listen: false)
                          .userList[index]
                          .subTitle ??
                      "",
                  style: TextStyle(
                      fontSize: SizeConfig.meduimText, letterSpacing: 0.5),
                ),
                value: Provider.of<UsersProvider>(context, listen: false)
                    .userList[index]
                    .check,
                secondary: Container(
                  height: SizeConfig.largText * 2,
                  width: SizeConfig.largText * 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0), //or 15.0
                    child: Container(
                      width: SizeConfig.xlargText * 2,
                      color: Color(0xffFF0E58),
                      child: Image.asset(
                        Provider.of<UsersProvider>(context, listen: false)
                            .userList[index]
                            .imgUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                onChanged: (bool val) {
                  Provider.of<UsersProvider>(context, listen: false)
                      .checkChange(val, index);
                  if (val) {
                    Provider.of<UsersProvider>(context, listen: false).add(
                        id: index,
                        title:
                            Provider.of<UsersProvider>(context, listen: false)
                                .userList[index]
                                .title,
                        imgUrl:
                            Provider.of<UsersProvider>(context, listen: false)
                                .userList[index]
                                .imgUrl,
                        check: val);
                  } else {
                    Provider.of<UsersProvider>(context, listen: false)
                        .delete(index);
                  }
                }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView.builder(
          itemCount: Provider.of<UsersProvider>(context).userList.length,
          itemBuilder: (BuildContext context, int index) {
            return _itemsVertical(context, index);
          }),
    );
  }
}
