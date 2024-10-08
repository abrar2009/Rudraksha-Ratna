/*
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'sign_up_o_t_p_model.dart';
export 'sign_up_o_t_p_model.dart';

class SignUpOTPWidget extends StatefulWidget {
  const SignUpOTPWidget({
    super.key,
    this.emailAddress,
    this.phoneNumber,
    this.countryCode,
    this.customerName,
    this.firstName,
    this.lastName
  });

  final String? emailAddress;
  final String? phoneNumber;
  final String? countryCode;
  final String? customerName;
  final String? firstName;
  final String? lastName;

  @override
  State<SignUpOTPWidget> createState() => _SignUpOTPWidgetState();
}

class _SignUpOTPWidgetState extends State<SignUpOTPWidget> {
  late SignUpOTPModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignUpOTPModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
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
                      padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                      child: Container(
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 24, 0, 12),
                                    child: Text(
                                      'Enter OTP',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
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
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: RichText(
                                  textScaler: MediaQuery.of(context).textScaler,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'OTP has been sent on ',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontSize: 12,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text: valueOrDefault<String>(
                                          widget.countryCode,
                                          '+91',
                                        ),
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '-',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                        text: valueOrDefault<String>(
                                          widget.phoneNumber,
                                          '993521178',
                                        ),
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                                child: TextFormField(
                                  controller: _model.textController,
                                  focusNode: _model.textFieldFocusNode,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'OTP',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                    ),
                                    hintText: 'Enter OTP',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
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
                                        color:
                                        FlutterFlowTheme.of(context).primary,
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
                                    contentPadding:
                                    EdgeInsetsDirectional.fromSTEB(
                                        0, 6, 0, 6),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                    letterSpacing: 0,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: _model.textControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 24, 0, 24),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      var _shouldSetState = false;
                                      _model.apiResultjp8 =
                                      await RegisterCustomerCall.call(
                                        hosturl: FFAppConstants.hosturl,
                                        customerName: widget.customerName,
                                        customerType: '1',
                                        mobilenumber: widget.phoneNumber,
                                        email: widget.emailAddress,
                                        countryCode: functions
                                            .operatorRemover(widget.countryCode),
                                        otp: _model.textController.text,
                                      );
                                      _shouldSetState = true;
                                      if ((_model.apiResultjp8?.succeeded ??
                                          true)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              getJsonField(
                                                (_model.apiResultjp8?.jsonBody ??
                                                    ''),
                                                r'''$.msg''',
                                              ).toString(),
                                              style: TextStyle(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                                fontSize: 16,
                                              ),
                                            ),
                                            duration:
                                            Duration(milliseconds: 4000),
                                            backgroundColor: Color(0xFF4BB543),
                                          ),
                                        );
                                        FFAppState().statusFailed = getJsonField(
                                          (_model.apiResultjp8?.jsonBody ?? ''),
                                          r'''$.status''',
                                        ).toString();
                                        setState(() {});
                                        if (FFAppState().statusFailed ==
                                            'success') {
                                          context.pushNamed(
                                            'LoginPage',
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey: TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                PageTransitionType.fade,
                                                duration:
                                                Duration(milliseconds: 0),
                                              ),
                                            },
                                          );
                                        } else {
                                          if (_shouldSetState) setState(() {});
                                          return;
                                        }
                                      } else {
                                        if (_shouldSetState) setState(() {});
                                        return;
                                      }

                                      if (_shouldSetState) setState(() {});
                                    },
                                    text: 'Register',
                                    options: FFButtonOptions(
                                      width: 160,
                                      height: 48,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24, 0, 24, 0),
                                      iconPadding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      color: FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
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
                              */
