import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'article_detail_widget.dart' show ArticleDetailWidget;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ArticleDetailModel extends FlutterFlowModel<ArticleDetailWidget> {
  ///  State fields for stateful widgets in this page.
  ApiCallResponse? apiResultjp10;

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  FocusNode? nameFieldFocusNode;
  FocusNode? emailFieldFocusNode;
  FocusNode? commentFieldFocusNode;
  TextEditingController? textController;
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? commentController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    nameFieldFocusNode?.dispose();
    emailFieldFocusNode?.dispose();
    commentFieldFocusNode?.dispose();
    textController?.dispose();
    nameController?.dispose();
    emailController?.dispose();
    commentController?.dispose();
  }
}
