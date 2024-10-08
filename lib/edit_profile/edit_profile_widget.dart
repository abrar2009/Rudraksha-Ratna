import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../flutter_flow/custom_functions.dart';
import '../flutter_flow/upload_data.dart';
import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'edit_profile_model.dart';
export 'edit_profile_model.dart';
import 'package:path/path.dart' as path;

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({super.key});

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  late EditProfileModel _model;
  File? _selectedImage;
  String? _cachedImagePath;
  String? customerName;
  String? email;
  int? phone;
  String? initialEmail;
  String? initialPhone;

  final EditProfileWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditProfileModel());
    _model.firstNameFocusNode ??= FocusNode();
    _model.lastNameFocusNode ??= FocusNode();
    _model.emailFocusNode ??= FocusNode();
    _model.phoneNoFocusNode ??= FocusNode();
    _loadCachedImagePath();
    initialEmail = _model.emailTextController.text;
    initialPhone = _model.phoneNoTextController.text;
    print('initial Email: $initialEmail');
  }

  Future<void> _loadCachedImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _cachedImagePath = prefs.getString('cachedImagePath');
      if (_cachedImagePath != null) {
        _selectedImage = File(_cachedImagePath!);
      }
    });
  }

  Future<File> getCachedImageFile(File imageFile) async {
    final directory = await getTemporaryDirectory();
    final fileName = imageFile.uri.pathSegments.last;
    final cachedFile = File('${directory.path}/$fileName');
    if (!await cachedFile.exists()) {
      await imageFile.copy(cachedFile.path);
    }
    return cachedFile;
  }

  void _performUpdateCustomerApiCall() async {
    _model.apiResultt41 = await UpdateCustomerCall.call(
      email: _model.emailTextController.text,
      mobileNumber: _model.phoneNoTextController.text,
      countryCode: FFAppState().countrycode,
      hosturl: FFAppConstants.hosturl,
      customerName: joinName(
        _model.firstNameTextController.text,
        _model.lastNameTextController.text,
      ),
      token: currentAuthenticationToken,
      imagePath: _selectedImage,
    );

    final requestData = {
      'email': _model.emailTextController.text,
      'mobilenumber': _model.phoneNoTextController.text,
      'country_code': FFAppState().countrycode,
      'customer_name': joinName(
        _model.firstNameTextController.text,
        _model.lastNameTextController.text,
      ),
      'profilepic': _selectedImage,
    };

    print('Profile Request Body: $requestData');

    if ((_model.apiResultt41?.succeeded ?? true)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            getJsonField(
              (_model.apiResultt41?.jsonBody ?? ''),
              r'''$.msg''',).toString(),
            style: TextStyle(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
          ),
          duration: Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).primary,
        ),
      );
      context.safePop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            getJsonField(
              (_model.apiResultt41?.jsonBody ?? ''),
              r'''$.msg''',).toString(),
            style: TextStyle(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
          ),
          duration: Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).primary,
        ),
      );
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: EditProfileWidgetscaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF272728),
              size: 30,
            ),
            onPressed: () async {context.pop();},
          ),
          title: Text(
            'Edit Profile',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Outfit',
              color: FlutterFlowTheme.of(context).primaryText,
              fontSize: 16,
              letterSpacing: 0,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0,
        ),
        body: Stack(
          children: [
            FutureBuilder<ApiCallResponse>(
              future: CustomerDetailsCall.call(
                token: currentAuthenticationToken,
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
                final columnCustomerDetailsResponse = snapshot.data!;

                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 26, 0, 0),
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-0.07, -0.77),
                                  child: _selectedImage != null
                                      ? ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: Image.memory(
                                      _selectedImage!.readAsBytesSync(),
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ) : Container(
                                    width: 120,
                                    height: 120,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 1,
                                        color: FlutterFlowTheme.of(context).primary
                                      )
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: getJsonField(
                                        columnCustomerDetailsResponse.jsonBody,
                                        r'''$.data.profilepic''',
                                      ).toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => CircularProgressIndicator(
                                        color: FlutterFlowTheme.of(context).primary,),
                                      errorWidget: (context, url, error) => Icon(Icons.person, size: 80),
                                    ),
                                  ),
                                ),
                                // Camera icon to trigger image selection
                                Align(
                                  alignment: AlignmentDirectional(0.19, 0.39),
                                  child: GestureDetector(
                                    onTap: () async {
                                      final selectedMedia =
                                      await selectMediaWithSourceBottomSheet(context, allowMultiple: false);
                                      if (selectedMedia.isNotEmpty &&
                                          validateFileFormat(selectedMedia.first.path, context)) {
                                        setState(() async {
                                          _selectedImage = File(selectedMedia.first.path);
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: 34,
                                      height: 34,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'assets/images/Group_1918.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(18, 0, 18, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'First Name',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          fontSize: 12,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.sizeOf(context).width * 0.45,
                                        height: 45,
                                        child: TextFormField(
                                          controller: _model.firstNameTextController ??= TextEditingController(
                                            text: nameSeparator(CustomerDetailsCall.customerName(
                                                  columnCustomerDetailsResponse.jsonBody,), 'first'),),
                                          focusNode: _model.firstNameFocusNode,
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                              fontFamily: 'Montserrat',
                                              letterSpacing: 0,
                                            ),
                                            hintText: 'First Name',
                                            hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                              fontFamily: 'Montserrat',
                                              letterSpacing: 0,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFE7E7E8),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(context).primary,
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(context).error,
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(context).error,
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                          ),
                                          keyboardType: TextInputType.name,
                                          validator: _model.firstNameTextControllerValidator.asValidator(context),
                                        ),
                                      )
                                    ].divide(SizedBox(height: 6)),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Last Name',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          fontSize: 12,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      // Generated code for this lastName Widget...
                                      Container(
                                        width: MediaQuery.sizeOf(context).width * 0.45,
                                        height: 45,
                                        child: TextFormField(
                                          controller: _model.lastNameTextController ??= TextEditingController(
                                            text: nameSeparator(
                                                CustomerDetailsCall.customerName(columnCustomerDetailsResponse.jsonBody,
                                                ), 'last'),
                                          ),
                                          focusNode: _model.lastNameFocusNode,
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                              fontFamily: 'Montserrat',
                                              letterSpacing: 0,
                                            ),
                                            hintText: 'Last Name',
                                            hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                              fontFamily: 'Montserrat',
                                              letterSpacing: 0,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFE7E7E8),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(context).primary,
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(context).error,
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(context).error,
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                          ),
                                          keyboardType: TextInputType.name,
                                          validator: _model.lastNameTextControllerValidator.asValidator(context),
                                        ),
                                      )
                                    ].divide(SizedBox(height: 6)),
                                  ),
                                ],
                              ),
                              /*Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 18, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Email Address',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        fontSize: 12,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 42,
                                      decoration: BoxDecoration(),
                                      child: TextFormField(
                                        controller: TextEditingController(
                                          text: CustomerDetailsCall.email(columnCustomerDetailsResponse.jsonBody).toString(),
                                        ),
                                        focusNode: _model.emailFocusNode,
                                        autofocus: false,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                          ),
                                          hintText: 'Email Address',
                                          hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFE7E7E8),
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).primary,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).error,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).error,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 0,
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                        validator: _model.emailTextControllerValidator.asValidator(context),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 6)),
                                ),
                              ),*/
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 18, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Email Address',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        fontSize: 12,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 42,
                                      decoration: BoxDecoration(),
                                      child: TextFormField(
                                        controller: _model.emailTextController ??= TextEditingController(
                                          text: CustomerDetailsCall.email(columnCustomerDetailsResponse.jsonBody)?.toString(),
                                        ),
                                        focusNode: _model.emailFocusNode,
                                        autofocus: false,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                          ),
                                          hintText: 'Email',
                                          hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFE7E7E8),
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).primary,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).error,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).error,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 0,
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                        validator: _model.emailTextControllerValidator.asValidator(context),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 6)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 18, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Phone No.',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        fontSize: 12,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 42,
                                      decoration: BoxDecoration(),
                                      child: TextFormField(
                                        controller:
                                        _model.phoneNoTextController ??=
                                            TextEditingController(
                                              text: CustomerDetailsCall.phone(columnCustomerDetailsResponse.jsonBody,)?.toString(),
                                            ),
                                        focusNode: _model.phoneNoFocusNode,
                                        autofocus: false,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                          ),
                                          hintText: 'Phone No.',
                                          hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFE7E7E8),
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).primary,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).error,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).error,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 0,
                                        ),
                                        keyboardType: TextInputType.phone,
                                        validator: _model.phoneNoTextControllerValidator.asValidator(context),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 6)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 60),
                      child: FFButtonWidget(
                        onPressed: () async {
                          FFAppState().imagePath = _selectedImage.toString();

                          print('FFAppState imagePath: ${FFAppState().imagePath}');
                          // Regular expression to match alphabetic characters
                          final nameRegExp = RegExp(r'^[a-zA-Z]+$');

                          // Validate first and last name
                          if (!nameRegExp.hasMatch(_model.firstNameTextController.text) ||
                              !nameRegExp.hasMatch(_model.lastNameTextController.text)) {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Name should only contain alphabetic characters.',
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor: FlutterFlowTheme.of(context).primary,
                              ),
                            );
                            return;
                          }

                          // Print the details of the API call
                          print('Making API call with the following parameters:');
                          print('Email: ${_model.emailTextController.text}');
                          print('Mobile Number: ${_model.phoneNoTextController.text}');
                          print('Country Code: ${FFAppState().countrycode}');
                          print('Host URL: ${FFAppConstants.hosturl}');
                          print('Customer Name: ${_model.firstNameTextController.text}');
                          print('Token: $currentAuthenticationToken');
                          print('Profile Image: $_selectedImage');
                          print('FFAppState imagePath: ${FFAppState().imagePath}');

                          _model.apiResultt41 = await UpdateCustomerCall.call(
                            email: _model.emailTextController.text,
                            mobileNumber: _model.phoneNoTextController.text,
                            countryCode: FFAppState().countrycode,
                            hosturl: FFAppConstants.hosturl,
                            customerName: joinName(
                              _model.firstNameTextController.text,
                              _model.lastNameTextController.text,
                            ),
                            token: currentAuthenticationToken,
                            imagePath: _selectedImage
                          );

                          final requestData = {
                            'email': _model.emailTextController.text,
                            'mobilenumber': _model.phoneNoTextController.text,
                            'country_code': FFAppState().countrycode,
                            'customer_name': joinName(
                              _model.firstNameTextController.text,
                              _model.lastNameTextController.text,
                            ),
                            'profilepic': _selectedImage
                          };

                          print('Profile Request Body: $requestData');

                          print('API call result: ${_model.apiResultt41?.jsonBody}');
                          print('Phone No. response debug: ${_model.apiResultt41?.response}');
                          print('Phone No. bodyText debug: ${_model.apiResultt41?.bodyText}');
                          print('Profile Image: $_selectedImage');

                          if ((_model.apiResultt41?.succeeded ?? true)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  getJsonField(
                                    (_model.apiResultt41?.jsonBody ?? ''),
                                    r'''$.msg''',).toString(),
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor: FlutterFlowTheme.of(context).primary,
                              ),
                            );
                            context.safePop();
                            // Compare the email and phone to initial values
                            if (_model.emailTextController.text != CustomerDetailsCall.email(columnCustomerDetailsResponse.jsonBody)?.toString() ||
                                _model.phoneNoTextController.text != CustomerDetailsCall.phone(columnCustomerDetailsResponse.jsonBody)?.toString()) {
                              // If email or phone is edited, navigate to login screen
                              print('Email or phone has changed. Navigating to login screen.');
                              GoRouter.of(context).prepareAuthEvent();
                              await authManager.signOut();
                              GoRouter.of(context).clearRedirectLocation();

                              context.goNamedAuth('LoginPage', context.mounted);

                              return;
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  getJsonField(
                                    (_model.apiResultt41?.jsonBody ?? ''),
                                    r'''$.msg''',).toString(),
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor: FlutterFlowTheme.of(context).primary,
                              ),
                            );
                          }

                          setState(() {});
                        },
                        text: 'Update Profile',
                        options: FFButtonOptions(
                          width: double.infinity,
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
                          borderSide: BorderSide(color: FlutterFlowTheme.of(context).primary),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Align(
              alignment: AlignmentDirectional(0, 1),
              child: wrapWithModel(
                model: _model.customNavBarModel,
                updateCallback: () => setState(() {}),
                child: CustomNavBarWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}