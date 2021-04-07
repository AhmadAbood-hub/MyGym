import 'package:flutter/material.dart';
import 'package:my_gym/Screens/start_screen.dart';
import '../configuration.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: PrimaryColor,
      body: Logo(),
    );
  }
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => StartScreen()));
          },
          child: SizedBox(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight / 4,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset("images/logo.png"),
            ),
          ),
        ),
      ),
    );
  }
}
