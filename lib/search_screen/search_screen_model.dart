import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'search_screen_widget.dart' show SearchScreenWidget;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchScreenModel extends FlutterFlowModel<SearchScreenWidget> {
  ///  Local state fields for this page.

  String? slugvalue;
  int? mainprodtype;
  ///  State fields for stateful widgets in this page.
  String? producttype;
  int? level;
  bool productlist = true;
  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (Search Screen)] action in TextField widget.
  ApiCallResponse? apiResultjwj;
  ApiCallResponse? apiResulth6o;
  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
