/*
// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:marquee/marquee.dart'; // Import the marquee package

class MarqueeText extends StatefulWidget {
  const MarqueeText({
    super.key,
    this.width,
    this.height,
    required this.text, // Add this parameter
    this.speed = 50.0, // Optional speed parameter
  });

  final double? width;
  final double? height;
  final String text; // Add this parameter
  final double speed; // Optional speed parameter

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Marquee(
        text: widget.text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        scrollAxis: Axis.horizontal,
        blankSpace: 20.0,
        velocity: widget.speed,
        startPadding: 10.0,
        accelerationDuration: Duration(seconds: 1),
        accelerationCurve: Curves.linear,
        decelerationDuration: Duration(milliseconds: 500),
        decelerationCurve: Curves.easeOut,
      ),
    );
  }
}
*/


// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:marquee/marquee.dart'; // Import the marquee package

class MarqueeText extends StatefulWidget {
  const MarqueeText({
    super.key,
    this.width,
    this.height,
    required this.text, // Add this parameter
    this.speed = 50.0, // Optional speed parameter
  });

  final double? width;
  final double? height;
  final String text; // Add this parameter
  final double speed; // Optional speed parameter

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText> {
  @override
  Widget build(BuildContext context) {
    return Center( // Wrap in Center widget
      child: Container(
        width: widget.width,
        height: widget.height,
        child: Marquee(
          text: widget.text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          scrollAxis: Axis.horizontal,
          blankSpace: 20.0,
          velocity: widget.speed,
          startPadding: 0.0, // Adjusted to ensure the text is fully in motion
          accelerationDuration: Duration(seconds: 1),
          accelerationCurve: Curves.linear,
          decelerationDuration: Duration(milliseconds: 500),
          decelerationCurve: Curves.easeOut,
        ),
      ),
    );
  }
}
