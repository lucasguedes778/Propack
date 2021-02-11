import 'package:flutter/material.dart';
import 'shed.dart';

final int defaultShed = 1;

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
        body: Shed(shedIndex: defaultShed),
    )
));