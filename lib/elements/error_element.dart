import 'package:flutter/material.dart';

Widget buildErrorWidget(String error) {
  return const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Text(
        "Check your internet connection or some error on system",
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
      ),
    ],
  );
}