/*Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Text(
                                        'Resend OTP ',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
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
                                      child: Text(
                                        '(24s)',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          fontSize: 12,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),*//*

                              // Generated code for this Text Widget...
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                                child: Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      var _shouldSetState = false;
                                      _model.apiResultr2o = await SignUpSendOTPCall.call(
                                        email: widget!.emailAddress,
                                        mobileNumber: widget!.phoneNumber,
                                        countryCode: functions.operatorRemover(widget!.countryCode),
                                        hosturl: FFAppConstants.hosturl,
                                        customerName:
                                        functions.joinName(widget!.firstName!, widget!.lastName!),
                                      );
                                      _shouldSetState = true;
                                      if ((_model.apiResultr2o?.succeeded ?? true)) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              getJsonField(
                                                (_model.apiResultr2o?.jsonBody ?? ''),
                                                r'''$.msg''',
                                              ).toString(),
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).primaryText,
                                                fontSize: 16,
                                              ),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: Color(0xFF4BB543),
                                          ),
                                        );
                                        FFAppState().statusFailed = getJsonField(
                                          (_model.apiResultr2o?.jsonBody ?? ''),
                                          r'''$.status''',
                                        ).toString();
                                        setState(() {});
                                      } else {
                                        if (_shouldSetState) setState(() {});
                                        return;
                                      }
                                      if (_shouldSetState) setState(() {});
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Resend OTP ',
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF6C7278),
                                            fontSize: 12,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Text(
                                            '(24s)',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: FlutterFlowTheme.of(context)
                                                  .primary,
                                              fontSize: 12,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ].divide(SizedBox(height: 2)),
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
*/

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'sign_up_o_t_p_model.dart';
export 'sign_up_o_t_p_model.dart';

class SignUpOTPWidget extends StatefulWidget {
  const SignUpOTPWidget({
    super.key,
    this.emailAddress,
    this.phoneNumber,
    this.countryCode,
    this.customerName,
    this.firstName,
    this.lastName,
  });

  final String? emailAddress;
  final String? phoneNumber;
  final String? countryCode;
  final String? customerName;
  final String? firstName;
  final String? lastName;

  @override
  State<SignUpOTPWidget> createState() => _SignUpOTPWidgetState();
}

class _SignUpOTPWidgetState extends State<SignUpOTPWidget> {
  late SignUpOTPModel _model;
  Timer? _resendTimer;
  int _resendSeconds = 30;

