import 'package:url_launcher/url_launcher.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'aboutus_model.dart';
export 'aboutus_model.dart';

class AboutusWidget extends StatefulWidget {
  const AboutusWidget({
    super.key,
    String? consultationtype,
  }) : this.consultationtype = consultationtype ?? 'home';

  final String consultationtype;

  @override
  State<AboutusWidget> createState() => _AboutusWidgetState();
}

class _AboutusWidgetState extends State<AboutusWidget> {
  late AboutusModel _model;

  final AboutusWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AboutusModel());
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
        key: AboutusWidgetscaffoldKey,
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
                'About Us',
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
                              EdgeInsetsDirectional.fromSTEB(16, 16, 0, 0),
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
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 0),
                                  child: Text('Rudra Centre was founded in the year 1997 in Mumbai, MH. India. It commands more than 20 years of Excellence at the Forefront of Rudraksha and Spiritual Products & Services Worldwide’s Distribution. Rudra Centre (www.rudraksha-ratna.com) is wholly owned and operated by Rudra Centre Services Private Limited. ',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF575758),
                                      fontSize: 14,
                                      letterSpacing: 0,
                                      lineHeight: 1.5,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE3CCE3),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 16, 16, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Our Mission',
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
                                                MediaQuery.sizeOf(context)
                                                    .width *
                                                    0.851,
                                                decoration: BoxDecoration(),
                                                child: Text(
                                                  'To eliminate sin, pain, and suffering from humanity worldwide.',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Montserrat',
                                                    color:
                                                    Color(0xFF575758),
                                                    fontSize: 13,
                                                    letterSpacing: 0,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    lineHeight: 1.5,
                                                  ),
                                                  textAlign: TextAlign.justify,
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
                                                MediaQuery.sizeOf(context)
                                                    .width *
                                                    0.851,
                                                decoration: BoxDecoration(),
                                                child: Text(
                                                    'To spread awareness about the profound benefits of Rudraksha beads and Gemstones in promoting healing, success, and self-empowerment.',style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Montserrat',
                                                    color:
                                                    Color(0xFF575758),
                                                    fontSize: 13,
                                                    letterSpacing: 0,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    lineHeight: 1.5,
                                                  ),
                                                  textAlign: TextAlign.justify,
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
                                                MediaQuery.sizeOf(context)
                                                    .width *
                                                    0.851,
                                                decoration: BoxDecoration(),
                                                child: Text('To spread awareness about the profound benefits of Rudraksha beads and Gemstones in promoting healing, success, and self-empowerment.',  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Montserrat',
                                                    color:
                                                    Color(0xFF575758),
                                                    fontSize: 13,
                                                    letterSpacing: 0,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    lineHeight: 1.5,
                                                  ),
                                                  textAlign: TextAlign.justify,
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
                                                MediaQuery.sizeOf(context)
                                                    .width *
                                                    0.851,
                                                decoration: BoxDecoration(),
                                                child: Text('To provide the best quality Rudraksha, gemstones, and spiritual products with proper usage guidelines for maximal benefit and at affordable prices.', style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Montserrat',
                                                    color:
                                                    Color(0xFF575758),
                                                    fontSize: 13,
                                                    letterSpacing: 0,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    lineHeight: 1.5,
                                                  ),
                                                  textAlign: TextAlign.justify,
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
                                                MediaQuery.sizeOf(context)
                                                    .width *
                                                    0.851,
                                                decoration: BoxDecoration(),
                                                child: Text(
                                                  'To promote continual study and research on spiritual sciences and spiritual products so that the knowledge may benefit all,',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Montserrat',
                                                    color:
                                                    Color(0xFF575758),
                                                    fontSize: 13,
                                                    letterSpacing: 0,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    lineHeight: 1.5,
                                                  ),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 8)),
                                          ),
                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0, 17, 0, 0),
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                  .width *
                                                  0.933,
                                              decoration: BoxDecoration(),
                                            ),
                                          ),
                                        ].divide(SizedBox(height: 10)),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFD62DD6),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 16, 16, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Our Vision',
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
                                                MediaQuery.sizeOf(context)
                                                    .width *
                                                    0.851,
                                                decoration: BoxDecoration(),
                                                child: Text(
                                                  'To become a global supplier of Rudraksha, gemstones, Yantra, Parad, as well as ritual and spiritual accessories.',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Montserrat',
                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                    fontSize: 13,
                                                    letterSpacing: 0,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    lineHeight: 1.5,
                                                  ),
                                                  textAlign: TextAlign.justify,
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
                                                MediaQuery.sizeOf(context)
                                                    .width *
                                                    0.851,
                                                decoration: BoxDecoration(),
                                                child: Text('To establish a worldwide network of healers that promote RRST and Chakra Vastu.', style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Montserrat',
                                                    color: FlutterFlowTheme
                                                        .of(context)
                                                        .secondaryBackground,
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
                                                MediaQuery.sizeOf(context)
                                                    .width *
                                                    0.851,
                                                decoration: BoxDecoration(),
                                                child: Text('To be the beacon of enlightenment for global consciousness.', style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Montserrat',
                                                    color: FlutterFlowTheme
                                                        .of(context)
                                                        .secondaryBackground,
                                                    fontSize: 13,
                                                    letterSpacing: 0,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    lineHeight: 1.5,
                                                  ),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 8)),
                                          ),

                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0, 17, 0, 0),
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                  .width *
                                                  0.933,
                                              decoration: BoxDecoration(),
                                            ),
                                          ),
                                        ].divide(SizedBox(height: 10)),
                                      ),
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(height: 16)),
                            ),
                          ].divide(SizedBox(height: 10)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Our Credentials',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 18,
                                    letterSpacing: 0.38,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text('Rudra Centre has developed in recent years into a One-Stop shop for Spiritual Products, Spiritual Services, and Holistic Healing on the internet. We sell authentic and high-quality Rudraksha, Gemstones, Parad, Yantra, Murtis of Gods and Goddesses, Puja and Meditation accessories, and Spiritual Books. Additionally, we offer Holistic Healing services to our customers globally, including personal counselling with chakra analysis and RRST solutions, Vastu consultation and personalized online Puja services. ',
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
                              ].divide(SizedBox(height: 5)),
                            ),
                          ].divide(SizedBox(height: 16)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          'https://youtube.com/watch?v=9uKrdssrG_c');
                                    },
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            'https://img.youtube.com/vi/9uKrdssrG_c/maxresdefault.jpg',
                                            width: MediaQuery.sizeOf(context).width * 0.99,
                                            height: 228,
                                            fit: BoxFit.fill,
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
                                          'https://youtube.com/watch?v=08y5vs6R50A');
                                    },
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            'https://img.youtube.com/vi/08y5vs6R50A/maxresdefault.jpg',
                                            width: MediaQuery.sizeOf(context).width * 0.99,
                                            height: 228,
                                            fit: BoxFit.fill,
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


                                ].divide(SizedBox(height: 10)),
                              ),
                            ),
                          ].divide(SizedBox(height: 16)),
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Container(
                              width:
                              MediaQuery.sizeOf(context).width *
                                  0.851,
                              decoration: BoxDecoration(),
                              child: Text(
                                'Rudra Centre is the first Rudraksha website in the world that came online in the year 1997 and is the world\'s first Rudraksha organization to be certified to ISO 9001:2015. We have accumulated over 22,000 testimonials from satisfied clients worldwide, with a distribution network that includes the USA, UK, European countries such as France, Belgium, Germany, The Netherlands, Denmark, Sweden and Norway. Australia, New Zealand, Singapore, Hong Kong, Malaysia, Thailand, Indonesia, Japan, United Arab Emirates, Trinidad, Africa, Philippines, Ecuador and Canada. ',
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
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 17, 0, 0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.933,
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Our Experience',
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
                                          borderRadius:
                                          BorderRadius.circular(0),
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                            Duration(milliseconds: 500),
                                            fadeOutDuration:
                                            Duration(milliseconds: 500),
                                            imageUrl:
                                            '${FFAppConstants.aboutUs}/knowledge.png',
                                            width: 106,
                                            height: 90,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Knowledge',
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
                                          'In-depth knowledge and expertise with products',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF575758),
                                            letterSpacing: 0,

                                          ),
                                          textAlign: TextAlign.center                                        ),
                                      ].divide(SizedBox(height: 6)),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(0),
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                            Duration(milliseconds: 500),
                                            fadeOutDuration:
                                            Duration(milliseconds: 500),
                                            imageUrl:
                                            '${FFAppConstants.aboutUs}/research.png',
                                            width: 106,
                                            height: 90,
                                            fit: BoxFit.contain,
                                            errorWidget:
                                                (context, error, stackTrace) =>
                                                Image.asset(
                                                  'assets/images/error_image.png',
                                                  width: 106,
                                                  height: 90,
                                                  fit: BoxFit.contain,
                                                ),
                                          ),
                                        ),
                                        Text(
                                          'Research',
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
                                          'Proper use according to Vedic wisdom and ongoing research',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF575758),
                                            letterSpacing: 0,
                                          ),
                                              textAlign: TextAlign.center
                                        ),
                                      ].divide(SizedBox(height: 6)),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(0),
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                            Duration(milliseconds: 500),
                                            fadeOutDuration:
                                            Duration(milliseconds: 500),
                                            imageUrl:
                                            '${FFAppConstants.aboutUs}/network.png',
                                            width: 106,
                                            height: 90,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Network',
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
                                          'Robust supply network across India and internationally',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF575758),
                                            letterSpacing: 0,
                                          ),
                                              textAlign: TextAlign.center
                                        ),
                                      ].divide(SizedBox(height: 6)),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(0),
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                            Duration(milliseconds: 500),
                                            fadeOutDuration:
                                            Duration(milliseconds: 500),
                                            imageUrl:
                                            '${FFAppConstants.aboutUs}/product.png',
                                            width: 106,
                                            height: 90,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Exclusive Products',
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
                                          'We provide the rarest of products that are not found anywhere else ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF575758),
                                            letterSpacing: 0,
                                          ),
                                              textAlign: TextAlign.center
                                        ),
                                      ].divide(SizedBox(height: 6)),
                                    ),

                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(0),
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                            Duration(milliseconds: 500),
                                            fadeOutDuration:
                                            Duration(milliseconds: 500),
                                            imageUrl:
                                            '${FFAppConstants.aboutUs}/customer-service.png',
                                            width: 106,
                                            height: 90,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Customer Service',
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
                                          'Praised by our exceptional Customer Service, with 90+ employees(in team) ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF575758),
                                            letterSpacing: 0,
                                          ),
                                              textAlign: TextAlign.center
                                        ),
                                      ].divide(SizedBox(height: 6)),
                                    ),
                                  ].divide(SizedBox(height: 30)),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(0),
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                            Duration(milliseconds: 500),
                                            fadeOutDuration:
                                            Duration(milliseconds: 500),
                                            imageUrl:
                                            '${FFAppConstants.aboutUs}/quality-assurance.png',
                                            width: 106,
                                            height: 90,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Quality Assuarance',
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
                                          'Product is inspected for quality before delivery',
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
                                          borderRadius:
                                          BorderRadius.circular(0),
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                            Duration(milliseconds: 500),
                                            fadeOutDuration:
                                            Duration(milliseconds: 500),
                                            imageUrl:
                                            '${FFAppConstants.aboutUs}/cert-product.png',
                                            width: 106,
                                            height: 90,
                                            fit: BoxFit.contain,
                                            errorWidget:
                                                (context, error, stackTrace) =>
                                                Image.asset(
                                                  'assets/images/error_image.png',
                                                  width: 106,
                                                  height: 90,
                                                  fit: BoxFit.contain,
                                                ),
                                          ),
                                        ),
                                        Text(
                                          'Research',
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
                                          'Proper use according to Vedic wisdom and ongoing research',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF575758),
                                            letterSpacing: 0,
                                          ),
                                              textAlign: TextAlign.center
                                        ),
                                      ].divide(SizedBox(height: 6)),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(0),
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                            Duration(milliseconds: 500),
                                            fadeOutDuration:
                                            Duration(milliseconds: 500),
                                            imageUrl:
                                            '${FFAppConstants.aboutUs}/complete.png',
                                            width: 106,
                                            height: 90,
                                            fit: BoxFit.contain,
                                            errorWidget:
                                                (context, error, stackTrace) =>
                                                Image.asset(
                                                  'assets/images/error_image.png',
                                                  width: 106,
                                                  height: 90,
                                                  fit: BoxFit.contain,
                                                ),
                                          ),
                                        ),
                                        Text(
                                          'Completeness',
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
                                          'Offer not only the highest-quality goods but also truthful information and instructions for proper product usage ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF575758),
                                            letterSpacing: 0,
                                          ),
                                              textAlign: TextAlign.center
                                        ),
                                      ].divide(SizedBox(height: 6)),
                                    ),
                                  ].divide(SizedBox(height: 30)),
                                ),
                              ].divide(SizedBox(height: 16)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: CachedNetworkImage(
                            fadeInDuration: Duration(milliseconds: 500),
                            fadeOutDuration: Duration(milliseconds: 500),
                            imageUrl:
                            '${FFAppConstants.aboutUs}/rrst.jpg',
                            width: double.infinity,
                            height: 392,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFF2D3091),
                        ),
                        child: Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(16, 10, 16, 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'The prestigious Rudraksha Ratna Science Therapy ® (RRST) © ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  fontSize: 20,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              RichText(
                                textScaler: MediaQuery.of(context).textScaler,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:'Rudraksha Ratna Science Therapy (RRST)™ is a well-researched alternate holistic therapy which help tap 100% positive properties and remedial effects of Rudraksha beads and natural Gemstones.\n\nSakhashree Neeta developed Rudraksha Ratna Science Therapy (RRST) after years of research on the curative and therapeutic qualities of Rudraksha and Gemstones. It works holistically to remove deep-seated obstructions on the physical, mental, and emotional levels. It is an alternative healing method with no side effects. RRST helps you attain the power of healing, empowerment, and success in your personal and professional life. Over 10,000 client testimonies from all over the world, show that the therapy has a solid track record of treating and curing people. ', style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        fontSize: 14,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.normal,
                                        lineHeight: 2.2,
                                      ),
                                    )
                                  ],
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    lineHeight: 2.2,
                                  ),
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ].divide(SizedBox(height: 10)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Our Ace Products',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                letterSpacing: 0.38,
                                fontWeight: FontWeight.w600,
                              ),
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
                                      child: CachedNetworkImage(
                                        fadeInDuration:
                                        Duration(milliseconds: 500),
                                        fadeOutDuration:
                                        Duration(milliseconds: 500),
                                        imageUrl:
                                        '${FFAppConstants.aboutUs}/rudraksha.jpg',
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
                                        fontSize: 14,
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
                                      child: CachedNetworkImage(
                                        fadeInDuration:
                                        Duration(milliseconds: 500),
                                        fadeOutDuration:
                                        Duration(milliseconds: 500),
                                        imageUrl:
                                        '${FFAppConstants.aboutUs}/genstone.jpg',
                                        width: 106,
                                        height: 90,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Text(
                                      'Gemstones',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(0),
                                      child: CachedNetworkImage(
                                        fadeInDuration:
                                        Duration(milliseconds: 500),
                                        fadeOutDuration:
                                        Duration(milliseconds: 500),
                                        imageUrl:
                                        '${FFAppConstants.aboutUs}/yantra.jpg',
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
                                        fontSize: 14,
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
                                      child: CachedNetworkImage(
                                        fadeInDuration:
                                        Duration(milliseconds: 500),
                                        fadeOutDuration:
                                        Duration(milliseconds: 500),
                                        imageUrl:
                                        '${FFAppConstants.aboutUs}/puja-services.jpg',
                                        width: 106,
                                        height: 90,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Text(
                                      'Puja\nservices',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
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
                                      child: CachedNetworkImage(
                                        fadeInDuration:
                                        Duration(milliseconds: 500),
                                        fadeOutDuration:
                                        Duration(milliseconds: 500),
                                        imageUrl:
                                        '${FFAppConstants.aboutUs}/parad.jpg',
                                        width: 106,
                                        height: 90,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Text(
                                      'Parad',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(0),
                                      child: CachedNetworkImage(
                                        fadeInDuration:
                                        Duration(milliseconds: 500),
                                        fadeOutDuration:
                                        Duration(milliseconds: 500),
                                        imageUrl:
                                        '${FFAppConstants.aboutUs}/jewelry.jpg',
                                        width: 106,
                                        height: 90,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Text(
                                      'Spiritual Jewelry',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
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
                                      child: CachedNetworkImage(
                                        fadeInDuration:
                                        Duration(milliseconds: 500),
                                        fadeOutDuration:
                                        Duration(milliseconds: 500),
                                        imageUrl:
                                        '${FFAppConstants.aboutUs}/vastu-item.jpg',
                                        width: 106,
                                        height: 90,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Text(
                                      'Vastu Items',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 8)),
                                ),
                              ],
                            ),
                          ].divide(SizedBox(height: 20)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.network(
                                '',
                              ).image,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: CachedNetworkImage(
                            fadeInDuration: Duration(milliseconds: 500),
                            fadeOutDuration: Duration(milliseconds: 500),
                            imageUrl: '${FFAppConstants.aboutUs}/Sakhashree.jpg',
                            width: double.infinity,
                            height: 392,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sakhashree Neeta',
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
                              RichText(
                                textScaler: MediaQuery.of(context).textScaler,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                      'She is the Founder of Rudraksha Ratna Science Therapy (RRST), which she developed after 17 years of research on Rudraksha and Gemstones and their influence on people, as well as information gleaned from ancient Puranas, Upanishads, and other Scriptures. She has also identified through her research and study, the way to harness the power of various sacred items used in meditation, puja and Vastu in order to obtain optimal health, wealth, success, and fulfillment in all spheres of life. ',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF575758),
                                        fontSize: 13,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                        lineHeight: 1.5,
                                      ),
                                    )
                                  ],
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF575758),
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    lineHeight: 2.2,
                                  ),
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  final Uri uri = Uri.parse('https://sakhashree.com/about-sakhashree/');
                                  try {
                                    await launchUrl(uri);
                                  } catch (e) {
                                    print("Error launching URL: $e");
                                  }
                                },
                                text: 'READ MORE',
                                options: FFButtonOptions(
                                  width: MediaQuery.sizeOf(context).width * 0.35,
                                  height: 40,
                                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  color: Color(0xFF740074),
                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  elevation: 0,
                                  borderSide: BorderSide(
                                    color: Color(0xFF740074),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
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
                              'Photo Gallery',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                letterSpacing: 0.38,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    setState(() {
                                      _model.selectedtype = 0;  // Set selected type to Events
                                    });
                                  },
                                  text: 'Events',
                                  options: FFButtonOptions(
                                    height: 40,
                                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                    color: _model.selectedtype == 0
                                        ? FlutterFlowTheme.of(context).primary // Highlight with primary color if selected
                                        : FlutterFlowTheme.of(context).secondaryBackground, // Otherwise, use secondary background color
                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                      fontFamily: 'Montserrat',
                                      color: _model.selectedtype == 0
                                          ? Colors.white // White text when selected
                                          : FlutterFlowTheme.of(context).primaryText, // Default text color otherwise
                                      letterSpacing: 0,
                                    ),
                                    elevation: 0,
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    setState(() {
                                      _model.selectedtype = 1;  // Set selected type to Awards
                                    });
                                  },
                                  text: 'Awards',
                                  options: FFButtonOptions(
                                    height: 40,
                                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                    color: _model.selectedtype == 1
                                        ? FlutterFlowTheme.of(context).primary // Highlight with primary color if selected
                                        : FlutterFlowTheme.of(context).secondaryBackground, // Otherwise, use secondary background color
                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                      fontFamily: 'Montserrat',
                                      color: _model.selectedtype == 1
                                          ? Colors.white // White text when selected
                                          : FlutterFlowTheme.of(context).primaryText, // Default text color otherwise
                                      letterSpacing: 0,
                                    ),
                                    elevation: 0,
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ].divide(SizedBox(width: 6)),  // Adds spacing between buttons
                            ),
                            if (_model.selectedtype==0)
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(11),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 240,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                  BorderRadius.circular(0),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(0),
                                                  child: CachedNetworkImage(
                                                    fadeInDuration: Duration(
                                                        milliseconds: 500),
                                                    fadeOutDuration: Duration(
                                                        milliseconds: 500),
                                                    imageUrl:
                                                    '${FFAppConstants.aboutUs}/sakhashree-neeta-conducts-a-workshop-in-rcf-mumbai.jpg',
                                                    width: 300,
                                                    height: 200,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Sakhashree Neeta conducts workshop in Rashtriya Chemical Fertilizers (RCF – Mumbai) ',
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
                                            ].divide(SizedBox(height: 10)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(11),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 240,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                  BorderRadius.circular(0),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(0),
                                                  child: CachedNetworkImage(
                                                    fadeInDuration: Duration(
                                                        milliseconds: 500),
                                                    fadeOutDuration: Duration(
                                                        milliseconds: 500),
                                                    imageUrl:
                                                    '${FFAppConstants.aboutUs}/sakhashree-neeta-with-gopinathan-ponmanadiyil.jpg',
                                                    width: 300,
                                                    height: 200,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Gopinathan Ponmanadiyil from Rudrasha Ratna stores, Canada, with Sakhashree Neeta. ',
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
                                            ].divide(SizedBox(height: 10)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(11),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 240,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                  BorderRadius.circular(0),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(0),
                                                  child: CachedNetworkImage(
                                                    fadeInDuration: Duration(
                                                        milliseconds: 500),
                                                    fadeOutDuration: Duration(
                                                        milliseconds: 500),
                                                    imageUrl:
                                                    '${FFAppConstants.aboutUs}/sakhashree-neeta-with-actress-madhoo-shah.jpg',
                                                    width: 300,
                                                    height: 200,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Sakhashree Neeta presents Rudraksha to film actress Madhoo Shah. ',
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
                                            ].divide(SizedBox(height: 10)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(11),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 240,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                  BorderRadius.circular(0),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(0),
                                                  child: CachedNetworkImage(
                                                    fadeInDuration: Duration(
                                                        milliseconds: 500),
                                                    fadeOutDuration: Duration(
                                                        milliseconds: 500),
                                                    imageUrl:
                                                    '${FFAppConstants.aboutUs}/sakhashree-neeta-with-mr-vinod-nambiar.jpg',
                                                    width: 300,
                                                    height: 200,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Sakhashree Neeta with Dubai Channel Partner Mr Vinod Nambiar at Skanda Yoga Centre. ',
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
                                            ].divide(SizedBox(height: 10)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(11),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 240,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                  BorderRadius.circular(0),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(0),
                                                  child: CachedNetworkImage(
                                                    fadeInDuration: Duration(
                                                        milliseconds: 500),
                                                    fadeOutDuration: Duration(
                                                        milliseconds: 500),
                                                    imageUrl:
                                                    '${FFAppConstants.aboutUs}/Sakhashree Neeta with Actress Anita Raj.jpg',
                                                    width: 300,
                                                    height: 200,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Sakhashree Neeta with Veteran actress Anita Raj from Indian Cinema ',
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
                                            ].divide(SizedBox(height: 10)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                 if(_model.selectedtype==1)
                                 Padding(
                                    padding: EdgeInsets.all(11),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 240,
                                            decoration: BoxDecoration(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                              borderRadius:
                                              BorderRadius.circular(0),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(0),
                                              child: CachedNetworkImage(
                                                fadeInDuration:
                                                Duration(milliseconds: 500),
                                                fadeOutDuration:
                                                Duration(milliseconds: 500),
                                                imageUrl:
                                                '${FFAppConstants.aboutUs}/photo-gallery2.jpg',
                                                width: 300,
                                                height: 200,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Life Insurance Corporation of India honoured Sakhashree Neeta on International Women’s Day, ',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .secondaryText,
                                              fontSize: 16,
                                              letterSpacing: 0,
                                              lineHeight: 1.5,
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(0),
                                            child: CachedNetworkImage(
                                              fadeInDuration:
                                              Duration(milliseconds: 500),
                                              fadeOutDuration:
                                              Duration(milliseconds: 500),
                                              imageUrl:
                                              '${FFAppConstants.aboutUs}/award1.jpg',
                                              width: double.infinity,
                                              height: 260,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(0),
                                            child: CachedNetworkImage(
                                              fadeInDuration:
                                              Duration(milliseconds: 500),
                                              fadeOutDuration:
                                              Duration(milliseconds: 500),
                                              imageUrl:
                                              '${FFAppConstants.aboutUs}/award2.jpg',
                                              width: double.infinity,
                                              height: 260,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(0),
                                            child: CachedNetworkImage(
                                              fadeInDuration:
                                              Duration(milliseconds: 500),
                                              fadeOutDuration:
                                              Duration(milliseconds: 500),
                                              imageUrl:
                                              '${FFAppConstants.aboutUs}/award3.jpg',
                                              width: double.infinity,
                                              height: 260,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(0),
                                            child: CachedNetworkImage(
                                              fadeInDuration:
                                              Duration(milliseconds: 500),
                                              fadeOutDuration:
                                              Duration(milliseconds: 500),
                                              imageUrl:
                                              '${FFAppConstants.aboutUs}/photo-gallery8.jpg',
                                              width: double.infinity,
                                              height: 260,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Text(
                                            'Felicitated by Kr. Ritu Singh, trustee DPS ( Jammu and Katra) ',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .secondaryText,
                                              fontSize: 16,
                                              letterSpacing: 0,
                                              lineHeight: 1.5,
                                            ),
                                          ),
                                        ].divide(SizedBox(height: 10)),
                                      ),
                                    ),
                                  ),


                          ].divide(SizedBox(height: 16)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 240,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: CachedNetworkImage(
                                    fadeInDuration: Duration(milliseconds: 500),
                                    fadeOutDuration:
                                    Duration(milliseconds: 500),
                                    imageUrl:
                                    '${FFAppConstants.aboutUs}/divij-sharma-head-of-company-operations-rudraksha-ratna.jpg',
                                    width: 300,
                                    height: 200,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Text(
                                'Divij Sharma',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 22,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Head of Company Operations',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Mr. Divij Sharma is a graduate in Chemical Engineering from BITS at Pilani University. He joined the company in 2015 and he is passionate about astrology and Chakra Science. For his proficiency in Vedic Astrology he has been awarded with ‘Astro Vastu Fair Achievement Award 2021’ by Maa Sharda Jyotishdham Anusandhan Sansthanam (Reg.) Indore during their 25th International Jyotish Vastu Seminar & Jyotish Fair on 6 – 7th March 2021 at Hotel Avika, Ujjain. He is currently responsible for the company\'s operations. ',
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
                            ].divide(SizedBox(height: 10)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 240,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: CachedNetworkImage(
                                    fadeInDuration: Duration(milliseconds: 500),
                                    fadeOutDuration:
                                    Duration(milliseconds: 500),
                                    imageUrl:
                                    '${FFAppConstants.aboutUs}/rudraksha-ratna-team.jpg',
                                    width: 300,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(
                                'Our Team',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 22,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Our diverse teams of 100+ staff work together to fulfill the company\'s vision and goal. Some of our departments include Client Coordination, Artisans, Inventory Management, Order Processing, Packaging and Handling, Dispatch, Web Design and Development, SEO and Content Creation, and Accounts. Each and every department is interconnected and functions in harmony. \nWe have an in-house design team of 12 expert artisans trained in thread, gold, and silver work who follow the Rudraksha stringing instructions detailed in our holy scriptures to create powerful and effective combinations of Rudraksha beads and gemstones in bracelets, malas, pendants, and rings as requested by clients. Additionally, we have an in-house manufacturing facility with skilled 14 artisans who create Yantras and other sacred items as well as Vastu products according to strict Vedic guidelines and procedures such as Pran Prathistha. ',
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
                              FFButtonWidget(
                                onPressed: () async {
                                  context.pushNamed(
                                    'OurTeam',
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey:
                                      const TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.bottomToTop,
                                        duration: Duration(milliseconds: 400),
                                      ),
                                    },
                                  );
                                },
                                text: 'VIEW TEAM',
                                options: FFButtonOptions(
                                  width: MediaQuery.sizeOf(context).width * 0.35,
                                  height: 40,
                                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  color: Color(0xFF740074),
                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  elevation: 0,
                                  borderSide: BorderSide(
                                    color: Color(0xFF740074),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ].divide(SizedBox(height: 10)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(),
                        ),
                      ),
                    ],
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
