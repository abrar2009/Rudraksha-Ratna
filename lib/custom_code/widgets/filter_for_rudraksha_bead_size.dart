// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class FilterForRudrakshaBeadSize extends StatefulWidget {
  const FilterForRudrakshaBeadSize({
    super.key,
    this.width,
    this.height,
    this.rangestart,
    this.rangeend,
    this.minValue,
    this.maxValue,
    this.divisions,
    this.labelStart,
    this.labelEnd,
  });

  final double? width;
  final double? height;
  final String? rangestart;
  final String? rangeend;
  final double? minValue;
  final double? maxValue;
  final int? divisions;
  final String? labelStart;
  final String? labelEnd;

  @override
  State<FilterForRudrakshaBeadSize> createState() =>
      _FilterForRudrakshaBeadSizeState();
}

class _FilterForRudrakshaBeadSizeState
    extends State<FilterForRudrakshaBeadSize> {
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    super.initState();

    // Initialize the current range values
    _currentRangeValues = RangeValues(
      double.tryParse(widget.rangestart ?? "0") ?? 0,
      double.tryParse(widget.rangeend ?? "0") ?? 0,
    );
  }

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
              showValueIndicator: ShowValueIndicator.always,
            ),
            child: RangeSlider(
              values: _currentRangeValues,
              min: widget.minValue!,
              max: widget.maxValue!,
              divisions: widget.divisions,
              labels: RangeLabels(
                'mm ${_currentRangeValues.start.round()}',
                'mm ${_currentRangeValues.end.round()}',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
                FFAppState().update(
                  () {
                    FFAppState().BeadSizeMin =
                        _currentRangeValues.start.toString();
                    FFAppState().BeadSizeMax =
                        _currentRangeValues.end.toString();
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('mm ${widget.minValue!}',
                  style: FlutterFlowTheme.of(context).bodyMedium),
              Text('mm ${widget.maxValue!}',
                  style: FlutterFlowTheme.of(context).bodyMedium),
            ],
          ),
        ],
      ),
    );
  }
}
