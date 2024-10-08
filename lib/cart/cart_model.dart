import '/backend/api_requests/api_calls.dart';
import '/components/custom_nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'cart_widget.dart' show CartWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartModel extends FlutterFlowModel<CartWidget> {
  ///  Local state fields for this page.

  int quantity = 1;
  int totalQuantity = 0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  ApiCallResponse? apiResult5ep;
  // Stores action output result for [Backend Call - API (Cart)] action in QuantityCounterWidget widget.
  ApiCallResponse? apiResultilt;
  // Stores action output result for [Backend Call - API (Cart)] action in QuantityCounterWidget widget.
  ApiCallResponse? apiResultiltCopy;
  // Model for CustomNavBar component.
  late CustomNavBarModel customNavBarModel;

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
