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
import 'login_page_model.dart';
export 'login_page_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  late LoginPageModel _model;

  final LoginPageWidgetscaffoldKey = GlobalKey<ScaffoldState>();

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
        key: LoginPageWidgetscaffoldKey,
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
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 59, 0, 58),
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
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.92,
                        decoration: BoxDecoration(
                          color:
                          FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: FlutterFlowTheme.of(context).primary, width: 1,),
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
                              /*Form(
                                key: _model.formKey2,
                                //autovalidateMode: AutovalidateMode.always,
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
                                      borderSide: const BorderSide(color: Color(0xFF868687), width: 1,),
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
                                    contentPadding: const EdgeInsetsDirectional.fromSTEB(0, 6, 0, 6),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                    letterSpacing: 0,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: _model.emailTextControllerValidator.asValidator(context),
                                ),
                              ),*/
                              Form(
                                key: _model.formKey2,
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
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.sizeOf(context).width * 0.3,
                                      height: 1,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEDF1F3),
                                        border: Border.all(
                                          color: const Color(0xFFEDF1F3),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: const AlignmentDirectional(0, 0),
                                      child: Text(
                                        'Or',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          color: const Color(0xFF6C7278),
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
                                        color: const Color(0xFFEDF1F3),
                                        border: Border.all(color: const Color(0xFFEDF1F3),),
                                      ),
                                    ),
                                  ].divide(const SizedBox(width: 6)),
                                ),
                              ),
                              /*Form(
                                key: _model.formKey1,
                                //autovalidateMode: AutovalidateMode.always,
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
                                          width: 65,
                                          maxHeight: 300,
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
                                          margin: const EdgeInsetsDirectional.fromSTEB(10, 6, 0, 12),
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
                                              borderSide: const BorderSide(color: Color(0xFF868687), width: 1,),
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
                                            contentPadding: const EdgeInsetsDirectional.fromSTEB(0, 6, 0, 12),
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
                                    ].divide(const SizedBox(width: 6)),
                                  ),
                                ),
                              ),*/
                              Form(
                                key: _model.formKey1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                                          width: 65,
                                          maxHeight: 300,
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
                                          margin: const EdgeInsetsDirectional.fromSTEB(10, 6, 0, 12),
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
                                    ].divide(const SizedBox(width: 6)),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      var _shouldSetState = false;

                                      // Validate email and phone number inputs
                                      bool isEmailValid = _model.emailTextController.text.isNotEmpty;
                                      bool isPhoneNumberValid = _model.phoneTextController.text.isNotEmpty;
                                      bool isCountryCodeValid = functions.operatorRemover(_model.dropDownValue) != null && functions.operatorRemover(_model.dropDownValue)!.isNotEmpty;

                                      if (!isEmailValid && !isPhoneNumberValid) {
                                        ScaffoldMessenger.of(context).clearSnackBars();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: const Text('Please enter either an email or a phone number.'),
                                            duration: const Duration(seconds: 2),
                                            backgroundColor: FlutterFlowTheme.of(context).primary,
                                          ),
                                        );
                                        return;
                                      }

                                      if (isPhoneNumberValid && !isCountryCodeValid) {
                                        ScaffoldMessenger.of(context).clearSnackBars();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Please select a country code.'),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: Color(0xFFFC100D),
                                          ),
                                        );
                                        return;
                                      }

                                      // Proceed with the API call if inputs are valid
                                      _model.apiResultjba = await LoginWithOTPCall.call(
                                        email: isEmailValid ? _model.emailTextController.text : '',
                                        mobileNumber: isPhoneNumberValid ? _model.phoneTextController.text : '',
                                        countryCode: isPhoneNumberValid ? functions.operatorRemover(_model.dropDownValue) : '',
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
                                                r'''$.msg''',).toString(),
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                fontSize: 16,
                                              ),
                                            ),
                                            duration: const Duration(seconds: 2),
                                            backgroundColor: FlutterFlowTheme.of(context).primary,
                                          ),
                                        );
                                        FFAppState().statusFailed = getJsonField(
                                          (_model.apiResultjba?.jsonBody ?? ''),
                                          r'''$.status''',).toString();
                                        FFAppState().countrycode = functions.operatorRemover(_model.dropDownValue) ?? '';
                                        setState(() {});
                                        if (FFAppState().statusFailed == 'success') {
                                          print('Country Code: ${FFAppState().countrycode}');
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
                                                functions.operatorRemover(_model.dropDownValue) ?? '',
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
                                                r'''$.msg''',).toString(),
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                fontSize: 16,
                                              ),
                                            ),
                                            duration: const Duration(milliseconds: 4000),
                                            backgroundColor: const Color(0xFFFC100D),
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
                                        'If you don\'t have an account? ',
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
                                            'RegisterPage',
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
                                          'Register Now',
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
