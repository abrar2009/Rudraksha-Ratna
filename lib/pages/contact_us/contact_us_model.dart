import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'contact_us_widget.dart' show ContactUsWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ContactUsModel extends FlutterFlowModel<ContactUsWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey5 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController1;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController2;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController3;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController4;

  // State field(s) for Name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return null;
    }

    if (!RegExp('^[A-Za-z ]{1,20}\$').hasMatch(val)) {
      return 'Should contain only characters';
    }
    return null;
  }

  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  String? _emailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return null;
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Has to be a valid email address.';
    }
    return null;
  }

  // State field(s) for dropDownValue widget.
  String? dropDownValueValue;
  FormFieldController<String>? dropDownValueValueController;
  // State field(s) for phone widget.
  FocusNode? phoneFocusNode;
  TextEditingController? phoneTextController;
  String? Function(BuildContext, String?)? phoneTextControllerValidator;
  String? _phoneTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return null;
    }
// Check if the length of the number exceeds 15 digits
    if (val.length > 15) {
      return 'Please enter a valid phone number';
    }
    if (!RegExp('^\\d{0,15}\$').hasMatch(val)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // State field(s) for Subject widget.
  FocusNode? subjectFocusNode;
  TextEditingController? subjectTextController;
  String? Function(BuildContext, String?)? subjectTextControllerValidator;
  String? _subjectTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return null;
    }

    return null;
  }

  // State field(s) for Query widget.
  FocusNode? queryFocusNode;
  TextEditingController? queryTextController;
  String? Function(BuildContext, String?)? queryTextControllerValidator;
  String? _queryTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return null;
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (ContactUs)] action in Button widget.
  ApiCallResponse? apiResulteem;

  @override
  void initState(BuildContext context) {
    nameTextControllerValidator = _nameTextControllerValidator;
    emailTextControllerValidator = _emailTextControllerValidator;
    phoneTextControllerValidator = _phoneTextControllerValidator;
    subjectTextControllerValidator = _subjectTextControllerValidator;
    queryTextControllerValidator = _queryTextControllerValidator;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    expandableExpandableController1.dispose();
    expandableExpandableController2.dispose();
    expandableExpandableController3.dispose();
    expandableExpandableController4.dispose();
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();

    phoneFocusNode?.dispose();
    phoneTextController?.dispose();

    subjectFocusNode?.dispose();
    subjectTextController?.dispose();

    queryFocusNode?.dispose();
    queryTextController?.dispose();
  }
}
