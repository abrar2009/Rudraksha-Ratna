import '../../flutter_flow/flutter_flow_model.dart';
import '/backend/api_requests/api_calls.dart';
import 'package:expandable/expandable.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'ChakraCleansingMeditationWithSakhashreeWidget.dart';

class ChakraCleansingMeditationWithSakhashreeModel
    extends FlutterFlowModel<ChakraCleansingMeditationWithSakhashreeWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for CountController widget.
  int? countControllerValue;
  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  CarouselSliderController? carouselController2;
  int carouselCurrentIndex = 1;
  int carouselCurrentIndex2 = 1;
  ApiCallResponse? apiResultj7i;
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController1;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    expandableExpandableController1.dispose();
    expandableExpandableController2.dispose();
  }
}
