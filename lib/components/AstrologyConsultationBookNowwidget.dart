import 'package:rudraksha_cart/components/AstrologyConsultationBookNow_model.dart';

import '../auth/custom_auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../pages/my_cart/my_cart_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



class AstrologyConsultationBookNowWidget extends StatefulWidget {
  const AstrologyConsultationBookNowWidget({super.key});

  @override
  State<AstrologyConsultationBookNowWidget> createState() =>
      _AstrologyConsultationBookNowWidgetState();
}

class _AstrologyConsultationBookNowWidgetState
    extends State<AstrologyConsultationBookNowWidget> {
  late AstrologyConsultationBookNowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AstrologyConsultationBookNowModel());

    _model.enterNameTextController ??= TextEditingController();
    _model.enterNameFocusNode ??= FocusNode();

    _model.enterPlaceofBirthTextController ??= TextEditingController();
    _model.enterPlaceofBirthFocusNode ??= FocusNode();

    _model.enterSpecialInstructionsTextController ??= TextEditingController();
    _model.enterSpecialInstructionsFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              context.safePop();
            },
            child: Container(
              width: 100,
              height: 28,
              decoration: BoxDecoration(
                color: Color(0x00FFFFFF),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/hint.png',
                  width: 72,
                  height: 24,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 706,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        textScaler: MediaQuery.of(context).textScaler,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Book Consultation ',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF272728),
                                fontSize: 16,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: '(45mins- INR 2,800)',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primary,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF272728),
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    child: Container(
                      height: 650,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 28, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        6, 0, 6, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'First Name',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                        TextFormField(
                                          controller:
                                          _model.enterNameTextController,
                                          focusNode: _model.enterNameFocusNode,
                                          autofocus: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelStyle: FlutterFlowTheme.of(
                                                context)
                                                .labelMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primaryText,
                                              fontSize: 16,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            hintText: 'Enter Name',
                                            hintStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              fontSize: 16,
                                              letterSpacing: 1,
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFF868687),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(0),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(0),
                                            ),
                                            errorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .error,
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(0),
                                            ),
                                            focusedErrorBorder:
                                            UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .error,
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(0),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14,
                                            letterSpacing: 0,
                                          ),
                                          validator: _model
                                              .enterNameTextControllerValidator
                                              .asValidator(context),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        6, 0, 6, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Date of Birth',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 12, 0, 12),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              // DatePickerDOB
                                              await showModalBottomSheet<bool>(
                                                  context: context,
                                                  builder: (context) {
                                                    final _datePicked1CupertinoTheme =
                                                    CupertinoTheme.of(
                                                        context);
                                                    return Container(
                                                      height:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                          3,
                                                      width:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                      color: FlutterFlowTheme
                                                          .of(context)
                                                          .secondaryBackground,
                                                      child: CupertinoTheme(
                                                        data:
                                                        _datePicked1CupertinoTheme
                                                            .copyWith(
                                                          textTheme:
                                                          _datePicked1CupertinoTheme
                                                              .textTheme
                                                              .copyWith(
                                                            dateTimePickerTextStyle:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .headlineMedium
                                                                .override(
                                                              fontFamily:
                                                              'Outfit',
                                                              color: FlutterFlowTheme.of(
                                                                  context)
                                                                  .primaryText,
                                                              letterSpacing:
                                                              0,
                                                            ),
                                                          ),
                                                        ),
                                                        child:
                                                        CupertinoDatePicker(
                                                          mode:
                                                          CupertinoDatePickerMode
                                                              .date,
                                                          minimumDate:
                                                          DateTime(1900),
                                                          initialDateTime:
                                                          getCurrentTimestamp,
                                                          maximumDate:
                                                          getCurrentTimestamp,
                                                          backgroundColor:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .secondaryBackground,
                                                          use24hFormat: false,
                                                          onDateTimeChanged:
                                                              (newDateTime) =>
                                                              safeSetState(
                                                                      () {
                                                                    _model.datePicked1 =
                                                                        newDateTime;
                                                                  }),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(),
                                              child: Text(
                                                valueOrDefault<String>(
                                                  dateTimeFormat('yMd',
                                                      _model.datePicked1),
                                                  'Enter Date of Birth',
                                                ),
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily:
                                                  'Montserrat',
                                                  fontSize: 16,
                                                  letterSpacing: 1,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                          thickness: 1,
                                          color: Color(0xFF868687),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      6, 0, 6, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Place of Birth',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color:
                                          FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _model
                                            .enterPlaceofBirthTextController,
                                        focusNode:
                                        _model.enterPlaceofBirthFocusNode,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle: FlutterFlowTheme.of(
                                              context)
                                              .labelMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 16,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          hintText: 'Enter Place of Birth',
                                          hintStyle:
                                          FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16,
                                            letterSpacing: 1,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF868687),
                                              width: 1,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(0),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(0),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(0),
                                          ),
                                          focusedErrorBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(0),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 0,
                                        ),
                                        validator: _model
                                            .enterPlaceofBirthTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        6, 0, 6, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Time of Birth',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 12, 0, 12),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await showModalBottomSheet<bool>(
                                                  context: context,
                                                  builder: (context) {
                                                    final _datePicked2CupertinoTheme =
                                                    CupertinoTheme.of(
                                                        context);
                                                    return Container(
                                                      height:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                          3,
                                                      width:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                      color: FlutterFlowTheme
                                                          .of(context)
                                                          .secondaryBackground,
                                                      child: CupertinoTheme(
                                                        data:
                                                        _datePicked2CupertinoTheme
                                                            .copyWith(
                                                          textTheme:
                                                          _datePicked2CupertinoTheme
                                                              .textTheme
                                                              .copyWith(
                                                            dateTimePickerTextStyle:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .headlineMedium
                                                                .override(
                                                              fontFamily:
                                                              'Outfit',
                                                              color: FlutterFlowTheme.of(
                                                                  context)
                                                                  .primaryText,
                                                              letterSpacing:
                                                              0,
                                                            ),
                                                          ),
                                                        ),
                                                        child:
                                                        CupertinoDatePicker(
                                                          mode:
                                                          CupertinoDatePickerMode
                                                              .time,
                                                          minimumDate:
                                                          DateTime(1900),
                                                          initialDateTime:
                                                          getCurrentTimestamp,
                                                          maximumDate:
                                                          DateTime(2050),
                                                          backgroundColor:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .secondaryBackground,
                                                          use24hFormat: false,
                                                          onDateTimeChanged:
                                                              (newDateTime) =>
                                                              safeSetState(
                                                                      () {
                                                                    _model.datePicked2 =
                                                                        newDateTime;
                                                                  }),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(),
                                              child: Text(
                                                valueOrDefault<String>(
                                                  dateTimeFormat(
                                                      'jm', _model.datePicked2),
                                                  '--:-- --',
                                                ),
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily:
                                                  'Montserrat',
                                                  fontSize: 16,
                                                  letterSpacing: 0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                          thickness: 1,
                                          color: Color(0xFF868687),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        6, 0, 6, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Purpose',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                        FlutterFlowDropDown<String>(
                                          controller: _model
                                              .enterSpecialInstructionsValueController ??=
                                              FormFieldController<String>(null),
                                          options: ['Health', 'Career', 'Education', 'Marriage', 'Overall Wellbeing'],
                                          onChanged: (val) => setState(() =>
                                          _model.enterSpecialInstructionsValue =
                                              val),
                                          width: double.infinity,
                                          height: 56,
                                          textStyle:
                                          FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16,
                                            letterSpacing: 0,
                                          ),
                                          hintText: 'Select Purpose',
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 24,
                                          ),
                                          fillColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          elevation: 2,
                                          borderColor: Colors.transparent,
                                          borderWidth: 2,
                                          borderRadius: 0,
                                          margin:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 0),
                                          isOverButton: true,
                                          isSearchable: false,
                                          isMultiSelect: false,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        6, 0, 6, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Concerns in Detail',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF868687),
                                            letterSpacing: 0,
                                          ),
                                        ),
                                        TextFormField(
                                          controller: _model
                                              .enterSpecialInstructionsTextController,
                                          focusNode: _model
                                              .enterSpecialInstructionsFocusNode,
                                          autofocus: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelStyle: FlutterFlowTheme.of(
                                                context)
                                                .labelMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primaryText,
                                              fontSize: 16,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            hintText: 'Concerns in Detail',
                                            hintStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              fontSize: 16,
                                              letterSpacing: 1,
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFF868687),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(0),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(0),
                                            ),
                                            errorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .error,
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(0),
                                            ),
                                            focusedErrorBorder:
                                            UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .error,
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(0),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                          ),
                                          validator: _model
                                              .enterSpecialInstructionsTextControllerValidator
                                              .asValidator(context),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(height: 16)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 5, 8),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        context.pop();
                                      },
                                      text: 'Cancel',
                                      options: FFButtonOptions(
                                        height: 48,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24, 0, 24, 0),
                                        iconPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                        color: Colors.white,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0,
                                        ),
                                        elevation: 0,
                                        borderSide: BorderSide(
                                          color: Color(0xFFE7E7E8),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 8),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        if (currentAuthenticationToken != null &&
                                            currentAuthenticationToken != '') {
                                          //print("_model.selectedid${_model.selectedid}");
                                          var _shouldSetState = false;
                                          _model.apiResultj7i2 =
                                          await AddToCartCall.call(
                                            hosturl: FFAppConstants.sanityurl,
                                            token: currentAuthenticationToken,
                                            productid:  "8",
                                            productType: "6",
                                            //productvariation:false,
                                            dob: _model.datePicked1.toString(),
                                            tob: _model.datePicked2.toString(),
                                            pob: _model.datePicked3.toString(),
                                            personName: _model.enterNameTextController.toString(),
                                            sankalp: _model.enterSpecialInstructionsValueController.toString(),
                                            specialInstructions: _model.enterSpecialInstructionsTextController.toString()

                                          );

                                          _shouldSetState = true;
                                          if ((_model.apiResultj7i2?.succeeded ??
                                              true)) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  getJsonField(
                                                    (_model.apiResultj7i2
                                                        ?.jsonBody ??
                                                        ''),
                                                    r'''$.msg''',
                                                  ).toString(),
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .primaryBackground,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                            );
                                            if (getJsonField(
                                              (_model.apiResultj7i2
                                                  ?.jsonBody ??
                                                  ''),
                                              r'''$.status''',
                                            ).toString() !=
                                                "failed")
                                              await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                Colors.transparent,
                                                enableDrag: false,
                                                context: context,
                                                builder: (context) {
                                                  return GestureDetector(
                                                    onTap: () => _model
                                                        .unfocusNode
                                                        .canRequestFocus
                                                        ? FocusScope.of(context)
                                                        .requestFocus(_model
                                                        .unfocusNode)
                                                        : FocusScope.of(context)
                                                        .unfocus(),
                                                    child: Padding(
                                                      padding: MediaQuery
                                                          .viewInsetsOf(
                                                          context),
                                                      child: MyCartWidget(),
                                                    ),
                                                  );
                                                },
                                              ).then((value) =>
                                                  safeSetState(() {}));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  getJsonField(
                                                    (_model.apiResultj7i2
                                                        ?.jsonBody ??
                                                        ''),
                                                    r'''$.msg''',
                                                  ).toString(),
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .primaryBackground,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                            );
                                            if (_shouldSetState)
                                              setState(() {});
                                            return;
                                          }

                                          setState(() {});
                                          if (_shouldSetState) setState(() {});
                                          context.pop();
                                        } else {
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
                                        }
                                      },
                                      text: 'Book',
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: 48,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                        iconPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                        color: Color(0xFF740074),
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
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
