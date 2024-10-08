import '/backend/api_requests/api_calls.dart';
import '/components/custom_nav_bar_widget.dart';
import '/components/select_free_gift_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/free_gift_component/free_gift_component_widget.dart';
import 'select_payment_method_widget.dart' show SelectPaymentMethodWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelectPaymentMethodModel
    extends FlutterFlowModel<SelectPaymentMethodWidget> {
  ///  State fields for stateful widgets in this page.

  String? cartTotal = '';

  final unfocusNode = FocusNode();
  // State field(s) for Checkbox widget.
  bool? checkboxValue1;
  // State field(s) for Checkbox widget.
  bool? checkboxValue2;
  // Model for CustomNavBar component.
  late CustomNavBarModel customNavBarModel;
  String? slugvalue;
  ApiCallResponse? apiResult3lf;
  ApiCallResponse? apiResultjwj;
  // Model for CustomNavBar component.
  int? mainprodtype;
  ///  State fields for stateful widgets in this page.
  String? producttype;
  int? level;
  bool productlist = true;
  ApiCallResponse? apiResulth6o;
  ApiCallResponse? fetchShippingOutput;
  @override
  void initState(BuildContext context) {
    customNavBarModel = createModel(context, () => CustomNavBarModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    customNavBarModel.dispose();
  }
}
