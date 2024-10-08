import 'dart:async';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'signin_o_t_p_model.dart';
export 'signin_o_t_p_model.dart';
import '/flutter_flow/custom_functions.dart' as functions;

class SigninOTPWidget extends StatefulWidget {
  const SigninOTPWidget({
    super.key,
    this.emailAddress,
    this.phoneNumber,
    this.countryCode,
  });

  final String? emailAddress;
  final String? phoneNumber;
  final String? countryCode;

  @override
  State<SigninOTPWidget> createState() => _SigninOTPWidgetState();
}

class _SigninOTPWidgetState extends State<SigninOTPWidget> {
  late SigninOTPModel _model;
  Timer? _resendTimer;
  int _resendSeconds = 30;

  final SigninOTPWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SigninOTPModel());

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
    print('Email: ${widget.emailAddress}');
    print('Phone number: ${widget.phoneNumber}');
    print('Country code: ${widget.countryCode}');
    var _shouldSetState = false;
    _model.apiResultjba = await LoginWithOTPCall.call(
      email: widget.emailAddress,
      mobileNumber: widget.phoneNumber,
      countryCode: functions.operatorRemover(widget.countryCode),
      hosturl: FFAppConstants.hosturl,
    );

    print('Api Response: ${_model.apiResultjba?.response}');

    _shouldSetState = true;
    if ((_model.apiResultjba?.succeeded ?? true)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            getJsonField(
              (_model.apiResultjba?.jsonBody ?? ''),
              r'''$.msg''',
            ).toString(),
            style: TextStyle(
              color: FlutterFlowTheme.of(context).primaryText,
              fontSize: 16,
            ),
          ),
          duration: Duration(seconds: 2),
          backgroundColor:
          FlutterFlowTheme.of(context)
              .primary,
        ),
      );
      FFAppState().statusFailed = getJsonField(
        (_model.apiResultjba?.jsonBody ?? ''),
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
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: SigninOTPWidgetscaffoldKey,
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
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 59.0, 0.0, 58.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/logo_1.png',
                              width: 191.0,
                              height: 80.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.92,
                        height: 298.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 0.0),
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
                                        0.0, 24.0, 0.0, 12.0),
                                    child: Text(
                                      'Enter OTP',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Builder(
                                  builder: (context) {
                                    if ((widget!.phoneNumber != null && widget!.phoneNumber != '') &&
                                        (widget!.countryCode != null && widget!.countryCode != '')) {
                                      return RichText(
                                        textScaler: MediaQuery.of(context).textScaler,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'OTP has been sent on ',
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Montserrat',
                                                color: Colors.black,
                                                fontSize: 12,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '+',
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).primary,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ),
                                            TextSpan(
                                              text: valueOrDefault<String>(
                                                widget!.countryCode,
                                                '+91',
                                              ),
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).primary,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '-',
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).primary,
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
                                                color: FlutterFlowTheme.of(context).primary,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            )
                                          ],
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      );
                                    } else if (widget.emailAddress != null &&
                                        widget.emailAddress != '') {
                                      return RichText(
                                        textScaler: MediaQuery.of(context).textScaler,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'OTP has been sent on ',
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Montserrat',
                                                color: Colors.black,
                                                fontSize: 12,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text: valueOrDefault<String>(
                                                widget.emailAddress,
                                                'example@mail.com',
                                              ),
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).primary,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            )
                                          ],
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 24.0, 0.0, 0.0),
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
                                          letterSpacing: 0.0,
                                        ),
                                    hintText: 'Enter OTP',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                        ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF868687),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).primary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0.0, 6.0, 0.0, 6.0),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                      ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: _model.textControllerValidator.asValidator(context),
                                  autofillHints: const [AutofillHints.oneTimeCode],
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 24.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      // Ensure OTP is not empty before making the API call
                                      if (_model.textController.text.isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Please enter the OTP.', style: TextStyle(
                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                              fontSize: 16,
                                            ),),

                                            duration: Duration(seconds: 2),
                                            backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        );
                                        return;
                                      }
                                      final requestBody = {
                                        "hosturl": FFAppConstants.hosturl,
                                        "email": widget.emailAddress,
                                        "mobilenumber": widget.phoneNumber,
                                        "countryCode": widget.countryCode,
                                        "emailotp": _model.textController.text,
                                        "mobileotp": _model.textController.text,
                                        "fcmToken": FFAppState().firebaseToken,
                                      };

                                      print('Stored fcm token: ${FFAppState().firebaseToken}');

                                      print('Request Body: ${jsonEncode(requestBody)}');



                                      print('token: $currentAuthenticationToken');
                                      _model.apiResultjp8 = await LoginCall.call(
                                        hosturl: FFAppConstants.hosturl,
                                        email: widget.emailAddress,
                                        mobilenumber: widget.phoneNumber,
                                        countryCode: widget.countryCode,
                                        emailotp: _model.textController.text,
                                        mobileotp: _model.textController.text,
                                        fcmToken: FFAppState().firebaseToken,
                                        //source: 'app'
                                      );

                                      final apiResponse = _model.apiResultjp8?.jsonBody ?? '';

                                      // Check the API response status
                                      if (getJsonField(apiResponse, r'''$.status''').toString() == 'failed') {
                                        ScaffoldMessenger.of(context).clearSnackBars();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              getJsonField(apiResponse, r'''$.msg''').toString(),
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            duration: Duration(seconds: 2),
                                            backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        );
                                        return;
                                      }

                                      if ((_model.apiResultjp8?.succeeded ?? true)) {
                                        ScaffoldMessenger.of(context).clearSnackBars();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              getJsonField(apiResponse, r'''$.msg''').toString(),
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            duration: Duration(seconds: 2),
                                            backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        );
                                        GoRouter.of(context).prepareAuthEvent();
                                        await authManager.signIn(
                                          authenticationToken: getJsonField(apiResponse, r'''$.token''').toString(),
                                          tokenExpiration: ExpiryTokenStruct.maybeFromMap(getJsonField(apiResponse, r'''$.expiry_time'''))?.expiryTime,
                                          authUid: LoginCall.uid(apiResponse),
                                          userData: UserStruct(
                                            uid: getJsonField(apiResponse, r'''$.data''').toString(),
                                            displayName: LoginCall.name(apiResponse),
                                          ),
                                        );

                                        context.pushNamedAuth(
                                          'Homepage',
                                          context.mounted,
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: TransitionInfo(
                                              hasTransition: true,
                                              transitionType: PageTransitionType.rightToLeft,
                                              duration: Duration(milliseconds: 400),
                                            ),
                                          },
                                        );
                                      }

                                      setState(() {});
                                    },
                                    text: 'Login',
                                    options: FFButtonOptions(
                                      width: 160.0,
                                      height: 48.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                        fontFamily: 'Montserrat',
                                        color: Colors.white,
                                        letterSpacing: 0.0,
                                      ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
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
                            ].divide(SizedBox(height: 2.0)),
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
