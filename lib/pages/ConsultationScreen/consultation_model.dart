import 'package:rudraksha_cart/backend/api_requests/api_manager.dart';
import 'package:rudraksha_cart/pages/ConsultationScreen/consultation_widget.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ConsultationScreenModel
    extends FlutterFlowModel<ConsultationScreenWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  ApiCallResponse? apiResultj7i;
  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
