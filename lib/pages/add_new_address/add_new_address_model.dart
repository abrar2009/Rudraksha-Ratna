import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'add_new_address_widget.dart' show AddNewAddressWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddNewAddressModel extends FlutterFlowModel<AddNewAddressWidget> {
  ///  Local state fields for this page.

  String? countryId = '101';

  String? stateId;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey6 = GlobalKey<FormState>();
  final formKey7 = GlobalKey<FormState>();
  final formKey5 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  // State field(s) for firstName widget.
  FocusNode? firstNameFocusNode;
  TextEditingController? firstNameTextController;
  String? Function(BuildContext, String?)? firstNameTextControllerValidator;
  String? _firstNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp('^[A-Za-z ]{1,20}\$').hasMatch(val)) {
      return 'Should contain only characters';
    }
    return null;
  }

  // State field(s) for lastName widget.
  FocusNode? lastNameFocusNode;
  TextEditingController? lastNameTextController;
  String? Function(BuildContext, String?)? lastNameTextControllerValidator;
  String? _lastNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp('^[A-Za-z ]{1,20}\$').hasMatch(val)) {
      return 'Should contain only characters';
    }
    return null;
  }

  // State field(s) for countryCode widget.
  String? countryCodeValue;
  FormFieldController<String>? countryCodeValueController;
  // State field(s) for phoneNumber widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberTextController;
  String? Function(BuildContext, String?)? phoneNumberTextControllerValidator;
  String? _phoneNumberTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp('').hasMatch(val)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  String? _emailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Has to be a valid email address.';
    }
    return null;
  }

  // State field(s) for address1 widget.
  FocusNode? address1FocusNode;
  TextEditingController? address1TextController;
  String? Function(BuildContext, String?)? address1TextControllerValidator;
  String? _address1TextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for address2 widget.
  FocusNode? address2FocusNode;
  TextEditingController? address2TextController;
  String? Function(BuildContext, String?)? address2TextControllerValidator;
  // State field(s) for landmark widget.
  FocusNode? landmarkFocusNode;
  TextEditingController? landmarkTextController;
  String? Function(BuildContext, String?)? landmarkTextControllerValidator;
  // State field(s) for country widget.
  String? countryValue;
  FormFieldController<String>? countryValueController;
  // State field(s) for state widget.
  String? stateValue;
  FormFieldController<String>? stateValueController;

  // State field(s) for city widget.
  FocusNode? cityFocusNode;
  TextEditingController? cityTextController;
  String? Function(BuildContext, String?)? cityTextControllerValidator;
  String? _cityTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp('^[A-Za-z ]{1,20}\$').hasMatch(val)) {
      return 'Should contain only characters';
    }
    return null;
  }

  // State field(s) for pinCode widget.
  FocusNode? pinCodeFocusNode;
  TextEditingController? pinCodeTextController;
  String? Function(BuildContext, String?)? pinCodeTextControllerValidator;
  String? _pinCodeTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (AddAddress)] action in Button widget.
  ApiCallResponse? apiResult35l;

  @override
  void initState(BuildContext context) {
    firstNameTextControllerValidator = _firstNameTextControllerValidator;
    lastNameTextControllerValidator = _lastNameTextControllerValidator;
    phoneNumberTextControllerValidator = _phoneNumberTextControllerValidator;
    emailTextControllerValidator = _emailTextControllerValidator;
    address1TextControllerValidator = _address1TextControllerValidator;
    cityTextControllerValidator = _cityTextControllerValidator;
    pinCodeTextControllerValidator = _pinCodeTextControllerValidator;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    firstNameFocusNode?.dispose();
    firstNameTextController?.dispose();

    lastNameFocusNode?.dispose();
    lastNameTextController?.dispose();

    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();

    address1FocusNode?.dispose();
    address1TextController?.dispose();

    address2FocusNode?.dispose();
    address2TextController?.dispose();

    landmarkFocusNode?.dispose();
    landmarkTextController?.dispose();

    cityFocusNode?.dispose();
    cityTextController?.dispose();

    pinCodeFocusNode?.dispose();
    pinCodeTextController?.dispose();
  }
}
