import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isNight = true;

const Color main_bk_night = Colors.black;
const Color main_bk_day = Colors.white;



const Color header_night = Colors.white24;
const Color header_day = Colors.blueAccent;

Color text_light = Color(0xff5a6068);


Color backgroundScaffold = Color(0xff121212);
Color backgroundAppbar = const Color(0xff121212);
Color color_bottom_navbar = const Color(0xff121212);
Color color_eventcard = Color(0xff212121);

Color backgroundScaffold_light = Color(0xfff2f2f2);
Color backgroundAppbar_light = const Color(0xffffffff);
Color color_bottom_navbar_light = const Color(0xffffffff);
Color color_eventcard_light = Color(0xffffffff);

Future<void> getTheme() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isNight = prefs.getBool('night') ?? true;
}