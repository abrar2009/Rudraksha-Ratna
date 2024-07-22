import 'package:cached_network_image/cached_network_image.dart';

import '../../auth/custom_auth/auth_util.dart';
import '../../components/logout_confirmation_widget.dart';
import '../../flutter_flow/custom_functions.dart';
import '../../flutter_flow/flutter_flow_drop_down.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_nav_bar_widget.dart';
import '/components/shimmer_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'homepage_model.dart';
export 'homepage_model.dart';

class HomepageWidget extends StatefulWidget {
  const HomepageWidget({super.key});

  @override
  State<HomepageWidget> createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends State<HomepageWidget> {
  late HomepageModel _model;
  final authToken = currentAuthenticationToken;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool expandableListenerRegistered = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomepageModel());

    _model.expandableExpandableController =
        ExpandableController(initialExpanded: false);
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
        key: scaffoldKey,
        backgroundColor: Colors.white,
        drawer: Drawer(
          elevation: 16.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 10.0, 24.0, 28.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/image_29_(1).png',
                                width: double.infinity,
                                height: 91.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FutureBuilder<ApiCallResponse>(
                                future: CurrencyCall.call(
                                  sanityurl: FFAppConstants.sanityurl,
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                          AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context).primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  final currencyDropDownCurrencyResponse = snapshot.data!;
                                  return FlutterFlowDropDown<String>(
                                    controller: _model.currencyDropDownValueController ??= FormFieldController<String>(
                                          _model.currencyDropDownValue ??= 'INR',),
                                    options: (getJsonField(
                                      currencyDropDownCurrencyResponse.jsonBody,
                                      r'''$.currency_data[:].currency_type''',
                                      true,
                                    ) as List)
                                        .map<String>((s) => s.toString())
                                        .toList()!,
                                    onChanged: (val) async {
                                      setState(() =>
                                      _model.currencyDropDownValue = val);
                                      FFAppState().currencyName =
                                      _model.currencyDropDownValue!;
                                      FFAppState().currencyRate =
                                      functions.currencyRateByName(
                                          getJsonField(
                                            currencyDropDownCurrencyResponse
                                                .jsonBody,
                                            r'''$.currency_data''',
                                            true,
                                          )!,
                                          FFAppState().currencyName)!;
                                      setState(() {
                                        print('Selected Currency Name: ${FFAppState().currencyName}');
                                      });
                                    },
                                    width: 300,
                                    height: 56,
                                    maxHeight: 350,
                                    searchHintTextStyle:
                                    FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                    ),
                                    searchTextStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                    ),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                    ),
                                    hintText: 'INR',
                                    searchHintText: 'Search',
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 24,
                                    ),
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    elevation: 2,
                                    borderColor:
                                    FlutterFlowTheme.of(context).alternate,
                                    borderWidth: 2,
                                    borderRadius: 8,
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        16, 4, 16, 4),
                                    hidesUnderline: true,
                                    isOverButton: true,
                                    isSearchable: true,
                                    isMultiSelect: false,
                                  );
                                },
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              /*InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    'Wishlist',
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType:
                                        PageTransitionType.rightToLeft,
                                        duration: Duration(milliseconds: 400),
                                      ),
                                    },
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 48.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    border: Border.all(
                                      color: Color(0xFFE7E7E8),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        17.0, 0.0, 18.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                Radius.circular(0.0),
                                                bottomRight:
                                                Radius.circular(0.0),
                                                topLeft: Radius.circular(0.0),
                                                topRight: Radius.circular(0.0),
                                              ),
                                              child: Image.asset(
                                                'assets/images/Star.png',
                                                width: 24.0,
                                                height: 24.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Text(
                                              'My Rewards',
                                              style: FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                color: FlutterFlowTheme.of(
                                                    context)
                                                    .primaryText,
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 10.0)),
                                        ),
                                        Text(
                                          'Bal: 742',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 10.0)),
                                    ),
                                  ),
                                ),
                              ),*/
                              if(currentAuthenticationToken != null)
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
                                          valueColor:
                                          AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  final containerCustomerDetailsResponse =
                                  snapshot.data!;

                                  return Container(
                                    width: double.infinity,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      border: Border.all(
                                        color: Color(0xFFE7E7E8),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          17, 0, 18, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                BorderRadius.only(
                                                  bottomLeft:
                                                  Radius.circular(0),
                                                  bottomRight:
                                                  Radius.circular(0),
                                                  topLeft: Radius.circular(0),
                                                  topRight:
                                                  Radius.circular(0),
                                                ),
                                                child: Image.asset(
                                                  'assets/images/Star.png',
                                                  width: 24,
                                                  height: 24,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Text(
                                                'My Rewards',
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily:
                                                  'Montserrat',
                                                  color:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .primaryText,
                                                  fontSize: 15,
                                                  letterSpacing: 0,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 10)),
                                          ),
                                          Text(
                                            'Bal: ${getJsonField(
                                              containerCustomerDetailsResponse
                                                  .jsonBody,
                                              r'''$.data.reward_points''',
                                            ).toStringAsFixed(0)}',
                                            style: FlutterFlowTheme.of(
                                                context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primary,
                                              fontSize: 15,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 10)),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Container(
                                width: double.infinity,
                                height: 48.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  border: Border.all(
                                    color: Color(0xFFE7E7E8),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      18.0, 0.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(0.0),
                                          bottomRight: Radius.circular(0.0),
                                          topLeft: Radius.circular(0.0),
                                          topRight: Radius.circular(0.0),
                                        ),
                                        child: Image.asset(
                                          'assets/images/Category.png',
                                          width: 20.0,
                                          height: 20.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        'Shop By Categories',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 15.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 10.0)),
                                  ),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    'Wishlist',
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType:
                                        PageTransitionType.rightToLeft,
                                        duration: Duration(milliseconds: 400),
                                      ),
                                    },
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 48.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    border: Border.all(
                                      color: Color(0xFFE7E7E8),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        17.0, 0.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(0.0),
                                            bottomRight: Radius.circular(0.0),
                                            topLeft: Radius.circular(0.0),
                                            topRight: Radius.circular(0.0),
                                          ),
                                          child: Image.asset(
                                            'assets/images/DrawerHeart.png',
                                            width: 24.0,
                                            height: 24.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          'Wishlist',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 10.0)),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    'MyOrders',
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType:
                                        PageTransitionType.rightToLeft,
                                        duration: Duration(milliseconds: 400),
                                      ),
                                    },
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 48.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    border: Border.all(
                                      color: Color(0xFFE7E7E8),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        17.0, 0.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(0.0),
                                            bottomRight: Radius.circular(0.0),
                                            topLeft: Radius.circular(0.0),
                                            topRight: Radius.circular(0.0),
                                          ),
                                          child: Image.asset(
                                            'assets/images/Bag_2.png',
                                            height: 22.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          'My Orders',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 10.0)),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 48.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  border: Border.all(
                                    color: Color(0xFFE7E7E8),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      18.0, 0.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(0.0),
                                          bottomRight: Radius.circular(0.0),
                                          topLeft: Radius.circular(0.0),
                                          topRight: Radius.circular(0.0),
                                        ),
                                        child: Image.asset(
                                          'assets/images/Time_Circle.png',
                                          width: 18.5,
                                          height: 18.5,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        'Track Orders',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 15.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 10.0)),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 48.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  border: Border.all(
                                    color: Color(0xFFE7E7E8),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      18.0, 0.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(0.0),
                                          bottomRight: Radius.circular(0.0),
                                          topLeft: Radius.circular(0.0),
                                          topRight: Radius.circular(0.0),
                                        ),
                                        child: Image.asset(
                                          'assets/images/Notification.png',
                                          width: 17.0,
                                          height: 20.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        'Notifications',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 15.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 10.0)),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  border: Border.all(
                                    color: Color(0xFFE7E7E8),
                                  ),
                                ),
                                child: Builder(builder: (_) {
                                  if (!expandableListenerRegistered) {
                                    expandableListenerRegistered = true;
                                    _model.expandableExpandableController
                                        .addListener(
                                          () async {
                                        _model.textColor = !_model.textColor;
                                        setState(() {});
                                      },
                                    );
                                  }
                                  return Container(
                                    width: double.infinity,
                                    color: Colors.white,
                                    child: ExpandableNotifier(
                                      controller:
                                      _model.expandableExpandableController,
                                      child: ExpandablePanel(
                                        header: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              15.0, 0.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Icon(
                                                Icons.info_outline,
                                                color: valueOrDefault<Color>(
                                                  _model.textColor == true
                                                      ? FlutterFlowTheme.of(
                                                      context)
                                                      .primaryText
                                                      : FlutterFlowTheme.of(
                                                      context)
                                                      .primary,
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                                ),
                                              ),
                                              Text(
                                                'Brand Info',
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color:
                                                  valueOrDefault<Color>(
                                                    _model.textColor == true
                                                        ? FlutterFlowTheme
                                                        .of(context)
                                                        .primaryText
                                                        : FlutterFlowTheme
                                                        .of(context)
                                                        .primary,
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .primaryText,
                                                  ),
                                                  fontSize: 15.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 10.0)),
                                          ),
                                        ),
                                        collapsed: Container(),
                                        expanded: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              52.0, 5.0, 0.0, 10.0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Articles',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF272728),
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  'Testimonials',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF272728),
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  'Careers',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF272728),
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  'Our Team',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF272728),
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  'Contact Us',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF272728),
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  'About Us',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF272728),
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  'Policy',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF272728),
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 16.0)),
                                            ),
                                          ),
                                        ),
                                        theme: ExpandableThemeData(
                                          tapHeaderToExpand: true,
                                          tapBodyToExpand: false,
                                          tapBodyToCollapse: false,
                                          headerAlignment:
                                          ExpandablePanelHeaderAlignment
                                              .center,
                                          hasIcon: true,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  /*Container(
                    width: double.infinity,
                    height: 48.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      border: Border.all(
                        color: Color(0xFFE7E7E8),
                      ),
                    ),
                    child: Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(18.0, 0.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(0.0),
                              topLeft: Radius.circular(0.0),
                              topRight: Radius.circular(0.0),
                            ),
                            child: Image.asset(
                              'assets/images/Logout.png',
                              width: 19.04,
                              height: 18.5,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Logout',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF272728),
                              fontSize: 15.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ].divide(SizedBox(width: 10.0)),
                      ),
                    ),
                  ),*/
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text('App Version: 1.0.0',
                        style: TextStyle(
                            color: FlutterFlowTheme.of(context).productName
                        )),
                      ),
                      Builder(
                        builder: (context) {
                          if (currentAuthenticationToken != null &&
                              currentAuthenticationToken != '') {
                            return InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {

                                /*GoRouter.of(context).prepareAuthEvent();
                                await authManager.signOut();
                                GoRouter.of(context).clearRedirectLocation();

                                // Navigate to the login page and remove all previous routes
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  'LoginPage',
                                      (Route<dynamic> route) => false,
                                  arguments: <String, dynamic>{
                                    kTransitionInfoKey: TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.bottomToTop,
                                      duration: Duration(milliseconds: 400),
                                    ),
                                  },
                                );*/
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return GestureDetector(
                                      onTap: () => _model.unfocusNode.canRequestFocus
                                          ? FocusScope.of(context)
                                          .requestFocus(_model.unfocusNode)
                                          : FocusScope.of(context).unfocus(),
                                      child: Padding(
                                        padding: MediaQuery.viewInsetsOf(context),
                                        child: const LogoutConfirmationWidget(),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: Container(
                                width: double.infinity,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  border: Border.all(
                                    color: Color(0xFFE7E7E8),
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0),
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                        ),
                                        child: Image.asset(
                                          'assets/images/Logout.png',
                                          width: 19.04,
                                          height: 18.5,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        'Logout',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF272728),
                                          fontSize: 15,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 10)),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  'LoginPage',
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: TransitionInfo(
                                      hasTransition: true,
                                      transitionType:
                                      PageTransitionType.bottomToTop,
                                      duration: Duration(milliseconds: 400),
                                    ),
                                  },
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  border: Border.all(
                                    color: Color(0xFFE7E7E8),
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        Icons.login_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24,
                                      ),
                                      Text(
                                        'Login',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF272728),
                                          fontSize: 15,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 10)),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 90.0, 0.0, 56.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 32.0,
                      decoration: BoxDecoration(
                        color: Color(0x34740074),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 32.0,
                        child: custom_widgets.MarqueeText(
                          width: double.infinity,
                          height: 32.0,
                          text:
                          'Worldwide Fast & Safe Delivery | Oldest ISO 9001-2015 certified rudraksha organization in the world | Your Trusted Brand Since 1997.                                      ',
                          speed: 100,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        height: 189.0,
                        decoration: BoxDecoration(
                          color:
                          FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Stack(
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(-1.98, 0.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Image.asset(
                                        'assets/images/placeholder.png',
                                        width: 327.0,
                                        height: 189.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, -0.77),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        'Perform Homas Yagnas by \nExperienced Shastri \nPriests',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment:
                                    AlignmentDirectional(-0.71, 0.63),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 0.0, 0.0, 0.0),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          print('Authentication Token: $authToken');
                                          //context.pushNamed('test');
                                        },
                                        text: 'Book Now',
                                        options: FFButtonOptions(
                                          height: 33.0,
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context).primary,
                                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 5.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          elevation: 0.0,
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(6.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment:
                                      AlignmentDirectional(-1.98, 0.0),
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(16.0),
                                        child: Image.asset(
                                          'assets/images/placeholder.png',
                                          width: 327.0,
                                          height: 189.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                      AlignmentDirectional(0.0, -0.77),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          'Perform Homas Yagnas by \nExperienced Shastri \nPriests',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                      AlignmentDirectional(-0.71, 0.63),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 0.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () {
                                            print('Button pressed ...');
                                          },
                                          text: 'Book Now',
                                          options: FFButtonOptions(
                                            height: 33.0,
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFF740074),
                                            textStyle:
                                            FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.white,
                                              fontSize: 5.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(6.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment:
                                      AlignmentDirectional(-1.98, 0.0),
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(16.0),
                                        child: Image.asset(
                                          'assets/images/placeholder.png',
                                          width: 327.0,
                                          height: 189.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                      AlignmentDirectional(0.0, -0.77),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          'Perform Homas Yagnas by \nExperienced Shastri \nPriests',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                      AlignmentDirectional(-0.71, 0.63),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 0.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () {
                                            print('Button pressed ...');
                                          },
                                          text: 'Book Now',
                                          options: FFButtonOptions(
                                            height: 33.0,
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFF740074),
                                            textStyle:
                                            FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.white,
                                              fontSize: 5.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(6.0),
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
                    Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 28.0, 16.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        height: 380.0,
                        decoration: BoxDecoration(
                          color:
                          FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Explore Products',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF740074),
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      'CategoriesListViewChooseChip',
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                          PageTransitionType.rightToLeft,
                                          duration: Duration(milliseconds: 400),
                                        ),
                                      },
                                    );
                                  },
                                  child: Text(
                                    'See all',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF696969),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            FutureBuilder<ApiCallResponse>(
                              future: ExploreCategoryListCall.call(
                                sanityurl: FFAppConstants.sanityurl,
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Container(
                                    height: 25.0,
                                    child: ShimmerWidget(),
                                  );
                                }
                                final choiceChipsExploreCategoryListResponse =
                                snapshot.data!;
                                return FlutterFlowChoiceChips(
                                  options: (getJsonField(
                                    choiceChipsExploreCategoryListResponse
                                        .jsonBody,
                                    r'''$.categorydata[:].category''',
                                    true,
                                  ) as List)
                                      .map<String>((s) => s.toString())
                                      .toList()!
                                      .map((label) => ChipData(label))
                                      .toList(),
                                  onChanged: (val) async {
                                    setState(() => _model.choiceChipsValue =
                                        val?.firstOrNull);
                                    _model.iD = functions.chipsId(
                                        _model.choiceChipsValue!,
                                        getJsonField(
                                          choiceChipsExploreCategoryListResponse
                                              .jsonBody,
                                          r'''$.categorydata''',
                                          true,
                                        )!)!;
                                    setState(() {});
                                  },
                                  selectedChipStyle: ChipStyle(
                                    backgroundColor: Colors.white,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context)
                                          .primary,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    iconColor: Color(0x00000000),
                                    iconSize: 18.0,
                                    labelPadding:
                                    EdgeInsetsDirectional.fromSTEB(
                                        16.0, 4.0, 16.0, 4.0),
                                    elevation: 0.0,
                                    borderColor:
                                    FlutterFlowTheme.of(context).primary,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  unselectedChipStyle: ChipStyle(
                                    backgroundColor: Colors.white,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF222222),
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    iconColor: Color(0x00000000),
                                    iconSize: 18.0,
                                    labelPadding:
                                    EdgeInsetsDirectional.fromSTEB(
                                        16.0, 4.0, 16.0, 4.0),
                                    elevation: 0.0,
                                    borderColor: Color(0xFF868687),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  chipSpacing: 12.0,
                                  rowSpacing: 12.0,
                                  multiselect: false,
                                  initialized: _model.choiceChipsValue != null,
                                  alignment: WrapAlignment.start,
                                  controller:
                                  _model.choiceChipsValueController ??=
                                      FormFieldController<List<String>>(
                                        ['Rudraksha'],
                                      ),
                                  wrapped: false,
                                );
                              },
                            ),
                            /*Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      FutureBuilder<ApiCallResponse>(
                                        future: ExploreProductsCall.call(
                                          sanityurl: FFAppConstants.sanityurl,
                                          id: valueOrDefault<String>(
                                            _model.iD, '8',
                                          ),
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Container(
                                              width: 160.0,
                                              height: 292.0,
                                              child: ShimmerWidget(),
                                            );
                                          }
                                          final listViewExploreProductsResponse =
                                          snapshot.data!;
                                          return Builder(
                                            builder: (context) {
                                              final productsList = getJsonField(
                                                listViewExploreProductsResponse
                                                    .jsonBody,
                                                r'''$.data''',
                                              ).toList();
                                              return ListView.separated(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection:
                                                Axis.horizontal,
                                                itemCount: productsList.length,
                                                separatorBuilder: (_, __) =>
                                                    SizedBox(width: 10.0),
                                                itemBuilder: (context,
                                                    productsListIndex) {
                                                  final productsListItem =
                                                  productsList[
                                                  productsListIndex];
                                                  return InkWell(
                                                    splashColor:
                                                    Colors.transparent,
                                                    focusColor:
                                                    Colors.transparent,
                                                    hoverColor:
                                                    Colors.transparent,
                                                    highlightColor:
                                                    Colors.transparent,
                                                    onTap: () async {
                                                      context.pushNamed(
                                                        'ProductDetails',
                                                        queryParameters: {
                                                          'productslugvalue':
                                                          serializeParam(
                                                            _model.productslugvalue,
                                                            ParamType.String,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String,
                                                            dynamic>{
                                                          kTransitionInfoKey:
                                                          TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType:
                                                            PageTransitionType
                                                                .bottomToTop,
                                                            duration: Duration(
                                                                milliseconds:
                                                                400),
                                                          ),
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      width: 170.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                        BorderRadius.only(
                                                          bottomLeft:
                                                          Radius.circular(
                                                              0.0),
                                                          bottomRight:
                                                          Radius.circular(
                                                              0.0),
                                                          topLeft:
                                                          Radius.circular(
                                                              16.0),
                                                          topRight:
                                                          Radius.circular(
                                                              16.0),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0.0,
                                                                0.0,
                                                                0.0,
                                                                12.0),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                    16.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                    16.0),
                                                                topLeft: Radius
                                                                    .circular(
                                                                    16.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                    16.0),
                                                              ),
                                                              child:
                                                              Image.network(
                                                                getJsonField(
                                                                  productsListItem,
                                                                  r'''$.thumbnail''',
                                                                ).toString(),
                                                                height: 198.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                AlignmentDirectional(
                                                                    -1.0,
                                                                    0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      8.0),
                                                                  child: Text(
                                                                    getJsonField(
                                                                      productsListItem,
                                                                      r'''$.productname''',
                                                                    ).toString(),
                                                                    maxLines: 2,
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodyMedium
                                                                        .override(
                                                                      fontFamily:
                                                                      'Montserrat',
                                                                      color:
                                                                      Color(0xFF696969),
                                                                      fontSize:
                                                                      15.0,
                                                                      letterSpacing:
                                                                      0.0,
                                                                      lineHeight:
                                                                      1.5,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment: AlignmentDirectional(-1, 0),
                                                                child: Text(
                                                                  '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(
                                                                    getJsonField(productsListItem, r'''$.selling_price''').toString(),
                                                                    FFAppState().currencyRate,
                                                                  )}',
                                                                  textAlign: TextAlign.start,
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    fontFamily: 'Montserrat',
                                                                    color: Colors.black,
                                                                    fontSize: 16,
                                                                    letterSpacing: 0,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 0.0, 0.0),
                                        child: Container(
                                          width: 160.0,
                                          height: 198.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                            BorderRadius.circular(16.0),
                                            border: Border.all(
                                              color: Color(0xFF740074),
                                              width: 2.0,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'View all',
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF740074),
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                              ),
                                              Icon(
                                                Icons
                                                    .arrow_circle_right_outlined,
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                                size: 30.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),*/
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      FutureBuilder<ApiCallResponse>(
                                        future: ExploreProductsCall.call(
                                          sanityurl: FFAppConstants.sanityurl,
                                          id: valueOrDefault<String>(
                                            _model.iD,
                                            '8',
                                          ),
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Container(
                                              width: 160,
                                              height: 292,
                                              child: ShimmerWidget(),
                                            );
                                          }
                                          final listViewExploreProductsResponse =
                                          snapshot.data!;
                                          return Builder(
                                            builder: (context) {
                                              final productsList = getJsonField(
                                                listViewExploreProductsResponse
                                                    .jsonBody,
                                                r'''$.data''',
                                              ).toList();
                                              return ListView.separated(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection:
                                                Axis.horizontal,
                                                itemCount: productsList.length,
                                                separatorBuilder: (_, __) =>
                                                    SizedBox(width: 10),
                                                itemBuilder: (context,
                                                    productsListIndex) {
                                                  final productsListItem =
                                                  productsList[
                                                  productsListIndex];
                                                  return InkWell(
                                                    splashColor:
                                                    Colors.transparent,
                                                    focusColor:
                                                    Colors.transparent,
                                                    hoverColor:
                                                    Colors.transparent,
                                                    highlightColor:
                                                    Colors.transparent,
                                                    onTap: () async {
                                                      //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsWidget( productSlugValue: _model.productslugvalue,)));

                                                      _model.apiResulth6o = await SlugSearchCall.call(
                                                        hosturl: FFAppConstants.hosturl,
                                                        slugValue: getJsonField(
                                                          productsListItem,
                                                          r'''$.slug_value''',
                                                        ).toString(),
                                                      );
                                                      _model.mainprodtype = SlugSearchCall.datamainprodtype(
                                                        (_model.apiResulth6o?.jsonBody ?? ''),
                                                      );
                                                      _model.level = SlugSearchCall.datalevel(
                                                        (_model.apiResulth6o?.jsonBody ?? ''),
                                                      );
                                                      _model.productlist = SlugSearchCall.dataproductlist(
                                                        (_model.apiResulth6o?.jsonBody ?? ''),
                                                      )!;
                                                      setState(() {
                                                        print("_model.mainprodtype${_model.mainprodtype}");
                                                        print("_model.level${_model.level}");
                                                        print("_model.productlist${_model.productlist}");

                                                      });
                                                      if(_model.mainprodtype==5)
                                                      { context.pushNamed(
                                                        'OtherProductDetails',
                                                        queryParameters: {
                                                          'productSlugValue': serializeParam(
                                                            getJsonField(
                                                              productsListItem,
                                                              r'''$.slug_value''',
                                                            ).toString(),
                                                            ParamType.String,
                                                          ),'producttype': FFAppConstants.RudrakshaMasterProductDetailsApi,

                                                        }.withoutNulls,
                                                        extra: <String, dynamic>{
                                                          kTransitionInfoKey: TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType: PageTransitionType.bottomToTop,
                                                            duration: Duration(milliseconds: 400),
                                                          ),
                                                        },
                                                      );}
                                                      else if(_model.mainprodtype==3)
                                                      { context.pushNamed(
                                                        'DiamondProductDetails',
                                                        queryParameters: {
                                                          'productSlugValue': serializeParam(
                                                            getJsonField(
                                                              productsListItem,
                                                              r'''$.slug_value''',
                                                            ).toString(),
                                                            ParamType.String,
                                                          ),'producttype': FFAppConstants.RudrakshaMasterProductDetailsApi,

                                                        }.withoutNulls,
                                                        extra: <String, dynamic>{
                                                          kTransitionInfoKey: TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType: PageTransitionType.bottomToTop,
                                                            duration: Duration(milliseconds: 400),
                                                          ),
                                                        },
                                                      );}
                                                      else if(_model.mainprodtype==4)
                                                      {
                                                        context.pushNamed(
                                                          'YantraProductDetails',
                                                          queryParameters: {
                                                            'productSlugValue':
                                                            serializeParam(
                                                              getJsonField(
                                                                productsListItem,
                                                                r'''$.slug_value''',
                                                              ).toString(),
                                                              ParamType.String,
                                                            ),
                                                            'producttype': FFAppConstants
                                                                .YantraMasterProductDetailsApi,
                                                          }.withoutNulls,
                                                        );
                                                      }
                                                      else
                                                      { context.pushNamed(
                                                        'DiamondProductDetails',
                                                        queryParameters: {
                                                          'productSlugValue': serializeParam(
                                                            getJsonField(
                                                              productsListItem,
                                                              r'''$.slug_value''',
                                                            ).toString(),
                                                            ParamType.String,
                                                          ),'producttype': FFAppConstants.GemstoneMasterProductDetailsApi,

                                                        }.withoutNulls,
                                                        extra: <String, dynamic>{
                                                          kTransitionInfoKey: TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType: PageTransitionType.bottomToTop,
                                                            duration: Duration(milliseconds: 400),
                                                          ),
                                                        },
                                                      );}
                                                      /*  context.pushNamed(
                                                        'ProductDetails',
                                                        queryParameters: {
                                                          'productslugvalue': serializeParam(
                                                            getJsonField(
                                                              productsListItem,
                                                              _model.productslugvalue,
                                                            ).toString(),
                                                            ParamType.String,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String, dynamic>{
                                                          kTransitionInfoKey: TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType: PageTransitionType.bottomToTop,
                                                            duration: Duration(milliseconds: 400),
                                                          ),
                                                        },
                                                      );*/
                                                    },
                                                    child: Container(
                                                      width: 170,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                        BorderRadius.only(
                                                          bottomLeft:
                                                          Radius.circular(
                                                              0),
                                                          bottomRight:
                                                          Radius.circular(
                                                              0),
                                                          topLeft:
                                                          Radius.circular(
                                                              16),
                                                          topRight:
                                                          Radius.circular(
                                                              16),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0,
                                                                0,
                                                                0,
                                                                12),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                    16),
                                                                bottomRight:
                                                                Radius
                                                                    .circular(
                                                                    16),
                                                                topLeft: Radius
                                                                    .circular(
                                                                    16),
                                                                topRight: Radius
                                                                    .circular(
                                                                    16),
                                                              ),
                                                              child:
                                                              CachedNetworkImage(
                                                                fadeInDuration: Duration(milliseconds: 100),
                                                                fadeOutDuration: Duration(milliseconds: 100),
                                                                imageUrl:
                                                                getJsonField(
                                                                  productsListItem,
                                                                  r'''$.thumbnail''',
                                                                ).toString(),
                                                                height: 198,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                AlignmentDirectional(-1, 0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                                                  child: Text(
                                                                    getJsonField(productsListItem, r'''$.productname''',).toString(),
                                                                    maxLines: 2,
                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                      fontFamily: 'Montserrat',
                                                                      color: FlutterFlowTheme.of(context).Productnamecolor,
                                                                      fontSize: 15,
                                                                      letterSpacing: 0,
                                                                      lineHeight: 1.5,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                AlignmentDirectional(
                                                                    -1, 0),
                                                                child: /*Text(
                                                                  'INR ${getJsonField(
                                                                    productsListItem,
                                                                    r'''$.selling_price''',
                                                                  ).toString()}',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .start,
                                                                  style: FlutterFlowTheme.of(
                                                                      context)
                                                                      .bodyMedium
                                                                      .override(
                                                                    fontFamily:
                                                                    'Montserrat',
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                    16,
                                                                    letterSpacing:
                                                                    0,
                                                                    fontWeight:
                                                                    FontWeight.w600,
                                                                  ),
                                                                ),*/
                                                                Text('${valueOrDefault<String>(FFAppState().currencyName, 'INR',)} '
                                                                    '${formatNumber(functions.currencyConversion(FFAppState().currencyRate, getJsonField(productsListItem, r'''$.selling_price''',).toString()),
                                                                  formatType: FormatType.decimal,
                                                                  decimalType: DecimalType.automatic,
                                                                )}',
                                                                  textAlign: TextAlign.start,
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    fontFamily: 'Montserrat',
                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                    fontSize: 18,
                                                                    letterSpacing: 0,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 0, 0),
                                        child: InkWell(
                                          onTap: (){
                                            context.pushNamed(
                                              'CategoriesListViewChooseChip',
                                              extra: <String, dynamic>{
                                                kTransitionInfoKey: TransitionInfo(
                                                  hasTransition: true,
                                                  transitionType:
                                                  PageTransitionType.rightToLeft,
                                                  duration: Duration(milliseconds: 400),
                                                ),
                                              },
                                            );
                                          },
                                          child: Container(
                                            width: 160,
                                            height: 198,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                              borderRadius:
                                              BorderRadius.circular(16),
                                              border: Border.all(
                                                color: FlutterFlowTheme.of(context).primary,
                                                width: 2,
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'View all',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: FlutterFlowTheme.of(context).primary,
                                                    fontSize: 16,
                                                    letterSpacing: 0,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_circle_right_outlined,
                                                  color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                  size: 30,
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
                            ),
                          ].divide(SizedBox(height: 12.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        height: 189.0,
                        decoration: BoxDecoration(
                          color:
                          FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.asset(
                            'assets/images/Group_1872.png',
                            width: 300.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 10.0),
                      child: Container(
                        width: double.infinity,
                        //height: 440.0,
                        decoration: BoxDecoration(
                          color:
                          FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 12.0),
                              child: Text(
                                'Product Categories',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF740074),
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            /*Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Image.asset(
                                        'assets/images/image_24.png',
                                        width: () {
                                          if (MediaQuery.sizeOf(context)
                                              .width <=
                                              375.0) {
                                            return 160.0;
                                          } else if (MediaQuery.sizeOf(context)
                                              .width <=
                                              400.0) {
                                            return 170.0;
                                          } else if (MediaQuery.sizeOf(context)
                                              .width <=
                                              430.0) {
                                            return 190.0;
                                          } else if (MediaQuery.sizeOf(context)
                                              .width <=
                                              393.0) {
                                            return 175.0;
                                          } else {
                                            return 165.0;
                                          }
                                        }(),
                                        height: () {
                                          if (MediaQuery.sizeOf(context)
                                              .height <=
                                              375.0) {
                                            return 160.0;
                                          } else if (MediaQuery.sizeOf(context)
                                              .height <=
                                              400.0) {
                                            return 180.0;
                                          } else if (MediaQuery.sizeOf(context)
                                              .height <=
                                              430.0) {
                                            return 195.0;
                                          } else if (MediaQuery.sizeOf(context)
                                              .height <=
                                              393.0) {
                                            return 175.0;
                                          } else {
                                            return 165.0;
                                          }
                                        }(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      'Silver Idols',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 8.0)),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Image.asset(
                                        'assets/images/image_24_(1).png',
                                        width: () {
                                          if (MediaQuery.sizeOf(context)
                                              .width <=
                                              375.0) {
                                            return 160.0;
                                          } else if (MediaQuery.sizeOf(context)
                                              .width <=
                                              400.0) {
                                            return 170.0;
                                          } else if (MediaQuery.sizeOf(context)
                                              .width <=
                                              430.0) {
                                            return 190.0;
                                          } else if (MediaQuery.sizeOf(context)
                                              .width <=
                                              393.0) {
                                            return 175.0;
                                          } else {
                                            return 165.0;
                                          }
                                        }(),
                                        height: () {
                                          if (MediaQuery.sizeOf(context)
                                              .height <=
                                              375.0) {
                                            return 160.0;
                                          } else if (MediaQuery.sizeOf(context)
                                              .height <=
                                              400.0) {
                                            return 180.0;
                                          } else if (MediaQuery.sizeOf(context)
                                              .height <=
                                              430.0) {
                                            return 195.0;
                                          } else if (MediaQuery.sizeOf(context)
                                              .height <=
                                              393.0) {
                                            return 175.0;
                                          } else {
                                            return 165.0;
                                          }
                                        }(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      'Pyramids',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 8.0)),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),*/
                            // Generated code for this Row Widget...
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
                                        'assets/images/image_24.png',
                                        width: MediaQuery.sizeOf(context).width * 0.44,
                                        height: MediaQuery.sizeOf(context).height * 0.20,
                                        /*height: () {
                                          if (MediaQuery.sizeOf(context).height <= 375.0) {
                                            return 160.0;
                                          } else if (MediaQuery.sizeOf(context).height <= 400.0) {
                                            return 180.0;
                                          } else if (MediaQuery.sizeOf(context).height <= 430.0) {
                                            return 195.0;
                                          } else if (MediaQuery.sizeOf(context).height <= 393.0) {
                                            return 175.0;
                                          } else {
                                            return 165.0;
                                          }
                                        }(),*/
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      'Silver Idols',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        fontSize: 16,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 8)),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
                                        'assets/images/image_24_(1).png',
                                        width: MediaQuery.sizeOf(context).width * 0.44,
                                        height: MediaQuery.sizeOf(context).height * 0.20,
                                        /*height: () {
                                          if (MediaQuery.sizeOf(context).height <= 375.0) {
                                            return 160.0;
                                          } else if (MediaQuery.sizeOf(context).height <= 400.0) {
                                            return 180.0;
                                          } else if (MediaQuery.sizeOf(context).height <= 430.0) {
                                            return 195.0;
                                          } else if (MediaQuery.sizeOf(context).height <= 393.0) {
                                            return 175.0;
                                          } else {
                                            return 165.0;
                                          }
                                        }(),*/
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      'Pyramids',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        fontSize: 16,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 8)),
                                ),
                              ].divide(SizedBox(width: 8)),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 12.0, 0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(16.0),
                                        child: Image.asset(
                                          'assets/images/image_24_(2).png',
                                          width: MediaQuery.sizeOf(context).width * 0.44,
                                          height: MediaQuery.sizeOf(context).height * 0.20,
                                          /*width: () {
                                            if (MediaQuery.sizeOf(context)
                                                .width <=
                                                375.0) {
                                              return 160.0;
                                            } else if (MediaQuery.sizeOf(
                                                context)
                                                .width <=
                                                400.0) {
                                              return 170.0;
                                            } else if (MediaQuery.sizeOf(
                                                context)
                                                .width <=
                                                430.0) {
                                              return 190.0;
                                            } else if (MediaQuery.sizeOf(
                                                context)
                                                .width <=
                                                393.0) {
                                              return 175.0;
                                            } else {
                                              return 165.0;
                                            }
                                          }(),
                                          height: () {
                                            if (MediaQuery.sizeOf(context)
                                                .height <=
                                                375.0) {
                                              return 160.0;
                                            } else if (MediaQuery.sizeOf(
                                                context)
                                                .height <=
                                                400.0) {
                                              return 180.0;
                                            } else if (MediaQuery.sizeOf(
                                                context)
                                                .height <=
                                                430.0) {
                                              return 195.0;
                                            } else if (MediaQuery.sizeOf(
                                                context)
                                                .height <=
                                                393.0) {
                                              return 175.0;
                                            } else {
                                              return 165.0;
                                            }
                                          }(),*/
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        'Spiritual Jewellery',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 8.0)),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(16.0),
                                        child: Image.asset(
                                          'assets/images/image_24_(3).png',
                                          /*width: () {
                                            if (MediaQuery.sizeOf(context)
                                                .width <=
                                                375.0) {
                                              return 160.0;
                                            } else if (MediaQuery.sizeOf(
                                                context)
                                                .width <=
                                                400.0) {
                                              return 170.0;
                                            } else if (MediaQuery.sizeOf(
                                                context)
                                                .width <=
                                                430.0) {
                                              return 190.0;
                                            } else if (MediaQuery.sizeOf(
                                                context)
                                                .width <=
                                                393.0) {
                                              return 175.0;
                                            } else {
                                              return 165.0;
                                            }
                                          }(),
                                          height: () {
                                            if (MediaQuery.sizeOf(context)
                                                .height <=
                                                375.0) {
                                              return 160.0;
                                            } else if (MediaQuery.sizeOf(
                                                context)
                                                .height <=
                                                400.0) {
                                              return 180.0;
                                            } else if (MediaQuery.sizeOf(
                                                context)
                                                .height <=
                                                430.0) {
                                              return 195.0;
                                            } else if (MediaQuery.sizeOf(
                                                context)
                                                .height <=
                                                393.0) {
                                              return 175.0;
                                            } else {
                                              return 165.0;
                                            }
                                          }(),*/
                                          width: MediaQuery.sizeOf(context).width * 0.44,
                                          height: MediaQuery.sizeOf(context).height * 0.20,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        'Shree Yantras',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 8.0)),
                                  ),
                                ].divide(SizedBox(width: 8.0)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 24),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                          FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: // Generated code for this Column Widget...
                        FutureBuilder<ApiCallResponse>(
                          future: HomeBlogCall.call(
                            sanityurl: FFAppConstants.sanityurl,
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
                            final columnHomeBlogResponse = snapshot.data!;
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                                  child: Text(
                                    'Blogs & Events',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF740074),
                                      fontSize: 18,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                      fadeInDuration: Duration(milliseconds: 100),
                                      fadeOutDuration: Duration(milliseconds: 100),
                                      imageUrl:
                                      valueOrDefault<String>(
                                        getJsonField(
                                          columnHomeBlogResponse.jsonBody,
                                          r'''$.data.image''',
                                        )?.toString(),
                                        'https://s3.amazonaws.com/RudraCentre/Test/ProductImages/blog/RUDRAKSHA.jpg',
                                      ),
                                      width: double.infinity,
                                      height: 189,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                                    child: Text(
                                      valueOrDefault<String>(
                                        getJsonField(
                                          columnHomeBlogResponse.jsonBody,
                                          r'''$.data.blog_title''',
                                        )?.toString(),
                                        'Everything About Rudraksha',
                                      ),
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                                    child: Text(
                                      valueOrDefault<String>(
                                        getJsonField(
                                          columnHomeBlogResponse.jsonBody,
                                          r'''$.data.small_description''',
                                        )?.toString(),
                                        'Learn about Rudraksha, the mystical dried fruit of Elaeocarpus Ganitrus Tree. Rudr-aksha (Shiva\'s-Tears) is a blessing to Humankind from Lord Shiva and are available in Nepal & Java varieties.',
                                      ),
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF575758),
                                        fontSize: 16,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () {
                                    print('Button pressed ...');
                                  },
                                  text: 'View All Articles',
                                  options: FFButtonOptions(
                                    height: 48,
                                    padding: EdgeInsetsDirectional.fromSTEB(32, 11, 32, 11),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    elevation: 0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, -0.91),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: Container(
                  width: double.infinity,
                  height: 52.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          scaffoldKey.currentState!.openDrawer();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(0.0),
                            topLeft: Radius.circular(0.0),
                            topRight: Radius.circular(0.0),
                          ),
                          child: Image.asset(
                            'assets/images/hamburger_1.png',
                            width: 24.0,
                            height: 24.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(0.0),
                          topLeft: Radius.circular(0.0),
                          topRight: Radius.circular(0.0),
                        ),
                        child: Image.asset(
                          'assets/images/image_29.png',
                          width: 102.0,
                          height: 46.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(
                            'Cart',
                            extra: <String, dynamic>{
                              kTransitionInfoKey: TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 400),
                              ),
                            },
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(0.0),
                            topLeft: Radius.circular(0.0),
                            topRight: Radius.circular(0.0),
                          ),
                          child: Image.asset(
                            'assets/images/Buy.png',
                            width: 30.0,
                            height: 30.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 1.0),
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
