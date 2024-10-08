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

class FreeGiftContainerdiscountpriceCopy extends StatefulWidget {
  const FreeGiftContainerdiscountpriceCopy({
    super.key,
    this.width,
    this.height,
    this.discountPercent,
    this.code,
  });

  final double? width;
  final double? height;
  final String? discountPercent;
  final String? code;

  @override
  State<FreeGiftContainerdiscountpriceCopy> createState() =>
      _FreeGiftContainerdiscountpriceCopyState();
}

class _FreeGiftContainerdiscountpriceCopyState
    extends State<FreeGiftContainerdiscountpriceCopy> {
  @override
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: TicketClipper(),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            width: (widget.width ?? 300.0) + 4,
            height: (widget.height ?? 100.0) + 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.discountPercent!,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF740074),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            '%',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF740074),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                      Text(
                        'Off',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 45,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.code!,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Row(
                        children: [
                          Text(
                            widget.discountPercent!,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          Text(
                            '% Off on Product Price',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: CustomPaint(
            size:
                Size((widget.width ?? 300.0) + 4, (widget.height ?? 100.0) + 4),
            painter: DashedLinePainter(height: (widget.height ?? 100.0) + 3),
          ),
        ),
      ],
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double notchRadius = 10.0;
    double notchPosition =
        size.width * 0.25; // Set the notch at 25% from the left

    // Top left arc
    path.moveTo(notchRadius, 0);
    path.lineTo(notchPosition - notchRadius, 0);
    path.arcToPoint(
      Offset(notchPosition + notchRadius, 0),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(size.width - notchRadius, 0);
    path.arcToPoint(
      Offset(size.width, notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: true,
    );

    // Right side
    path.lineTo(size.width, size.height - notchRadius);
    path.arcToPoint(
      Offset(size.width - notchRadius, size.height),
      radius: Radius.circular(notchRadius),
      clockwise: true,
    );

    // Bottom right arc
    path.lineTo(notchPosition + notchRadius, size.height);
    path.arcToPoint(
      Offset(notchPosition - notchRadius, size.height),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(notchRadius, size.height);
    path.arcToPoint(
      Offset(0, size.height - notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: true,
    );

    // Left side
    path.lineTo(0, notchRadius);
    path.arcToPoint(
      Offset(notchRadius, 0),
      radius: Radius.circular(notchRadius),
      clockwise: true,
    );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class DashedLinePainter extends CustomPainter {
  final double height;

  DashedLinePainter({required this.height});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF740074)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double dashWidth = 5, dashSpace = 3, startY = 0;
    final path = Path();

    // Adjust the height to make the dashed line fit proportionally
    double adjustedHeight = height - 25; // Adjust as needed to fit the design

    double startX =
        size.width * 0.25; // Position the dashed line at 25% from the left
    while (startY < adjustedHeight) {
      path.moveTo(startX, startY);
      path.lineTo(startX, startY + dashWidth);
      startY += dashWidth + dashSpace;
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
*/


// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class FreeGiftContainerdiscountpriceCopy extends StatefulWidget {
  const FreeGiftContainerdiscountpriceCopy({
    super.key,
    this.width,
    this.height,
    this.discountPercent,
    this.discountType,
    this.description,
    this.code,
  });

  final double? width;
  final double? height;
  final String? discountPercent;
  final String? discountType;
  final String? description;
  final String? code;

  @override
  State<FreeGiftContainerdiscountpriceCopy> createState() =>
      _FreeGiftContainerdiscountpriceCopyState();
}

class _FreeGiftContainerdiscountpriceCopyState
    extends State<FreeGiftContainerdiscountpriceCopy> {
  @override
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: TicketClipper(),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            width: (widget.width ?? 300.0) + 4,
            height: (widget.height ?? 100.0) + 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.discountPercent!.split('.')[0],
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF740074),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            widget.discountType!,
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF740074),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Off',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 60,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.code!,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            widget.description!,
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: CustomPaint(
            size: Size((widget.width ?? 300.0) + 4, (widget.height ?? 100.0) + 4),
            painter: DashedLinePainter(height: (widget.height ?? 100.0) + 3),
          ),
        ),
      ],
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double notchRadius = 10.0;
    double notchPosition =
        size.width * 0.25; // Set the notch at 25% from the left

    // Top left arc
    path.moveTo(notchRadius, 0);
    path.lineTo(notchPosition - notchRadius, 0);
    path.arcToPoint(
      Offset(notchPosition + notchRadius, 0),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(size.width - notchRadius, 0);
    path.arcToPoint(
      Offset(size.width, notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: true,
    );

    // Right side
    path.lineTo(size.width, size.height - notchRadius);
    path.arcToPoint(
      Offset(size.width - notchRadius, size.height),
      radius: Radius.circular(notchRadius),
      clockwise: true,
    );

    // Bottom right arc
    path.lineTo(notchPosition + notchRadius, size.height);
    path.arcToPoint(
      Offset(notchPosition - notchRadius, size.height),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(notchRadius, size.height);
    path.arcToPoint(
      Offset(0, size.height - notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: true,
    );

    // Left side
    path.lineTo(0, notchRadius);
    path.arcToPoint(
      Offset(notchRadius, 0),
      radius: Radius.circular(notchRadius),
      clockwise: true,
    );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class DashedLinePainter extends CustomPainter {
  final double height;

  DashedLinePainter({required this.height});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF740074)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double dashWidth = 5, dashSpace = 3, startY = 0;
    final path = Path();

    // Adjust the height to make the dashed line fit proportionally
    double adjustedHeight = height - 25; // Adjust as needed to fit the design

    double startX =
        size.width * 0.25; // Position the dashed line at 25% from the left
    while (startY < adjustedHeight) {
      path.moveTo(startX, startY);
      path.lineTo(startX, startY + dashWidth);
      startY += dashWidth + dashSpace;
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}