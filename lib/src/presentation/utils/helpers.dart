import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:nectar/src/data/models/user.dart';

// email regex
bool isValidEmail(String email) {
  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',
  );
  return emailRegExp.hasMatch(email);
}

// random color
Color generateRandomColor() {
  const List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.indigo,
    Colors.cyan,
    Colors.amber,
    Colors.lime,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.deepPurple,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
  ];

  return colors[Random().nextInt(colors.length)];
}

// is user registered
bool isUserRegistered() {
  User? user = Hive.box('myBox').get('user');

  if (user == null) {
    return false;
  } else {
    return user.address.isEmpty ? false : true;
  }
}
