import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HourglassBackground extends StatelessWidget {
  final double width;
  HourglassBackground({this.width});
  final spinkit = SpinKitPouringHourglass(
    duration: Duration(milliseconds: 7200),
    size: 800,
    color: Colors.blue,
  );
  @override
  Widget build(BuildContext context) {
    return spinkit;
  }
}
