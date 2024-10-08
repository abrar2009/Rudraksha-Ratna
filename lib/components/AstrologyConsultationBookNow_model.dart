import 'package:rudraksha_cart/components/AstrologyConsultationBookNowwidget.dart';

import '../backend/api_requests/api_manager.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AstrologyConsultationBookNowModel
    extends FlutterFlowModel<AstrologyConsultationBookNowWidget> {
  ///  Local state fields for this component.

  bool selected = true;

  int? selectedindex;

  ApiCallResponse? apiResultj7i2;

  ///  State fields for stateful widgets in this component.

  // State field(s) for EnterName widget.
  FocusNode? enterNameFocusNode;
  TextEditingController? enterNameTextController;
  String? Function(BuildContext, String?)? enterNameTextControllerValidator;
  DateTime? datePicked1;
  final unfocusNode = FocusNode();
  // State field(s) for EnterPlaceofBirth widget.
  FocusNode? enterPlaceofBirthFocusNode;
  TextEditingController? enterPlaceofBirthTextController;
  String? Function(BuildContext, String?)?
  enterPlaceofBirthTextControllerValidator;
  DateTime? datePicked2;
  DateTime? datePicked3;
  // State field(s) for EnterSpecialInstructions widget.
  String? enterSpecialInstructionsValue;
  FormFieldController<String>? enterSpecialInstructionsValueController;
  // State field(s) for EnterSpecialInstructions widget.
  FocusNode? enterSpecialInstructionsFocusNode;
  TextEditingController? enterSpecialInstructionsTextController;
  String? Function(BuildContext, String?)?
  enterSpecialInstructionsTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    enterNameFocusNode?.dispose();
    enterNameTextController?.dispose();

    enterPlaceofBirthFocusNode?.dispose();
    enterPlaceofBirthTextController?.dispose();

    enterSpecialInstructionsFocusNode?.dispose();
    enterSpecialInstructionsTextController?.dispose();
  }
}
