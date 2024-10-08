import 'package:rudraksha_cart/auth/custom_auth/auth_util.dart';
import 'package:rudraksha_cart/backend/api_requests/api_calls.dart';
import 'package:rudraksha_cart/components/AstrologyConsultationBookNowwidget.dart';
import 'package:rudraksha_cart/pages/ConsultationScreen/consultation_model.dart';
import 'package:rudraksha_cart/pages/my_cart/my_cart_widget.dart';
import '../../components/Consultationwithsakashreebooknow_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



class ConsultationScreenWidget extends StatefulWidget {
  const ConsultationScreenWidget({super.key});

  @override
  State<ConsultationScreenWidget> createState() =>
      _ConsultationScreenWidgetState();
}

class _ConsultationScreenWidgetState extends State<ConsultationScreenWidget> {
  late ConsultationScreenModel _model;

  final ConsultationScreenWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConsultationScreenModel());
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
        key: ConsultationScreenWidgetscaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15), // Shadow color with opacity
                  offset: Offset(0, 4), // Move shadow downwards by 4 pixels
                  blurRadius: 6, // Blur radius for a softer shadow
                  spreadRadius: 1, // Spread radius for shadow expansion
                ),
              ],
            ),
            child: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Color(0xFF272728),
                  size: 30,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Text(
                'Consultation',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Color(0xFF272728),
                  fontSize: 16,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [],
              centerTitle: true,
              elevation: 0,
            ),
          ),
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                    child: Text(
                      'Our Consultation Services',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(

                          borderRadius: BorderRadius.circular(0),
                          child: Image.network(
                            '${FFAppConstants.consultation}/Rudraksha-Gemstones-Chakra.jpg',
                            width: MediaQuery.sizeOf(context).width * 0.99,
                            height: 228,
                            fit: BoxFit.contain,

                          ),
                        ),
                        Text(
                          'Consult with Sakhashree',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Personal consultation with Sakhashree to Experience Healing & Empowerment in Health, Career & Relationships with etailed Chakra Analysis & Powerful Remedies to balance Chakras. Receive detailed Chakra Analysis Report with remedies which include Rudraksha & Cemstone combinations, Yantrast Mantras & Meditation techniques to heal & empower imbalanced Chakras.',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF575758),
                            fontSize: 15,
                            letterSpacing: 0,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        InkWell(
                          onTap: (){
                            context.pushNamed(
                              'Consultationwithsakhashree',

                            );
                          },
                          child: Text(
                            'Know More',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF740074),
                              fontSize: 16,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 68,
                          decoration: BoxDecoration(),
                          child: FFButtonWidget(
                            onPressed: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return GestureDetector(
                                    onTap: () => _model.unfocusNode
                                        .canRequestFocus
                                        ? FocusScope.of(context)
                                        .requestFocus(
                                        _model.unfocusNode)
                                        : FocusScope.of(context)
                                        .unfocus(),
                                    child: Padding(
                                      padding:
                                      MediaQuery.viewInsetsOf(
                                          context),
                                      child: Container(
                                        height: 628,
                                        child: const ConsultationwithsakashreebooknowWidget(),
                                      ),
                                    ),
                                  );
                                },
                              ).then(
                                      (value) => safeSetState(() {}));
                            },
                            text: 'Book Now INR 1,100 - 5,100',
                            options: FFButtonOptions(
                              height: 40,
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontSize: 14,
                                letterSpacing: 0,
                              ),
                              elevation: 0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            showLoadingIndicator: false,
                          ),
                        ),
                      ].divide(SizedBox(height: 10)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: Image.network(
                            '${FFAppConstants.consultation}/rudraksha-gems-recommendation.jpg',
                            width: MediaQuery.sizeOf(context).width * 0.99,
                            height: 228,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text(
                          'Rudraksha & Gems Recommendation',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text("Get Personalized Certified Rudraksha & Gemstone Recommendation from Experts based on Chakra Therapy & Horoscope Analysis. Rudraksha Ratna Science Therapy is the world fastest healing therapy to balance chakras & horoscope where positive results are experienced within 10 days of wearing the suggested combination. ",
                        //  'Personal consultation with Sakhashree to Experience Healing & Empowerment in Health, Career & Relationships with detailed Chakra Analysis & Powerful Remedies to balance Chakras. Receive detailed Chakra Analysis Report with remedies which include Rudraksha & Cemstone combinations, Yantrast Mantras & Meditation techniques to heal & empower imbalanced Chakras.',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF575758),
                            fontSize: 15,
                            letterSpacing: 0,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        InkWell(
                          onTap: (){


                            context.pushNamed(
                              'RudrakshaGemsRecommendationWidget',

                            );
                          },
                          child: Text(
                            'Know More',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF740074),
                              fontSize: 16,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 68,
                          decoration: BoxDecoration(),
                          child: FFButtonWidget(
                            onPressed: () async {
                              print("currentAuthenticationToken:${currentAuthenticationToken}");
                              if (currentAuthenticationToken != null &&
                                  currentAuthenticationToken != '') {

                                var _shouldSetState = false;
                                _model.apiResultj7i =
                                await AddToCartCall.call(
                                  hosturl: FFAppConstants.sanityurl,
                                  token: currentAuthenticationToken,
                                  productid:  "5",
                                  productType:"6",
                                  // productvariation:false,




                                );
                                _shouldSetState = true;
                                if ((_model.apiResultj7i?.succeeded ??
                                    true)) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        getJsonField(
                                          (_model.apiResultj7i
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
                                    (_model.apiResultj7i
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
                                          (_model.apiResultj7i
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
                            text: 'Book Now INR 1,100',
                            options: FFButtonOptions(
                              height: 40,
                              padding:
                              EdgeInsetsDirectional.fromSTEB(50, 0, 50, 0),
                              iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontSize: 14,
                                letterSpacing: 0,
                              ),
                              elevation: 0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            showLoadingIndicator: false,
                          ),
                        ),
                      ].divide(SizedBox(height: 10)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: Image.network(
                            '${FFAppConstants.consultation}/puja-services-recommendation.jpg',
                            width: MediaQuery.sizeOf(context).width * 0.99,
                            height: 228,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text(
                          'Puja Services Recommendation',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text("Learn about your Astrological Doshas & Planetary Imbalances in Horoscope and Avail Personalized Puja Recommendation to resolve all astrological issues in your chart. Experience the Divine Power of Puja, Havan & Mantra Chanting Performed as per Vedic Vidhi by Karmakandi Pandits ",
                         // 'Personal consultation with Sakhashree to Experience Healing & Empowerment in Health, Career & Relationships with detailed Chakra Analysis & Powerful Remedies to balance Chakras. Receive detailed Chakra Analysis Report with remedies which include Rudraksha & Cemstone combinations, Yantrast Mantras & Meditation techniques to heal & empower imbalanced Chakras.',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF575758),
                            fontSize: 15,
                            letterSpacing: 0,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        InkWell(
                          onTap: (){
                            context.pushNamed(
                              'PujaServicesRecommendationWidget',

                            );
                          },
                          child: Text(
                            'Know More',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF740074),
                              fontSize: 16,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 68,
                          decoration: BoxDecoration(),
                          child: FFButtonWidget(
                            onPressed: () async {
                              if (currentAuthenticationToken != null &&
                                  currentAuthenticationToken != '') {

                                var _shouldSetState = false;
                                _model.apiResultj7i =
                                await AddToCartCall.call(
                                  hosturl: FFAppConstants.sanityurl,
                                  token: currentAuthenticationToken,
                                  productid:  "6",
                                  productType:"6",
                                  // productvariation:false,




                                );
                                _shouldSetState = true;
                                if ((_model.apiResultj7i?.succeeded ??
                                    true)) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        getJsonField(
                                          (_model.apiResultj7i
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
                                    (_model.apiResultj7i
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
                                          (_model.apiResultj7i
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
                            text: 'Book Now INR 1,100',
                            options: FFButtonOptions(
                              height: 40,
                              padding:
                              EdgeInsetsDirectional.fromSTEB(50, 0, 50, 0),
                              iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontSize: 14,
                                letterSpacing: 0,
                              ),
                              elevation: 0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            showLoadingIndicator: false,
                          ),
                        ),
                      ].divide(SizedBox(height: 10)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: Image.network(
                            '${FFAppConstants.consultation}/chakra-vastu-consultation.jpg',
                            width: MediaQuery.sizeOf(context).width * 0.99,
                            height: 228,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text(
                          'Chakra Vastu Consultation',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Balance the Elements, Colours, Directions, Cuts & Corners and rectify all Vastu Doshas (Imbalances) of your Dwelling. Vastu Purush (Man) is the personification of the dwelling and balancing the Chakras of the Vastu Purush (Man) is important to experience harmony with your surroundings. Receive Detailed Chakra Vastu Report with Remedies. ',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF575758),
                            fontSize: 15,
                            letterSpacing: 0,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        InkWell(
                          onTap: (){
                            context.pushNamed(
                              'ChakraVastuConsultationWidget',

                            );
                          },
                          child: Text(
                            'Know More',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF740074),
                              fontSize: 16,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 68,
                          decoration: BoxDecoration(),
                          child: FFButtonWidget(
                            onPressed: () async {
                              if (currentAuthenticationToken != null &&
                                  currentAuthenticationToken != '') {

                                var _shouldSetState = false;
                                _model.apiResultj7i =
                                await AddToCartCall.call(
                                  hosturl: FFAppConstants.sanityurl,
                                  token: currentAuthenticationToken,
                                  productid:  "7",
                                  productType:"6",
                                  // productvariation:false,




                                );
                                _shouldSetState = true;
                                if ((_model.apiResultj7i?.succeeded ??
                                    true)) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        getJsonField(
                                          (_model.apiResultj7i
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
                                    (_model.apiResultj7i
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
                                          (_model.apiResultj7i
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
                            text: 'Book Now INR 5,100',
                            options: FFButtonOptions(
                              height: 40,
                              padding:
                              EdgeInsetsDirectional.fromSTEB(50, 0, 50, 0),
                              iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontSize: 14,
                                letterSpacing: 0,
                              ),
                              elevation: 0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            showLoadingIndicator: false,
                          ),
                        ),
                      ].divide(SizedBox(height: 10)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: Image.network(
                            '${FFAppConstants.consultation}/chakra-cleansing-meditation-with-sakhashree.jpg',
                            width: MediaQuery.sizeOf(context).width * 0.99,
                            height: 228,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text(
                          'Chakra Cleansing Meditation with Sakhashree',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Guided Meditation technique based on Neti Neti Principle of Advait Vedanta to balance Chakras. Release Guilt, Trauma, Obsessive thoughts, Limiting Beliefs, Negative Self Image & Develop a Positive & Abundance Mindset. Experience Healing & Empowerment in all areas of life. ',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF575758),
                            fontSize: 15,
                            letterSpacing: 0,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        InkWell(
                          onTap: (){
                            context.pushNamed(
                              'ChakraCleansingMeditationWithSakhashreeWidget',

                            );
                          },
                          child: Text(
                            'Know More',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF740074),
                              fontSize: 16,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 68,
                          decoration: BoxDecoration(),
                          child: FFButtonWidget(
                            onPressed: () async {
                              if (currentAuthenticationToken != null &&
                                  currentAuthenticationToken != '') {

                                var _shouldSetState = false;
                                _model.apiResultj7i =
                                await AddToCartCall.call(
                                  hosturl: FFAppConstants.sanityurl,
                                  token: currentAuthenticationToken,
                                  productid:  "4",
                                  productType:"6",
                                  // productvariation:false,




                                );
                                _shouldSetState = true;
                                if ((_model.apiResultj7i?.succeeded ??
                                    true)) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        getJsonField(
                                          (_model.apiResultj7i
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
                                    (_model.apiResultj7i
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
                                          (_model.apiResultj7i
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
                            text: 'Book Now INR 5,100',
                            options: FFButtonOptions(
                              height: 40,
                              padding:
                              EdgeInsetsDirectional.fromSTEB(50, 0, 50, 0),
                              iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontSize: 14,
                                letterSpacing: 0,
                              ),
                              elevation: 0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            showLoadingIndicator: false,
                          ),
                        ),
                      ].divide(SizedBox(height: 10)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: Image.network(
                            '${FFAppConstants.consultation}/Astrology-Consultation-Tile.jpg',
                            width: MediaQuery.sizeOf(context).width * 0.99,
                            height: 228,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text(
                          'Astrology Consultation',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Our astrological experts can provide you with personalized recommendations to balance your horoscope. By analyzing your astrological doshas and planetary imbalances, we can help you resolve any issues you may be facing in your life. Whether you\'re struggling with relationship problems, financial difficulties, or health issues, our horoscope-based recommendations can help you overcome these challenges and live your best life. ',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF575758),
                            fontSize: 15,
                            letterSpacing: 0,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        InkWell(
                          onTap: (){
                            context.pushNamed(
                              'AstrologyConsultationWidget',

                            );
                          },
                          child: Text(
                            'Know More',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF740074),
                              fontSize: 16,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 68,
                          decoration: BoxDecoration(),
                          child: FFButtonWidget(
                            onPressed: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return GestureDetector(
                                    onTap: () => _model.unfocusNode
                                        .canRequestFocus
                                        ? FocusScope.of(context)
                                        .requestFocus(
                                        _model.unfocusNode)
                                        : FocusScope.of(context)
                                        .unfocus(),
                                    child: Padding(
                                      padding:
                                      MediaQuery.viewInsetsOf(
                                          context),
                                      child: Container(
                                        height:734,
                                        child: const AstrologyConsultationBookNowWidget(),
                                      ),
                                    ),
                                  );
                                },
                              ).then(
                                      (value) => safeSetState(() {}));
                            },
                            text: 'Book Now INR 2,800',
                            options: FFButtonOptions(
                              height: 40,
                              padding:
                              EdgeInsetsDirectional.fromSTEB(50, 0, 50, 0),
                              iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontSize: 14,
                                letterSpacing: 0,
                              ),
                              elevation: 0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            showLoadingIndicator: false,
                          ),
                        ),
                      ].divide(SizedBox(height: 10)),
                    ),
                  ),
                ].divide(SizedBox(height: 10)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
