import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/AppWidget.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
  ));

  runApp(MyApp());
}


  