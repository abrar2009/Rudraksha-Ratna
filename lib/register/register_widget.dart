import '../custom_code/widgets/custom_textformfield.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'register_model.dart';
export 'register_model.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  late RegisterModel _model;

  final RegisterWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RegisterModel());

    _model.firstNameTextController ??= TextEditingController();
    _model.firstNameFocusNode ??= FocusNode();

    _model.lastNameTextController ??= TextEditingController();
    _model.lastNameFocusNode ??= FocusNode();

    _model.emailTextController ??= TextEditingController();
    _model.emailFocusNode ??= FocusNode();

    _model.phoneTextController ??= TextEditingController();
    _model.phoneFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: RegisterWidgetscaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 59, 0, 26),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/logo_1.png',
                              width: 191,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.92,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                                  child: Text(
                                    'Create a new account',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: Colors.black,
                                      fontSize: 20,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Form(
                              key: _model.formKey3,
                              autovalidateMode: AutovalidateMode.always,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                                child: Expanded(
                                  child: CustomTextFormField(
                                    controller: _model.firstNameTextController!,
                                    focusNode: _model.firstNameFocusNode!,
                                    labelText: 'First Name',
                                    hintText: 'Enter First Name',
                                    keyboardType: TextInputType.name,
                                    isObscureText: false,
                                    validator: _model.firstNameTextControllerValidator.asValidator(context)!,
                                  ),
                                ),
                                /*TextFormField(
                                  controller: _model.firstNameTextController,
                                  focusNode: _model.firstNameFocusNode,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'First Name',
                                    labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                    ),
                                    hintText: 'Enter First Name',
                                    hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      fontSize: 16,
                                      letterSpacing: 0,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF868687),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).primary,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    contentPadding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 6),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                    letterSpacing: 0,
                                  ),
                                  keyboardType: TextInputType.name,
                                  validator: _model.firstNameTextControllerValidator.asValidator(context),
                                ),*/
                              ),
                            ),
                            Form(
                              key: _model.formKey4,
                              autovalidateMode: AutovalidateMode.always,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                                child: Expanded(
                                  child: CustomTextFormField(
                                    controller: _model.lastNameTextController!,
                                    focusNode: _model.lastNameFocusNode!,
                                    labelText: 'Last Name',
                                    hintText: 'Enter Last Name',
                                    keyboardType: TextInputType.name,
                                    isObscureText: false,
                                    validator: _model.lastNameTextControllerValidator.asValidator(context)!,
                                  ),
                                ),
                                /*TextFormField(
                                  controller: _model.lastNameTextController,
                                  focusNode: _model.lastNameFocusNode,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Last Name',
                                    labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                    ),
                                    hintText: 'Enter Last Name',
                                    hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      fontSize: 16,
                                      letterSpacing: 0,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF868687),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).primary,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    contentPadding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 6),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                    letterSpacing: 0,
                                  ),
                                  keyboardType: TextInputType.name,
                                  validator: _model.lastNameTextControllerValidator.asValidator(context),
                                ),*/
                              ),
                            ),
                            Form(
                              key: _model.formKey2,
                              autovalidateMode: AutovalidateMode.always,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                                child: Expanded(
                                  child: CustomTextFormField(
                                    controller: _model.emailTextController!,
                                    focusNode: _model.emailFocusNode!,
                                    labelText: 'Email',
                                    hintText: 'Enter Email Address',
                                    keyboardType: TextInputType.emailAddress,
                                    isObscureText: false,
                                    validator: _model.emailTextControllerValidator.asValidator(context)!,
                                  ),
                                ),
                                /*TextFormField(
                                  controller: _model.emailTextController,
                                  focusNode: _model.emailFocusNode,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                    ),
                                    hintText: 'Enter Email Address',
                                    hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      fontSize: 16,
                                      letterSpacing: 0,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF868687),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).primary,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    contentPadding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 6),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                    letterSpacing: 0,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: _model.emailTextControllerValidator.asValidator(context),
                                ),*/
                              ),
                            ),
                            /*Form(
                              key: _model.formKey1,
                              autovalidateMode: AutovalidateMode.always,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0, 1),
                                      child: FlutterFlowDropDown<String>(
                                        controller: _model.dropDownValueController ??= FormFieldController<String>(null),
                                        options: functions.countryCodes()!,
                                        onChanged: (val) => setState(() => _model.dropDownValue = val),
                                        width: 75,
                                        maxHeight: 350,
                                        searchHintTextStyle:
                                        FlutterFlowTheme.of(context).labelMedium.override(
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 0,
                                        ),
                                        searchTextStyle:
                                        FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 0,
                                        ),
                                        textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          color:
                                          FlutterFlowTheme.of(context).secondaryText,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        hintText: '+00',
                                        searchHintText: '',
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: FlutterFlowTheme.of(context).secondaryText,
                                          size: 24,
                                        ),
                                        fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                        elevation: 2,
                                        borderColor: Colors.transparent,
                                        borderWidth: 0,
                                        borderRadius: 0,
                                        margin: EdgeInsetsDirectional.fromSTEB(6, 6, 0, 12),
                                        isOverButton: true,
                                        isSearchable: true,
                                        isMultiSelect: false,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _model.phoneTextController,
                                        focusNode: _model.phoneFocusNode,
                                        autofocus: false,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Phone Number',
                                          labelStyle:
                                          FlutterFlowTheme.of(context).labelMedium.override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                          ),
                                          hintText: 'Enter Phone Number',
                                          hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                            fontFamily: 'Montserrat',
                                            color: FlutterFlowTheme.of(context).primaryText,
                                            fontSize: 16,
                                            letterSpacing: 0,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF868687),
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).primary,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).error,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                                          focusedErrorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).error,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                                          contentPadding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 12),
                                        ),
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 16,
                                          letterSpacing: 0,
                                        ),
                                        keyboardType: TextInputType.phone,
                                        validator: _model.phoneTextControllerValidator.asValidator(context),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 6)),
                                ),
                              ),
                            ),*/
                            Form(
                              key: _model.formKey1,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: const AlignmentDirectional(0, 1),
                                      child: FlutterFlowDropDown<String>(
                                        controller: _model.dropDownValueController ??= FormFieldController<String>(null),
                                        options: functions.countryCodes()!,
                                        onChanged: (val) => setState(() => _model.dropDownValue = val),
                                        width: 75,
                                        maxHeight: 350,
                                        searchHintTextStyle:
                                        FlutterFlowTheme.of(context).labelMedium.override(
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 0,
                                        ),
                                        searchTextStyle:
                                        FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 0,
                                        ),
                                        textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          color:
                                          FlutterFlowTheme.of(context).secondaryText,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        hintText: '+00',
                                        searchHintText: '',
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: FlutterFlowTheme.of(context).secondaryText,
                                          size: 24,
                                        ),
                                        fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                        elevation: 2,
                                        borderColor: Colors.transparent,
                                        borderWidth: 0,
                                        borderRadius: 0,
                                        margin: const EdgeInsetsDirectional.fromSTEB(6, 6, 0, 12),
                                        isOverButton: true,
                                        isSearchable: true,
                                        isMultiSelect: false,
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomTextFormField(
                                        controller: _model.phoneTextController!,
                                        focusNode: _model.phoneFocusNode!,
                                        labelText: 'Phone Number',
                                        hintText: 'Enter Phone Number',
                                        keyboardType: TextInputType.phone,
                                        isObscureText: false,
                                        validator: _model.phoneTextControllerValidator.asValidator(context)!,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    // Validate fields
                                    if (_model.emailTextController.text.isEmpty ||
                                        _model.phoneTextController.text.isEmpty ||
                                        _model.firstNameTextController.text.isEmpty ||
                                        _model.lastNameTextController.text.isEmpty) {
                                      ScaffoldMessenger.of(context).clearSnackBars();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Please fill in all fields',
                                            style: TextStyle(
                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                              fontSize: 16,
                                            ),
                                          ),
                                          duration: const Duration(milliseconds: 4000),
                                          backgroundColor: FlutterFlowTheme.of(context).primary,
                                        ),
                                      );
                                      return;
                                    }

                                    // Validate first and last name format (only alphabetic characters)
                                    RegExp nameRegExp = RegExp(r'^[a-zA-Z]+$');
                                    if (!nameRegExp.hasMatch(_model.firstNameTextController.text) ||
                                        !nameRegExp.hasMatch(_model.lastNameTextController.text)) {
                                      ScaffoldMessenger.of(context).clearSnackBars();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'First and last name should contain only alphabetic characters',
                                            style: TextStyle(
                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                              fontSize: 16,
                                            ),
                                          ),
                                          duration: const Duration(milliseconds: 4000),
                                          backgroundColor: FlutterFlowTheme.of(context).primary,
                                        ),
                                      );
                                      return;
                                    }

                                    // Validate email format
                                    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                    if (!emailRegExp.hasMatch(_model.emailTextController.text)) {
                                      ScaffoldMessenger.of(context).clearSnackBars();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Invalid email format',
                                            style: TextStyle(
                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                              fontSize: 16,
                                            ),
                                          ),
                                          duration: const Duration(milliseconds: 4000),
                                          backgroundColor: FlutterFlowTheme.of(context).primary,
                                        ),
                                      );
                                      return;
                                    }

                                    // Validate phone number format (only numbers)
                                    RegExp phoneRegExp = RegExp(r'^[0-9]+$');
                                    if (!phoneRegExp.hasMatch(_model.phoneTextController.text)) {
                                      ScaffoldMessenger.of(context).clearSnackBars();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Phone number should contain only numbers',
                                            style: TextStyle(
                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                              fontSize: 16,
                                            ),
                                          ),
                                          duration: const Duration(milliseconds: 4000),
                                          backgroundColor: FlutterFlowTheme.of(context).primary,
                                        ),
                                      );
                                      return;
                                    }

                                    // Check if country code is selected from dropdown
                                    if (_model.dropDownValue == null) {
                                      ScaffoldMessenger.of(context).clearSnackBars();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Please select a country code',
                                            style: TextStyle(
                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                              fontSize: 16,
                                            ),
                                          ),
                                          duration: const Duration(milliseconds: 4000),
                                          backgroundColor: FlutterFlowTheme.of(context).primary,
                                        ),
                                      );
                                      return;
                                    }

                                    var _shouldSetState = false;
                                    FFAppState().countryCode4Payment = _model.dropDownValue!;
                                    _model.apiResultr2o = await SignUpSendOTPCall.call(
                                      email: _model.emailTextController.text,
                                      mobileNumber: _model.phoneTextController.text,
                                      countryCode: functions.operatorRemover(_model.dropDownValue),
                                      hosturl: FFAppConstants.hosturl,
                                      customerName: functions.joinName(
                                        _model.firstNameTextController.text,
                                        _model.lastNameTextController.text,
                                      ),
                                    );
                                    _shouldSetState = true;

                                    if ((_model.apiResultr2o?.succeeded ?? true)) {
                                      ScaffoldMessenger.of(context).clearSnackBars();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            getJsonField(
                                              (_model.apiResultr2o?.jsonBody ?? ''),
                                              r'''$.msg''',
                                            ).toString(),
                                            style: TextStyle(
                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                              fontSize: 16,
                                            ),
                                          ),
                                          duration: const Duration(milliseconds: 4000),
                                          backgroundColor: FlutterFlowTheme.of(context).primary,
                                        ),
                                      );
                                      FFAppState().statusFailed = getJsonField(
                                        (_model.apiResultr2o?.jsonBody ?? ''),
                                        r'''$.status''',
                                      ).toString();
                                      FFAppState().countrycode = functions.operatorRemover(_model.dropDownValue)!;
                                      setState(() {
                                        if (FFAppState().statusFailed == 'success') {
                                          print('Country Code: ${FFAppState().countrycode}');
                                          context.pushNamed(
                                            'SignUpOTP',
                                            queryParameters: {
                                              'emailAddress': serializeParam(
                                                _model.emailTextController.text,
                                                ParamType.String,
                                              ),
                                              'phoneNumber': serializeParam(
                                                _model.phoneTextController.text,
                                                ParamType.String,
                                              ),
                                              'countryCode': serializeParam(
                                                functions.operatorRemover(_model.dropDownValue),
                                                ParamType.String,
                                              ),
                                              'customerName': serializeParam(
                                                functions.joinName(
                                                  _model.firstNameTextController.text,
                                                  _model.lastNameTextController.text,
                                                ),
                                                ParamType.String,
                                              ),
                                              'firstName': serializeParam(
                                                _model.firstNameTextController.text,
                                                ParamType.String,
                                              ),
                                              'lastName': serializeParam(
                                                _model.lastNameTextController.text,
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey: const TransitionInfo(
                                                hasTransition: true,
                                                transitionType: PageTransitionType.rightToLeft,
                                                duration: Duration(milliseconds: 400),
                                              ),
                                            },
                                          );
                                        }
                                      });
                                    }

                                    if (_shouldSetState) {
                                      setState(() {});
                                    }
                                  },
                                  text: 'SEND OTP',
                                  options: FFButtonOptions(
                                    width: 160,
                                    height: 48,
                                    padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      letterSpacing: 0,
                                    ),
                                    elevation: 0,
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Text(
                                      'Already have an account? ',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        color: const Color(0xFF6C7278),
                                        fontSize: 12,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          'LoginPage',
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: const TransitionInfo(
                                              hasTransition: true,
                                              transitionType: PageTransitionType.fade,
                                              duration: Duration(milliseconds: 0),
                                            ),
                                          },
                                        );
                                      },
                                      child: Text(
                                        'Sign In',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          color: const Color(0xFF4D81E7),
                                          fontSize: 12,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}