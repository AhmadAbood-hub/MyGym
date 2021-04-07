import 'package:flutter/material.dart';
import '../configuration.dart';
import '../provider/sport.dart';
import 'package:provider/provider.dart';

class SelectSports extends StatefulWidget {
  @override
  _SelectSportsState createState() => _SelectSportsState();
}

class _SelectSportsState extends State<SelectSports> {
  TextEditingController controllerSearch = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      bottomNavigationBar:
          Provider.of<SportProvider>(context).sportHorizantalList.length == 0
              ? null
              : SelectSportList(),
      appBar: appBarSelectSports(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: accentColor,
          size: SizeConfig.xlargText + SizeConfig.smallText,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
      ),
      body: Column(
        children: [
          searchSports(context, controllerSearch),
          Expanded(
              child: Provider.of<SportProvider>(context)
                              .searchResult
                              .length != 0 ||
                      controllerSearch.text.isNotEmpty
                  ? ListView.builder(
                      itemCount:
                          Provider.of<SportProvider>(context,listen: true).searchResult.length,
                      itemBuilder: (BuildContext context, index) {
                        return itemSports(
                            Provider.of<SportProvider>(context,listen: true)
                                .searchResult[index],
                            context,
                            index);
                      },
                    )
                  :  ListView.builder(
                itemCount:
                Provider.of<SportProvider>(context,listen: true).sportList.length,
                itemBuilder: (BuildContext context, index) {
                  return itemSports(
                      Provider.of<SportProvider>(context,listen: true)
                          .sportList[index],
                      context,
                      index);
                },
              ))
        ],
      ),
    );
  }
}

Widget appBarSelectSports(context) {
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
    title: Text('Select The Sports',
        style: TextStyle(
            fontSize: SizeConfig.meduim2Text,
            fontWeight: FontWeight.bold,
            color: PrimaryColor)),
    centerTitle: true,
    actions: [
      Icon(
        Icons.save,
        color: buttonColor,
      ),
      Icon(
        Icons.save,
        color: Colors.transparent,
      )
    ],
  );
}

Widget searchSports(context, controllerSearch) {
  return Padding(
    padding:  EdgeInsets.only(left:SizeConfig.meduimText,right:SizeConfig.meduimText ),
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

Widget itemSports(Sport sport, context, index) {
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
                      padding: EdgeInsets.all(SizeConfig.smallText),
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
              Positioned(
                top: SizeConfig.meduimText,
                right: SizeConfig.meduimText,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.smallText),
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<SportProvider>(context, listen: false)
                                      .sportList[index]
                                      .colorIsCheck ==
                                  buttonColor
                              ? Provider.of<SportProvider>(context,
                                      listen: false)
                                  .itemChange(Colors.grey, index)
                              : Provider.of<SportProvider>(context,
                                      listen: false)
                                  .itemChange(buttonColor, index);

                          Provider.of<SportProvider>(context, listen: false)
                                      .sportList[index]
                                      .colorIsCheck ==
                                  Colors.grey
                              ? Provider.of<SportProvider>(context,
                                      listen: false)
                                  .delete(index)
                              : Provider.of<SportProvider>(context,
                                      listen: false)
                                  .add(sport);
                        },
                        child: Icon(
                          Icons.done_outline,
                          color:
                              Provider.of<SportProvider>(context, listen: true)
                                  .sportList[index]
                                  .colorIsCheck,
                        ),
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

class SelectSportList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight * 0.08,
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.largText, right: SizeConfig.largText),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: Provider.of<SportProvider>(context)
                        .sportHorizantalList
                        .length,
                    itemBuilder: (BuildContext context, index) {
                      return Center(
                        child: Text(
                            Provider.of<SportProvider>(context, listen: true)
                                    .sportHorizantalList[index]
                                    .title +
                                ","),
                      );
                    }),
              ),
              Expanded(
                  flex: 1,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                          right: SizeConfig.smallText,
                          top: SizeConfig.smallText,
                          child: Container(
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: buttonColor),
                            constraints: BoxConstraints(
                                minHeight: SizeConfig.largText,
                                minWidth: SizeConfig.largText),
                            child: Center(
                              child: Text(
                                Provider.of<SportProvider>(context)
                                    .sportHorizantalList
                                    .length
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: SizeConfig.meduimText,
                                    color: accentColor),
                              ),
                            ),
                          ))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
