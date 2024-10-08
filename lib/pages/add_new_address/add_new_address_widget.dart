import 'package:flutter/services.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_new_address_model.dart';
export 'add_new_address_model.dart';

class AddNewAddressWidget extends StatefulWidget {
  const AddNewAddressWidget({super.key});

  @override
  State<AddNewAddressWidget> createState() => _AddNewAddressWidgetState();
}

class _AddNewAddressWidgetState extends State<AddNewAddressWidget> {
  late AddNewAddressModel _model;

  final AddNewAddressWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddNewAddressModel());

    _model.firstNameTextController ??= TextEditingController();
    _model.firstNameFocusNode ??= FocusNode();

    _model.lastNameTextController ??= TextEditingController();
    _model.lastNameFocusNode ??= FocusNode();

    _model.phoneNumberTextController ??= TextEditingController();
    _model.phoneNumberFocusNode ??= FocusNode();

    _model.emailTextController ??= TextEditingController();
    _model.emailFocusNode ??= FocusNode();

    _model.address1TextController ??= TextEditingController();
    _model.address1FocusNode ??= FocusNode();

    _model.address2TextController ??= TextEditingController();
    _model.address2FocusNode ??= FocusNode();

    _model.landmarkTextController ??= TextEditingController();
    _model.landmarkFocusNode ??= FocusNode();

    _model.cityTextController ??= TextEditingController();
    _model.cityFocusNode ??= FocusNode();

    _model.pinCodeTextController ??= TextEditingController();
    _model.pinCodeFocusNode ??= FocusNode();
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
        key: AddNewAddressWidgetscaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF272728),
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            //'Add New Address',
            '${_model.countryId}',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Outfit',
              color: Color(0xFF272728),
              fontSize: 16,
              letterSpacing: 0,
              fontWeight: FontWeight.w500,
            ),
          ),
          /*RichText(
            textScaler: MediaQuery.of(context).textScaler,
            text: TextSpan(
              children: [
                TextSpan(
                  text: valueOrDefault<String>(
                    _model.countryId,
                    'IN',
                  ),
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Outfit',
                    color: Color(0xFF272728),
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: ' ',
                  style: TextStyle(),
                ),
                TextSpan(
                  text: valueOrDefault<String>(
                    _model.stateId,
                    'Mh',
                  ),
                  style: TextStyle(),
                )
              ],
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Outfit',
                color: Color(0xFF272728),
                fontSize: 16.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),*/
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 1.0,
                decoration: BoxDecoration(
                  color: Color(0xFFE7E7E8),
                  border: Border.all(
                    color: Color(0xFFE7E7E8),
                  ),
                ),
              ),
              Padding(
                padding:
                EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    /*TextFormField(
                      controller: _model.firstNameTextController,
                      focusNode: _model.firstNameFocusNode,
                      autofocus: true,
                      obscureText: false,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')), // Allow only alphabets
                        LengthLimitingTextInputFormatter(50)
                      ],
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        labelStyle:
                        FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF868687),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                        ),
                        hintText: 'Enter First Name',
                        hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Montserrat',
                          color: FlutterFlowTheme.of(context).primaryText,
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
                            color: FlutterFlowTheme.of(context).primary,
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
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        letterSpacing: 0.0,
                      ),
                      validator: _model.firstNameTextControllerValidator.asValidator(context),
                    ),*/
                    Form(
                      key: _model.formKey3,
                      autovalidateMode: AutovalidateMode.always,
                      child: TextFormField(
                        controller: _model.firstNameTextController,
                        focusNode: _model.firstNameFocusNode,
                        autofocus: true,
                        obscureText: false,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')), // Allow only alphabets
                          LengthLimitingTextInputFormatter(50)
                        ],
                        decoration: InputDecoration(
                          labelText: 'First Name *',
                          labelStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF868687),
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Enter First Name',
                          hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
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
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                        ),
                        validator: _model.firstNameTextControllerValidator
                            .asValidator(context),
                      ),
                    ),
                    Form(
                      key: _model.formKey2,
                      autovalidateMode: AutovalidateMode.always,
                      child: TextFormField(
                        controller: _model.lastNameTextController,
                        focusNode: _model.lastNameFocusNode,
                        autofocus: true,
                        obscureText: false,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')), // Allow only alphabets
                          LengthLimitingTextInputFormatter(50)
                        ],
                        decoration: InputDecoration(
                          labelText: 'Last Name *',
                          labelStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF868687),
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Enter Last Name',
                          hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
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
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                        ),
                        validator: _model.lastNameTextControllerValidator
                            .asValidator(context),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 1.0),
                          child: FlutterFlowDropDown<String>(
                            controller: _model.countryCodeValueController ??= FormFieldController<String>(null),
                            options: functions.countryCodes()!,
                            onChanged: (val) => setState(() => _model.countryCodeValue = val),
                            width: 65,
                            maxHeight: 300,
                            searchHintTextStyle: FlutterFlowTheme.of(context).labelMedium.override(
                              fontFamily: 'Montserrat',
                              letterSpacing: 0.0,
                            ),
                            searchTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              letterSpacing: 0.0,
                            ),
                            textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                            ),
                            hintText: '+00',
                            searchHintText: '',
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                            elevation: 2.0,
                            borderColor: Colors.transparent,
                            borderWidth: 0.0,
                            borderRadius: 0.0,
                            margin: EdgeInsetsDirectional.fromSTEB(10, 6, 0, 12),
                            isOverButton: true,
                            isSearchable: true,
                            isMultiSelect: false,
                          ),
                        ),
                        Expanded(
                          child: Form(
                            key: _model.formKey5,
                            autovalidateMode: AutovalidateMode.always,
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                              child: TextFormField(
                                controller: _model.phoneNumberTextController,
                                focusNode: _model.phoneNumberFocusNode,
                                autofocus: true,
                                obscureText: false,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly, // Allow only digits
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Phone Number *',
                                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF868687),
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
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
                                ),
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  letterSpacing: 0,
                                ),
                                keyboardType: TextInputType.phone,
                                validator: _model.phoneNumberTextControllerValidator.asValidator(context),
                              ),
                            ),
                          ),
                        ),
                      ].divide(SizedBox(width: 15.0)),
                    ),
                    Form(
                      key: _model.formKey4,
                      autovalidateMode: AutovalidateMode.always,
                      child: TextFormField(
                        controller: _model.emailTextController,
                        focusNode: _model.emailFocusNode,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Email *',
                          labelStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF868687),
                            fontSize: 14,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Enter Email Address ',
                          hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
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
                          contentPadding:
                          EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                        ),
                        validator: _model.emailTextControllerValidator
                            .asValidator(context),
                      ),
                    ),
                    Form(
                      key: _model.formKey6,
                      autovalidateMode: AutovalidateMode.always,
                      child: TextFormField(
                        controller: _model.address1TextController,
                        focusNode: _model.address1FocusNode,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Address Line 1 *',
                          labelStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF868687),
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Enter Address ',
                          hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
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
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                        ),
                        validator: _model.address1TextControllerValidator
                            .asValidator(context),
                      ),
                    ),
                    TextFormField(
                      controller: _model.address2TextController,
                      focusNode: _model.address2FocusNode,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Address Line 2 (optional)',
                        labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF868687),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                        ),
                        hintText: 'Enter Address (optional)',
                        hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Montserrat',
                          color: FlutterFlowTheme.of(context).primaryText,
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
                            color: FlutterFlowTheme.of(context).primary,
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
                        contentPadding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        letterSpacing: 0.0,
                      ),
                      validator: _model.address2TextControllerValidator.asValidator(context),
                    ),
                    TextFormField(
                      controller: _model.landmarkTextController,
                      focusNode: _model.landmarkFocusNode,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Landmark  (optional)',
                        labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF868687),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                        ),
                        hintText: 'Enter Landmark (optional)',
                        hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Montserrat',
                          color: FlutterFlowTheme.of(context).primaryText,
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
                            color: FlutterFlowTheme.of(context).primary,
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
                        contentPadding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        letterSpacing: 0.0,
                      ),
                      validator: _model.landmarkTextControllerValidator.asValidator(context),
                    ),
                    FutureBuilder<ApiCallResponse>(
                      future: CountryListCall.call(
                        hosturl: FFAppConstants.hosturl,
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        final countryCountryListResponse = snapshot.data!;
                        return FlutterFlowDropDown<String>(
                          controller: _model.countryValueController ??=
                              FormFieldController<String>(_model.countryValue ??= 'Select Country',),
                          options: CountryListCall.name(countryCountryListResponse.jsonBody,)!,
                          onChanged: (val) async {
                            setState(() => _model.countryValue = val);
                            _model.countryId = functions.countryIdByName(
                                getJsonField(countryCountryListResponse.jsonBody, r'''$.data[:]''', true,),
                                _model.countryValue)?.toString();
                            setState(() {});
                          },
                          width: double.infinity,
                          height: 50.0,
                          maxHeight: 350.0,
                          searchHintTextStyle: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                          ),
                          searchTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            letterSpacing: 0.0,
                          ),
                          textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Select Country',
                          searchHintText: '',
                          searchCursorColor: FlutterFlowTheme.of(context).primary,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 2.0,
                          borderColor: Colors.transparent,
                          borderWidth: 2.0,
                          borderRadius: 8.0,
                          margin: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                          isOverButton: true,
                          isSearchable: true,
                          isMultiSelect: false,
                        );
                      },
                    ),
                    FutureBuilder<ApiCallResponse>(
                      future: StateListCall.call(
                        countryId: valueOrDefault<String>(
                          _model.countryId,
                          '101',
                        ),
                        hosturl: FFAppConstants.hosturl,
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        final stateStateListResponse = snapshot.data!;
                        return FlutterFlowDropDown<String>(
                          controller: _model.stateValueController ??=
                              FormFieldController<String>(_model.stateValue ??= 'Select State',),
                          options: StateListCall.stateName(
                            stateStateListResponse.jsonBody,
                          ) ?? [],
                          onChanged: (val) async {
                            setState(() => _model.stateValue = val);
                            _model.stateId = functions.stateIdByName(
                                getJsonField(
                                  stateStateListResponse.jsonBody,
                                  r'''$.data''', true,
                                ), _model.stateValue).toString();
                            setState(() {});
                          },
                          width: double.infinity,
                          height: 50.0,
                          searchHintTextStyle: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                          ),
                          searchTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            letterSpacing: 0.0,
                          ),
                          textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Select State',
                          searchHintText: '',
                          searchCursorColor: FlutterFlowTheme.of(context).primary,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 2.0,
                          borderColor: Colors.transparent,
                          borderWidth: 2.0,
                          borderRadius: 8.0,
                          margin: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                          isOverButton: true,
                          isSearchable: true,
                          isMultiSelect: false,
                        );
                      },
                    ),
                    Form(
                      key: _model.formKey1,
                      autovalidateMode: AutovalidateMode.always,
                      child: TextFormField(
                        controller: _model.cityTextController,
                        focusNode: _model.cityFocusNode,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'City *',
                          labelStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF868687),
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Enter City',
                          hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
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
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                        ),
                        validator: _model.cityTextControllerValidator
                            .asValidator(context),
                      ),
                    ),
                    Form(
                      key: _model.formKey7,
                      autovalidateMode: AutovalidateMode.always,
                      child: TextFormField(
                        controller: _model.pinCodeTextController,
                        focusNode: _model.pinCodeFocusNode,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Pincode/Zipcode *',
                          labelStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF868687),
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Enter Pincode/Zipcode',
                          hintStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Montserrat',
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
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                        ),
                        validator: _model.pinCodeTextControllerValidator
                            .asValidator(context),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 46.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {context.safePop();},
                            text: 'Cancel',
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(51.0, 11.0, 51.0, 11.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).secondaryBackground,
                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF3E3E40),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              var _shouldSetState = false;

                              // Validate required fields
                              if (_model.firstNameTextController.text.isEmpty ||
                                  _model.lastNameTextController.text.isEmpty ||
                                  _model.emailTextController.text.isEmpty ||
                                  _model.phoneNumberTextController.text.isEmpty ||
                                  _model.address1TextController.text.isEmpty ||
                                  _model.cityTextController.text.isEmpty ||
                                  _model.pinCodeTextController.text.isEmpty ||
                                  _model.countryCodeValue == null ||
                                  _model.countryId == null ||
                                  _model.stateId == null) {

                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Please fill in all required fields',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        fontSize: 16,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              // Check if country code is selected from dropdown
                              if (_model.countryCodeValue == null) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Please select a country code',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        fontSize: 16,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              // Make the API call to add the address
                              _model.apiResult35l = await AddAddressCall.call(
                                token: currentAuthenticationToken,
                                hosturl: FFAppConstants.hosturl,
                                name: functions.joinName(
                                  _model.firstNameTextController.text,
                                  _model.lastNameTextController.text,
                                ),
                                contactNo: _model.phoneNumberTextController.text,
                                address: _model.address1TextController.text,
                                addresstwo: _model.address2TextController.text,
                                email: _model.emailTextController.text,
                                landmark: _model.landmarkTextController.text,
                                countryCode: _model.countryCodeValue,
                                city: _model.cityTextController.text,
                                pincode: _model.pinCodeTextController.text,
                                country: _model.countryId,
                                state: _model.stateId,
                              );

                              _shouldSetState = true;

                              if ((_model.apiResult35l?.succeeded ?? true)) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      getJsonField(
                                        (_model.apiResult35l?.jsonBody ?? ''),
                                        r'''$.msg''',
                                      ).toString(),
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor: FlutterFlowTheme.of(context).primary,
                                  ),
                                );

                                FFAppState().statusFailed = getJsonField(
                                  (_model.apiResult35l?.jsonBody ?? ''),
                                  r'''$.status''',
                                ).toString();

                                setState(() {});

                                if (FFAppState().statusFailed == 'success') {
                                  if (FFAppState().isDeliveryAddress) {
                                    context.pushNamed(
                                      'DeliveryAddress',
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType: PageTransitionType.bottomToTop,
                                          duration: Duration(milliseconds: 400),
                                        ),
                                      },
                                    );
                                  } else {
                                    context.pushNamed(
                                      'MyAddresses',
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType: PageTransitionType.rightToLeft,
                                          duration: Duration(milliseconds: 400),
                                        ),
                                      },
                                    );
                                  }
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
                                        (_model.apiResult35l?.jsonBody ?? ''),
                                        r'''$.msg''',
                                      ).toString(),
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                        fontSize: 16.0,
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
                            text: 'Add',
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(62.5, 11.0, 62.5, 11.0),
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
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ].divide(SizedBox(height: 14.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
