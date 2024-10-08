import 'package:rudraksha_cart/auth/custom_auth/auth_util.dart';
import '../my_cart/my_cart_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart' as slider;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'ChakraCleansingMeditationWithSakhashreeModel.dart';
export 'ChakraCleansingMeditationWithSakhashreeModel.dart';


class ChakraCleansingMeditationWithSakhashreeWidget extends StatefulWidget {
  const ChakraCleansingMeditationWithSakhashreeWidget({
    super.key,
    String? consultationtype,
  }) : this.consultationtype = consultationtype ?? 'home';

  final String consultationtype;

  @override
  State<ChakraCleansingMeditationWithSakhashreeWidget> createState() =>
      _ChakraCleansingMeditationWithSakhashreeWidgetState();
}

class _ChakraCleansingMeditationWithSakhashreeWidgetState extends State<ChakraCleansingMeditationWithSakhashreeWidget> {
  late ChakraCleansingMeditationWithSakhashreeModel _model;

  final ChakraCleansingMeditationWithSakhashreeWidgetscaffoldKey = GlobalKey<ScaffoldState>();
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(
        context, () => ChakraCleansingMeditationWithSakhashreeModel());

    _model.expandableExpandableController1 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController2 =
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
        key: ChakraCleansingMeditationWithSakhashreeWidgetscaffoldKey,
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
                                  'Chakra Cleansing Meditation With Sakhashree',
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
                                                      'https://www.youtube.com/watch?v=-8IGBIv4xgw&t=14s');
                                                },
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(0),
                                                      child: Image.network(
                                                        '${FFAppConstants.consultationWithSakhashreereeImageUrl}/consult-v-sakhashree.jpg',
                                                        width: MediaQuery.sizeOf(context).width * 0.99,
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
                                                'Discover the transformative power of meditation to release trauma, anxiety, and negative beliefs. Embrace peace, tranquility, and empowerment. ',
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                  fontSize: 15,
                                                  letterSpacing: 0,
                                                  //fontWeight: FontWeight.w500,
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
                                                'Rudraksha Beads and gemstones runctiotl to cleanse and balance your chakras. thereby ervpowering you and enhancing your aura. Qernarkably, this transrorrnaLion can occur in as little as five davs when worn according to Qudraksha (QaLna Chakra Therapy. Once\nLine relevant chakras are opened and hatrvonized, individuals guin\nL ine empowerment needed 10 achieve success in physical,ernolicnal, and \',vorldly so+eres Of life.',
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
                                                textAlign: TextAlign.justify,
                                              ),
                                            ].divide(SizedBox(height: 16)),
                                          );
                                        }
                                      },
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Text(
                                        'Get Freedom From',
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
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            '${FFAppConstants.chakraCleansingMeditationWithSakhashree}/trauma.jpg',
                                            width: 130,
                                            height: 97,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            '${FFAppConstants.chakraCleansingMeditationWithSakhashree}/obsessive-thoughts.jpg',
                                            width: 130,
                                            height: 97,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            '${FFAppConstants.chakraCleansingMeditationWithSakhashree}/negativity.jpg',
                                            width: 130,
                                            height: 97,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            '${FFAppConstants.chakraCleansingMeditationWithSakhashree}/anxiety.jpg',
                                            width: 130,
                                            height: 97,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            '${FFAppConstants.chakraCleansingMeditationWithSakhashree}/limiting-beliefs-pattern.jpg',
                                            width: 130,
                                            height: 97,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            '${FFAppConstants.chakraCleansingMeditationWithSakhashree}/self-doubt.jpg',
                                            width: 130,
                                            height: 97,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            '${FFAppConstants.chakraCleansingMeditationWithSakhashree}/low-confidence.jpg',
                                            width: 130,
                                            height: 97,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            '${FFAppConstants.chakraCleansingMeditationWithSakhashree}/poor-self-worth.jpg',
                                            width: 130,
                                            height: 97,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ].divide(SizedBox(height: 10)),
                                ),
                              ),
                            ].divide(SizedBox(height: 10)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Container(
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
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(0),
                                    child: CachedNetworkImage(
                                      fadeInDuration: Duration(milliseconds: 500),
                                      fadeOutDuration:
                                      Duration(milliseconds: 500),
                                      imageUrl:
                                      '${FFAppConstants.chakraCleansingMeditationWithSakhashree}/dynamic-chakra-cleansing-meditation.jpg',
                                      width: double.infinity,
                                      height: 228,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Text(
                                    'What is Chakra Marjan Kriya (Dynamic Chakra Cleansing Meditation)?',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                      textAlign: TextAlign.justify
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width * 0.933,
                                      decoration: BoxDecoration(),
                                      child: Text(
                                        'Chakra Marjan Kriya is a dynamic fear-releasing process developed by globally renowned Chakra Healer Sakhashree Neeta. The guided session involves being witnesses to fear and emotions in an aware state and willingly driving them away forever. \n In this meditation, you will focus on your fears and negativity, which can be relationship discord, financial troubles, or adverse situations in personal, social, or professional life. After which, the meditation technique will be used to remove any deep-rooted fear and belief. With the release of deep-rooted fears, one is empowered to transform his or her life and overcome obstacles, problems, and sufferings. \n Uncover your deep-seated fears and negative beliefs and transform your life by connecting to the now, which is true wisdom and peace. Release these fears from their roots to experience positivity and self-power. \n Balance your chakras and heal naturally from low immunity and various diseases and ailments. Handle challenges and problems in personal, professional, and social life with ease. Find reasons for your problems and sufferings and find solutions to them by understanding the lessons of the chakras and being in tune with your true self. ',
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
                                    ),
                                  ),
                                ].divide(SizedBox(height: 10)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'What is the procedure of Chakra Marjan Kriya?',
                                      textAlign: TextAlign.justify,
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
                                              0.765,
                                          decoration: BoxDecoration(),
                                          child: Text(
                                            'Book a Dynamic Chakra Cleansing Session with Sakhashree online on the website. ',
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
                                              0.765,
                                          decoration: BoxDecoration(),
                                          child: Text(
                                            'Your order will be acknowledged, and your session will be scheduled within the next 24 to 48 hours. ',
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
                                              0.765,
                                          decoration: BoxDecoration(),
                                          child: Text(
                                            'A link to the Aura Chakra software application will be sent to you, in which you will be filling in your details, details of any issues you may be facing, and a questionnaire related to the 7 chakras. ',
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
                                              0.765,
                                          decoration: BoxDecoration(),
                                          child: Text(
                                            'A typical Chakra The Marjan Kriya session begins with a one-on-one counseling session with Sakhashree in which blockages of specific chakras are identified. ',
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
                                              0.765,
                                          decoration: BoxDecoration(),
                                          child: Text(
                                            'The session is followed by positive affirmations and relevant chakra activation. Beej mantra music to enliven the chakra session will also be played. ',
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
                                              0.765,
                                          decoration: BoxDecoration(),
                                          child: Text(
                                            'Finally, Sakhashree will help you identify the path you need to take to cleanse them, either with Rudraksha Ratna Science Therapy solutions or through chakra cleansing sessions. ',
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
                            ].divide(SizedBox(height: 16)),
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
                                    'Changes Experienced After the\nConsultation',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                      textAlign: TextAlign.justify
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
                                        MediaQuery.sizeOf(context).width * 0.835,
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          'You will prevent and experience relief from any health condition. ',
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
                                            textAlign: TextAlign.justify
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
                                        MediaQuery.sizeOf(context).width * 0.835,
                                        decoration: BoxDecoration(),
                                        child: Text("You will be able to self-diagnose your issues and chakra imbalances and remove the negative thought process(s) or belief system(s) with the meditation technique taught to you in the consultation. ", style: FlutterFlowTheme.of(context)
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
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 17, 0, 0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width * 0.933,
                                      decoration: BoxDecoration(),
                                      child: Text("There is a 100% money-back guarantee with no questions asked if you are not satisfied with the consultation.  ",
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
                            EdgeInsetsDirectional.fromSTEB(16, 10, 16, 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'About Sakhashree Neeta',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF313131),
                                    fontSize: 22,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                RichText(
                                  textScaler: MediaQuery.of(context).textScaler,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                        'Respected internationally, Sakhashree Neeta specializes in the healing of chakras, Rudraksha, and gemstones. She has promoted the success and empowerment of individuals from diverse backgrounds through her more than two decades of experience in counseling making use of chakra therapy. She has over 500 videos with over 5 million views on YouTube that discuss chakras, spirituality, empowerment, and rudrakshas. She has undertaken substantial research throughout the years regarding the chakras, ancient Hindu healing sciences, astrology, and the Vastu Shastra. The individual has linked the concept of dwelling energy with the seven Chakras of the Vastu Purush, which are present in each dwelling and have an impact on the energy levels of its occupants. She developed the Chakra Vastu, an architectural system that seeks to harmonize the diverse colors, directions, chakras, cuts, and extensions of a dwelling. By doing so, its residents may attain a state of complete harmony and well-being across every aspect of their lives. ',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).secondaryText,
                                          fontSize: 15,
                                          letterSpacing: 0,
                                          //fontWeight: FontWeight.w500,
                                          lineHeight: 1.5,
                                        ),
                                      )
                                    ],
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF575758),
                                      fontSize: 13,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.normal,
                                      lineHeight: 2.2,
                                    ),
                                  ),
                                    textAlign: TextAlign.justify
                                ),
                              ].divide(SizedBox(height: 10)),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: CachedNetworkImage(
                            fadeInDuration: Duration(milliseconds: 500),
                            fadeOutDuration: Duration(milliseconds: 500),
                            imageUrl:
                            '${FFAppConstants.chakraVastuConsultation}/about-sakhashree.jpg',
                            width: double.infinity,
                            height: 392,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFE3CCE3),
                          ),
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'What are Chakras? Benefits of Chakra Balancing',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                    lineHeight: 1.4,
                                  ),
                                    textAlign: TextAlign.justify
                                ),
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                  child: RichText(
                                    textScaler: MediaQuery.of(context).textScaler,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                          'Chakras are the most important parts of the energy system of the human body. Chakras are primary energy centers or nodes; one may visualize them as a rotating spiral vortex of energies. They rotate, absorb, and emit universal energies for the optimal working of the human energy system. The mention of chakras is available in old Vedic texts like the Rig Veda, Yog Sutras of Patanjali, Jabala Darshan Upanishad, and Shandilya Upanishad. Later, these texts were interpreted and contextualized for many modern alternative healing modalities. Although there are 114 chakras, the 7 major chakras, which lie along the spinal cord of the human body from the base of the spine until the crown of the head, are the most important. These 7 primary chakras are Muladhara (Root), Swadhisthana (Sacral), Manipura (Solar Plexus), Anahata (Heart), Vishuddha (Throat), Ajna (3rd Eye), and Sahasrara (Crown). They govern different aspects of our mental, emotional, and financial, material wellbeing. ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: FlutterFlowTheme.of(context).secondaryText,
                                            fontSize: 15,
                                            letterSpacing: 0,
                                            //fontWeight: FontWeight.w500,
                                            lineHeight: 1.5,
                                          ),
                                        )
                                      ],
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 13,
                                        letterSpacing: 0,
                                        lineHeight: 2,
                                      ),
                                    ),
                                      textAlign: TextAlign.justify
                                  ),
                                ),
                              ].divide(SizedBox(height: 10)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'How do Chakras affect our Health?',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                                  textAlign: TextAlign.justify
                              ),
                              RichText(
                                textScaler: MediaQuery.of(context).textScaler,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                      'The 7 Chakras align with endocrine glands, which produce important hormones and regulate various bodily systems. Balanced chakras are vital for optimal functioning of organs and systems. Imbalances or blockages in the Chakra system can lead to health issues and diseases. The images below depict the 7 Chakras, each responsible for governing specific endocrine glands and systems in the body. ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        fontSize: 15,
                                        letterSpacing: 0,
                                        //fontWeight: FontWeight.w500,
                                        lineHeight: 1.5,
                                      ),
                                    )
                                  ],
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF575758),
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    lineHeight: 1.5,
                                  ),
                                ),
                                  textAlign: TextAlign.justify
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 34, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: Image.asset(
                                  'assets/images/_com.apple.Pasteboard_8.png',
                                  width: double.infinity,
                                  height: 228,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.asset(
                                    'assets/images/_com.apple.Pasteboard_9.png',
                                    width: double.infinity,
                                    height: 228,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Text(
                                'How do Chakras affect Your Career or Business?',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                                  textAlign: TextAlign.justify
                              ),
                              RichText(
                                textScaler: MediaQuery.of(context).textScaler,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                      'The Chakras govern our emotions, aspirations, and energy levels. An empowered Chakra attracts suitable situations and people for our material growth. It fosters commitment and inspires innovative approaches to career advancement. Each chakra bestows unique skills that aid personal and professional growth. ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        fontSize: 15,
                                        letterSpacing: 0,
                                        //fontWeight: FontWeight.w500,
                                        lineHeight: 1.5,
                                      ),
                                    )
                                  ],
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF575758),
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    lineHeight: 2,
                                  ),
                                ),
                                  textAlign: TextAlign.justify
                              ),
                            ].divide(SizedBox(height: 10)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(0),
                                        child: Image.network(
                                          '${FFAppConstants.consultationWithSakhashreereeImageUrl}/Muladhara.png',
                                          width: 106,
                                          height: 90,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Text(
                                        'Muladhara',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'Security, Stability, Sense\nof Belonging.',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF575758),
                                          fontSize: 13,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 8)),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(0),
                                        child: Image.network(
                                          '${FFAppConstants.consultationWithSakhashreereeImageUrl}/swadhisthana.png',
                                          width: 106,
                                          height: 90,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Text(
                                        'Swadhisthana',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'Self-Identity. Emotional\nBalance.',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF575758),
                                          fontSize: 13,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 8)),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(0),
                                        child: Image.network(
                                          '${FFAppConstants.consultationWithSakhashreereeImageUrl}/manipura.png',
                                          width: 106,
                                          height: 90,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Text(
                                        'Manipura',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'Leadership Life\nPurpose.',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF575758),
                                          fontSize: 13,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 8)),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(0),
                                        child: Image.network(
                                          '${FFAppConstants.consultationWithSakhashreereeImageUrl}/anahata.png',
                                          width: 106,
                                          height: 90,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Text(
                                        'Heart Chakra',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'Networking,Trust\nRelationships.',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF575758),
                                          fontSize: 13,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 8)),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(0),
                                        child: Image.network(
                                          '${FFAppConstants.consultationWithSakhashreereeImageUrl}/vishuddha.png',
                                          width: 106,
                                          height: 90,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Text(
                                        'Throat Chakra',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'Expression,\nCommunication& Problem\nSolving.',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF575758),
                                          fontSize: 13,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 8)),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(0),
                                        child: Image.network(
                                          '${FFAppConstants.consultationWithSakhashreereeImageUrl}/anjna.png',
                                          width: 106,
                                          height: 90,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Text(
                                        '3rd Eye Chakra',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'Foresight, Intuition,\nStrategic Planning.',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF575758),
                                          fontSize: 13,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 8)),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(0),
                                        child: Image.network(
                                          '${FFAppConstants.consultationWithSakhashreereeImageUrl}/sahasrara.png',
                                          width: 106,
                                          height: 90,
                                          fit: BoxFit.contain,
                                          alignment: Alignment(0, -1),
                                        ),
                                      ),
                                      Text(
                                        'Crown Chakra',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'Manifestation,\nAbundance, Collective\nConsciousness,Innovative ldeas',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF575758),
                                          fontSize: 13,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 8)),
                                  ),

                                ],
                              ),
                              RichText(
                                textScaler: MediaQuery.of(context).textScaler,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:'All of these qualities contribute to exponential career growth and the manifestation of prosperity and expansion, which are intrinsic qualities of every individual. ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        fontSize: 15,
                                        letterSpacing: 0,
                                        //fontWeight: FontWeight.w500,
                                        lineHeight: 1.5,
                                      ),
                                    ),
                                  ],
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF575758),
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    lineHeight: 2,
                                  ),
                                ),
                                  textAlign: TextAlign.justify
                              ),
                              RichText(
                                textScaler: MediaQuery.of(context).textScaler,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:'Consult today to establish a connection with your TRUE NATURE. ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        fontSize: 15,
                                        letterSpacing: 0,
                                        //fontWeight: FontWeight.w500,
                                        lineHeight: 1.5,
                                      ),
                                    )
                                  ],
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF575758),
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    lineHeight: 2,
                                  ),
                                ),
                                  textAlign: TextAlign.justify
                              ),
                            ].divide(SizedBox(height: 20)),
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
                                  'How do Chakras affect Your Relationships?',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                RichText(
                                  textScaler: MediaQuery.of(context).textScaler,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                        'The Chakras govern emotions, insecurities, and fears. ay aligning with their lessons, we can form more holistic, ealthy, and harmonious relationships. While you cannot control others\' behavior, you have the power to control your  sponse and also speak your truth with innate power. ay doing so, you can protect your interests and maintain your boundaries and also positively influence others.',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).secondaryText,
                                          fontSize: 15,
                                          letterSpacing: 0,
                                          //fontWeight: FontWeight.w500,
                                          lineHeight: 1.5,
                                        ),
                                      )
                                    ],
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF575758),
                                      fontSize: 13,
                                      letterSpacing: 0,
                                      lineHeight: 2,
                                    ),
                                  ),
                                    textAlign: TextAlign.justify
                                ),
                                Text(
                                  'When the 7 chakras are imbalanced One May Experience:',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                    textAlign: TextAlign.start
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(0),
                                                child: Image.network(
                                                  '${FFAppConstants.consultationWithSakhashreereeImageUrl}/Muladhara.png',
                                                  width: 106,
                                                  height: 90,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Text(
                                                'Muladhara',
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                'Insecurity, \nLack of Stability, \nFear of Abandonment, \nBad Relationship\n with Parents. ',
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF575758),
                                                  fontSize: 13,
                                                  letterSpacing: 0,
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 8)),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(0),
                                                child: Image.network(
                                                  '${FFAppConstants.consultationWithSakhashreereeImageUrl}/swadhisthana.png',
                                                  width: 106,
                                                  height: 90,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Text(
                                                'Swadhisthana',
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                'Fear of Being \nTaken Advantage \nof. Lack of \nSelf-Identity. ',
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF575758),
                                                  fontSize: 13,
                                                  letterSpacing: 0,
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 8)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(0),
                                                child: Image.network(
                                                  '${FFAppConstants.consultationWithSakhashreereeImageUrl}/manipura.png',
                                                  width: 106,
                                                  height: 90,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Text(
                                                'Manipura',
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                'Co-Dependency, \nVictimization, \nLack of Motivation. ',
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF575758),
                                                  fontSize: 13,
                                                  letterSpacing: 0,
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 8)),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(0),
                                                child: Image.network(
                                                  '${FFAppConstants.consultationWithSakhashreereeImageUrl}/anahata.png',
                                                  width: 106,
                                                  height: 90,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Text(
                                                'Heart Chakra',
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                'Mistrust, Grief, \nUnforgiveness.',
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF575758),
                                                  fontSize: 13,
                                                  letterSpacing: 0,
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 8)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(0),
                                                child: Image.network(
                                                  '${FFAppConstants.consultationWithSakhashreereeImageUrl}/vishuddha.png',
                                                  width: 106,
                                                  height: 90,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Text(
                                                'Throat Chakra',
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                'Lack of Clarity \nand Communication, \nNegativity. ',
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF575758),
                                                  fontSize: 13,
                                                  letterSpacing: 0,
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 8)),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(0),
                                                child: Image.network(
                                                  '${FFAppConstants.consultationWithSakhashreereeImageUrl}/anjna.png',
                                                  width: 106,
                                                  height: 90,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Text(
                                                '3rd Eye Chakra',
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                'Non-Acceptance, \nRigidity, \nStubbornness.',
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF575758),
                                                  fontSize: 13,
                                                  letterSpacing: 0,
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 8)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(0),
                                                child: Image.network(
                                                  '${FFAppConstants.consultationWithSakhashreereeImageUrl}/sahasrara.png',
                                                  width: 106,
                                                  height: 90,
                                                  fit: BoxFit.contain,
                                                  alignment: Alignment(0, -1),
                                                ),
                                              ),
                                              Text(
                                                'Crown Chakra',
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                'Feeling Unlucky, \nDiscontentment, \nHopelessness. ',
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF575758),
                                                  fontSize: 13,
                                                  letterSpacing: 0,
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 8)),
                                          ),
                                        ],
                                      ),
                                    ].divide(SizedBox(height: 20)),
                                  ),
                                ),
                                Text(
                                  'By receiving guidance from Sakhashree Neeta, you will evolve as a human being and experience more joy in your relationships with others through learning the lessons of the 7 chakras.',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                    textAlign: TextAlign.justify
                                ),
                              ].divide(SizedBox(height: 20)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Testimonials',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                                                valueColor: AlwaysStoppedAnimation<Color>(FlutterFlowTheme.of(context).primary,
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
                                            ).toList()
                                                .where((item) => getJsonField(item, r'''$.testimonial_type''') == 1)
                                                .toList();
                                            return Container(
                                              width: double.infinity,
                                              height: 260,
                                              child: CarouselSlider.builder(
                                                itemCount: testimonials.length,
                                                itemBuilder: (context, testimonialsIndex, _) {
                                                  final testimonialsItem = testimonials[testimonialsIndex];
                                                  return Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      elevation: 5,
                                                      shape:
                                                      RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(12),
                                                      ),
                                                      child: Container(
                                                        width: 343,
                                                        height: 240,
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                          borderRadius: BorderRadius.circular(12),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                mainAxisSize: MainAxisSize.max,
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius: BorderRadius.circular(0),
                                                                    child: Image.asset('assets/images/image_442.png',
                                                                      width: 26,
                                                                      height: 19,
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                getJsonField(
                                                                  testimonialsItem,
                                                                  r'''$.name''',
                                                                ).toString(),
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Montserrat',
                                                                  fontSize: 16,
                                                                  letterSpacing: 0,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
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
                                      elevation: 0,
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
                                                textAlign: TextAlign.justify
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
                                              .expandableExpandableController2,
                                          child: ExpandablePanel(
                                            header: Text(
                                              '02. What if I am not satisfied with the consultation? ',
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
                                              'Sakhashree Neeta Ji will dive deep into your issues and resolve all your concerns. To date, we have a track record of 100% satisfaction. However, in case you don’t feel satisfied with the consultation, we have a no-questions-asked 100% money-back guarantee. ',
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
                              EdgeInsetsDirectional.fromSTEB(16, 0, 16, 10),
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
                                  SizedBox(height: 8),
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
                                                              //height: 40,
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
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 14),
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
                    text: 'Book Now - 5,100',
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

