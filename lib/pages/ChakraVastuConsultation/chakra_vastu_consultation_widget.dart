import 'package:rudraksha_cart/auth/custom_auth/auth_util.dart';
import '../my_cart/my_cart_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:carousel_slider/carousel_controller.dart' as slider;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'chakra_vastu_consultation_model.dart';
export 'chakra_vastu_consultation_model.dart';

class ChakraVastuConsultationWidget extends StatefulWidget {
  const ChakraVastuConsultationWidget({
    super.key,
    String? consultationtype,
  }) : this.consultationtype = consultationtype ?? 'home';

  final String consultationtype;

  @override
  State<ChakraVastuConsultationWidget> createState() =>
      _ChakraVastuConsultationWidgetState();
}

class _ChakraVastuConsultationWidgetState
    extends State<ChakraVastuConsultationWidget> {
  late ChakraVastuConsultationModel _model;

  final ChakraVastuConsultationWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChakraVastuConsultationModel());

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
        key: ChakraVastuConsultationWidgetscaffoldKey,
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
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 80),
                  child: SingleChildScrollView(
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
                                  'Chakra Vastu Consultation',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Builder(
                                      builder: (context) {
                                        if (widget!.consultationtype ==
                                            'home') {
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
                                                          'https://www.youtube.com/watch?v=iG49XijS9k0');
                                                    },
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
                                                        '${FFAppConstants.chakraVastuConsultation}/vastu-consl-video-banner.jpg',
                                                        width:
                                                        MediaQuery.sizeOf(
                                                            context)
                                                            .width *
                                                            0.99,
                                                        height: 228,
                                                        fit: BoxFit.cover,
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
                                                        BorderRadius
                                                            .circular(0),
                                                        child:
                                                        CachedNetworkImage(
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
                                                'Discover the transformative power of Divine Vastu Science. Achieve harmony in your living space by balancing the Chakras of the Vastu Purush, 5 Elements, Colors, 8 Directions, Cuts, and Extensions. Experience success in your career, health, and relationships as you align with your surroundings. ',
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                  fontSize: 15,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.normal,
                                                  lineHeight: 1.5,
                                                ),
                                                textAlign: TextAlign.justify,
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
                                                    BorderRadius.circular(
                                                        0),
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
                                                        BorderRadius
                                                            .circular(0),
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
                                  ].divide(SizedBox(height: 10)),
                                ),
                              ),
                            ].divide(SizedBox(height: 10)),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFE3CCE3),
                          ),
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'What will be required from my side?',
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
                                Text(
                                  'We will require:',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
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
                                        'Concerns Related to Health, Career, Relationships and Wealth of the individuals residing in the dwelling. ',
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
                                        'Floor plan of the house.',
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
                                        'Images of Every Room.',
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
                                        'Video Call Session for a detailed analysis of colors, cuts, and extensions by the consultant. ',
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
                                        'North degrees.',
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
                                        'Google Map location.',
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
                              ].divide(SizedBox(height: 16)),
                            ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'What is the Procedure of Chakra Vastu Consultation?',
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
                                        'Once you book the consultation, you will receive a confirmation email from our side. ',
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
                                        'Our consultant will contact you regarding the mentioned details. ',
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
                                        'A video call session will be arranged to map the colors, cuts, and extensions in detail. ',
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
                                        'Once all the details are received, we will prepare the report mapping the Vastu Purush to your floor plan. ',
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
                                        'The report will comprise of Elemental Balance, Color Balance, Energy Balance, Defects, and Doshas. ',
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
                                        'Along with this, we will also prepare a report comprising all the remedies to balance the energies of the house. ',
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
                                        'Both reports will be shared with you.',
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
                                        'A call session to explain the various issues in the dwelling and how the remedies suggested will help will be organized. ',
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
                                Text(
                                  'If you are not satisfied with the consultation, you will receive a full refund, no questions asked. ',
                                  textAlign: TextAlign.start,
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
                            EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 24, 16, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Our Vastu Tools & Remedies',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 22,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Container(
                                        height: 256,
                                        decoration: BoxDecoration(),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(0),
                                          child: Image.network(
                                            '${FFAppConstants.chakraVastuConsultation}/yantras.jpg',
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
                                  'Yantras',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 20,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: CachedNetworkImage(
                                    fadeInDuration: Duration(milliseconds: 500),
                                    fadeOutDuration:
                                    Duration(milliseconds: 500),
                                    imageUrl:
                                    '${FFAppConstants.chakraVastuConsultation}/Auspicious-Artifacts.jpg',
                                    width: 300,
                                    height: 200,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(
                                  'Auspicious Artifacts',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 20,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: CachedNetworkImage(
                                    fadeInDuration: Duration(milliseconds: 500),
                                    fadeOutDuration:
                                    Duration(milliseconds: 500),
                                    imageUrl:
                                    '${FFAppConstants.chakraVastuConsultation}/vastu-rectifiers.jpg',
                                    width: 300,
                                    height: 200,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(
                                  'Vastu Rectifiers',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 20,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: CachedNetworkImage(
                                    fadeInDuration: Duration(milliseconds: 500),
                                    fadeOutDuration:
                                    Duration(milliseconds: 500),
                                    imageUrl:
                                    '${FFAppConstants.chakraVastuConsultation}/pyramids.jpg',
                                    width: 300,
                                    height: 200,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(
                                  'Pyramids',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 20,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ].divide(SizedBox(height: 16)),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 16),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 16, 16, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(0),
                                          child: Image.network(
                                            '${FFAppConstants.consultationWithSakhashreereeImageUrl}/experience-relief-from-health-issues.webp',
                                            width: double.infinity,
                                            height: 228,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Changes Experienced After the Consultation',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            fontSize: 18,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
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
                                              width: MediaQuery.sizeOf(context)
                                                  .width *
                                                  0.835,
                                              decoration: BoxDecoration(),
                                              child: Text(
                                                'You will experience peace & positivity in the dwelling',
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF575758),
                                                  fontSize: 13,
                                                  letterSpacing: 0,
                                                  fontWeight:
                                                  FontWeight.w500,
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
                                              width: MediaQuery.sizeOf(context)
                                                  .width *
                                                  0.835,
                                              decoration: BoxDecoration(),
                                              child: Text(
                                                'Harmonious interactions & relationship amongst the individuals residing in the dwelling ',
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF575758),
                                                  fontSize: 13,
                                                  letterSpacing: 0,
                                                  fontWeight:
                                                  FontWeight.w500,
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
                                              width: MediaQuery.sizeOf(context)
                                                  .width *
                                                  0.835,
                                              decoration: BoxDecoration(),
                                              child: Text(
                                                'Success in different projects, Career Growth & Abundance',
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF575758),
                                                  fontSize: 13,
                                                  letterSpacing: 0,
                                                  fontWeight:
                                                  FontWeight.w500,
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
                                              width: MediaQuery.sizeOf(context)
                                                  .width *
                                                  0.835,
                                              decoration: BoxDecoration(),
                                              child: Text(
                                                'Success in different projects, Career Growth & Abundance',
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF575758),
                                                  fontSize: 13,
                                                  letterSpacing: 0,
                                                  fontWeight:
                                                  FontWeight.w500,
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
                                              width: MediaQuery.sizeOf(context).width * 0.835,
                                              decoration: BoxDecoration(),
                                              child: Text(
                                                'Removal of Different Obstacles in Personal and Professional Life, Good Health, and Spiritual Elevation of Individuals Residing in the Dwelling. ',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                                      ].divide(SizedBox(height: 10)),
                                    ),
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
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFE3CCE3),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 24, 16, 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(0),
                                        child: Image.network(
                                          '${FFAppConstants.chakraVastuConsultation}/chakra-vastu.png',
                                          width: double.infinity,
                                          height: 200,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Text(
                                        'What is Chakra Vastu?',
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
                                        'Vastu Shastra is an ancient science of construction and architecture compiled from various Puranas and Agamas. All construction done in ancient times, especially that of building a temple, adhered strictly to Vastu principles. Vastu Shastra uses shapes (mandalas), directions, principals, and concepts so that any construction and nature can exist in harmony and in fact benefit from each other. Vastu Shastra also helps one derive maximum benefits from various energies that reside in various directions. Vastu Shastra, in accordance with Chakra Science, is Chakra Vastu. Devised by Sakhashree Neeta, Chakra Vastu is a science that maps the 7 chakras (subtle energies in the human aura) with the Vastu Shastra (or the Vastu Purush). The rules and principles of Chakra Vastu, in alignment with the construction of houses or flats, ensure the harmony of the residents with various elemental energies leading to health, happiness, growth, and abundance in all aspects of their lives. ',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).secondaryText,
                                          fontSize: 15,
                                          letterSpacing: 0,
                                          lineHeight: 1.5,
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ].divide(SizedBox(height: 10)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'About Sakhashree Neeta',
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
                                        'Sakhashree Neeta is a globally renowned expert in chakra healing, Rudraksha, and gemstones. With over 20 years of counseling experience using chakra therapy, she has empowered individuals from diverse backgrounds to achieve success. With over 5 million views, she has created a stunning collection of over 500 YouTube videos on chakras, spirituality, empowerment, and rudrakshas. She has dedicated years to researching chakras and ancient Hindu sciences such as healing, astrology, and Vastu Shastra. She has connected the energy of homes with the 7 Chakras of Vastu Purush. These Chakras exist in every dwelling and impact the energy levels of its residents. Through her research, she has created Chakra Vastu, a practice that harmonizes colors, directions, chakras, cuts, and extensions within a dwelling. Its purpose is to enable residents to live a blissful and balanced life in all aspects. ',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).secondaryText,
                                          fontSize: 15,
                                          letterSpacing: 0,
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
                                                AlwaysStoppedAnimation<
                                                    Color>(
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
                                            final testimonials =  getJsonField(
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
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0, 10, 0, 10),
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      elevation: 5,
                                                      shape:
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(12),
                                                      ),
                                                      child: Container(
                                                        width: 343,
                                                        height: 240,
                                                        decoration:
                                                        BoxDecoration(
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
                                                              .fromSTEB(
                                                              16,
                                                              12,
                                                              16,
                                                              12),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .max,
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
                                                                        .circular(0),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/image_442.png',
                                                                      width: 26,
                                                                      height:
                                                                      19,
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
                                                                style: FlutterFlowTheme.of(
                                                                    context)
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
                                                                  textAlign: TextAlign.justify,
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
                                                carouselController: _model
                                                    .carouselController1 ??=
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
                                                  Duration(
                                                      milliseconds: 800),
                                                  autoPlayInterval: Duration(
                                                      milliseconds:
                                                      (800 + 4000)),
                                                  autoPlayCurve: Curves.linear,
                                                  pauseAutoPlayInFiniteScroll:
                                                  true,
                                                  onPageChanged: (index, _) =>
                                                  _model.carouselCurrentIndex1 =
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
                                      iconPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      color:
                                      FlutterFlowTheme.of(context).primary,
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
                                              .expandableExpandableController1,
                                          child: ExpandablePanel(
                                            header: Text(
                                              '01. Can we still conduct this consultation without an exact floor plan of my home? ',
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
                                              'Yes, we can work with rough drafts of the house and also have a video call to talk more about the design and colors of the house. ',
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                                              '02. How to find out the north degrees of my house? ',
                                              style: FlutterFlowTheme.of(
                                                  context)
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
                                              'You can get the North Degrees of the house with the google map location ',
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Montserrat',
                                                letterSpacing: 0,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                            theme: ExpandableThemeData(
                                              tapHeaderToExpand: true,
                                              tapBodyToExpand: false,
                                              tapBodyToCollapse: false,
                                              headerAlignment: ExpandablePanelHeaderAlignment.center,
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
                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        color: Colors.white,
                                        child: ExpandableNotifier(
                                          controller: _model.expandableExpandableController3,
                                          child: ExpandablePanel(
                                            header: Text(
                                              '03. What if I am not satisfied with the consultation? ',
                                              style: FlutterFlowTheme.of(context).displaySmall.override(
                                                fontFamily: 'Outfit',
                                                color: Color(0xFF313131),
                                                fontSize: 14,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                            collapsed: Container(),
                                            expanded: Text(
                                              'To date, we have a track record of 100% satisfaction. However, in case you don’t feel satisfied with the consultation, we have a no-questions-asked 100% money-back guarantee. ',
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Montserrat',
                                                letterSpacing: 0,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                            theme: ExpandableThemeData(
                                              tapHeaderToExpand: true,
                                              tapBodyToExpand: false,
                                              tapBodyToCollapse: false,
                                              headerAlignment: ExpandablePanelHeaderAlignment.center,
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
                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        color: Colors.white,
                                        child: ExpandableNotifier(
                                          controller: _model.expandableExpandableController4,
                                          child: ExpandablePanel(
                                            header: Text(
                                              '04. When will I receive my report? ',
                                              style: FlutterFlowTheme.of(context).displaySmall.override(
                                                fontFamily: 'Outfit',
                                                color: Color(0xFF313131),
                                                fontSize: 14,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            collapsed: Container(),
                                            expanded: Text(
                                              'Once all of your information is received, you will receive the report within 5 days. ',
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 16),
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
                                ],
                              ),
                            ),
                          ),
                        ),
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
                                                  'Astrology\nConsultation',
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
                                                  'Chakra Cleansing\nMeditation with\nSakhashree ',
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
                                                  'Puja Services\nRecommendation',
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
              Align(
                alignment: AlignmentDirectional(0, 1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 16, 24, 16),
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
                              backgroundColor: FlutterFlowTheme.of(context).primary,
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
                              FlutterFlowTheme.of(context).primary,
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