  final SignUp2OTPWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignUpOTPModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    startResendTimer();
  }

  @override
  void dispose() {
    _model.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }

  void startResendTimer() {
    _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendSeconds > 0) {
          _resendSeconds--;
        } else {
          _resendTimer?.cancel();
        }
      });
    });
  }

  void resendOTP() async {
    print('Resending OTP...');
    print('First & last name: ${widget.firstName} ${widget.lastName}');
    print('Email: ${widget.emailAddress}');
    print('Phone number: ${widget.phoneNumber}');
    print('Country code: ${widget.countryCode}');
    print('Customer Name: ${widget.customerName}');
    print('API Response: ${_model.apiResultr2o?.jsonBody}');
    var _shouldSetState = false;
    _model.apiResultr2o = await SignUpSendOTPCall.call(
      email: widget.emailAddress,
      mobileNumber: widget.phoneNumber,
      countryCode: functions.operatorRemover(widget.countryCode),
      hosturl: FFAppConstants.hosturl,
      customerName: functions.joinName(widget.firstName!, widget.lastName!),
    );

    _shouldSetState = true;
    if ((_model.apiResultr2o?.succeeded ?? true)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            getJsonField(
              (_model.apiResultr2o?.jsonBody ?? ''),
              r'''$.msg''',
            ).toString(),
            style: TextStyle(
              color: FlutterFlowTheme.of(context).primaryText,
              fontSize: 16,
            ),
          ),
          duration: Duration(milliseconds: 4000),
          backgroundColor: Color(0xFF4BB543),
        ),
      );
      FFAppState().statusFailed = getJsonField(
        (_model.apiResultr2o?.jsonBody ?? ''),
        r'''$.status''',
      ).toString();
      setState(() {});
      // Reset timer and start again
      _resendSeconds = 30;
      startResendTimer();
    } else {
      print('API Call Failed');
      if (_shouldSetState) setState(() {});
      return;
    }
    if (_shouldSetState) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: SignUp2OTPWidgetscaffoldKey,
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
                      padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                      child: Container(
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 24, 0, 12),
                                    child: Text(
                                      'Enter OTP',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
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
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: RichText(
                                  textScaler: MediaQuery.of(context).textScaler,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'OTP has been sent on ',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontSize: 12,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text: valueOrDefault<String>(
                                          widget.countryCode,
                                          '+91',
                                        ),
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '-',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                        text: valueOrDefault<String>(
                                          widget.phoneNumber,
                                          '993521178',
                                        ),
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                                child: TextFormField(
                                  controller: _model.textController,
                                  focusNode: _model.textFieldFocusNode,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'OTP',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                    ),
                                    hintText: 'Enter OTP',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
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
                                        color:
                                        FlutterFlowTheme.of(context).primary,
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
                                    contentPadding:
                                    EdgeInsetsDirectional.fromSTEB(
                                        0, 6, 0, 6),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                    letterSpacing: 0,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: _model.textControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 24, 0, 24),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      var _shouldSetState = false;
                                      _model.apiResultjp8 =
                                      await RegisterCustomerCall.call(
                                        hosturl: FFAppConstants.hosturl,
                                        customerName: widget.customerName,
                                        customerType: '1',
                                        mobilenumber: widget.phoneNumber,
                                        email: widget.emailAddress,
                                        countryCode: functions.operatorRemover(widget.countryCode),
                                        otp: _model.textController.text,
                                      );

                                      final response = await RegisterCustomerCall.call(
                                        hosturl: FFAppConstants.hosturl,
                                        customerName: widget.customerName,
                                        customerType: '1',
                                        mobilenumber: widget.phoneNumber,
                                        email: widget.emailAddress,
                                        countryCode: functions.operatorRemover(widget.countryCode),
                                        otp: _model.textController.text,
                                      );

                                      print('API Response: ${response.jsonBody}');
                                      print('API Response status: ${response.statusCode}');

                                      final requestBody = {
                                        'hosturl': FFAppConstants.hosturl,
                                        'customerName': widget.customerName,
                                        'customerType': '1',
                                        'mobilenumber': widget.phoneNumber,
                                        'email': widget.emailAddress,
                                        'countryCode': functions.operatorRemover(widget.countryCode),
                                        'otp': _model.textController.text,
                                      };

                                      print('Register Request body: $requestBody');
                                      print('Register Response: ${_model.apiResultjp8?.jsonBody}');
                                      _shouldSetState = true;
                                      if ((_model.apiResultjp8?.succeeded ??
                                          true)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              getJsonField(
                                                (_model.apiResultjp8?.jsonBody ??
                                                    ''),
                                                r'''$.msg''',
                                              ).toString(),
                                              style: TextStyle(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                                fontSize: 16,
                                              ),
                                            ),
                                            duration:
                                            Duration(milliseconds: 4000),
                                            backgroundColor: Color(0xFF4BB543),
                                          ),
                                        );
                                        FFAppState().statusFailed = getJsonField(
                                          (_model.apiResultjp8?.jsonBody ?? ''),
                                          r'''$.status''',
                                        ).toString();
                                        setState(() {});
                                        if (FFAppState().statusFailed ==
                                            'success') {
                                          context.pushNamed(
                                            'LoginPage',
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey: TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                PageTransitionType.fade,
                                                duration:
                                                Duration(milliseconds: 0),
                                              ),
                                            },
                                          );
                                        } else {
                                          if (_shouldSetState) setState(() {});
                                          return;
                                        }
                                      } else {
                                        if (_shouldSetState) setState(() {});
                                        return;
                                      }

                                      if (_shouldSetState) setState(() {});
                                    },
                                    text: 'Register',
                                    options: FFButtonOptions(
                                      width: 160,
                                      height: 48,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24, 0, 24, 0),
                                      iconPadding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      color: FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
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
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                                child: Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: _resendSeconds == 0 ? resendOTP : null,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Resend OTP ',
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            color: _resendSeconds == 0 ? FlutterFlowTheme.of(context).primary : Color(0xFF6C7278),
                                            fontSize: 12,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        if (_resendSeconds > 0) ...{
                                          Align(
                                            alignment: AlignmentDirectional(0, 0),
                                            child: Text(
                                              '($_resendSeconds\s)',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                color: FlutterFlowTheme.of(context)
                                                    .primary,
                                                fontSize: 12,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        }
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ].divide(SizedBox(height: 2)),
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

