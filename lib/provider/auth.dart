import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:my_gym/model/application_user.dart';
import '../configuration.dart';

class Auth with ChangeNotifier {
  bool isLoading = false;
  int tab = 0;

  ApplicationUser currentUser;

  String url = SizeConfig.baseUrl;

  Future<void> signUp(
      String email,
      String password,
      String firstName,
      String lastName,
      String phone,
      String country,
      String city,
      String address,
      bool accept,
      context) async {
    return await http
        .post("$url/api/Auth/RegisterAsync",
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "firstName": firstName,
              "lastName": lastName,
              "country": "سوريا",
              "city": "حلب",
              "email": email,
              "password": password,
              "phoneNumber": phone,
              "address": address,
              "acceptTerms": true
            }))
        .then((value) {
      if (value.statusCode == 200) {
        print("true");
        isLoading = false;
        tab = 1;
        notifyListeners();
      } else {
        print("false");

        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('An Error Occurred'),
                  content: Text("Please enter a vaild data !"),
                  actions: [
                    FlatButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: Text('okay!'))
                  ],
                ));
        isLoading = false;
        notifyListeners();
      }
    });
  }

  Future<void> login(String phone, String password, contex) async {
    return await http
        .post("$url/api/Auth/Gymuserlogin",
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "cos_tele1": "123456789",
              "cos_tele4": "123456",
            }))
        .then((value) {
      if (value.statusCode == 200) {
        print("true");
        isLoading = false;
        tab = 1;
        notifyListeners();
      } else {
        showDialog(
            context: contex,
            builder: (ctx) => AlertDialog(
                  title: Text('An Error Occurred'),
                  content: Text("Please enter a vaild data !"),
                  actions: [
                    FlatButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: Text('okay!'))
                  ],
                ));
        isLoading = false;
        notifyListeners();
      }
    });
  }
}
