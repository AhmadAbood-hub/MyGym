import 'package:flutter/material.dart';
import 'package:my_gym/configuration.dart';
import '../components/coustom_drawer.dart';
import '../components/coustom_bottom_nav_bar.dart';
import '../enums.dart';
import '../Screens/edit_profile.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey, // assign key to Scaffold

      drawer: MyDrawer(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
      backgroundColor: Colors.white,
      body: CustomScrollView(
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
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => EditProfile()));
                  },
                  icon: Icon(Icons.edit),
                ),
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
                        "My Scheduling History",
                        style: TextStyle(
                            fontSize: SizeConfig.meduim2Text,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: SizeConfig.meduim2Text,
                      ),
                      Text(
                        "Today is Saturday",
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
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    icon: Icon(Icons.arrow_back_ios_outlined),
                                    onPressed: null),
                                Text(
                                  "August",
                                  style: TextStyle(
                                      fontSize: SizeConfig.meduimText),
                                ),
                                IconButton(
                                    icon:
                                        Icon(Icons.arrow_forward_ios_outlined),
                                    onPressed: null),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(SizeConfig.smallText),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: _photos().length,
                                itemBuilder: (context, index) {
                                  return Item(photo: _photos()[index]);
                                },
                              ),
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
