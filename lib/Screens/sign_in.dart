import 'package:flutter/material.dart';
import 'package:my_gym/model/application_user.dart';
import '../configuration.dart';
import '../Screens/home.dart';
import '../provider/auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:signalr_client/signalr_client.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

bool _isHidden = true;

final _phoneController = TextEditingController();
final _passwordController = TextEditingController();

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double larg = SizeConfig.largText;
    double small = SizeConfig.smallText;

    return Scaffold(
      backgroundColor: accentColor,
      body: Padding(
        padding: EdgeInsets.only(left: larg, right: larg),
        child: ListView(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.1,
            ),
            Text(
              "SIGN IN",
              style: TextStyle(
                  fontSize: larg,
                  color: PrimaryColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.01,
            ),
            Text(
              "Curabitur vulputate arcu odio , ac facilisis diam accumsan ut. Ut imperdiet et leo in vulputate",
              style: TextStyle(
                fontSize: small,
                color: PrimaryColor,
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.0833,
            ),
            EmailTextField(),
            SizedBox(
              height: SizeConfig.screenHeight * 0.04,
            ),
            PasswordTextField(),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            Text("FORGOT PASSWORD",
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: small, color: Colors.grey)),
            SizedBox(
              height: SizeConfig.screenHeight * 0.04,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: SizeConfig.meduimText,
                  left: SizeConfig.smallText,
                  right: SizeConfig.smallText),
              child: SizedBox(
                width: double.infinity,
                height: SizeConfig.screenHeight * 0.0833,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: buttonColor,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => Home()));
                    // Provider.of<Auth>(context).login(_phoneController.text,
                    //     _passwordController.text, context);
                    // signupNormall(context);
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(
                        fontSize: SizeConfig.smallText,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            controller: _phoneController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Email',
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
}

class PasswordTextField extends StatefulWidget {
  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            controller: _passwordController,
            obscureText: _isHidden,
            obscuringCharacter: "*",
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Password',
              hintStyle:
                  TextStyle(fontSize: SizeConfig.smallText, color: Colors.grey),
              contentPadding: EdgeInsets.only(
                  left: SizeConfig.screenHeight * 0.033,
                  top: SizeConfig.screenHeight * 0.02),
              suffixIcon: InkWell(
                onTap: _togglePasswordView,
                child: Icon(_isHidden ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future signupNormall(context) async {
  http.Response response = await http.post(
    "http://192.168.1.104:45457/api/Auth/Gymuserlogin?user=" +
        json.encode({
          "cos_tele1": "123456789",
          "cos_tele4": "123456",
        }),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    print(response.statusCode);
    Map<String, dynamic> res = json.decode(response.body);
    print("RESSSSSSSSSSSS $res");
    if (res != null) {
      ApplicationUser user = ApplicationUser.fromJson(res);
      user.remmberme = true;
      print("user.userguid");
      print(user.userGuid);
      Provider.of<Auth>(context, listen: false).currentUser = user;
      _getHubConnection(user.toJson().toString().replaceAll("'null'", "null"));
    }
  } else {
    print(response.statusCode);
  }
}

typedef HubConnectionProvider = Future<HubConnection> Function();
HubConnection _hubConnection;

Future<HubConnection> _getHubConnection(String userGuide) async {
  //final logger = _logger;
  final logger = null;

  print("hub connectoion ");
  print(userGuide);
  print("_getHubConnection");
  if (_hubConnection == null) {
    final httpOptions = new HttpConnectionOptions(logger: logger);
    //final httpOptions = new HttpConnectionOptions(logger: logger, transport: HttpTransportType.ServerSentEvents);
    //final httpOptions = new HttpConnectionOptions(logger: logger, transport: HttpTransportType.LongPolling);
    _hubConnection = HubConnectionBuilder()
        .withUrl(
            SizeConfig.baseUrl +
                "/UserTrace?user=$userGuide&userType=ApplicationUser",
            options: httpOptions)
        .configureLogging(logger)
        .build();
    _hubConnection.onclose((error) => print(error));
  }
  if (_hubConnection.state != HubConnectionState.Connected) {
    await _hubConnection.start();
    print("Connection state '${_hubConnection.state}'");
  }
  return _hubConnection;
}
