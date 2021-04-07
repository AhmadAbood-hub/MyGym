import 'package:flutter/material.dart';
import 'package:my_gym/Screens/select_user.dart';
import '../configuration.dart';

class MyMessages extends StatefulWidget {
  @override
  _MyMessagesState createState() => _MyMessagesState();
}

class _MyMessagesState extends State<MyMessages> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => SelectUser()));
        },
        child: Icon(Icons.add,
            color: accentColor,
            size: SizeConfig.xlargText + SizeConfig.smallText),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
      ),
      appBar: appBarMyMessages(context),
      body: Padding(
        padding: EdgeInsets.only(top: SizeConfig.smallText),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: _photos().length,
          itemBuilder: (context, index) {
            return Item(photo: _photos()[index]);
          },
        ),
      ),
    );
  }
}

Widget appBarMyMessages(context) {
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
    title: Text('MY MESSAGES',
        style: TextStyle(
            fontSize: SizeConfig.meduim2Text,
            fontWeight: FontWeight.bold,
            color: PrimaryColor)),
    centerTitle: true,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.add_comment_outlined),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => SelectUser()));
        },
        color: PrimaryColor,
      )
    ],
  );
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
  ];
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
      padding: EdgeInsets.only(top: SizeConfig.smallText),
      child: Column(
        children: [
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(12.0), //or 15.0
              child: Container(
                width: SizeConfig.xlargText * 2,
                color: Color(0xffFF0E58),
                child: Image.asset(
                  "images/man.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            title: Text(
              "Ahmad Abood",
              style: TextStyle(
                  color: PrimaryColor, fontSize: SizeConfig.meduim2Text),
            ),
            subtitle: Text(
              "padding const EdgeInsets all padding const EdgeInsets all padding const EdgeInsets all padding const EdgeInsets all padding const EdgeInsets all",
              style: TextStyle(
                fontSize: SizeConfig.smallText,
              ),
              maxLines: 2,
            ),
            trailing: Text(
              "12:52 pm",
              style: TextStyle(fontSize: SizeConfig.smallText),
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
