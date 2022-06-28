import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olsify/WebviewScreen.dart';

void main() {

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,));
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Olsify',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WebviewScreen()
    );
  }
}

