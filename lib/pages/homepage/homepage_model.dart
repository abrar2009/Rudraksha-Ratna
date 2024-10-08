import '/backend/api_requests/api_calls.dart';
import '/components/custom_nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'homepage_widget.dart' show HomepageWidget;
import 'package:expandable/expandable.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomepageModel extends FlutterFlowModel<HomepageWidget> {
  ///  Local state fields for this page.

  String iD = '8';
  String productslugvalue = 'p';
  int? mainprodtype;
  bool textColor = true;
  bool shopbycattextColor = true;
  String? producttype;
  int? level;
  bool productlist = true;
  String? slugvalue;
  ///  State fields for stateful widgets in this page.
  int? countControllerValue;
  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 1;
  final unfocusNode = FocusNode();
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Model for CustomNavBar component.
  String? currencyDropDownValue;
  FormFieldController<String>? currencyDropDownValueController;
  late CustomNavBarModel customNavBarModel;
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController;
  late ExpandableController consulatatoinexpandableExpandableController;
  late ExpandableController shopbycategoryController;
  ApiCallResponse? apiResulth6o;

  @override
  void initState(BuildContext context) {
    customNavBarModel = createModel(context, () => CustomNavBarModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    customNavBarModel.dispose();
    expandableExpandableController.dispose();
    shopbycategoryController.dispose();
  }
}
