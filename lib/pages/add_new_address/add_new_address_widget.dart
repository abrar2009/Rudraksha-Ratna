import '../../custom_code/widgets/custom_textformfield.dart';
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
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Add New Address',
            //'${_model.countryId}',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Outfit',
              color: FlutterFlowTheme.of(context).primaryText,
              fontSize: 16,
              letterSpacing: 0,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: const [],
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
                    Form(
                      key: _model.formKey3,
                      autovalidateMode: AutovalidateMode.always,
                      child: CustomTextFormField(
                        controller: _model.firstNameTextController!,
                        focusNode: _model.firstNameFocusNode!,
                        labelText: 'First Name *',
                        hintText: 'Enter First Name',
                        keyboardType: TextInputType.name,
                        isObscureText: false,
                        validator: _model.firstNameTextControllerValidator.asValidator(context)!,
                      ),
                    ),
                    Form(
                      key: _model.formKey2,
                      autovalidateMode: AutovalidateMode.always,
                      child: CustomTextFormField(
                        controller: _model.lastNameTextController!,
                        focusNode: _model.lastNameFocusNode!,
                        labelText: 'Last Name *',
                        hintText: 'Enter Last Name',
                        keyboardType: TextInputType.name,
                        isObscureText: false,
                        validator: _model.lastNameTextControllerValidator.asValidator(context)!,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0.0, 1.0),
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
                            margin: const EdgeInsetsDirectional.fromSTEB(10, 6, 0, 12),
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
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                              child: CustomTextFormField(
                                controller: _model.phoneNumberTextController!,
                                focusNode: _model.phoneNumberFocusNode!,
                                labelText: 'Phone Number *',
                                hintText: 'Enter Phone Number',
                                keyboardType: TextInputType.phone,
                                isObscureText: false,
                                validator: _model.phoneNumberTextControllerValidator.asValidator(context)!,
                              ),
                            ),
                          ),
                        ),
                      ].divide(const SizedBox(width: 15.0)),
                    ),
                    Form(
                      key: _model.formKey4,
                      autovalidateMode: AutovalidateMode.always,
                      child: CustomTextFormField(
                        controller: _model.emailTextController!,
                        focusNode: _model.emailFocusNode!,
                        labelText: 'Email *',
                        hintText: 'Enter Email Address ',
                        keyboardType: TextInputType.emailAddress,
                        isObscureText: false,
                        validator: _model.emailTextControllerValidator.asValidator(context)!,
                      ),
                    ),
                    Form(
                      key: _model.formKey6,
                      autovalidateMode: AutovalidateMode.always,
                      child: CustomTextFormField(
                        controller: _model.address1TextController!,
                        focusNode: _model.address1FocusNode!,
                        labelText: 'Address Line 1 *',
                        hintText: 'Enter Address',
                        keyboardType: TextInputType.none,
                        isObscureText: false,
                        validator: _model.address1TextControllerValidator.asValidator(context)!,
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
                      controller: _model.landmarkTextController,
                      focusNode: _model.landmarkFocusNode,
                      autofocus: true,
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
                          margin: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
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
                          margin: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                          isOverButton: true,
                          isSearchable: true,
                          isMultiSelect: false,
                        );
                      },
                    ),
                    Form(
                      key: _model.formKey1,
                      autovalidateMode: AutovalidateMode.always,
                      child: CustomTextFormField(
                        controller: _model.cityTextController!,
                        focusNode: _model.cityFocusNode!,
                        labelText: 'City *',
                        hintText: 'Enter City',
                        keyboardType: TextInputType.none,
                        isObscureText: false,
                        validator: _model.cityTextControllerValidator.asValidator(context)!,
                      ),
                    ),
                    Form(
                      key: _model.formKey7,
                      autovalidateMode: AutovalidateMode.always,
                      child: CustomTextFormField(
                        controller: _model.pinCodeTextController!,
                        focusNode: _model.pinCodeFocusNode!,
                        labelText: 'Pincode/Zipcode *',
                        hintText: 'Enter Pincode/Zipcode',
                        keyboardType: TextInputType.none,
                        isObscureText: false,
                        validator: _model.pinCodeTextControllerValidator.asValidator(context)!,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 46.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {context.safePop();},
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
                                    duration: const Duration(milliseconds: 4000),
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
                                    duration: const Duration(milliseconds: 4000),
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
                                  if (FFAppState().isDeliveryAddress) {
                                    context.pushNamed(
                                      'DeliveryAddress',
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: const TransitionInfo(
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
                                        kTransitionInfoKey: const TransitionInfo(
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
                                    duration: const Duration(milliseconds: 4000),
                                    backgroundColor: FlutterFlowTheme.of(context).primary,
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
                              padding: const EdgeInsetsDirectional.fromSTEB(62.5, 11.0, 62.5, 11.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Montserrat',
                                color: FlutterFlowTheme.of(context).primaryBackground,
                                letterSpacing: 0.0,
                              ),
                              elevation: 0.0,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ].divide(const SizedBox(height: 14.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
