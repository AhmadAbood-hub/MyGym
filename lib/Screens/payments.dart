import 'package:flutter/material.dart';
import '../configuration.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/bottom_sheet_filter_payment.dart';
import '../provider/payment.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

String _name = "";

class Payments extends StatelessWidget {
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerPrice = new TextEditingController();
  TextEditingController controllerSearch = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: appBarMyPayments(context),
      backgroundColor: accentColor,
      bottomNavigationBar: bottomNavigationTotal(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _create(context, controllerName, controllerPrice);
        },
        child: Icon(
          Icons.add,
          color: accentColor,
          size: SizeConfig.xlargText + SizeConfig.smallText,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
      ),
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.smallText),
        child: ListView(children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.005,
          ),
          searchPayments(context, controllerSearch),
          SizedBox(
            height: SizeConfig.screenHeight * 0.025,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.meduimText, right: SizeConfig.meduimText),
            child: Container(
              child: Column(
                children: [
                  titels(),
                  Divider(),
                  Container(
                    height: SizeConfig.screenHeight * 0.55,
                    child: Provider.of<PaymentProvider>(context,
                                        listen: false)
                                    .searchResult
                                    .length !=
                                0 ||
                            controllerSearch.text.isNotEmpty
                        ? ListView.builder(
                            itemCount: Provider.of<PaymentProvider>(context,
                                    listen: false)
                                .searchResult
                                .length,
                            itemBuilder: (context, index) {
                              return details(
                                  Provider.of<PaymentProvider>(context,
                                          listen: true)
                                      .searchResult[index]
                                      .name,
                                  Provider.of<PaymentProvider>(context,
                                          listen: true)
                                      .searchResult[index]
                                      .date,
                                  Provider.of<PaymentProvider>(context,
                                          listen: true)
                                      .searchResult[index]
                                      .price
                                      .toString());
                            },
                          )
                        : ListView.builder(
                            itemCount: Provider.of<PaymentProvider>(context,
                                    listen: false)
                                .paymentList
                                .length,
                            itemBuilder: (BuildContext contex, index) => details(
                                Provider.of<PaymentProvider>(context, listen: true)
                                    .paymentList[index]
                                    .name,
                                Provider.of<PaymentProvider>(context, listen: true)
                                    .paymentList[index]
                                    .date,
                                Provider.of<PaymentProvider>(context, listen: true)
                                    .paymentList[index]
                                    .price
                                    .toString())),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

Widget appBarMyPayments(context) {
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
    title: Text('Payments',
        style: TextStyle(
            fontSize: SizeConfig.meduim2Text,
            fontWeight: FontWeight.bold,
            color: PrimaryColor)),
    centerTitle: true,
  );
}

Widget searchPayments(context, TextEditingController controllerSearch) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    color: accentColor,
    child: new TextFormField(
      controller: controllerSearch,
      onChanged: Provider.of<PaymentProvider>(context, listen: false)
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
            Provider.of<PaymentProvider>(context, listen: false)
                .searchResult
                .clear();

            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: BottomSheetFilterPayment(),
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

Widget titels() {
  return Container(
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            child: Center(
              child: Text(
                "Name",
                style: TextStyle(
                    fontSize: SizeConfig.meduimText, color: PrimaryColor),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: Center(
              child: Text(
                "Date",
                style: TextStyle(
                    fontSize: SizeConfig.meduimText, color: PrimaryColor),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: Center(
              child: Text(
                "Price",
                style: TextStyle(
                    fontSize: SizeConfig.meduimText, color: PrimaryColor),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget details(String nameOfThings, DateTime date, String price) {
  return Container(
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            child: Center(
              child: Text(
                nameOfThings,
                style: TextStyle(
                    fontSize: SizeConfig.smallText, color: PrimaryColor),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Center(
              child: Text(
                DateTime.parse("22/04/2000".split('/').reversed.join())== date
                    ? ""
                    : DateFormat('dd/MM/yyyy').format(date).toString(),
                style: TextStyle(
                    fontSize: SizeConfig.smallText, color: PrimaryColor),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Center(
              child: Text(
                double.parse(price) == 0.0 ? "" : price + " sp",
                style: TextStyle(
                    fontSize: SizeConfig.smallText, color: buttonColor),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget bottomNavigationTotal() {
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
                flex: 2,
                child: Container(
                  child: Center(
                    child: Text("TOTAL IS:",
                        style: TextStyle(
                            fontSize: SizeConfig.meduimText,
                            fontWeight: FontWeight.bold,
                            color: PrimaryColor)),
                  ),
                )),
            Spacer(
              flex: 1,
            ),
            Expanded(
                flex: 2,
                child: Container(
                  child: Center(
                    child: Text("592 SP",
                        style: TextStyle(
                            fontSize: SizeConfig.meduimText,
                            fontWeight: FontWeight.bold,
                            color: buttonColor)),
                  ),
                )),
          ],
        ),
      ),
    ),
  );
}

Widget textFieldName(controllerName) {
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
          controller: controllerName,
          onChanged: (value) {
            _name = value;
          },
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Name",
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

Widget textFieldPrice(controllerPrice) {
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
          controller: controllerPrice,
          onChanged: (value) {
            _name = value;
          },
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Price",
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

void _create(BuildContext context, TextEditingController controllerName,
    TextEditingController controllerPrice) {
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
                          child: Text("ADD A THING",
                              style: GoogleFonts.montserrat(
                                  color: Color.fromRGBO(59, 57, 60, 1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(child: Spacer())
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.025),
                    Container(
                        child: Column(
                      children: [
                        textFieldName(controllerName),
                        SizedBox(height: SizeConfig.screenHeight * 0.025),
                        textFieldPrice(controllerPrice),
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
                              Provider.of<PaymentProvider>(context,
                                      listen: false)
                                  .add(Payment(
                                      name: controllerName.text != ""
                                          ? controllerName.text
                                          : "null",
                                      price: controllerPrice.text != ""
                                          ? double.parse(controllerPrice.text)
                                          : "null",
                                      date: DateTime
                                          .now() /*DateFormat('dd/MM/yyyy')
                                          .format(DateTime.now())
                                          .toString()*/
                                      ));
                              Navigator.of(context).pop();
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) => Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        elevation: 0.0,
                                        backgroundColor: Colors.transparent,
                                        child: Stack(
                                          children: [
                                            SingleChildScrollView(
                                              child: Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.all(
                                                    SizeConfig.meduim2Text),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black26,
                                                      blurRadius: 10.0,
                                                      offset: const Offset(
                                                          0.0, 10.0),
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  // To make the card compact
                                                  children: <Widget>[
                                                    SizedBox(
                                                        height: SizeConfig
                                                            .meduimText),
                                                    Icon(
                                                      Icons.done_outline,
                                                      color: buttonColor,
                                                      size: SizeConfig
                                                              .xlargText +
                                                          SizeConfig.smallText,
                                                    ),
                                                    SizedBox(
                                                        height: SizeConfig
                                                            .meduimText),
                                                    Text("Add New Scheduling",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        59,
                                                                        57,
                                                                        60,
                                                                        1),
                                                                fontSize: SizeConfig
                                                                    .meduimText,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                    SizedBox(
                                                        height: SizeConfig
                                                            .meduimText),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ));
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
