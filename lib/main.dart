import 'package:flutter/material.dart';
import './route.dart';

void main() => runApp(MaterialApp(
      title: 'flutter-app',
      initialRoute: "/",
      routes: new Routes().routes,
    ));


