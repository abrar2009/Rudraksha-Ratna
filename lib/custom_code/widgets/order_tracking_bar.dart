/*
import '../../flutter_flow/flutter_flow_theme.dart';
import '/backend/schema/structs/index.dart';
import 'package:flutter/material.dart';
class OrderTrackingBar extends StatelessWidget {
  final List<TrackingStep> steps;

  const OrderTrackingBar({Key? key, required this.steps, required double width, required double height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: steps.asMap().entries.map((entry) {
        int idx = entry.key;
        TrackingStep step = entry.value;
        bool isLast = idx == steps.length - 1;

        return Row(
          children: [
            Expanded(
              child: _buildStepContent(step, context),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildCircle(bool isCompleted, BuildContext context) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: !isCompleted ? Border.all(color: Colors.grey, width: 2) : null,
      ),
      child: CircleAvatar(
        radius: 6,
        backgroundColor: isCompleted ? Color(0xFF740074) : Colors.white,
        // child: isCompleted ? Icon(Icons.check, size: 10, color: Colors.white) : null,
      ),
    );
  }

  Widget _buildDottedLine() {
    return Column(
      children: List.generate(
          2,
              (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Container(
              width: 2,
              height: 15,
              color: Colors.purple,
            ),
          )),
    );
  }

  Widget _buildStepContent(TrackingStep step, BuildContext context) {
    final int lastIndex = steps.length - 1;
    final bool isLastStep = step == steps[lastIndex];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCircle(step.isCompleted, context),
            SizedBox(width: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Montserrat',
                    color: step.isCompleted ? Colors.black : Colors.grey,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 4, width: 16), // Adjust the spacing between title and date
                Text(
                  step.date,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Montserrat',
                    color: step.isCompleted ? Colors.black : Colors.grey,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
        if (!isLastStep)
          Padding(
            padding: const EdgeInsets.only(left: 6.4),
            child: _buildDottedLine(),
          ),
      ],
    );
  }

}

class TrackingStep {
  final String title;
  final String date;
  final bool isCompleted;

  TrackingStep({
    required this.title,
    required this.date,
    this.isCompleted = false,
  });
}
*/


import 'package:flutter/material.dart';
import '../../flutter_flow/flutter_flow_theme.dart';

class OrderTrackingBar extends StatelessWidget {
  final List<Map<String, dynamic>> steps;
  final double width;
  final double height;

  const OrderTrackingBar({
    Key? key,
    required this.steps,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Column(
        children: steps.asMap().entries.map((entry) {
          int idx = entry.key;
          Map<String, dynamic> step = entry.value;
          bool isLast = idx == steps.length - 1;

          return Row(
            children: [
              Expanded(
                child: _buildStepContent(step, context, isLast),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCircle(bool isCompleted, BuildContext context) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: !isCompleted ? Border.all(color: Colors.grey, width: 2) : null,
      ),
      child: CircleAvatar(
        radius: 6,
        backgroundColor: isCompleted ? Color(0xFF740074) : Colors.white,
      ),
    );
  }

  Widget _buildDottedLine(Map<String, dynamic> step) {
    return Column(
      children: List.generate(
        2,
            (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Container(
            width: 2,
            height: 15,
            color: step['isCompleted'] ? Color(0xFF740074) : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent(Map<String, dynamic> step, BuildContext context, bool isLastStep) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCircle(step['isCompleted'], context),
            SizedBox(width: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  step['title'],
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Montserrat',
                    color: step['isCompleted'] ? Colors.black : Colors.grey,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  step['date'] != null ? step['date'] : '',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Montserrat',
                    color: step['isCompleted'] ? Colors.black : Colors.grey,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                SizedBox(width: 16),
                if (step['trackingid'] != null && step['trackingid'].isNotEmpty)
                Text(
                  step['trackingid'] != null ? 'Tracking ID: ${step['trackingid']}' : '',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Montserrat',
                    color: step['isCompleted'] ? Colors.black : Colors.grey,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        if (!isLastStep)
          Padding(
            padding: const EdgeInsets.only(left: 6.4),
            child: _buildDottedLine(step),
          ),
      ],
    );
  }
}

