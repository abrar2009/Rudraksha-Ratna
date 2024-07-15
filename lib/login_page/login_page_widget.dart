import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_page_model.dart';
export 'login_page_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  late LoginPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPageModel());

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
        key: scaffoldKey,
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 59, 0, 58),
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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.92,
                        decoration: BoxDecoration(
                          color:
                          FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: FlutterFlowTheme.of(context).primary, width: 1,),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                                    child: Text(
                                      'Fills details to Sign In',
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
                                key: _model.formKey2,
                                autovalidateMode: AutovalidateMode.always,
                                child: TextFormField(
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
                                      borderSide: BorderSide(color: Color(0xFF868687), width: 1,),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: FlutterFlowTheme.of(context).primary, width: 1,),
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
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.sizeOf(context).width * 0.3,
                                      height: 1,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFEDF1F3),
                                        border: Border.all(
                                          color: Color(0xFFEDF1F3),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Text(
                                        'Or',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF6C7278),
                                          fontSize: 12,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.sizeOf(context).width * 0.3,
                                      height: 1,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFEDF1F3),
                                        border: Border.all(color: Color(0xFFEDF1F3),),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 6)),
                                ),
                              ),
                              Form(
                                key: _model.formKey1,
                                autovalidateMode: AutovalidateMode.always,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(0, 1),
                                        child: FlutterFlowDropDown<String>(
                                          controller: _model.dropDownValueController ??= FormFieldController<String>(_model.dropDownValue ??= '+00',),
                                          options: functions.countryCodes()!,
                                          onChanged: (val) => setState(() => _model.dropDownValue = val),
                                          width: 75,
                                          maxHeight: 350,
                                          searchHintTextStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                          ),
                                          searchTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                          ),
                                          textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            color: FlutterFlowTheme.of(context).secondaryText,
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
                                            labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
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
                                              borderSide: BorderSide(color: Color(0xFF868687), width: 1,),
                                              borderRadius: BorderRadius.circular(0),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: FlutterFlowTheme.of(context).primary, width: 1,),
                                              borderRadius: BorderRadius.circular(0),
                                            ),
                                            errorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: FlutterFlowTheme.of(context).error, width: 1,),
                                              borderRadius: BorderRadius.circular(0),
                                            ),
                                            focusedErrorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: FlutterFlowTheme.of(context).error, width: 1,),
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
                              ),
                              /*Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      var _shouldSetState = false;
                                      _model.apiResultjba = await LoginWithOTPCall.call(
                                        email: _model.emailTextController.text,
                                        mobileNumber: _model.phoneTextController.text,
                                        countryCode: functions.operatorRemover(_model.dropDownValue),
                                        hosturl: FFAppConstants.hosturl,
                                      );
                                      _shouldSetState = true;
                                      if ((_model.apiResultjba?.succeeded ?? true)) {
                                        ScaffoldMessenger.of(context).clearSnackBars();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              getJsonField((_model.apiResultjba?.jsonBody ?? ''), r'''$.msg''',).toString(),
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                fontSize: 16,
                                              ),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: Color(0xFF4BB543),
                                          ),
                                        );
                                        FFAppState().statusFailed = getJsonField((_model.apiResultjba?.jsonBody ?? ''), r'''$.status''',).toString();
                                        setState(() {});
                                        if (FFAppState().statusFailed == 'success') {
                                          context.pushNamed(
                                            'SigninOTP',
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
                                                functions.operatorRemover(
                                                    FFAppState().countrycode),
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey: TransitionInfo(
                                                hasTransition: true,
                                                transitionType: PageTransitionType.rightToLeft,
                                                duration: Duration(milliseconds: 400),
                                              ),
                                            },
                                          );
                                        } else {
                                          if (_shouldSetState) setState(() {});
                                          return;
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context).clearSnackBars();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              getJsonField((_model.apiResultjba?.jsonBody ?? ''), r'''$.msg''',).toString(),
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                fontSize: 16,
                                              ),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: Color(0xFFFC100D),
                                          ),
                                        );
                                        if (_shouldSetState) setState(() {});
                                        return;
                                      }
                                      if (_shouldSetState) setState(() {});
                                    },
                                    text: 'SEND OTP',
                                    options: FFButtonOptions(
                                      width: 160,
                                      height: 48,
                                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                      color: FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                        fontFamily: 'Montserrat',
                                        color: Colors.white,
                                        letterSpacing: 0,
                                      ),
                                      elevation: 0,
                                      borderSide: BorderSide(color: Colors.transparent, width: 1,),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),*/
                              // Generated code for this Button Widget...
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      var _shouldSetState = false;
                                      _model.apiResultjba = await LoginWithOTPCall.call(
                                        email: _model.emailTextController.text,
                                        mobileNumber: _model.phoneTextController.text,
                                        countryCode: functions.operatorRemover(_model.dropDownValue),
                                        hosturl: FFAppConstants.hosturl,
                                      );
                                      _shouldSetState = true;
                                      if ((_model.apiResultjba?.succeeded ?? true)) {
                                        ScaffoldMessenger.of(context).clearSnackBars();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              getJsonField(
                                                (_model.apiResultjba?.jsonBody ?? ''),
                                                r'''$.msg''',
                                              ).toString(),
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                fontSize: 16,
                                              ),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: Color(0xFF4BB543),
                                          ),
                                        );
                                        FFAppState().statusFailed = getJsonField(
                                          (_model.apiResultjba?.jsonBody ?? ''),
                                          r'''$.status''',
                                        ).toString();
                                        setState(() {});
                                        if (FFAppState().statusFailed == 'success') {
                                          context.pushNamed(
                                            'SigninOTP',
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
                                                functions.operatorRemover(FFAppState().countrycode),
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey: TransitionInfo(
                                                hasTransition: true,
                                                transitionType: PageTransitionType.rightToLeft,
                                                duration: Duration(milliseconds: 400),
                                              ),
                                            },
                                          );
                                        } else {
                                          if (_shouldSetState) setState(() {});
                                          return;
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context).clearSnackBars();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              getJsonField(
                                                (_model.apiResultjba?.jsonBody ?? ''),
                                                r'''$.msg''',
                                              ).toString(),
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                fontSize: 16,
                                              ),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: Color(0xFFFC100D),
                                          ),
                                        );
                                        if (_shouldSetState) setState(() {});
                                        return;
                                      }
                                      if (_shouldSetState) setState(() {});
                                    },
                                    text: 'SEND OTP',
                                    options: FFButtonOptions(
                                      width: 160,
                                      height: 48,
                                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                      color: FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                        fontFamily: 'Montserrat',
                                        color: Colors.white,
                                        letterSpacing: 0,
                                      ),
                                      elevation: 0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Text(
                                        'If you don\'t have an account? ',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF6C7278),
                                          fontSize: 12,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                            'RegisterPage',
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey: const TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                PageTransitionType.fade,
                                                duration:
                                                Duration(milliseconds: 0),
                                              ),
                                            },
                                          );
                                        },
                                        child: Text(
                                          'Register Now',
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF4D81E7),
                                            fontSize: 12,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                            decoration:
                                            TextDecoration.underline,
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
