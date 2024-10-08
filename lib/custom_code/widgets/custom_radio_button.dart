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

class CustomRadioButton extends StatefulWidget {
  const CustomRadioButton({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  int _groupValue = -1;

  void _handleRadioValueChange(int? value) {
    setState(() {
      _groupValue = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> options = [
      'Small',
      'Regular',
      'Large',
      'Collector',
      'Super Collector'
    ];

    return Container(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: options.asMap().entries.map((entry) {
          int index = entry.key;
          String text = entry.value;
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Radio<int>(
                    value: index,
                    groupValue: _groupValue,
                    onChanged: _handleRadioValueChange,
                    activeColor: Color(0xFF740074),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
                color: Color(0xFFE7E7E8),
              ),
              SizedBox(height: 20),
            ],
          );
        }).toList(),
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

class CustomRadioButton extends StatefulWidget {
  const CustomRadioButton({
    super.key,
    this.width,
    this.height,
    this.selectedSizeGrade,
  });

  final double? width;
  final double? height;
  final String? selectedSizeGrade;

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  int _groupValue = -1;

  List<String> options = [
    'Small',
    'Regular',
    'Large',
    'Collector',
    'Super Collector'
  ];

  void initState() {
    super.initState();
    if (widget.selectedSizeGrade != null) {
      _groupValue = options.indexOf(widget.selectedSizeGrade!);
    }
  }

  void _handleRadioValueChange(int? value) {
    setState(() {
      _groupValue = value!;
    });
    // Update the AppState variable here
    FFAppState().SelectedSizeGrade = options[_groupValue];
    print("FFAppState().SelectedSizeGrade : ${FFAppState().SelectedSizeGrade}");

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: options.asMap().entries.map((entry) {
          int index = entry.key;
          String text = entry.value;
          return GestureDetector(
            onTap: () {
              _handleRadioValueChange(index);
            },
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Radio<int>(
                      value: index,
                      groupValue: _groupValue,
                      onChanged: _handleRadioValueChange,
                      activeColor: Color(0xFF740074),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xFFE7E7E8),
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
