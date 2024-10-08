import '/flutter_flow/flutter_flow_util.dart';
import 'astrology_consultation_widget.dart' show AstrologyConsultationWidget;
import 'package:expandable/expandable.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AstrologyConsultationModel
    extends FlutterFlowModel<AstrologyConsultationWidget> {
  ///  Local state fields for this page.

  int selectedindex = 0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for CountController widget.
  int? countControllerValue;
  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 1;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController1;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController2;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController3;

  @override
  void initState(BuildContext context) {}
  CarouselSliderController? carouselController2;
  int carouselCurrentIndex2 = 1;
  @override
  void dispose() {
    unfocusNode.dispose();
    expandableExpandableController1.dispose();
    expandableExpandableController2.dispose();
    expandableExpandableController3.dispose();
  }
}
