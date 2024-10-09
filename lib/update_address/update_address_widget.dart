import 'package:rudraksha_cart/custom_code/widgets/custom_textformfield.dart';

import '../flutter_flow/custom_functions.dart';
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
import 'update_address_model.dart';
export 'update_address_model.dart';

class UpdateAddressWidget extends StatefulWidget {
  const UpdateAddressWidget({
    super.key,
    required this.addressId,
    required this.editCountryId,
    required this.editStateId,
  });

  final int? addressId;
  final String? editCountryId;
  final String? editStateId;

  @override
  State<UpdateAddressWidget> createState() => _UpdateAddressWidgetState();
}

class _UpdateAddressWidgetState extends State<UpdateAddressWidget> {
  late UpdateAddressModel _model;

  final UpdateAddressWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UpdateAddressModel());

    _model.firstNameFocusNode ??= FocusNode();

    _model.lastNameFocusNode ??= FocusNode();

    _model.phoneNumberFocusNode ??= FocusNode();

    _model.emailFocusNode ??= FocusNode();

    _model.address1FocusNode ??= FocusNode();

    _model.address2FocusNode ??= FocusNode();

    _model.landmarkFocusNode ??= FocusNode();

    _model.cityFocusNode ??= FocusNode();

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
        key: UpdateAddressWidgetscaffoldKey,
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
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Update Address',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Outfit',
              color: FlutterFlowTheme.of(context).primaryText,
              fontSize: 16.0,
            ),
          ),
          actions: const [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Form(
            key: _model.formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: FutureBuilder<ApiCallResponse>(
              future: AddressListCall.call(
                hosturl: FFAppConstants.hosturl,
                token: currentAuthenticationToken,
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
                final columnAddressListResponse = snapshot.data!;
                final fullName = functions.editAddressById(
                  widget.addressId!,
                  getJsonField(
                    columnAddressListResponse.jsonBody,
                    r'''$.data''', true,)!,
                  'name',
                );

                final nameParts = splitName(fullName);

                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 1.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).borderColor,
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).borderColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TextFormField(
                              controller: _model.firstNameTextController ??= TextEditingController(text: nameParts?[0]),
                              focusNode: _model.firstNameFocusNode,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'First Name',
                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).labelText,
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
                                    color: FlutterFlowTheme.of(context).labelText,
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
                            ),
                            TextFormField(
                              controller: _model.lastNameTextController ??= TextEditingController(text: nameParts?[1]),
                              focusNode: _model.lastNameFocusNode,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Last Name',
                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).labelText,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                                hintText: 'Enter Last Name',
                                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).labelText,
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
                              validator: _model.lastNameTextControllerValidator.asValidator(context),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Align(
                                  alignment: const AlignmentDirectional(0.0, 1.0),
                                  child: FlutterFlowDropDown<String>(
                                    controller: _model.countryCodeValueController ??= FormFieldController<String>(
                                      _model.countryCodeValue ??= functions.editAddressById(
                                          widget.addressId!, getJsonField(
                                        columnAddressListResponse.jsonBody, r'''$.data''',
                                        true,)!, 'countrycode'),
                                    ),
                                    options: functions.countryCodes()!,
                                    onChanged: (val) => setState(() => _model.countryCodeValue = val),
                                    width: 57.0,
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
                                    hintText: functions.editAddressById(
                                        widget.addressId!,
                                        getJsonField(
                                          columnAddressListResponse.jsonBody,
                                          r'''$.data''', true,)!,
                                        'countrycode'),
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
                                    margin: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                                    isOverButton: true,
                                    isSearchable: true,
                                    isMultiSelect: false,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                                    child: TextFormField(
                                      controller: _model.phoneNumberTextController ??= TextEditingController(
                                        text: functions.editAddressById(
                                            widget.addressId!,
                                            getJsonField(
                                              columnAddressListResponse.jsonBody,
                                              r'''$.data''', true,)!,
                                            'contact_no'),
                                      ),
                                      focusNode: _model.phoneNumberFocusNode,
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Phone Number',
                                        labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).labelText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        hintText: 'Enter Phone Number',
                                        hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context).labelText,
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
                                      validator: _model.phoneNumberTextControllerValidator.asValidator(context),
                                    ),
                                  ),
                                ),
                              ].divide(const SizedBox(width: 15.0)),
                            ),
                            TextFormField(
                              controller: _model.emailTextController ??= TextEditingController(
                                text: functions.editAddressById(
                                    widget.addressId!,
                                    getJsonField(
                                      columnAddressListResponse.jsonBody,
                                      r'''$.data''', true,)!,
                                    'email'),
                              ),
                              focusNode: _model.emailFocusNode,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).labelText,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                                hintText: 'Enter Email Address ',
                                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).labelText,
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
                                contentPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                              ),
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0.0,
                              ),
                              validator: _model.emailTextControllerValidator.asValidator(context),
                            ),
                            TextFormField(
                              controller: _model.address1TextController ??= TextEditingController(
                                text: functions.editAddressById(
                                    widget.addressId!,
                                    getJsonField(
                                      columnAddressListResponse.jsonBody,
                                      r'''$.data''', true,)!,
                                    'address'),
                              ),
                              focusNode: _model.address1FocusNode,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Address Line 1',
                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).labelText,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                                hintText: 'Enter Address ',
                                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).labelText,
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
                              validator: _model.address1TextControllerValidator.asValidator(context),
                            ),
                            TextFormField(
                              controller: _model.address2TextController ??= TextEditingController(
                                text: functions.editAddressById(
                                    widget.addressId!,
                                    getJsonField(
                                      columnAddressListResponse.jsonBody,
                                      r'''$.data''', true,)!,
                                    'addresstwo'),
                              ),
                              focusNode: _model.address2FocusNode,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Address Line 2 (optional)',
                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).labelText,
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
                                    color: FlutterFlowTheme.of(context).labelText,
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
                                contentPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                              ),
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0.0,
                              ),
                              validator: _model.address2TextControllerValidator.asValidator(context),
                            ),
                            TextFormField(
                              controller: _model.landmarkTextController ??= TextEditingController(
                                text: functions.editAddressById(
                                    widget.addressId!,
                                    getJsonField(
                                      columnAddressListResponse.jsonBody,
                                      r'''$.data''', true,)!,
                                    'landmark'),
                              ),
                              focusNode: _model.landmarkFocusNode,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Landmark  (optional)',
                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).labelText,
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
                                    color: FlutterFlowTheme.of(context).labelText,
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
                                contentPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
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
                                      width: 50,
                                      height: 50,
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
                                      FormFieldController<String>(
                                        _model.countryValue ??= functions.editAddressById(
                                          widget.addressId!,
                                          getJsonField(
                                            columnAddressListResponse.jsonBody,
                                            r'''$.data''', true,)!,
                                          'countryname'),
                                      ),
                                  options: (getJsonField(
                                    countryCountryListResponse.jsonBody,
                                    r'''$.data[:].name''',
                                    true,
                                  ) as List)
                                      .map<String>((s) => s.toString())
                                      .toList(),
                                  onChanged: (val) async {
                                    setState(() => _model.countryValue = val);
                                    _model.countryId = functions.countryIdByName(
                                        getJsonField(
                                          countryCountryListResponse.jsonBody,
                                          r'''$.data[:]''', true,
                                        ),
                                        _model.countryValue).toString();
                                    setState(() {});
                                  },
                                  width: double.infinity,
                                  height: 50,
                                  maxHeight: 350,
                                  searchHintTextStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    fontSize: 16,
                                    letterSpacing: 0,
                                  ),
                                  searchTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    letterSpacing: 0,
                                  ),
                                  textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintText: functions.editAddressById(
                                      widget.addressId!,
                                      getJsonField(
                                        columnAddressListResponse.jsonBody,
                                        r'''$.data''', true,)!,
                                      'countryname'),
                                  searchHintText: '',
                                  searchCursorColor: FlutterFlowTheme.of(context).primary,
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    size: 24,
                                  ),
                                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                  elevation: 2,
                                  borderColor: Colors.transparent,
                                  borderWidth: 2,
                                  borderRadius: 8,
                                  margin: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                  isOverButton: true,
                                  isSearchable: true,
                                  isMultiSelect: false,
                                );
                              },
                            ),
                            FutureBuilder<ApiCallResponse>(
                              future: StateListCall.call(
                                hosturl: FFAppConstants.hosturl,
                                countryId: _model.countryId,
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                final stateStateListResponse = snapshot.data!;
                                final stateOptions = (getJsonField(
                                  stateStateListResponse.jsonBody,
                                  r'''$.data[:].name''', true,
                                ) as List?)
                                    ?.map<String>((s) => s.toString())
                                    .toList() ?? [];

                                // Check if the dropdown data is empty or null
                                if (stateOptions.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'No states available',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                }

                                return FlutterFlowDropDown<String>(
                                  controller: _model.stateValueController ??= FormFieldController<String>(
                                    _model.stateValue ??= functions.editAddressById(
                                      widget.addressId!,
                                      getJsonField(
                                        columnAddressListResponse.jsonBody,
                                        r'''$.data''', true,)!,
                                      'statename'),
                                  ),
                                  options: stateOptions, // Use stateOptions instead of calculating it again
                                  onChanged: (val) async {
                                    setState(() => _model.stateValue = val);
                                    _model.stateId = functions.stateIdByName(
                                        getJsonField(stateStateListResponse.jsonBody,
                                          r'''$.data''', true,),
                                        _model.stateValue).toString();
                                    setState(() {});
                                  },
                                  width: double.infinity,
                                  height: 50,
                                  searchHintTextStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    fontSize: 16,
                                    letterSpacing: 0,
                                  ),
                                  searchTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    letterSpacing: 0,
                                  ),
                                  textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintText: functions.editAddressById(
                                      widget.addressId!, getJsonField(
                                        columnAddressListResponse.jsonBody,
                                        r'''$.data''', true,)!,
                                      'statename'),
                                  searchHintText: '',
                                  searchCursorColor: FlutterFlowTheme.of(context).primary,
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    size: 24,
                                  ),
                                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                  elevation: 2,
                                  borderColor: Colors.transparent,
                                  borderWidth: 2,
                                  borderRadius: 8,
                                  margin: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                  isOverButton: true,
                                  isSearchable: true,
                                  isMultiSelect: false,
                                );
                              },
                            ),
                            TextFormField(
                              controller: _model.cityTextController ??= TextEditingController(
                                text: functions.editAddressById(
                                    widget.addressId!, getJsonField(
                                      columnAddressListResponse.jsonBody,
                                      r'''$.data''', true,)!,
                                    'cityname'),
                              ),
                              focusNode: _model.cityFocusNode,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'City',
                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).labelText,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                                hintText: 'Enter City',
                                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).labelText,
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
                              validator: _model.cityTextControllerValidator.asValidator(context),
                            ),
                            TextFormField(
                              controller: _model.pinCodeTextController ??= TextEditingController(
                                text: functions.editAddressById(
                                    widget.addressId!, getJsonField(
                                      columnAddressListResponse.jsonBody,
                                      r'''$.data''', true,)!,
                                    'pincode'),
                              ),
                              focusNode: _model.pinCodeFocusNode,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Pincode/Zipcode',
                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).labelText,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                                hintText: 'Enter Pincode/Zipcode',
                                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Montserrat',
                                  letterSpacing: 0.0,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).labelText,
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
                              validator: _model.pinCodeTextControllerValidator.asValidator(context),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 46.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  FFButtonWidget(
                                    onPressed: () async {
                                      context.safePop();
                                    },
                                    text: 'Cancel',
                                    options: FFButtonOptions(
                                      height: 40.0,
                                      padding: const EdgeInsetsDirectional.fromSTEB(51.0, 11.0, 51.0, 11.0),
                                      iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).primaryText,
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
                                  // Generated code for this Button Widget...
                                  FFButtonWidget(
                                    onPressed: () async {
                                      var _shouldSetState = false;
                                      _model.apiResult35l = await UpdateAddressCall.call(
                                        hosturl: FFAppConstants.hosturl,
                                        token: currentAuthenticationToken,
                                        //name: _model.firstNameTextController.text,
                                        name: joinName(
                                          _model.firstNameTextController.text,
                                          _model.lastNameTextController.text,
                                        ),
                                        contactNo: _model.phoneNumberTextController.text,
                                        address: _model.address1TextController.text,
                                        addresstwo: _model.address2TextController.text,
                                        email: _model.emailTextController.text,
                                        landmark: _model.landmarkTextController.text,
                                        countryCode: _model.countryCodeValue,
                                        country: widget.editCountryId != null && widget.editCountryId != ''
                                            ? widget.editCountryId
                                            : _model.countryId,
                                        state: widget.editStateId != null && widget.editStateId != ''
                                            ? widget.editStateId
                                            : _model.stateId,
                                        city: _model.cityTextController.text,
                                        pincode: _model.pinCodeTextController.text,
                                        id: widget.addressId?.toString(),
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
                                                fontSize: 16,
                                              ),
                                            ),
                                            duration: const Duration(milliseconds: 4000),
                                            backgroundColor: FlutterFlowTheme.of(context).primary,
                                          ),
                                        );
                                        FFAppState().statusFailed = getJsonField(
                                          (_model.apiResult35l?.jsonBody ?? ''),
                                          r'''$.status''',
                                        ).toString();
                                        setState(() {});
                                        if (FFAppState().statusFailed == 'success') {
                                          context.pushNamed(
                                            'MyAddresses',
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
                                        if (_shouldSetState) setState(() {});
                                        return;
                                      }
                                      if (_shouldSetState) setState(() {});
                                    },
                                    text: 'Add',
                                    options: FFButtonOptions(
                                      height: 40,
                                      padding: const EdgeInsetsDirectional.fromSTEB(62.5, 11, 62.5, 11),
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
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ].divide(const SizedBox(height: 14.0)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
