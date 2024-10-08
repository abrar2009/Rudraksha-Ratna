import 'package:rudraksha_cart/auth/custom_auth/auth_util.dart';
import 'package:rudraksha_cart/pages/my_cart/my_cart_widget.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:carousel_slider/carousel_controller.dart' as slider;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'PujaServicesRecommendationModel.dart';

class PujaServicesRecommendationWidget extends StatefulWidget {
  const PujaServicesRecommendationWidget({
    super.key,
    String? consultationtype,
  }) : this.consultationtype = consultationtype ?? 'home';

  final String consultationtype;

  @override
  State<PujaServicesRecommendationWidget> createState() =>
      _PujaServicesRecommendationWidgetState();
}

class _PujaServicesRecommendationWidgetState
    extends State<PujaServicesRecommendationWidget> {
  late PujaServicesRecommendationModel _model;

  final PujaServicesRecommendationWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PujaServicesRecommendationModel());

    _model.expandableExpandableController1 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController2 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController3 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController4 =
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
        key: PujaServicesRecommendationWidgetscaffoldKey,
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
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 60),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                child: Text(
                                  'Puja Services Recommendation',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 18,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Builder(
                                      builder: (context) {
                                        if (widget!.consultationtype == 'home') {
                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Stack(
                                                children: [
                                                  InkWell(
                                                    splashColor:
                                                    Colors.transparent,
                                                    focusColor:
                                                    Colors.transparent,
                                                    hoverColor:
                                                    Colors.transparent,
                                                    highlightColor:
                                                    Colors.transparent,
                                                    onTap: () async {
                                                      await launchURL(
                                                          'https://www.youtube.com/watch?v=D4D18vDm404');
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          0),
                                                      child: CachedNetworkImage(
                                                        fadeInDuration: Duration(
                                                            milliseconds: 500),
                                                        fadeOutDuration: Duration(
                                                            milliseconds: 500),
                                                        imageUrl:
                                                        '${FFAppConstants.pujaServicesRecommendationImafeUrl}/puja-service.jpg',
                                                        width: MediaQuery.sizeOf(
                                                            context)
                                                            .width *
                                                            0.99,
                                                        height: 228,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                    AlignmentDirectional(
                                                        0, 0),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0, 83, 0, 0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                        child: CachedNetworkImage(
                                                          fadeInDuration:
                                                          Duration(
                                                              milliseconds:
                                                              500),
                                                          fadeOutDuration:
                                                          Duration(
                                                              milliseconds:
                                                              500),
                                                          imageUrl:
                                                          '${FFAppConstants.commonImageUrl}/youtube_icon.png',
                                                          width: 64,
                                                          height: 64,
                                                          fit: BoxFit.scaleDown,
                                                          alignment:
                                                          Alignment(0, 0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                'Seek Divine Grace and Blessings for',
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .primaryText,
                                                  fontSize: 20,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w600,
                                                  lineHeight: 1.5,
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 16)),
                                          );
                                        } else {
                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(0),
                                                    child: Image.asset(
                                                      'assets/images/Consultationimg1.png',
                                                      width: MediaQuery.sizeOf(
                                                          context)
                                                          .width *
                                                          0.99,
                                                      height: 228,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                    AlignmentDirectional(
                                                        0, 0),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0, 83, 0, 0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                        child: Image.asset(
                                                          'assets/images/image_432.png',
                                                          width: 64,
                                                          height: 64,
                                                          fit: BoxFit.scaleDown,
                                                          alignment:
                                                          Alignment(0, 0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                'Audraksha Oeads and gemstones runctiotl to cleanse and balance your chakras. thereby ervpowering you and enhancing your aura. Qernarkably, this transrorrnaLion can occur in as little as five davs when worn according to Qudraksha (QaLna Chakra Therapy. Once\nLine relevant chakras are opened and hatrvonized, individuals guin\nL ine empowerment needed 10 achieve success in physical,ernolicnal, and \',vorldly so+eres Of life.',
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF575758),
                                                  fontSize: 15,
                                                  letterSpacing: 0,
                                                  lineHeight: 1.5,
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 16)),
                                          );
                                        }
                                      },
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 19,
                                          height: 19,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            'assets/images/ArrowRightCircle.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          width:
                                          MediaQuery.sizeOf(context).width *
                                              0.835,
                                          decoration: BoxDecoration(),
                                          child: Text(
                                            'Good Health',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF575758),
                                              fontSize: 13,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                              lineHeight: 1.5,
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8)),
                                    ),  Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 19,
                                          height: 19,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            'assets/images/ArrowRightCircle.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          width:
                                          MediaQuery.sizeOf(context).width *
                                              0.835,
                                          decoration: BoxDecoration(),
                                          child: Text(
                                            'Growth, Prosperity and Wealth',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF575758),
                                              fontSize: 13,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                              lineHeight: 1.5,
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8)),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 19,
                                          height: 19,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            'assets/images/ArrowRightCircle.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          width:
                                          MediaQuery.sizeOf(context).width *
                                              0.835,
                                          decoration: BoxDecoration(),
                                          child: Text(
                                            'Harmonious Relationships',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF575758),
                                              fontSize: 13,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                              lineHeight: 1.5,
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8)),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 19,
                                          height: 19,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            'assets/images/ArrowRightCircle.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          width:
                                          MediaQuery.sizeOf(context).width *
                                              0.835,
                                          decoration: BoxDecoration(),
                                          child: Text(
                                            'Protection from Black Magic, Evil Eye, Accidents and Negativities ',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF575758),
                                              fontSize: 13,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                              lineHeight: 1.5,
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8)),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 19,
                                          height: 19,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            'assets/images/ArrowRightCircle.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          width:
                                          MediaQuery.sizeOf(context).width *
                                              0.835,
                                          decoration: BoxDecoration(),
                                          child: Text(
                                            'Relieve and Cure of acute and chronic ailments and disorders ',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF575758),
                                              fontSize: 13,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                              lineHeight: 1.5,
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8)),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 19,
                                          height: 19,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            'assets/images/ArrowRightCircle.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          width:
                                          MediaQuery.sizeOf(context).width *
                                              0.835,
                                          decoration: BoxDecoration(),
                                          child: Text(
                                            'Victory over enemies and success in Court Cases',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF575758),
                                              fontSize: 13,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                              lineHeight: 1.5,
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8)),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 19,
                                          height: 19,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            'assets/images/ArrowRightCircle.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          width:
                                          MediaQuery.sizeOf(context).width *
                                              0.835,
                                          decoration: BoxDecoration(),
                                          child: Text(
                                            'Removal of Planetary Malefics & Doshas in Horoscope',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF575758),
                                              fontSize: 13,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                              lineHeight: 1.5,
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8)),
                                    ),
                                  ].divide(SizedBox(height: 10)),
                                ),
                              ),
                            ].divide(SizedBox(height: 10)),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(16, 20, 16, 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'What is the Procedure of Puja Consultation?',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 20,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 19,
                                      height: 19,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'assets/images/ArrowRightCircle.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.835,
                                      decoration: BoxDecoration(),
                                      child: Text(
                                        'You will receive a confirmation email from us once you have scheduled the consultation. ',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF575758),
                                          fontSize: 13,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                          lineHeight: 1.5,
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 8)),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 19,
                                      height: 19,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'assets/images/ArrowRightCircle.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.835,
                                      decoration: BoxDecoration(),
                                      child: Text(
                                        'You will receive a confirmation email from us once you have scheduled the consultation. ',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF575758),
                                          fontSize: 13,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                          lineHeight: 1.5,
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 8)),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 19,
                                      height: 19,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'assets/images/ArrowRightCircle.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.835,
                                      decoration: BoxDecoration(),
                                      child: Text(
                                        'Once details are received and analyzed, you will receive an email containing your complete horoscope analysis, including Astrology Report, Dashas, Malefic and Benefic Planets, Lucky Numbers, Doshas, and the most appropriate Puja(s) for you. ',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF575758),
                                          fontSize: 13,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                          lineHeight: 1.5,
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 8)),
                                ),
                                Text(
                                  'If you are not satisfied with the consultation, there is 100% money back guarantee no questions asked ',
                                  textAlign: TextAlign.justify,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                    lineHeight: 1.5,
                                  ),
                                ),
                              ].divide(SizedBox(height: 16)),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFE3CCE3),
                          ),
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Rudra Centre Puja Services is the World\'s Oldest and most Trusted online provider of Vedic pujas. ',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 18,
                                        letterSpacing: 0.38,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 5)),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          '100,000+',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                            fontSize: 35,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'Pujas Performed for Global Clientele',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF575758),
                                            letterSpacing: 0,
                                            lineHeight: 1.4,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 6)),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          '250+',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                            fontSize: 35,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'Team of Curated Pandits',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF575758),
                                            letterSpacing: 0,
                                            lineHeight: 1.4,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 6)),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          '500+',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                            fontSize: 35,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'Different Pujas, Homas, Paaths, Kathas Performed as per Vedic Vidhi ',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF575758),
                                            letterSpacing: 0,
                                            lineHeight: 1.4,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 6)),
                                    ),
                                  ].divide(SizedBox(height: 30)),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Book a Consultation, and our Team of Expert Astrologers & Puja Experts will analyze your birth chart and concerns affecting to your health, business, career, and relationships and recommend the most suitable Puja Yagna.  ',
                                      textAlign: TextAlign.justify,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                        lineHeight: 1.5,
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 5)),
                                ),
                              ].divide(SizedBox(height: 16)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Rudra Centre Puja Services conducts only Sattvic Puja complete with all Vedic rituals as prescribed in the Yajurveda ensuring only positive effects and benefits. ',
                                    textAlign: TextAlign.justify,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context).secondaryText,
                                      fontSize: 15,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                      lineHeight: 1.5,
                                    ),
                                  ),
                                  Text(
                                    'Karmakandi Pundits will follow the steps spelled out in the Vedas to do rituals like calling on the Principal Deity, performing Yantra and Idol Puja and Abhishekam, Mantra Japa, Yajna or Homa with Tarpan, Marjan and Brahmin Bhoj and Daan, and more. ',
                                    textAlign: TextAlign.justify,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context).secondaryText,
                                      fontSize: 15,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                      lineHeight: 1.5,
                                    ),
                                  ),
                                  /*Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 19,
                                        height: 19,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          'assets/images/ArrowRightCircle.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.sizeOf(context).width *
                                            0.835,
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          'Your thought process will become streamlined & clear',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF575758),
                                            fontSize: 13,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w500,
                                            lineHeight: 1.5,
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 8)),
                                  ),

                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 19,
                                        height: 19,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          'assets/images/ArrowRightCircle.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.sizeOf(context).width *
                                            0.835,
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          ' You will see your obstacles as opportunities for growth & learning ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF575758),
                                            fontSize: 13,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w500,
                                            lineHeight: 1.5,
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 8)),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 19,
                                        height: 19,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          'assets/images/ArrowRightCircle.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.sizeOf(context).width *
                                            0.835,
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          ' You will be able to set clear well-defined goals and achieve them ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF575758),
                                            fontSize: 13,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w500,
                                            lineHeight: 1.5,
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 8)),
                                  ),*/
                                ].divide(SizedBox(height: 10)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFE3CCE3),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: CachedNetworkImage(
                                  fadeInDuration: Duration(milliseconds: 500),
                                  fadeOutDuration: Duration(milliseconds: 500),
                                  imageUrl:
                                  '${FFAppConstants.pujaServicesRecommendationImafeUrl}/perform-puja-with-sakhashree-neeta.jpg',
                                  width: double.infinity,
                                  height: 228,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 24, 16, 24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'What is a Puja Yagya & Homam?',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 20,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Puja is the sacred practice of worshipping and revering the Divine. Performing Puja rituals is a timeless tradition in Sanatan Dharma. In Hinduism, different Deities symbolize distinct energies or aspects of the Supreme Consciousness. They are revered and worshipped to seek specific blessings. Goddess Laxmi embodies the energies of wealth and prosperity, and is worshipped to seek divine blessings for abundance. \n According to Vedic scriptures, performing Puja Yagna with traditional Karmakand Shodashopachar Vidhi, including Beej Mantra Japa and Homa, by qualified Karmakandi Pandits, is a fast and effective method to attain divine grace. This practice brings protection, peace, health stability, desire fulfillment, and success in life. \n Devotees who wholeheartedly perform Puja and offer prayers to the Divine have long believed that their wishes are always granted and they never leave empty-handed. Bhakti, expressed through Pujas and complete surrender to the Divine, is the definite path to success and the fulfillment of all wishes and desires. ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        fontSize: 15,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                        lineHeight: 1.5,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ].divide(SizedBox(height: 16)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFE3CCE3),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: CachedNetworkImage(
                                  fadeInDuration: Duration(milliseconds: 500),
                                  fadeOutDuration: Duration(milliseconds: 500),
                                  imageUrl:
                                  '${FFAppConstants.pujaServicesRecommendationImafeUrl}/rudra-centre-puja-service.jpg',
                                  width: double.infinity,
                                  height: 228,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 24, 16, 24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Why Online Pujas & Homas by Rudra Centre Puja Services ',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 20,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Rudra Centre Puja Services is the oldest and most trusted online puja service provider in the world. For over 20 years, we have organized Yagnas, Pujas, Homas, and Kathas like Ati Rudra Mahayajna, Sahasra Chandi Homa, Akhand Ramayan Paath, Shiva Maha Puran Katha, and 4 Prahar Mahashivratri Mahapuja with teams of 100’s of experienced curated priests for the benefit of mankind and our global clientele.  Our Karma Kandi Pandits are highly learned in Vedic Shastras, Puranas, Upanishads, and Tantras and have been initiated and received Diksha for the Mantras under the guidance of a Guru. All of them are guided and curated by Sakhashree Neeta. The Pandits will take the solemn oath with betel nuts and leaves (as per the Vedic Shastra) before beginning the puja to complete all the rituals mentioned in the puja as per the Vedic Vidhi.  Our Karma Kandi Pandits are highly learned in Vedic Shastras, Puranas, Upanishads, and Tantras and have been initiated and received Diksha for the Mantras under the guidance of a Guru. All of them are guided and curated by Sakhashree Neeta. The Pandits will take the solemn oath with betel nuts and leaves (as per the Vedic Shastra) before beginning the puja to complete all the rituals mentioned in the puja as per the Vedic Vidhi. ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        fontSize: 15,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                        lineHeight: 1.5,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ].divide(SizedBox(height: 16)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'We have three temple premises',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 20,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                height: 256,
                                decoration: BoxDecoration(),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.network(
                                    '${FFAppConstants.pujaServicesRecommendationImafeUrl}/puja-at-mumbai-temple.JPG',
                                    width: 300,
                                    height: 200,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Mumbai',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                height: 256,
                                decoration: BoxDecoration(),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: CachedNetworkImage(
                                    fadeInDuration: Duration(milliseconds: 500),
                                    fadeOutDuration: Duration(milliseconds: 500),
                                    imageUrl:
                                    '${FFAppConstants.pujaServicesRecommendationImafeUrl}/puja-at-trimbakeshwar-temple.jpg',
                                    width: 300,
                                    height: 200,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Text(
                                'Trimbakeshwar',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 20,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                height: 256,
                                decoration: BoxDecoration(),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: CachedNetworkImage(
                                    fadeInDuration: Duration(milliseconds: 500),
                                    fadeOutDuration: Duration(milliseconds: 500),
                                    imageUrl: '${FFAppConstants.pujaServicesRecommendationImafeUrl}/puja-at-nagpur-temple.jpeg',
                                    width: 300,
                                    height: 200,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Text(
                                'Nagpur',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 20,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 24, 16, 24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Meet My Team',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 20,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 16, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(0),
                                                    child: Image.network(
                                                      '${FFAppConstants.pujaServicesRecommendationImafeUrl}/team/jay-rohida.jpeg',
                                                      width: 116,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ].divide(SizedBox(height: 8)),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(0),
                                                child: Image.network(
                                                  '${FFAppConstants.pujaServicesRecommendationImafeUrl}/team/4.jpg',
                                                  width: 116,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(0),
                                                    child: Image.network(
                                                      '${FFAppConstants.pujaServicesRecommendationImafeUrl}/team/2.jpg',
                                                      width: 116,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ].divide(SizedBox(height: 8)),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(0),
                                                child: Image.network(
                                                  '${FFAppConstants.pujaServicesRecommendationImafeUrl}/team/3.jpg',
                                                  width: 116,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(0),
                                                    child: Image.network(
                                                      '${FFAppConstants.pujaServicesRecommendationImafeUrl}/team/5.JPG',
                                                      width: 116,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ].divide(SizedBox(height: 8)),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(0),
                                                child: Image.network(
                                                  '${FFAppConstants.pujaServicesRecommendationImafeUrl}/team/6.JPG',
                                                  width: 116,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(0),
                                                    child: Image.network(
                                                      '${FFAppConstants.pujaServicesRecommendationImafeUrl}/team/7.JPG',
                                                      width: 116,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ].divide(SizedBox(height: 8)),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(0),
                                                child: Image.network(
                                                  '${FFAppConstants.pujaServicesRecommendationImafeUrl}/team/8.JPG',
                                                  width: 116,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ].divide(SizedBox(height: 20)),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 16)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  'Our core team oversees and manages pujas in multiple temple locations across three cities. Rudra Centre Puja Services has a dedicated group of over 250 pandits who have been performing significant Yagyas, such as Sahasra Chandi Homa, Ati Rudra Mahayagya, Akhand Ramayan Paath, and Mrit Sanjeevani Puja Mantra Japa, for the past 20 years, all aimed at benefiting humanity. ',
                                  textAlign: TextAlign.justify,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                    lineHeight: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFE3CCE3),
                          ),
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Our Mahapuja Videos',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 20,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await launchURL(
                                            'https://www.youtube.com/watch?v=w3SwvVjinxY');
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(0),
                                        child: CachedNetworkImage(
                                          fadeInDuration:
                                          Duration(milliseconds: 500),
                                          fadeOutDuration:
                                          Duration(milliseconds: 500),
                                          imageUrl: '${FFAppConstants.pujaServicesRecommendationImafeUrl}/video-image1.jpg',
                                          width: MediaQuery.sizeOf(context).width * 0.99,
                                          height: 228,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 83, 0, 0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                            Duration(milliseconds: 500),
                                            fadeOutDuration:
                                            Duration(milliseconds: 500),
                                            imageUrl:
                                            '${FFAppConstants.commonImageUrl}/youtube_icon.png',
                                            width: 64,
                                            height: 64,
                                            fit: BoxFit.scaleDown,
                                            alignment: Alignment(0, 0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await launchURL(
                                            'https://www.youtube.com/watch?v=mXiYUwpGM2U');
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(0),
                                        child: CachedNetworkImage(
                                          fadeInDuration:
                                          Duration(milliseconds: 500),
                                          fadeOutDuration:
                                          Duration(milliseconds: 500),
                                          imageUrl: '${FFAppConstants.pujaServicesRecommendationImafeUrl}/video-image2.jpg',
                                          width: MediaQuery.sizeOf(context).width * 0.99,
                                          height: 228,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 83, 0, 0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                            Duration(milliseconds: 500),
                                            fadeOutDuration:
                                            Duration(milliseconds: 500),
                                            imageUrl:
                                            '${FFAppConstants.commonImageUrl}/youtube_icon.png',
                                            width: 64,
                                            height: 64,
                                            fit: BoxFit.scaleDown,
                                            alignment: Alignment(0, 0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await launchURL(
                                            'https://www.youtube.com/watch?v=wdYM_7nUj98');
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(0),
                                        child: CachedNetworkImage(
                                          fadeInDuration:
                                          Duration(milliseconds: 500),
                                          fadeOutDuration:
                                          Duration(milliseconds: 500),
                                          imageUrl:
                                          '${FFAppConstants.pujaServicesRecommendationImafeUrl}/video-image3.jpg',
                                          width:
                                          MediaQuery.sizeOf(context).width *
                                              0.99,
                                          height: 228,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 83, 0, 0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                            Duration(milliseconds: 500),
                                            fadeOutDuration:
                                            Duration(milliseconds: 500),
                                            imageUrl:
                                            '${FFAppConstants.commonImageUrl}/youtube_icon.png',
                                            width: 64,
                                            height: 64,
                                            fit: BoxFit.scaleDown,
                                            alignment: Alignment(0, 0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ].divide(SizedBox(height: 16)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Testimonials',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 16,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(0),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                        child: FlutterFlowCountController(
                                          decrementIconBuilder: (enabled) => Icon(
                                            Icons.arrow_back_ios,
                                            color: enabled
                                                ? FlutterFlowTheme.of(context)
                                                .secondaryText
                                                : FlutterFlowTheme.of(context)
                                                .alternate,
                                            size: 15,
                                          ),
                                          incrementIconBuilder: (enabled) => Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            color: enabled
                                                ? FlutterFlowTheme.of(context)
                                                .primary
                                                : FlutterFlowTheme.of(context)
                                                .alternate,
                                            size: 15,
                                          ),
                                          countBuilder: (count) => Text(
                                            count.toString(),
                                            style: FlutterFlowTheme.of(context)
                                                .titleLarge
                                                .override(
                                              fontFamily: 'Outfit',
                                              fontSize: 0,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                          count: _model.countControllerValue ??=
                                          0,
                                          updateCount: (count) => setState(() =>
                                          _model.countControllerValue =
                                              count),
                                          stepSize: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 270,
                                    decoration: BoxDecoration(),
                                    child: FutureBuilder<ApiCallResponse>(
                                      future: TestimonialListCall.call(
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
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        final carouselExploreCategoryListResponse =
                                        snapshot.data!;

                                        return Builder(
                                          builder: (context) {
                                            final testimonials = getJsonField(
                                              carouselExploreCategoryListResponse.jsonBody,
                                              r'''$.data''',
                                            )
                                                .toList()
                                                .where((item) => getJsonField(item, r'''$.testimonial_type''') == 1)
                                                .toList();

                                            return Container(
                                              width: double.infinity,
                                              height: 260,
                                              child: CarouselSlider.builder(
                                                itemCount: testimonials.length,
                                                itemBuilder: (context,
                                                    testimonialsIndex, _) {
                                                  final testimonialsItem =
                                                  testimonials[
                                                  testimonialsIndex];
                                                  return Padding(
                                                    padding: EdgeInsetsDirectional
                                                        .fromSTEB(0, 10, 0, 10),
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      elevation: 5,
                                                      shape:
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                      ),
                                                      child: Container(
                                                        width: 343,
                                                        height: 240,
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryBackground,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(12),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(16,
                                                              12, 16, 12),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        0),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/image_442.png',
                                                                      width: 26,
                                                                      height: 19,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                getJsonField(
                                                                  testimonialsItem,
                                                                  r'''$.name''',
                                                                ).toString(),
                                                                style: FlutterFlowTheme
                                                                    .of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                  fontFamily:
                                                                  'Montserrat',
                                                                  fontSize:
                                                                  16,
                                                                  letterSpacing:
                                                                  0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0,
                                                                    2,
                                                                    0,
                                                                    0),
                                                                child: Text(
                                                                  getJsonField(
                                                                    testimonialsItem,
                                                                    r'''$.testimonial_text''',
                                                                  ).toString(),
                                                                  style: FlutterFlowTheme.of(context)
                                                                      .bodyMedium
                                                                      .override(
                                                                    fontFamily: 'Montserrat',
                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                    fontSize: 13,
                                                                    letterSpacing: 0,
                                                                    lineHeight: 1.5,
                                                                  ),
                                                                  maxLines: 9,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                carouselController:
                                                _model.carouselController ??=
                                                    CarouselSliderController(),
                                                options: CarouselOptions(
                                                  initialPage: max(
                                                      0,
                                                      min(
                                                          valueOrDefault<int>(
                                                            _model
                                                                .countControllerValue,
                                                            0,
                                                          ),
                                                          testimonials.length -
                                                              1)),
                                                  viewportFraction: 0.9,
                                                  disableCenter: true,
                                                  enlargeCenterPage: true,
                                                  enlargeFactor: 0.25,
                                                  enableInfiniteScroll: true,
                                                  scrollDirection:
                                                  Axis.horizontal,
                                                  autoPlay: true,
                                                  autoPlayAnimationDuration:
                                                  Duration(milliseconds: 800),
                                                  autoPlayInterval: Duration(
                                                      milliseconds: (800 + 4000)),
                                                  autoPlayCurve: Curves.linear,
                                                  pauseAutoPlayInFiniteScroll:
                                                  true,
                                                  onPageChanged: (index, _) =>
                                                  _model.carouselCurrentIndex =
                                                      index,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  FFButtonWidget(
                                    onPressed: () {
                                      context.pushNamed(
                                        'TestimonialsWidget',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType: PageTransitionType.leftToRight,
                                            duration: Duration(milliseconds: 400),
                                          ),
                                        },
                                      );
                                    },
                                    text: 'View All',
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
                                      elevation: 3,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'FAQs',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 16, 0, 0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        color: Colors.white,
                                        child: ExpandableNotifier(
                                          controller: _model
                                              .expandableExpandableController1,
                                          child: ExpandablePanel(
                                            header: Text(
                                              '01. Does it work to perform online or long-distance Pujas, Homas, and Yagyas? ',
                                              style: FlutterFlowTheme.of(context)
                                                  .displaySmall
                                                  .override(
                                                fontFamily: 'Outfit',
                                                color: Color(0xFF313131),
                                                fontSize: 14,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            collapsed: Container(),
                                            expanded: Text(
                                              'Yes, as per Vedic scriptures they do. Rudra Centre Puja Services pundits perform the pujas in the most authentic manner with proper Vedic rituals. Blessings and positive energies surpass distances created by matter. Numerous Yajmans have reported positive effects after doing online Pujas. ',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                letterSpacing: 0,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                            theme: ExpandableThemeData(
                                              tapHeaderToExpand: true,
                                              tapBodyToExpand: false,
                                              tapBodyToCollapse: false,
                                              headerAlignment:
                                              ExpandablePanelHeaderAlignment
                                                  .center,
                                              hasIcon: true,
                                              iconSize: 28,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 16, 0, 0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        color: Colors.white,
                                        child: ExpandableNotifier(
                                          controller: _model
                                              .expandableExpandableController2,
                                          child: ExpandablePanel(
                                            header: Text(
                                              '02. What If I am not satisfied with the consultation? ',
                                              style: FlutterFlowTheme.of(context)
                                                  .displaySmall
                                                  .override(
                                                fontFamily: 'Outfit',
                                                color: Color(0xFF313131),
                                                fontSize: 14,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            collapsed: Container(),
                                            expanded: Text(
                                              'There is a 100% money-back guarantee with no questions asked if you are not satisfied with the consultation. ',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                letterSpacing: 0,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                            theme: ExpandableThemeData(
                                              tapHeaderToExpand: true,
                                              tapBodyToExpand: false,
                                              tapBodyToCollapse: false,
                                              headerAlignment:
                                              ExpandablePanelHeaderAlignment
                                                  .center,
                                              hasIcon: true,
                                              iconSize: 28,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        color: Colors.white,
                                        child: ExpandableNotifier(
                                          controller: _model
                                              .expandableExpandableController3,
                                          child: ExpandablePanel(
                                            header: Text(
                                              '03. Are there any negative effects associated with pujas? ',
                                              style: FlutterFlowTheme.of(context)
                                                  .displaySmall
                                                  .override(
                                                fontFamily: 'Outfit',
                                                color: Color(0xFF313131),
                                                fontSize: 14,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            collapsed: Container(),
                                            expanded: Text(
                                              'No, Rudra Centre Puja Services conduct all their Pujas in a Sattvik way using only Bhakti Mantras. We don’t conduct any tantric rituals so Pujas conducted by us only provide positivity and auspiciousness. ',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                letterSpacing: 0,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                            theme: ExpandableThemeData(
                                              tapHeaderToExpand: true,
                                              tapBodyToExpand: false,
                                              tapBodyToCollapse: false,
                                              headerAlignment:
                                              ExpandablePanelHeaderAlignment
                                                  .center,
                                              hasIcon: true,
                                              iconSize: 28,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 16, 0, 0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        color: Colors.white,
                                        child: ExpandableNotifier(
                                          controller: _model
                                              .expandableExpandableController4,
                                          child: ExpandablePanel(
                                            header: Text(
                                              '04. How do I know the Puja are being performed? ',
                                              style: FlutterFlowTheme.of(context)
                                                  .displaySmall
                                                  .override(
                                                fontFamily: 'Outfit',
                                                color: Color(0xFF313131),
                                                fontSize: 14,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            collapsed: Container(),
                                            expanded: Text(
                                              'Yajmans can remotely participate in the Puja. They will be provided with the schedule and may connect with Punditji on the specified date and time to take Sankalp personally and observe Live the Puja being conducted. After the completion of the Puja, Yajmans are also provided with photographs and short videos of their Puja, and a Puja Tokri containing Prasad and energized Yantras, Rudrakshas, and other items will be sent to them. ',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                letterSpacing: 0,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                            theme: ExpandableThemeData(
                                              tapHeaderToExpand: true,
                                              tapBodyToExpand: false,
                                              tapBodyToCollapse: false,
                                              headerAlignment:
                                              ExpandablePanelHeaderAlignment
                                                  .center,
                                              hasIcon: true,
                                              iconSize: 28,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Our Consultation Services',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 16,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    width: double.infinity,
                                    height: 220,
                                    child: CarouselSlider(
                                      items: [
                                        Material(
                                          color: Colors.transparent,
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                                          child: Container(
                                            width: 343,
                                            height: 180,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                              borderRadius: BorderRadius.circular(0),
                                            ),
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(0),
                                                  child: Image.network(
                                                    '${FFAppConstants.consultation}/Astrology-Consultation-Tile.jpg',
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Align(
                                                  alignment: AlignmentDirectional(-1, 1),
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 100,
                                                    decoration: BoxDecoration(),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(16),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Text(
                                                            'Astrology \nConsultation',
                                                            style: FlutterFlowTheme.of(
                                                                context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Montserrat',
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .primaryBackground,
                                                              fontSize: 18,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                            ),
                                                          ),
                                                          FFButtonWidget(
                                                            onPressed: () {
                                                              context.pushNamed(
                                                                'AstrologyConsultationWidget',

                                                              );
                                                            },
                                                            text: 'KNOW MORE',
                                                            options: FFButtonOptions(
                                                              height: 40,
                                                              padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  24, 0, 24, 0),
                                                              iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0, 0, 0, 0),
                                                              color: Colors.transparent,
                                                              textStyle: FlutterFlowTheme
                                                                  .of(context)
                                                                  .titleSmall
                                                                  .override(
                                                                fontFamily:
                                                                'Montserrat',
                                                                color: Colors.white,
                                                                letterSpacing: 0,
                                                                fontWeight:
                                                                FontWeight.w600,
                                                              ),
                                                              elevation: 0,
                                                              borderSide: BorderSide(
                                                                color: FlutterFlowTheme
                                                                    .of(context)
                                                                    .primaryBackground,
                                                                width: 2,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  8),
                                                            ),
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
                                        Material(
                                          color: Colors.transparent,
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                                          child: Container(
                                            width: 343,
                                            height: 180,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                              borderRadius: BorderRadius.circular(0),
                                            ),
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(0),
                                                  child: Image.network(
                                                    '${FFAppConstants.consultation}/consult-with-sakhashree.jpg',
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Align(
                                                  alignment: AlignmentDirectional(-1, 1),
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 100,
                                                    decoration: BoxDecoration(),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(16),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Text(
                                                            'Consult with\nSakhashree',
                                                            style: FlutterFlowTheme.of(
                                                                context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Montserrat',
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .primaryBackground,
                                                              fontSize: 18,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                            ),
                                                          ),
                                                          FFButtonWidget(
                                                            onPressed: () {
                                                              context.pushNamed(
                                                                'Consultationwithsakhashree',

                                                              );
                                                            },
                                                            text: 'KNOW MORE',
                                                            options: FFButtonOptions(
                                                              height: 40,
                                                              padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  24, 0, 24, 0),
                                                              iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0, 0, 0, 0),
                                                              color: Colors.transparent,
                                                              textStyle: FlutterFlowTheme
                                                                  .of(context)
                                                                  .titleSmall
                                                                  .override(
                                                                fontFamily:
                                                                'Montserrat',
                                                                color: Colors.white,
                                                                letterSpacing: 0,
                                                                fontWeight:
                                                                FontWeight.w600,
                                                              ),
                                                              elevation: 0,
                                                              borderSide: BorderSide(
                                                                color: FlutterFlowTheme
                                                                    .of(context)
                                                                    .primaryBackground,
                                                                width: 2,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  8),
                                                            ),
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
                                        Material(
                                          color: Colors.transparent,
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                                          child: Container(
                                            width: 343,
                                            height: 180,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                              borderRadius: BorderRadius.circular(0),
                                            ),
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(0),
                                                  child: Image.network(
                                                    '${FFAppConstants.consultation}/chakra-cleansing-meditation-with-sakhashree.jpg',
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Align(
                                                  alignment: AlignmentDirectional(-1, 1),
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 100,
                                                    decoration: BoxDecoration(),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(16),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Text(
                                                            'Chakra Cleansing \nMeditation with \nSakhashree ',
                                                            style: FlutterFlowTheme.of(
                                                                context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Montserrat',
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .primaryBackground,
                                                              fontSize: 17,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                            ),
                                                          ),
                                                          FFButtonWidget(
                                                            onPressed: () {
                                                              context.pushNamed(
                                                                'ChakraCleansingMeditationWithSakhashreeWidget',
                                                              );
                                                            },
                                                            text: 'KNOW MORE',
                                                            options: FFButtonOptions(
                                                              height: 40,
                                                              padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  24, 0, 24, 0),
                                                              iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0, 0, 0, 0),
                                                              color: Colors.transparent,
                                                              textStyle: FlutterFlowTheme
                                                                  .of(context)
                                                                  .titleSmall
                                                                  .override(
                                                                fontFamily:
                                                                'Montserrat',
                                                                color: Colors.white,
                                                                letterSpacing: 0,
                                                                fontWeight:
                                                                FontWeight.w600,
                                                              ),
                                                              elevation: 0,
                                                              borderSide: BorderSide(
                                                                color: FlutterFlowTheme
                                                                    .of(context)
                                                                    .primaryBackground,
                                                                width: 2,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  8),
                                                            ),
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
                                        Material(
                                          color: Colors.transparent,
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                                          child: Container(
                                            width: 343,
                                            height: 180,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                              borderRadius: BorderRadius.circular(0),
                                            ),
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(0),
                                                  child: Image.network(
                                                    '${FFAppConstants.consultation}/puja-services-recommendation.jpg',
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Align(
                                                  alignment: AlignmentDirectional(-1, 1),
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 100,
                                                    decoration: BoxDecoration(),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(16),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Text(
                                                            'Puja Services \nRecommendation',
                                                            style: FlutterFlowTheme.of(
                                                                context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Montserrat',
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .primaryBackground,
                                                              fontSize: 17,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                            ),
                                                          ),
                                                          FFButtonWidget(
                                                            onPressed: () {
                                                              context.pushNamed(
                                                                'PujaServicesRecommendationWidget',

                                                              );
                                                            },
                                                            text: 'KNOW MORE',
                                                            options: FFButtonOptions(
                                                              height: 40,
                                                              padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  24, 0, 24, 0),
                                                              iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0, 0, 0, 0),
                                                              color: Colors.transparent,
                                                              textStyle: FlutterFlowTheme
                                                                  .of(context)
                                                                  .titleSmall
                                                                  .override(
                                                                fontFamily:
                                                                'Montserrat',
                                                                color: Colors.white,
                                                                letterSpacing: 0,
                                                                fontWeight:
                                                                FontWeight.w600,
                                                              ),
                                                              elevation: 0,
                                                              borderSide: BorderSide(
                                                                color: FlutterFlowTheme
                                                                    .of(context)
                                                                    .primaryBackground,
                                                                width: 2,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  8),
                                                            ),
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
                                      carouselController: _model.carouselController2 ??=
                                          CarouselSliderController(),
                                      options: CarouselOptions(
                                        initialPage: max(
                                            0,
                                            min(
                                                valueOrDefault<int>(
                                                  _model.countControllerValue,
                                                  0,
                                                ),
                                                3)),
                                        viewportFraction: 0.9,
                                        disableCenter: true,
                                        enlargeCenterPage: true,
                                        enlargeFactor: 0.25,
                                        enableInfiniteScroll: true,
                                        scrollDirection: Axis.horizontal,
                                        autoPlay: true,
                                        autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                        autoPlayInterval:
                                        Duration(milliseconds: (800 + 4000)),
                                        autoPlayCurve: Curves.linear,
                                        pauseAutoPlayInFiniteScroll: true,
                                        onPageChanged: (index, _) =>
                                        _model.carouselCurrentIndex2 = index,
                                      ),
                                    ),
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
              Align(
                alignment: AlignmentDirectional(0, 1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 16),
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
                              duration: Duration(milliseconds: 4000),
                              backgroundColor: FlutterFlowTheme.of(context).primary,
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
                      width: double.infinity,
                      height: 46,
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                      FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 14,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
