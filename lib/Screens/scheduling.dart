import 'package:flutter/material.dart';
import '../configuration.dart';
import '../calendar_model.dart';
import '../db.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Scheduling extends StatefulWidget {
  @override
  _SchedulingState createState() => _SchedulingState();
}

class _SchedulingState extends State<Scheduling> {
  DateTime _selectedDay = DateTime.now();

  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events = {};
  List<CalendarItem> _data = [];
  List<dynamic> _selectedEvents = [];

  List<Widget> get _eventWidgets =>
      _selectedEvents.map((e) => events(e)).toList();

  void initState() {
    super.initState();
    DB.init().then((value) => _fetchEvents());
    _calendarController = CalendarController();
  }

  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  Widget events(var d) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(color: Theme.of(context).dividerColor),
          )),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              d,
            ),
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: buttonColor,
                  size: SizeConfig.largText,
                ),
                onPressed: () => _deleteEvent(d))
          ])),
    );
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedDay = day;
      _selectedEvents = events;
    });
  }

  void _create(BuildContext context) {
    String _name = "";
    String pickedtime = "";

    var floatingActionButtonSetTime = FloatingActionButton.extended(
      onPressed: () {
        DatePicker.showTime12hPicker(context,
            showTitleActions: true,
            currentTime: DateTime.now(), onConfirm: (time) {
          setState(() {
            pickedtime =
                "Picked time is : ${time.hour} : ${time.minute} : ${time.second}";
          });
        });
      },
      label: Text(
        "Set Time",
        style: TextStyle(color: PrimaryColor, fontSize: SizeConfig.meduimText),
      ),
      backgroundColor: accentColor,
      icon: Icon(
        Icons.timer,
        color: PrimaryColor,
        size: SizeConfig.largText,
      ),
    );
    var textFieldTitle = Container(
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
              hintText: 'Title',
              hintStyle: TextStyle(
                  fontSize: SizeConfig.meduimText, color: Colors.grey),
              contentPadding:
                  EdgeInsets.only(left: SizeConfig.screenHeight * 0.033),
            ),
          ),
        ),
      ),
    );
    var btn = Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: buttonColor,
      child: FlatButton(
        child: Text('ADD',
            style: GoogleFonts.montserrat(
                color: accentColor,
                fontSize: SizeConfig.meduimText,
                fontWeight: FontWeight.bold)),
        onPressed: () => _addEvent(_name),
      ),
    );
    var cancelButton = Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: FlatButton(
          color: Colors.white,
          child: Text('Cancel',
              style: GoogleFonts.montserrat(
                  color: PrimaryColor,
                  fontSize: SizeConfig.meduimText,
                  fontWeight: FontWeight.bold)),
          onPressed: () => Navigator.of(context).pop(false)),
    );
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
                padding: EdgeInsets.all(6),
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
                  mainAxisSize: MainAxisSize.min, // To make the card compact
                  children: <Widget>[
                    SizedBox(height: SizeConfig.meduimText),
                    Text("Add New Scheduling",
                        style: GoogleFonts.montserrat(
                            color: Color.fromRGBO(59, 57, 60, 1),
                            fontSize: SizeConfig.meduim2Text,
                            fontWeight: FontWeight.bold)),
                    Container(
                        padding: EdgeInsets.all(SizeConfig.meduim2Text),
                        child: Column(
                          children: [
                            textFieldTitle,
                            SizedBox(
                              height: SizeConfig.meduim2Text,
                            ),
                            floatingActionButtonSetTime
                          ],
                        )),
                    Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      cancelButton,
                      SizedBox(
                        width: SizeConfig.meduimText,
                      ),
                      btn
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchEvents() async {
    _events = {};
    List<Map<String, dynamic>> _results = await DB.query(CalendarItem.table);
    _data = _results.map((item) => CalendarItem.fromMap(item)).toList();
    _data.forEach((element) {
      DateTime formattedDate = DateTime.parse(DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(element.date.toString())));
      if (_events.containsKey(formattedDate)) {
        _events[formattedDate].add(element.name.toString());
      } else {
        _events[formattedDate] = [element.name.toString()];
      }
    });
    setState(() {});
  }

  void _addEvent(String event) async {
    CalendarItem item =
        CalendarItem(date: _selectedDay.toString(), name: event);
    await DB.insert(CalendarItem.table, item);
    _selectedEvents.add(event);
    _fetchEvents();

    Navigator.pop(context);
  }

  // Delete doesnt refresh yet, thats it, then done!
  void _deleteEvent(String s) {
    List<CalendarItem> d = _data.where((element) => element.name == s).toList();
    if (d.length == 1) {
      DB.delete(CalendarItem.table, d[0]);
      _selectedEvents.removeWhere((e) => e == s);
      _fetchEvents();
    }
  }

  Widget calendar() {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: new Offset(0.0, 5))
            ]),
        child: TableCalendar(
          calendarStyle: CalendarStyle(
            canEventMarkersOverflow: true,
            markersColor: PrimaryColor,
            weekdayStyle: TextStyle(color: PrimaryColor),
            todayColor: Colors.white54,
            todayStyle: TextStyle(
                color: buttonColor,
                fontSize: SizeConfig.meduimText,
                fontWeight: FontWeight.bold),
            selectedColor: buttonColor,
            outsideWeekendStyle: TextStyle(color: Colors.grey),
            outsideStyle: TextStyle(color: Colors.grey),
            weekendStyle: TextStyle(color: PrimaryColor),
            renderDaysOfWeek: false,
          ),
          onDaySelected: (date, events, _) {
            _onDaySelected(date, events);
          },
          calendarController: _calendarController,
          events: _events,
          headerStyle: HeaderStyle(
            leftChevronIcon: Icon(Icons.arrow_back_ios,
                size: SizeConfig.meduimText, color: PrimaryColor),
            rightChevronIcon: Icon(Icons.arrow_forward_ios,
                size: SizeConfig.meduimText, color: PrimaryColor),
            titleTextStyle: GoogleFonts.montserrat(
                color: PrimaryColor, fontSize: SizeConfig.meduim2Text),
            formatButtonDecoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(20),
            ),
            formatButtonTextStyle: GoogleFonts.montserrat(
                color: accentColor, fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ));
  }

  Widget eventTitle() {
    if (_selectedEvents.length == 0) {
      return Container(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
        child: Text(
          "No events",
          style: TextStyle(fontSize: SizeConfig.meduimText),
        ),
      );
    }
    return Container(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
        child: Text(
          "Events",
          style: TextStyle(fontSize: SizeConfig.meduimText),
        ));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: appBarMyscheduling(context),
      backgroundColor: accentColor,
      body: ListView(
        children: [
          calendar(),
          eventTitle(),
          Column(children: _eventWidgets),
          SizedBox(height: SizeConfig.xlargText * 2)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: SizeConfig.xlargText + SizeConfig.smallText,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Widget appBarMyscheduling(context) {
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
    title: Text('scheduling',
        style: TextStyle(
            fontSize: SizeConfig.meduimText,
            fontWeight: FontWeight.bold,
            color: PrimaryColor)),
    centerTitle: true,
  );
}
