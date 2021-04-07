import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const PrimaryColor = Color(0xFF023047);
const buttonColor = Color(0xFFff8800);
Color accentColor = Colors.white.withOpacity(0.95);

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;
  static String baseUrl = "http://192.168.1.104:45457";

  static double xlargText = 30.ssp;
  static double largText = 25.ssp;
  static double meduim2Text = 15.ssp;
  static double meduimText = 12.ssp;
  static double smallText = 10.ssp;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }

  static double getScreenHeight() {
    double screenHeight = SizeConfig.screenHeight;
    return screenHeight;
  }

  static double getScreenWidth() {
    double screenWidth = SizeConfig.screenWidth;
    return screenWidth;
  }
}
