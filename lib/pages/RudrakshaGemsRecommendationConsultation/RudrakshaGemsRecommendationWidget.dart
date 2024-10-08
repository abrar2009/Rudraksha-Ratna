import 'package:rudraksha_cart/pages/RudrakshaGemsRecommendationConsultation/RudrakshaGemsRecommendationModel.dart';
import '../../auth/custom_auth/auth_util.dart';
import '../my_cart/my_cart_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:expandable/expandable.dart';
import 'package:carousel_slider/carousel_controller.dart' as slider;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide CarouselController;

class RudrakshaGemsRecommendationWidget extends StatefulWidget {
  const RudrakshaGemsRecommendationWidget({
    super.key,
    String? consultationtype,
  }) : this.consultationtype = consultationtype ?? 'home';

  final String consultationtype;

  @override
  State<RudrakshaGemsRecommendationWidget> createState() =>
      _RudrakshaGemsRecommendationWidgetState();
}

class _RudrakshaGemsRecommendationWidgetState
    extends State<RudrakshaGemsRecommendationWidget> {
  late RudrakshaGemsRecommendationModel _model;

  final RudrakshascaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RudrakshaGemsRecommendationModel());

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
        key: RudrakshascaffoldKey,
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 80),
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
                                  'Rudraksha & Gems Recommendation',
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
                                            'Receive Rudraksha & Gemstone Recommendation from Rudra Centre Experts based on Astrology Chart & Chakra Analysis. ',
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
                                            textAlign: TextAlign.justify
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
                                          width:
                                          MediaQuery.sizeOf(context).width *
                                              0.835,
                                          decoration: BoxDecoration(),
                                          child: Text(
                                            'Empower your Career/Business & Attract Wealth and Abundance. ',
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
                                              textAlign: TextAlign.justify
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
                                            'Achieve Holistic Health & Experience Relief from Back Pain, Knee Pain, Body Aches, Headaches, Migraine, Sinus Congestion, Acidity, Diabetes & More ',
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
                                              textAlign: TextAlign.justify
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
                                            'Experience Harmonious Relationships with Colleagues, Seniors, Spouse, Family Members. Relief from Stress, Irritability, Frustration, Anger, Jealousy, Hopelessness, Anxiety, OCD. ',
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
                                              textAlign: TextAlign.justify
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8)),
                                    ),
                                    Builder(
                                      builder: (context) {
                                        if (widget!.consultationtype == 'home') {
                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
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
                                                      'https://www.youtube.com/watch?v=l8oD8sBigqM');
                                                },
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(0),
                                                      child: Image.network(
                                                        '${FFAppConstants.consultationWithSakhashreereeImageUrl}/Rudraksha-&-Gems-Recommendation.jpg',
                                                        width: MediaQuery.sizeOf(
                                                            context)
                                                            .width *
                                                            0.99,
                                                        height: 228,
                                                        fit: BoxFit.contain,
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
                                                          child: Image.network(
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
                                              ),
                                              Text(
                                                'Balance your Chakras With Rudraksha Ratna Science Therapy & Achieve Healing & Empowerment in Health, Career & Relationships ',
                                                  style: FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF575758),
                                                    fontSize: 15,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.w500,
                                                    lineHeight: 1.5,
                                                  ),
                                                  textAlign: TextAlign.justify
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
                                                'Rudraksha Peads and gemstones runctiotl to cleanse and balance your chakras. thereby ervpowering you and enhancing your aura. Qernarkably, this transrorrnaLion can occur in as little as five davs when worn according to Qudraksha (QaLna Chakra Therapy. Once\nLine relevant chakras are opened and hatrvonized, individuals guin\nL ine empowerment needed 10 achieve success in physical,ernolicnal, and \',vorldly so+eres Of life.',
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
                        SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFE3CCE3),
                          ),
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(16, 20, 16, 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'What is the procedure of Rudraksha and Gemstone Recommendation?',
                                  textAlign: TextAlign.center,
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
                                        'Once the consultation is booked you will receive a confirmation email from our side. ',
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
                                          textAlign: TextAlign.justify
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
                                        'You will receive a link to a questionnaire which will generate your chakra analysis report & horoscope. ',
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
                                          textAlign: TextAlign.justify
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
                                        'Once you submit this questionnaire Rudra Centre Experts will contact you for a suitable time for the consultation, you can choose to connect via Phone Call, WhatsApp Call, Zoom, Google Meet or Skype. ',
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
                                          textAlign: TextAlign.justify
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
                                        'The consultation dives deep into your issues related to health, career & relationships during the consultation the root cause of your problems will be identified, and practical solutions after psychometric assessment will be offered to overcome them. Along with this appropriate Rudraksha & Gemstone combinations, Yantras, Mantras & Meditation techniques will be prescribed for healing & empowerment in all spheres of life. ',
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
                                          textAlign: TextAlign.justify
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
                                      width: MediaQuery.sizeOf(context).width * 0.835,
                                      decoration: BoxDecoration(),
                                      child: Text(
                                        'After the consultation you will receive an email with the chakra analysis report, horoscope & recommendations within 1 – 2 workings days. ',
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
                                          textAlign: TextAlign.justify
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 8)),
                                ),
                              ].divide(SizedBox(height: 16)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                          child: Container(
                            width: double.infinity,
                            
                            decoration: BoxDecoration(
                              //color: Color(0xFFE3CCE3),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(0),
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
                                        width:
                                        MediaQuery.sizeOf(context).width * 0.835,
                                        decoration: BoxDecoration(),
                                        child: Text("Your thought process will become streamlined & clear",style: FlutterFlowTheme.of(context)
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
                                        width:
                                        MediaQuery.sizeOf(context).width * 0.835,
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          'You will see your obstacles as opportunities for growth & learning ',
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
                                        width:
                                        MediaQuery.sizeOf(context).width * 0.835,
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          'You will be able to set clear well-defined goals and achieve them ',
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
                                        width:
                                        MediaQuery.sizeOf(context).width * 0.835,
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          'You will experience relief from your health issues',
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
                                        width:
                                        MediaQuery.sizeOf(context).width * 0.835,
                                        decoration: BoxDecoration(),
                                        child: Text("You will Grow in your Career", style: FlutterFlowTheme.of(context)
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
                                  ), Row(
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
                                        width:
                                        MediaQuery.sizeOf(context).width * 0.835,
                                        decoration: BoxDecoration(),
                                        child: Text("You will improve your relationships both personal as well as professional ", style: FlutterFlowTheme.of(context)
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
                                  ), Row(
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
                                        width:
                                        MediaQuery.sizeOf(context).width * 0.835,
                                        decoration: BoxDecoration(),
                                        child: Text("You will experience harmony with your family, friends & surroundings ", style: FlutterFlowTheme.of(context)
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
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 17, 0, 0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width * 0.933,
                                      decoration: BoxDecoration(),
                                      child: Text("You will be able to self-diagnose your issues and chakra imbalances & remove the negative thought process(s)/belief system(s) with the meditation technique taught to you in the consultation ",
                                        textAlign: TextAlign.justify,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF575758),
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                          lineHeight: 1.5,
                                        ),
                                      ),
                                    ),
                                  ), 
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 17, 0, 0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width * 0.933,
                                      decoration: BoxDecoration(),
                                      child: Text("If you are not satisfied with the consultation, there is 100% money back guarantee no questions asked ",
                                        textAlign: TextAlign.justify,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF575758),
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                          lineHeight: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 10)),
                              ),
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
                                      'Chakras Balancing Tools',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 18,
                                        letterSpacing: 0.38,
                                        fontWeight: FontWeight.w600,
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
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            '${FFAppConstants.consultationWithSakhashreereeImageUrl}/rudraksha.png',
                                            width: 106,
                                            height: 90,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Rudraksha',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'Suitable combinations of Rudraksha beads for empowerment',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF575758),
                                            letterSpacing: 0,
                                          ),

                                        ),
                                      ].divide(SizedBox(height: 6)),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            '${FFAppConstants.consultationWithSakhashreereeImageUrl}/gemstones.png',
                                            width: 106,
                                            height: 90,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Gemstone',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'Suitable gemstones as per your Life Chart and Chakra report. Additionally, the report verifies the stone you are already wearing for its suitability and suggests its correct placement ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF575758),
                                            letterSpacing: 0,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ].divide(SizedBox(height: 6)),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            '${FFAppConstants.consultationWithSakhashreereeImageUrl}/yantra.png',
                                            width: 106,
                                            height: 90,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Yantra',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'Suitable Yantras as per your chart',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF575758),
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 6)),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            '${FFAppConstants.consultationWithSakhashreereeImageUrl}/use-of-metal-and-color.png',
                                            width: 106,
                                            height: 90,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Use of',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'Suitable metals, colours, numbers and directions',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF575758),
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 6)),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            '${FFAppConstants.consultationWithSakhashreereeImageUrl}/mantra.png',
                                            width: 106,
                                            height: 90,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Mantras and Daily affirmations',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'Mantras and Daily affirmations',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF575758),
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 6)),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            '${FFAppConstants.consultationWithSakhashreereeImageUrl}/meditation.png',
                                            width: 106,
                                            height: 90,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Meditation',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'A powerful technique to release deep rooted fears and negative belief & thought patterns ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF575758),
                                            letterSpacing: 0,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ].divide(SizedBox(height: 6)),
                                    ),
                                  ].divide(SizedBox(height: 30)),
                                ),
                              ].divide(SizedBox(height: 16)),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'What are Rudrakshas? \nHow Do they Work?',
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child:
                                Image.network(
                                  '${FFAppConstants.consultationWithSakhashreereeImageUrl}/how-rudraksha-works.jpg',
                                  width: 327.0,
                                  height: 189.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Text(
                                'Rudraksha beads range from 1-mukhi to 21-mukhi and each has a different property which works on balancing the energies of different Chakras by resonance. They work like Capacitors and store Bioenergy, when they are in sync with an individual’s energy system, they release this bioenergy and emit a particular frequency which corresponds to a particular Chakra’s inherent balanced frequency. This creates resonance and the Rudraksha forces the Chakra to become balanced. Over the years Sakhashree Neeta researched extensively over Rudraksha & Gemstones their presiding deity, ruling planets & corresponding chakras & their placement over the human body which will tap into their full potential and devised RRST which is the most powerful healing therapy known the Humankind. ',
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
                        Container(
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
                                  'How to Gemstones Work?',
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
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child:  Image.network(
                                    '${FFAppConstants.consultationWithSakhashreereeImageUrl}/how-gems-works.jpg',
                                    width: 327.0,
                                    height: 189.0,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(
                                  'Gems are also considered as storehouses of divine energy. Gems absorb, reflect, and radiate different frequencies of light and with their constant contact with the skin bring about changes in the body’s energy field. Each color ray relates to one or more of the Chakras. Sun rays passing through a gemstone make it emit a cosmic color that is absorbed by the body Chakras, bringing the affected Chakra to a state of balance. Sakhashree curates and recommend only natural, untreated and unheated gemstones which enhances the beneficial effects and nullifies the malefic of the Navgrahas (9 planets) & balances the Chakras of the individual. ',
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
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'What is Rudraksha Ratna Science Therapy (RRST)?',
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: Image.network(
                                  '${FFAppConstants.consultationWithSakhashreereeImageUrl}/rrct.jpg',
                                  width: double.infinity,
                                //  height: 200,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Text(
                                'Rudraksha Ratna Science Therapy (RRST) is the science of using specific Rudraksha and Ratna (Gemstone) on the body for balancing the Chakras. This holistic healing therapy was devised by Sakhashree along with her team of doctors, scientists, researchers, and scholars after two decades of research and through working with several clients from different walks of life. This science taps the power of Rudraksha and Gemstones, so that 100% of their properties are utilized to open the blocked Chakras. Rudraksha Ratna Science Therapy (RRST) details the methodology of usage of various Rudraksha bead or Gemstones to derive best results. ',
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
                        Container(
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
                                  'What are Chakras?',
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
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.network(
                                    '${FFAppConstants.consultationWithSakhashreereeImageUrl}/chakra-energy-system-of-human-body.jpg',
                                    width: double.infinity,
                                    //  height: 200,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(
                                  'Chakras are the most important parts of the energy system of the human body. Chakras are primary energy centres or nodes; one may visualize them as rotating spiral vortex of energies. They rotate, absorb and emit universal energies for the optimal working of the human energy system. The mention of Chakras is available in old Vedic texts like the Rig Ved, Yog Sutras of Patanjali, Jabala Darshan Upanishad, Shandilya Upanishad. Later these texts were interpreted & contemporized for many modern alternative healing modalities. Although there are 114 Chakras the 7 major Chakras which lie along the spinal cord of the human body from the base of the spine till the crown of the head are the most important. These 7 primary Chakras are Muladhara (Root), Swadhisthana (Sacral), Manipura (Solar Plexus), Anahata (Heart), Vishuddha (Throat), Ajna (3rd Eye) and Sahasrara (Crown) Chakra. They govern different aspects of our mental, emotional & financial/material wellbeing. ',
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
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'RRST Combinations',
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
                                    '${FFAppConstants.consultationWithSakhashreereeImageUrl}/supreme-kavacham-power.jpg',
                                    width: 300,
                                    height: 200,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Supreme Kavacham Power',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 20,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                height: 256,
                                decoration: BoxDecoration(),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.network(
                                    '${FFAppConstants.consultationWithSakhashreereeImageUrl}/surya-power.jpg',
                                    width: 300,
                                    height: 200,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Text(
                                'Surya power',
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
                          decoration: BoxDecoration(
                            color: Color(0xFFE3CCE3),
                          ),
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(16, 16, 16, 24),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Treatments Available For',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 18,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.asset(
                                    'assets/images/Group1686551151.png',
                                    width: double.infinity,
                                    height: 378,
                                    fit: BoxFit.fill,
                                  ),
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
                                                                style: FlutterFlowTheme.of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                  fontFamily: 'Montserrat',
                                                                  //color: FlutterFlowTheme.of(context).secondaryText,
                                                                  fontSize: 15,
                                                                  letterSpacing: 0,
                                                                  fontWeight: FontWeight.w500,
                                                                  //lineHeight: 1.5,
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
                                              'What is the timing of the consultation? I am from the East Coast of the USA.',
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
                                              'After the consultation is booked, Sakhashree will contact you at a mutually convenient time. Normally, the consultation slots are between 8:00 a.m. and 8:00 p.m. (IST) from Monday to Sunday. ',
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
                                              '02. Is it safe to wear Rudraksha & Gemstones as per RRST? Will Rudraksha & Gemstone suit me? ',
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
                                              'Yes, Rudraksha and Gemstone when worn as per RRST suit everyone regardless of their horoscope. We have healed millions of individuals over 20 years with this divine therapy. You can go through our testimonials. ',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                letterSpacing: 0,
                                              ),
                                              textAlign: TextAlign.justify
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
                                              .expandableExpandableController3,
                                          child: ExpandablePanel(
                                            header: Text(
                                              '03. What if I am not satisfied with the consultation? ',
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
                                              'Our Experts will dive deep into your issues and resolve all your concerns, till date we have a track record of 100% satisfaction. However in case you don’t feel satisfied with the consultation we have a no questions asked 100% money back guarantee. ',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                letterSpacing: 0,
                                              ),
                                                textAlign: TextAlign.justify
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
                                              '04.When will I receive my report? ',
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
                                              'For email consultation once you submit your filled questionnaire you shall receive the report with remedies within 1-2 working days.\nFor Video Call consultation you will receive the report after 1-2 working days post completion of the video call session  For Video Call consultation you will receive the report after 1-2 working days post completion of the video call session ',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                letterSpacing: 0,
                                              ),
                                              textAlign: TextAlign.justify
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
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Text(
                                                            'Puja Services \nRecommendation',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Montserrat',
                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                              fontSize: 17,
                                                              letterSpacing: 0,
                                                              fontWeight: FontWeight.w600,
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
                                                              padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                              color: Colors.transparent,
                                                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                fontFamily: 'Montserrat',
                                                                color: Colors.white,
                                                                letterSpacing: 0,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                              elevation: 0,
                                                              borderSide: BorderSide(
                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                width: 2,
                                                              ),
                                                              borderRadius: BorderRadius.circular(8),
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
                                            0, min(valueOrDefault<int>(
                                              _model.countControllerValue, 0,
                                            ), 3)),
                                        viewportFraction: 0.9,
                                        disableCenter: true,
                                        enlargeCenterPage: true,
                                        enlargeFactor: 0.25,
                                        enableInfiniteScroll: true,
                                        scrollDirection: Axis.horizontal,
                                        autoPlay: true,
                                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                                        autoPlayInterval: Duration(milliseconds: (800 + 4000)),
                                        autoPlayCurve: Curves.linear,
                                        pauseAutoPlayInFiniteScroll: true,
                                        onPageChanged: (index, _) => _model.carouselCurrentIndex2 = index,
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
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 14),
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
                    text: 'Book Now - INR 1,100',
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
