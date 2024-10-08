import 'package:readmore/readmore.dart';
import 'package:rudraksha_cart/backend/api_requests/api_calls.dart';
import 'package:rudraksha_cart/backend/api_requests/api_manager.dart';
import 'package:rudraksha_cart/pages/Consultationwithsakhashree/Consultationwithsakhashree_model.dart';
import '../../components/consultationwithsakashreebooknow_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/gestures.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide CarouselController;

class ConsultationwithsakhashreeWidget extends StatefulWidget {
  const ConsultationwithsakhashreeWidget({
    super.key,
    String? consultationtype,
  }) : this.consultationtype = consultationtype ?? 'home';

  final String consultationtype;

  @override
  State<ConsultationwithsakhashreeWidget> createState() =>
      _ConsultationwithsakhashreeWidgetState();
}
class _ConsultationwithsakhashreeWidgetState
    extends State<ConsultationwithsakhashreeWidget> {
  late ConsultationwithsakhashreeModel _model;

  final ConsultationwithsakhashreeWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConsultationwithsakhashreeModel());

    _model.expandableExpandableController1 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController2 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController3 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController4 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController5 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController6 =
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
        key: ConsultationwithsakhashreeWidgetscaffoldKey,
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
                                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                child: Text(
                                  'Our Consultation Services',
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
                                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                            'Are you striving to reach the next level in life, whether it\'s personal or professional growth, achieving holistic health,or fostering happier relationships?',
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
                                            'Do you face recurring health issues such as back pain, knee pain, body aches, headaches, migraines, sinus congestion, acidity, or diabetes?',
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
                                            'Do you face difficulty concentrating,making poor judgments, struggling with memory, negative thinking, forgetfulness, irritability, or feelings of\nhopelessness?',
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
                                          child: Text("Do you feel stuck in your career or personal life?\n\nRelax! There is a solution. These symptoms indicate blockages in one or more of your chakras which require cleansing and balancing.\nI invite you for a personal consultation, where I will discern which of your chakras needs attention and recommend a combination of Rudraksha beads and gemstones to help you achieve healing, empowerment, and success.",
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
                                    // Generated code for this ConditionalBuilder Widget...
                                    Builder(
                                      builder: (context) {
                                        if (widget!.consultationtype == 'home') {
                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children:   [


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
                                                      'https://www.youtube.com/watch?v=0CQELOKdIyQ');
                                                },
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(0),
                                                      child: Image.network(
                                                        '${FFAppConstants.consultationWithSakhashreereeImageUrl}/consult-v-sakhashree.jpg',
                                                        width: MediaQuery.sizeOf(context).width * 0.99,
                                                        height: 228,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: AlignmentDirectional(0, 0),
                                                      child: Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 83, 0, 0),
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(0),
                                                          child: Image.network(
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
                                              ),
                                              Text(
                                                'Rudraksha beads and gemstones function to cleanse and balance your chakras, thereby empowering you and enhancing your aura. Remarkably, this transformation can occur in as little as five days when worn according to Rudraksha Ratna Chakra Therapy. Once the relevant chakras are opened and harmonized, individuals gain the empowerment needed to achieve success in physical, emotional, and worldly spheres of life. ',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                                        } else {
                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(0),
                                                    child:  Image.network(
                                                      'https://www.rudraksha-ratna.com/assets/img/consultation/consult-v-sakhashree.jpg',
                                                      width: MediaQuery.sizeOf(context).width * 0.99,
                                                      height: 228,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: AlignmentDirectional(0, 0),
                                                    child: Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(0, 83, 0, 0),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(0),
                                                        child: Image.network(
                                                          'https://www.rudraksha-ratna.com/assets/img/youtube_icon.png',
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
                                              Text(
                                                'Audraksha Oeads and gemstones runctiotl to cleanse and balance your chakras. thereby ervpowering you and enhancing your aura. Qernarkably, this transrorrnaLion can occur in as little as five davs when worn according to Qudraksha (QaLna Chakra Therapy. Once\nLine relevant chakras are opened and hatrvonized, individuals guin\nL ine empowerment needed 10 achieve success in physical,ernolicnal, and \',vorldly so+eres Of life.',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
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

                                    Text(
                                      'The 7 Chakras',
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
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          ].divide(SizedBox(height: 8)),
                                        ),
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
                                          ].divide(SizedBox(height: 8)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
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
                                              'Heart \nChakra',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                fontSize: 12,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w600,
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
                                                '${FFAppConstants.consultationWithSakhashreereeImageUrl}/vishuddha.png',
                                                width: 106,
                                                height: 90,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Text(
                                              'Throat\nChakra',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                fontSize: 12,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w600,
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
                                              '3rd Eye\nChakra',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                fontSize: 12,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ].divide(SizedBox(height: 8)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                              ),
                                            ),
                                            Text(
                                              'Crown\nChakra',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                fontSize: 12,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ].divide(SizedBox(height: 8)),
                                        ),
                                      ],
                                    ),
                                    Text('Chakras are the seven energy centers along the spine that govern your mental, physical, and emotional well-being. When they are balanced, you experience holistic health, harmonious relationships, mental peace, and personal and professional growth. They help you unlock your potential and empower you to navigate life s challenges with grace, power and authenticity \n', style: FlutterFlowTheme.of(context)
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
                            padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'You can choose to book an Email or \n Video all Consultation',
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
                                Text(
                                  'Opting for a Video Call consultation\nwhenever feasible is highly \n recommended.',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF575758),
                                    fontSize: 16,
                                    letterSpacing: 0,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.network(
                                    '${FFAppConstants.consultationWithSakhashreereeImageUrl}/email-consultation.png',
                                    width: 48,
                                    height: 48,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(
                                  'Email Consultation Process:',
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
                                  width: double.infinity,
                                  height: 368,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(14),
                                    child: Text(
                                      'Upon booking your consultation, I will promptly reach out to you and provide a link to an online form.\n\nThe online form will require you to provide detailed answers, which will enable the generation of your personalized chakra report and horoscope. \n\n After receiving your completed form, I will meticulously analyze the information provided and compile a detailed report. This report will delve into the root causes of your concerns and offer tailored RRCT (Rudraksha Ratna Chakra Therapy) remedies, along with meditation techniques and affirmations. ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF575758),
                                        letterSpacing: 0,
                                        lineHeight: 1.5,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.network(
                                    '${FFAppConstants.consultationWithSakhashreereeImageUrl}/video-call.png',
                                    width: 48,
                                    height: 48,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(
                                  'Video Call Consultation Process:',
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
                                  width: double.infinity,
                                 
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(14),
                                    child: Text(
                                      'Upon booking your consultation, I will promptly reach out to you and provide a link to an online form.\n\nThe online form will require you to provide detailed answers, which will enable the generation of your personalized chakra report and horoscope. \n\n During our scheduled Zoom meeting, I will delve deep into your issues related to health, career, and relationships. At this time, I will identify the root cause of your problems, assist you in navigating your beliefs, and suggest practical solutions to overcome them. If time permits, I will also guide you through a meditation session.  \n\nFollowing our session, I will send you a detailed email summarizing our discussion and findings. This email will include your horoscope, meditation techniques, affirmations, and tailored RRCT (Rudraksha Ratna Chakra Therapy) remedies based on our consultation. ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF575758),
                                        letterSpacing: 0,
                                        lineHeight: 1.5,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(height: 16)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
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
                                  Text(
                                    'Rrst combos with properties',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF575758),
                                      fontSize: 16,
                                      letterSpacing: 0.38,
                                      fontWeight: FontWeight.normal,
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
                                        'Suitable Combinations of Rudraksha Beads For Healing, Empowerment & Success. ',
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
                                      Text('Recommended gemstones based on your Natal Chart and Chakra report. Furthermore, I will assess the gemstones you are currently wearing and guide you about their necessity and proper placement. ', style: FlutterFlowTheme.of(context)
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
                                        'Appropriate Yantras that align with your Birth Chart and Chakra report. ',
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
                                        'Appropriate Mantras & Affirmations for developing positivity, self-confidence, and clarity of thoughts.',
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
                                        'A powerful technique to release deep rooted fears and negative belief and thought patterns.',
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Container(
                            width: double.infinity,
                            //height: 690,
                            decoration: BoxDecoration(
                              color: Color(0xFFE3CCE3),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
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
                                        child: Text(
                                          'Enhanced Clarity: You will realize the beliefs that have been creating the situations you are going through and feel more in control of your life.',
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
                                        width:
                                        MediaQuery.sizeOf(context).width * 0.835,
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          'Growth Mindset: You will view obstacles as opportunities for growth and learning.',
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
                                        width:
                                        MediaQuery.sizeOf(context).width * 0.835,
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          'Improved Health: You will realize that health in your hands as you tune into a positive mindset and adopt a disciplined lifestyle.',
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
                                        width:
                                        MediaQuery.sizeOf(context).width * 0.835,
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          'Better Relationships: With inner positivity, you will be more harmonious in relationships and know how to effectively deal with people.',
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
                                        child: Text("Career Advancement: You will realise that growth is natural and it happens as you flow with life. ",
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
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 17, 0, 0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width * 0.933,
                                      decoration: BoxDecoration(),
                                      child: Text(
                                        'If for any reason you are not satisfied with the consultation, rest assured that you will receive a full refund with no questions asked.',
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Specific Treatments Available For',
                                style:
                                FlutterFlowTheme.of(context).bodyMedium.override(
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(0),
                            child: Image.asset(
                              'assets/images/_com.apple.Pasteboard_5.png',
                              width: double.infinity,
                              height: 392,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          //height: 385,
                          decoration: BoxDecoration(
                            color: Color(0xFFE3CCE3),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'About Sakhashree',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF313131),
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                ReadMoreText(
                                  "Sakhashree Neeta stands as a globally recognized authority in Chakra healing and balancing with rudraksha, and gemstones, with over two decades of expertise in Chakra Therapy counseling. Throughout her illustrious career, she has empowered individuals from diverse backgrounds to attain success. Her impact resonates through a remarkable collection of more than 500 YouTube videos, amassing over 5 million views, which delve into the realms of Chakras, Spirituality, Self-Empowerment, and Rudrakshas.\n\n In a typical RRST session with Sakhashree, she engages in deeply personal conversations with her clients to dissect their challenges, unearth the root causes, offer pragmatic solutions, and prescribe tailored meditation techniques. Drawing upon her profound understanding of Chakras, she maps the relevant energy centers to the identified issues, facilitating healing and empowerment. Through this process, she recommends specific Rudraksha beads and gemstones, with clients often experiencing tangible positive shifts within a week of wearing them. Witnessing the transformative impact of her therapy, clients embrace more fulfilling and joyful lives under her guidance. Sakhashree meticulous selection of Rudraksha beads and gemstones underscores her commitment to delivering personalized solutions that yield profound results.  Beyond individual therapy sessions, Sakhashree Neeta extends her reach through Chakra Yog Workshops and Webinars, dedicated to disseminating knowledge about Chakra Science and Spiritual Awakening. These workshops, rooted in Chakra Sadhana, foster self-awareness, holistic wellbeing, work-life balance, and spiritual growth by delving into the teachings of the seven Chakras. Participants in these transformative workshops are guided through powerful releasing meditations inspired by the Neti Neti principle of Advaita Vedanta, facilitating shifts in perceptions of life, work, and the world.  With Sakhashree Neetas expert guidance and personal touch individuals embark on profound journeys of self-discovery and empowerment paving the way for enduring transformation in their lives.",
                                  trimLines: 15,
                                  colorClickableText: Color(0xFF575758),
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: 'Read more',
                                  trimExpandedText: ' Read less',
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF575758),
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    lineHeight: 2.2,
                                  ),
                                  lessStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF575758),
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                    lineHeight: 2.2,
                                  ),
                                  moreStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF575758),
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                    lineHeight: 2.2,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),

                              ].divide(SizedBox(height: 10)),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: Image.asset(
                            'assets/images/_com.apple.Pasteboard_6.png',
                            width: double.infinity,
                            height: 392,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                         // height: 341,
                          decoration: BoxDecoration(
                            color: Color(0xFFE3CCE3),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'What is Rudraksha Ratna Chakra Therapy (RRCT)?',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                    lineHeight: 1.4,
                                  ),
                                ),
                                ReadMoreText(
                                  "Rudraksha Ratna Chakra Therapy (RRCT) is a holistic healing approach that involves the strategic use of specific Rudraksha beads and gemstones to balance the chakras within the body. Developed by Sakhashree Neeta and her team of doctors, scientists, researchers, and scholars after two decades of extensive research and practical application, RRCT taps into the inherent properties of Rudraksha and gemstones to effectively open blocked chakras. \n This therapy aims to utilize 100% of the properties of Rudraksha and Gemstones, maximizing their healing potential. RRCT outlines precise methodologies for selecting and using various Rudraksha beads or gemstones to achieve optimal results in chakra balancing and holistic well-being. Through RRCT, individuals can experience profound transformations and achieve balance on physical, emotional, and spiritual levels. ",
                                  trimLines: 10,
                                  colorClickableText: Color(0xFF575758),
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: 'Read more',
                                  trimExpandedText: ' Read less',
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF575758),
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    lineHeight: 2.2,
                                  ),
                                  lessStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF575758),
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                    lineHeight: 2.2,
                                  ),
                                  moreStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF575758),
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                    lineHeight: 2.2,
                                  ),
                                ),
                            /*    RichText(
                                  textScaler: MediaQuery.of(context).textScaler,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                        'Rudraksha Ratna Chakra Therapy (RRCT) is a holistic healing approach that involves the strategic use of specific Rudraksha beads and gemstones to balance the chakras within the body. Developed by Sakhashree Neeta and her team of doctors, scientists, researchers,\nand scholars after two decades of extensive research and practical application, RACT taps into the inherent properties of Rudraksha and gemstones to effectively open blocked chakras. ',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 13,
                                          letterSpacing: 0,
                                          lineHeight: 2,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Read More.',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
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
                                ),*/
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
                                'What are Chakras?',
                                style:
                                FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
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
                                    '${FFAppConstants.consultationWithSakhashreereeImageUrl}/chakra-energy-system-of-human-body.jpg',
                                    width: 300,
                                    height: 200,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),

                              ReadMoreText(
                                "Chakras are visualized as rotating spiral vortexes of energy that play a vital role in the absorption, emission, and circulation of universal energies essential for the optimal functioning of the human energy system.  References to chakras can be found in ancient Vedic texts such as the Rig Veda, Yoga Sutras of Patanjali, Jabala Darshan Upanishad, and Shandilya Upanishad. Over time, these texts have been interpreted and contextualized to inform various modern alternative healing modalities.  While there are a total of 114 chakras, the seven major chakras hold particular significance. Aligned along the spinal cord from the base to the crown of the head, these seven primary chakras govern various aspects of mental, emotional, financial, and material well-being. They are: \n 1. Muladhara (Root Chakra) \n 2. Swadhisthana (Sacral Chakra) \n3. Manipura (Solar Plexus Chakra) \n4. Anahata (Heart Chakra) \n5. Vishuddha (Throat Chakra) \n6. Ajna (Third Eye Chakra) \n7. Sahasrara (Crown Chakra) \n  Understanding and balancing these chakras is crucial for achieving holistic health and harmony within oneself. ",
                                trimLines: 10,
                                colorClickableText: Color(0xFF575758),
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Read more',
                                trimExpandedText: ' Read less',
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF575758),
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  lineHeight: 2.2,
                                ),
                                lessStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF575758),
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                  lineHeight: 2.2,
                                ),
                                moreStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF575758),
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                  lineHeight: 2.2,
                                ),
                                textAlign: TextAlign.justify,
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
                              Text(
                                'How do Chakras affect Your Health?',
                                style:
                                FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),


                              ReadMoreText(
                                "Chakras play a crucial role in maintaining overall health and well-being by aligning with the body's endocrine glands and regulating various bodily systems. When the chakras are balanced, they support the optimal functioning of organs and systems throughout the body. However, imbalances or blockages in the chakra system can lead to a range of health issues and diseases.  Each of the seven chakras corresponds to specific endocrine glands and systems within the body. When these chakras are in harmony, they ensure the smooth flow of energy and proper functioning of the associated glands and systems. However, when there are disruptions or blockages in the chakra system, it can result in disturbances in the flow of energy, leading to imbalances in the corresponding glands and systems. glands and systems. \n  For example: \n 1. The Root Chakra (Muladhara) is associated with the adrenal glands and governs the body's fight-or-flight response. Imbalances in this chakra can manifest as issues related to the adrenal glands, such as fatigue or adrenal fatigue. \n2. The Sacral Chakra (Swadhisthana) is linked to the reproductive organs and influences creativity and sexuality. Imbalances here may lead to reproductive issues or difficulties with emotional expression. \n3. The Solar Plexus Chakra (Manipura) corresponds to the pancreas and digestive system. Imbalances can result in digestive issues, as well as issues related to self-esteem and personal power. \n4. The Heart Chakra (Anahata) is associated with the thymus gland and governs the cardiovascular system and immune function. Imbalances can manifest as heart-related problems or issues with giving and receiving love. \n5. The Throat Chakra (Vishuddha) is linked to the thyroid gland and regulates communication and self-expression. Imbalances may lead to thyroid issues or difficulties with speaking one's truth. \n6. The Third Eye Chakra (Ajna) corresponds to the pituitary gland and governs intuition and perception. Imbalances can result in issues with mental clarity, intuition, and decision-making. \n7. The Crown Chakra (Sahasrara) is associated with the pineal gland and connects us to the divine and spiritual realms. Imbalances here can manifest as issues related to spiritual disconnection or lack of purpose. \n Overall, maintaining balance and harmony in the chakra system is essential for promoting physical, emotional, and spiritual health. Practices such as meditation, yoga, and energy healing modalities can help to rebalance the chakras and support overall well-being. ",
                                trimLines: 10,
                                colorClickableText: Color(0xFF575758),
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Read more',
                                trimExpandedText: ' Read less',
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF575758),
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  lineHeight: 2.2,
                                ),
                                lessStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF575758),
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                  lineHeight: 2.2,
                                ),
                                moreStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF575758),
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                  lineHeight: 2.2,
                                ),
                                textAlign: TextAlign.justify,
                              ),
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
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
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
                                style:
                                FlutterFlowTheme.of(context).bodyMedium.override(
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
                                      'Chakras play a significant role in influencing your career or business success by overning your emotions, aspirations, and energy levels. When your chakras are empowered and balanced, they attract suitable situations and people that support your material growth and careeradvancement. Empowered chakras foster and inspire innovative commitment approaches to achieving success in your professional endeavors.',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 13,
                                        letterSpacing: 0,
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
                                textAlign: TextAlign.justify,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                child: RichText(
                                  textScaler: MediaQuery.of(context).textScaler,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                        'Each chakra grants distinct abilities that contribute to personal and professional development:',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 13,
                                          letterSpacing: 0,
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
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ].divide(SizedBox(height: 10)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
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
                            ].divide(SizedBox(height: 20)),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          //height: 1122,
                          decoration: BoxDecoration(
                            color: Color(0xFFE3CCE3),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 16),
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
                                        'The Chakras govern emotions, insecurities,and fears. ay aligning with their lessons, we can form more holistic, ealthy, and harmonious relationships. While you cannot control others\' behavior, you have the power to control your  sponse and also speak your truth with innate power. ay doing so, you can protect your interests and maintain your boundaries and also positively influence others.',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 13,
                                          letterSpacing: 0,
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
                                  textAlign: TextAlign.justify,
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
                                                ' Insecurity, \nInstability,\n Anxiety,\n Stressed \nParental\n Relationships ',
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
                                                ' Feeling Being \nTaken Advantage of.\n Blurry Sense of\n Who you are. ',
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
                                                ' Co-Dependency, \nVictimization,\n Lack of Motivation \n& Vitality. .',
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
                                                ' Mistrust, Grief,\n Loneliness, \nInability to forgive. ',
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
                                                ' Lack of Clarity,\n Misunderstandings, \nFrustration, \nHelplessness. ',
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
                                                'Non-Acceptance,\n Rigidity,\n Stubbornness.',
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
                                                'Feeling Unlucky,\n Discontentment,Control, Hopelessness. ',
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
                                  textAlign: TextAlign.justify,
                                ),
                              ].divide(SizedBox(height: 20)),
                            ),
                          ),
                        ),
                        // Generated code for this Container Widget...
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
                                                                  style: FlutterFlowTheme.of(
                                                                      context)
                                                                      .bodyMedium
                                                                      .override(
                                                                    fontFamily:
                                                                    'Montserrat',
                                                                    color: Color(
                                                                        0xFF575758),
                                                                    fontSize:
                                                                    13,
                                                                    letterSpacing:
                                                                    0,
                                                                    lineHeight:
                                                                    1.5,
                                                                  ),
                                                                  maxLines: 9,
                                                                  textAlign: TextAlign.justify,
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
                                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                      color: FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
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
                        )
                        ,
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
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
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
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
                                          controller:
                                          _model.expandableExpandableController1,
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
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
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
                                          controller:
                                          _model.expandableExpandableController2,
                                          child: ExpandablePanel(
                                            header: Text(
                                              'Will you analyze my horoscope or astrology chart? ',
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
                                                'The consultation will provide a comprehensive analysis of the doshas, favorable planets and mantras, lucky days of the week, and a complete horoscope. However, the main focus will be on empowering and balancing your chakras. Chakra Therapy is a highly effective healing modality. Balancing your chakras aligns with the planets and resolves horoscope issues. To gain a comprehensive understanding of your horoscope, I recommend scheduling an astrology consultation.',
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
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
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
                                          controller:
                                          _model.expandableExpandableController4,
                                          child: ExpandablePanel(
                                            header: Text(
                                              'Is it safe to wear Rudraksha & Gemstones as per RRST? Will Rudraksha & Gemstone suit me? ',
                                              style: FlutterFlowTheme.of(context)
                                                  .displaySmall
                                                  .override(
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
                                              "Absolutely, Rudraksha and gemstones, when worn according to Rudraksha Ratna Science Therapy (RRST), are beneficial for everyone, irrespective of their horoscope. This therapy has positively impacted millions of individuals over the past 20 years, providing healing and empowerment across diverse backgrounds and circumstances.  The effectiveness of RRST is evidenced by the countless testimonials from people worldwide, reflecting the transformative experiences and tangible benefits they have received. These testimonials serve as powerful endorsements of the efficacy and versatility of Rudraksha and gemstones in promoting holistic well-being and personal growth. ", style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
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
                                          controller:
                                          _model.expandableExpandableController5,
                                          child: ExpandablePanel(
                                            header: Text(
                                              'What if I am not satisfied with the consultation?',
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
                                            expanded: Text("If, for any reason, you are not satisfied with the consultation provided by Sakhashree Neeta Ji, rest assured that your concerns will be addressed promptly and professionally. While we maintain a track record of 100% satisfaction, we understand that each individual's experience may vary. \n In the rare event that you do not feel satisfied with the consultation, we offer a no-questions-asked 100% money-back guarantee. Your satisfaction and well-being are our top priorities, and we are committed to ensuring that you receive the support and guidance you deserve. ",style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
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
                                          controller:
                                          _model.expandableExpandableController6,
                                          child: ExpandablePanel(
                                            header: Text(
                                              'When can I expect to receive my report? ',
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
                                            expanded: Text("You can expect to receive the report containing remedies within 2-7 working days via email consultation. Similarly, after the completion of the video call session, you will receive the consultation report within 2-7 working days. We strive to ensure that you receive your personalized report promptly, allowing you to embark on your journey towards healing and empowerment as soon as possible. If you have any further questions or need additional assistance, please feel free to reach out to us. ",style: FlutterFlowTheme.of(context).bodyMedium.override(
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
              // Generated code for this Button Widget...
              Align(
                alignment: AlignmentDirectional(0, 1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 14),
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
                    text: 'Book Now - INR 1,100-5,100',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 46,
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
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
              )

            ],
          ),
        ),
      ),
    );
  }
}
