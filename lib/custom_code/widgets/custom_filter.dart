// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// // Automatic FlutterFlow imports
// import '/backend/schema/structs/index.dart';
// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import '/custom_code/widgets/index.dart'; // Imports other custom widgets
// import '/flutter_flow/custom_functions.dart'; // Imports custom functions
// import 'package:flutter/material.dart';
// // Begin custom widget code
// // DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// class CustomFilter extends StatefulWidget {
//   const CustomFilter({
//     super.key,
//     this.width,
//     this.height,
//   });

//   final double? width;
//   final double? height;

//   @override
//   State<CustomFilter> createState() => _CustomFilterState();
// }

// class _CustomFilterState extends State<CustomFilter> {
//   RangeValues _priceRange = RangeValues(2550, 15000);
//   RangeValues _beadSizeRange = RangeValues(24, 42);
//   String _sizeGrade = 'Small';

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.width ?? double.infinity,
//       height: widget.height ?? double.infinity,
//       padding: EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12),
//       decoration: BoxDecoration(
//         color: FlutterFlowTheme.of(context).secondaryBackground,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Text(
//             'Price',
//             style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//           ),
//           RangeSlider(
//             values: _priceRange,
//             min: 0,
//             max: 200000,
//             divisions: 100,
//             labels: RangeLabels(
//               'INR ${_priceRange.start.round()}',
//               'INR ${_priceRange.end.round()}',
//             ),
//             onChanged: (RangeValues values) {
//               setState(() {
//                 _priceRange = values;
//               });
//             },
//             activeColor: Color(0xFF740074),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('INR ${_priceRange.start.round()}',
//                   style: FlutterFlowTheme.of(context).bodyMedium),
//               Text('INR ${_priceRange.end.round()}',
//                   style: FlutterFlowTheme.of(context).bodyMedium),
//             ],
//           ),
//           SizedBox(height: 12),
//           Divider(
//             thickness: 1,
//             color: Color(0xFFE7E7E8),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Text(
//             'Bead Size',
//             style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//           ),
//           RangeSlider(
//             values: _beadSizeRange,
//             min: 10,
//             max: 50,
//             //divisions: 40,
//             labels: RangeLabels(
//               '${_beadSizeRange.start.round()}mm',
//               '${_beadSizeRange.end.round()}mm',
//             ),
//             onChanged: (RangeValues values) {
//               setState(() {
//                 _beadSizeRange = values;
//               });
//             },
//             activeColor: Color(0xFF740074),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('${_beadSizeRange.start.round()}mm',
//                   style: FlutterFlowTheme.of(context).bodyMedium),
//               Text('${_beadSizeRange.end.round()}mm',
//                   style: FlutterFlowTheme.of(context).bodyMedium),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class CustomFilter extends StatefulWidget {
  const CustomFilter({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<CustomFilter> createState() => _CustomFilterState();
}

class _CustomFilterState extends State<CustomFilter> {
  RangeValues _priceRange = RangeValues(2550, 15000);
  RangeValues _beadSizeRange = RangeValues(24, 42);
  String _sizeGrade = 'Small';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      padding: EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Price',
            style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Color(0xFF740074),
              inactiveTrackColor: Color(0xFFE1C4E9),
              overlayColor: Color(0x66740074),
              thumbColor: Color(0xFF740074),
              valueIndicatorColor: Color.fromARGB(120, 120, 0, 120),
              valueIndicatorTextStyle: TextStyle(
                color: Colors.white,
              ),
              showValueIndicator: ShowValueIndicator.always,
            ),
            child: RangeSlider(
              values: _priceRange,
              min: 0,
              max: 200000,
              divisions: 100,
              labels: RangeLabels(
                'INR ${_priceRange.start.round()}',
                'INR ${_priceRange.end.round()}',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _priceRange = values;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('INR ${_priceRange.start.round()}',
                  style: FlutterFlowTheme.of(context).bodyMedium),
              Text('INR ${_priceRange.end.round()}',
                  style: FlutterFlowTheme.of(context).bodyMedium),
            ],
          ),
          SizedBox(height: 12),
          Divider(
            thickness: 1,
            color: Color(0xFFE7E7E8),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Bead Size',
            style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Color(0xFF740074),
              inactiveTrackColor: Color(0xFFE1C4E9),
              overlayColor: Color(0x66740074),
              thumbColor: Color(0xFF740074),
              valueIndicatorColor: Color.fromARGB(120, 120, 0, 120),
              valueIndicatorTextStyle: TextStyle(
                color: Colors.white,
              ),
              showValueIndicator:
                  ShowValueIndicator.always, // Always show value indicator
            ),
            child: RangeSlider(
              values: _beadSizeRange,
              min: 10,
              max: 50,
              labels: RangeLabels(
                '${_beadSizeRange.start.round()}mm',
                '${_beadSizeRange.end.round()}mm',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _beadSizeRange = values;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${_beadSizeRange.start.round()}mm',
                  style: FlutterFlowTheme.of(context).bodyMedium),
              Text('${_beadSizeRange.end.round()}mm',
                  style: FlutterFlowTheme.of(context).bodyMedium),
            ],
          ),
        ],
      ),
    );
  }
}
