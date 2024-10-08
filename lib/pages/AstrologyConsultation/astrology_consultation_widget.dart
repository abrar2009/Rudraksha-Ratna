import '../../components/AstrologyConsultationBookNowwidget.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'astrology_consultation_model.dart';
export 'astrology_consultation_model.dart';

class AstrologyConsultationWidget extends StatefulWidget {
  const AstrologyConsultationWidget({
    super.key,
    String? consultationtype,
  }) : this.consultationtype = consultationtype ?? 'home';

  final String consultationtype;

  @override
  State<AstrologyConsultationWidget> createState() =>
      _AstrologyConsultationWidgetState();
}

class _AstrologyConsultationWidgetState
    extends State<AstrologyConsultationWidget> {
  late AstrologyConsultationModel _model;

  final AstrologyConsultationWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AstrologyConsultationModel());

    _model.expandableExpandableController1 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController2 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController3 =
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
        key: AstrologyConsultationWidgetscaffoldKey,
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
                                  'Astrology Consultation',
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
                                                  ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(0),
                                                    child: CachedNetworkImage(
                                                      fadeInDuration: Duration(
                                                          milliseconds: 500),
                                                      fadeOutDuration: Duration(
                                                          milliseconds: 500),
                                                      imageUrl:
                                                      '${FFAppConstants.astrologyConsultation}/Astrology-Consultation-main-image.jpg',
                                                      width: MediaQuery.sizeOf(
                                                          context)
                                                          .width *
                                                          0.99,
                                                      height: 228,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ],
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
                                    Text(
                                      'Consult with our Expert Astrologer for advice on Finances, Career, Marriage, Relationships, Business, Education, Physical & Mental Health issues based on your horoscope. ',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF575758),
                                        fontSize: 15,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                        lineHeight: 1.5,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                    Text(
                                      'Book 1 on 1 Call consultation with our Expert & Receive Holistic Advice & Recommendation of mystical tools like Rudraksha, Gemstones, Yantra & Pujas along detailed analysis of your horoscope. ',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF575758),
                                        fontSize: 15,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
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
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Procedure of the Consultation',
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
                                  ],
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
                                        'Once you book the consultation you will receive a confirmation email from our side on email ',
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
                                        'Our Expert will get in touch with you to receive your birth details (date, place & time of birth) as well as concerns related to health, career & relationship. ',
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
                                        'A mutually convenient time will also be decided for the consultation. ',
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
                                        'You may opt for Phone Call or Video Call (WhatsApp/Skype/Zoom/Google Meet) ',
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
                                        'Once the consultation is done you shall receive an email from our side with your horoscope analysis along with recommendation of most appropriate Rudraksha, Gemstone, Yantra & Puja ',
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
                              ].divide(SizedBox(height: 16)),
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
                                  '${FFAppConstants.pujaServicesRecommendationImafeUrl}/team/jay-rohida.jpeg',
                                  width: double.infinity,

                                  fit: BoxFit.contain,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 24, 16, 24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Our Expert: Mr Jay Rohida',
                                      textAlign: TextAlign.start,
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
                                      '(Senior Astrologer & Vastu Consultant)',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 18,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'My Jay Rohida has spent several years of his life researching Astrology, Vastu Shastra, Numerology, Intuition & Chakra Therapy. He is the chairman of IAF (International Astro Federation – USA) & has been honorary chief guest for several Astrology & Vastu conferences all over the world. After meeting Sakhashree Neeta in 2016 and learning about the power of Chakras and its link to all Planets, Astrology & Vastu he decided to be in her tutelage. Under her guidance he has become an expert in Astro Vatsu, Chakra Vastu & Astro Chakra Therapy. He specializes in making individuals realize the lessons of the planets & provides tools & techniques for alignment with these lessons so one can achieve their material & spiritual aspirations. ',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                                  '${FFAppConstants.astrologyConsultation}/astrology-consultation.jpg',
                                  width: double.infinity,

                                  fit: BoxFit.contain,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 16, 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Lessons of Planets of Astrology',
                                      textAlign: TextAlign.start,
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
                                      'Astrology is an ancient science which has been developed over millions of years. Jungian psychology emphasizes the existence of archetypes, universal symbols and themes that are present in the collective unconscious. Similarly, Vedic astrology has a rich system of symbols and archetypes, such as the planets, houses, and nakshatras (lunar mansions). Many have tried to draw parallels between the archetypal symbols in astrology and Jungian archetypes.Jung proposed the idea of a personal unconscious, which contains unique aspects of an individual\'s experiences. Vedic astrology, with its focus on the natal chart, could be seen as a tool for exploring an individual\'s unique psychological makeup. The planets\' positions and relationships in the birth chart might be interpreted as symbolic representations of psychological tendencies.Jung introduced the concept of synchronicity, the meaningful coincidence of events. Some might argue that the movements of celestial bodies and the events in a person\'s life can be linked in a synchronistic way. For example, specific transits or planetary alignments might coincide with significant psychological developments.Jung emphasized the importance of integrating opposites within the psyche for personal growth and individuation. In Vedic astrology, the concept of balancing opposing forces is evident in various aspects, such as the interplay of masculine and feminine energies, or the balancing of planetary influences.Aligning with the lessons of planets & learning about your own psychological makeup can prove to be extremely vital for our material as well as spiritual elevation. ',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                          padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.selectedindex = 0;
                                      setState(() {});
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(
                                            '${FFAppConstants.astrologyConsultation}/sun.png',
                                            width: 35,
                                            height: 35,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Sun',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: _model.selectedindex == 0
                                                ? FlutterFlowTheme.of(context)
                                                .primary
                                                : FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 16,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 8)),
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.selectedindex = 1;
                                      setState(() {});
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(
                                            '${FFAppConstants.astrologyConsultation}/moon.png',
                                            width: 35,
                                            height: 35,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Moon',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: _model.selectedindex == 1
                                                ? FlutterFlowTheme.of(context)
                                                .primary
                                                : FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 16,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 8)),
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.selectedindex = 2;
                                      setState(() {});
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(
                                            '${FFAppConstants.astrologyConsultation}/mercury.png',
                                            width: 35,
                                            height: 35,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Mercury',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: _model.selectedindex == 2
                                                ? FlutterFlowTheme.of(context)
                                                .primary
                                                : FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 16,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 8)),
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.selectedindex = 3;
                                      setState(() {});
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(
                                            '${FFAppConstants.astrologyConsultation}/venus.png',
                                            width: 35,
                                            height: 35,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Venus',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: _model.selectedindex == 3
                                                ? FlutterFlowTheme.of(context)
                                                .primary
                                                : FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 16,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 8)),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.selectedindex = 4;
                                      setState(() {});
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(
                                            '${FFAppConstants.astrologyConsultation}/mars.png',
                                            width: 35,
                                            height: 35,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Mars',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: _model.selectedindex == 4
                                                ? FlutterFlowTheme.of(context)
                                                .primary
                                                : FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 16,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 8)),
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.selectedindex = 5;
                                      setState(() {});
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(
                                            '${FFAppConstants.astrologyConsultation}/jupiter.png',
                                            width: 35,
                                            height: 35,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Jupiter',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: _model.selectedindex == 5
                                                ? FlutterFlowTheme.of(context)
                                                .primary
                                                : FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 16,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 8)),
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.selectedindex = 6;
                                      setState(() {});
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(
                                            '${FFAppConstants.astrologyConsultation}/saturn.png',
                                            width: 35,
                                            height: 35,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Saturn',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: _model.selectedindex == 6
                                                ? FlutterFlowTheme.of(context)
                                                .primary
                                                : FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 16,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 8)),
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.selectedindex = 7;
                                      setState(() {});
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(
                                            '${FFAppConstants.astrologyConsultation}/ketu.png',
                                            width: 35,
                                            height: 35,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Ketu',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: _model.selectedindex == 7
                                                ? FlutterFlowTheme.of(context)
                                                .primary
                                                : FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 16,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 8)),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.selectedindex = 8;
                                      setState(() {});
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(
                                            '${FFAppConstants.astrologyConsultation}/rahu.png',
                                            width: 35,
                                            height: 35,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Rahu',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: _model.selectedindex == 8
                                                ? FlutterFlowTheme.of(context)
                                                .primary
                                                : FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 16,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 8)),
                                    ),
                                  ),
                                ],
                              ),
                              Builder(
                                builder: (context) {
                                  if (_model.selectedindex == 0) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            '${FFAppConstants.astrologyConsultation}/sun.jpg',
                                            width: double.infinity,
                                            height: 200,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Sun, the giver of life, represents our conscious mind in Astrology. It represents our will to live and our creative life. The Sun is our basic identity, and represents self-realization. The Sun also represents our overall vitality. The Sun directs us, and can be considered “the boss” or the director of our chart. It determines our life purpose. \n The Sun reflects the present or the “here and now”. It teaches that you have maximum potential only in the now. Past is gone and future has yet to come. So release the past by act of forgiveness and let go. The sun teaches us lessons of evoking our self power and not giving our power to others. \n When we are “acting out” our Sun, we are purposeful, directed, proud, and creative. On the negative side, we can be haughty, overly willful, self-centered, and judgmental. ',
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            color: FlutterFlowTheme.of(context).secondaryText,
                                            fontSize: 15,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w500,
                                            lineHeight: 1.5,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ].divide(SizedBox(height: 10)),
                                    );
                                  } else if (_model.selectedindex == 1) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            'https://www.rudraksha-ratna.com/assets/img/consultation/moon.jpg',
                                            width: double.infinity,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          'The Moon, in Astrology, is the ruler of Cancer. The Moon represents our deepest personal needs, our basic habits and reactions, and our unconscious. Where the Sun acts, the Moon reacts. How do we instinctively react or respond to problems? What do we feel we need for a sense of security? Look to the Moon in your natal chart for answers. \n The Moon is associated with the mother and with feminine energy in general. The Moon is related to both our inner child and our external mother, as well as our inner maternal instinct. It is responsive, receptive, and reflective. The Moon is our spontaneous and instinctual reactions. We can also consider the Moon to be the source of our life\'s narrative and vitality, since we cannot advance if we lack motivation and the feeling to act. \n The Moon houses all our feelings. It governs the rhythmic ebb and flow of energy and activity. It acts as a bridge between the inner and outer worlds. In contrast to the objectivity of the Sun, the Moon is irrational or subjective. As a result, the Moon governs prejudices and ingrained patterns of behaviors. Prejudices may not be acted out, as our Sun may censor them, but the Moon rules our spontaneous reactions and feelings. \n When we have a strong Moon in the chart we are imaginative, creative, fearless, emotionally balanced, adaptable, introspective, and protective. Those with malefic moon are prone to emotional instability, fears, and insecurities and are moody, restless, and irrational. Our natal Moon\'s most valuable lesson is to experience inner joy. ',
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            color: FlutterFlowTheme.of(context).secondaryText,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w500,
                                            lineHeight: 1.5,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 10)),
                                    );
                                  } else if (_model.selectedindex == 2) {
                                    return Column(
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
                                            'https://www.rudraksha-ratna.com/assets/img/consultation/mercury.jpg',
                                            width: double.infinity,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          'Mercury, the messenger of the gods, is the ruler of the zodiac sign Gemini and the third house. Mercury is the messenger of day-to-day expression and communication. In modern times, we tend to “meet” people\'s Mercury first. Mercury regulate whether our speech and/or writing is flowery, concise, or even businesslike, including in our personal communications. \n Mercury not only rules communication, it also rules our heart chakra. Those with an unfavorable positioned Mercury at birth go through intense ups and downs in relationships till they learn lessons of right communication, social learning and stability in relationships through their thoughts and actions. When we are “acting out” our Mercury, we are inquisitive, curious, communicative, and versatile. On the negative side, we can be high-strung or nervous, nit-picky, indecisive, and overly technical. \n Mercury by sign shows an individual\'s style of communication. For instance Mercury in Aries denotes an impulsive and straightforward expression of our thoughts while Mercury in Libra relates with a more poetic and tactful manner of communication. Mercury in Cancer enjoys telling stories, whereas Mercury in Leo conveys everything with drama. Also, Mercury is the closest planet to the Sun in the natal chart, so they share the same zodiac sign in most cases. \n By house, Mercury reveals where natives seek to communicate and express their ideas to others, where they tend to intellectualize and give a lot of thought to. However, the way Mercury operates in the natal chart is largely modified by any planet in aspect with it, especially when it is in aspect with the outer planets, from Saturn and beyond. \n Mercury retrograde in a natal chart hinders communication and encourages the withholding of thoughts and their expression to others. On the other hand, extrovert speakers are born with a dynamic Mercury aspected by numerous planets. Genius minds are very often a result of a combination of Mercury connected by aspect with Jupiter, Uranus and/or Pluto. ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w500,
                                            lineHeight: 1.5,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 10)),
                                    );
                                  } else if (_model.selectedindex == 3) {
                                    return Column(
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
                                            'https://www.rudraksha-ratna.com/assets/img/consultation/mercury.jpg',
                                            width: double.infinity,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          'Venus is the Goddess of Love. In Astrology, Venus has dual rulership over Libra and Taurus. As a result, Venus represents two main areas of our life: love and money. However, “Love and money” is actually a simplistic interpretation of Venus. Venus rules our sentiments, what we value, and the pleasure we take in life. Grace, charm, and beauty are all ruled by Venus. Through Venus, we learn about our tastes, pleasures, artistic inclinations, and what makes us happy. \n where they lose money if not careful or end up in debts or face discontentment or shortfall of money occasionally. Once lessons are learned they are blessed with abundance.  where they lose money if not careful or end up in debts or face discontentment or shortfall of money occasionally. Once lessons are learned they are blessed with abundance. \n Venus rules attachments to others. It rules attractiveness both the ability to attract and attraction to others (and things). Venus energy is harmonious, and this is why people with Venus prominent in their charts are often peace-makers. In Venus, we find a need to be appreciated and to appreciate. Venus rules, amongst other things, the arts, love and romance, beauty and the beautifying process, money, entertainment, leisure, sensuality, and comfort. When we are “acting out” our Venus, we compromise, make peace, are loving, and act with taste. On the negative side, we can be self-indulgent, self-centered, vain, and superficial. \n Venus is the most social planet; its position at birth indicates how we begin to interact with others, how we express and receive affection from others, and how we tend to behave in general in social settings. Thus, a Venus in Virgo tends to be shy, whereas a Venus in Sagittarius is full of friends. It regulates our affections and connections with others. ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w500,
                                            lineHeight: 1.5,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 10)),
                                    );
                                  } else if (_model.selectedindex == 4) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            'https://www.rudraksha-ratna.com/assets/img/consultation/mars.jpg',
                                            width: double.infinity,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          'Mars, the God of War, is the ruler of Aries. In astrology, Mars is the planet of action and impulse. It also represents our survival instinct, and can be thought of as the \"leftover\" animal nature of man. \n Therefore, Mars rules our animal instincts for aggression, anger, and subsistence. With Mars, there is no contemplation before action. The drive associated with Mars differs from that of the Sun in its willingness to act and complete tasks. It embodies our sense of self-assertiveness. Mars rules our survival for stability in life, this is why hunters are ruled by Mars. \n Let’s say we have a natal Mars in bad aspect with Jupiter, until we sort out this we cannot achieve fruitful objectives in life. Or Mars negatively aspected with the Moon or Neptune, showing a constant disorientation of our actions so we hardly accomplish our needs. \n Mars is the motivation that gets us out of bed in the morning, our drive to act in accordance with the desires of Venus in our natal chart, and our physical energy. An aware and well-balanced Mars energy makes us confident, determined, forthright, and daring. Otherwise, we could be rash, impatient, aggressive, and destructive on the negative side. ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w500,
                                            lineHeight: 1.5,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 10)),
                                    );
                                  } else if (_model.selectedindex == 5) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            'https://www.rudraksha-ratna.com/assets/img/consultation/jupiter.jpg',
                                            width: double.infinity,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          'Jupiter, the King of the Gods, is the ruler of Sagittarius and called Guru the Teacher. In Astrology, Jupiter is a planet of learning. Jupiter seeks insight through knowledge. Some of this planet\'s keywords include morality, self-confidence, hope, honor, and the law. \n Jupiter is a planet of broader purpose, reach, and possibilities, and it is related with higher learning and traveling. It has generally been associated with optimism and growth (including mental and spiritual growth). It teaches that we can grow in life only by tapping and developing our own uniqueness, wisdom and understanding and realizing things from our perspective. \n Jupiter is the most beneficial planet in the birth chart, there is not such a thing as a malefic Jupiter in the chart. It represents our access to higher knowledge and wisdom and how we can grow our unique qualities. The best positioned it is the easier we can develop these. ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w500,
                                            lineHeight: 1.5,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 10)),
                                    );
                                  } else if (_model.selectedindex == 6) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            'https://www.rudraksha-ratna.com/assets/img/consultation/saturn.jpg',
                                            width: double.infinity,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          'Saturn, is the ruler of Capricorn. In astrology, Saturn is associated with restriction and limitation. Where Jupiter expands, Saturn constricts. Because of this Saturn might seem gloomy but it is not. Saturn brings structure and meaning to our world. Saturn knows the limits of time and matter. Saturn reminds us of our boundaries, our duties and our commitments. It provides meaning to our lives. Saturn teaches us the importance of self-discipline, handling responsibilities, facing problems head-on, and recognizing our limits and boundaries. Saturn rules the skin of the human body, which serves as a healthy barrier between us and others. \n Saturn is often associated with our fathers and authority figures. In childhood, the discipline, rules, and regulations imposed on us by our authority figures, from parents, teachers, and the like were not always pleasant, but they actually helped us to understand the world around us. Similarly, Saturn\'s lessons actually help us to grow, mature and reach our goals. ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w500,
                                            lineHeight: 1.5,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 10)),
                                    );
                                  } else if (_model.selectedindex == 7) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            'https://www.rudraksha-ratna.com/assets/img/consultation/ketu.jpg',
                                            width: double.infinity,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          'Ketu is the lower part of the celestial snake. Ketu causes great impediments in your paths. It sets up roadblocks, traffic jams, boulders in your journey of life. It causes pain. It wants to change your psyche. You learn to leave your excess baggage of past Karma behind. Travel lightly into your this existence so that you can understand there are areas of your life which need to address and some left behind. Those unable to harness the power of Ketu or understand its karmic path can be lead to a sorrowful existence. \n Occasionally, it is difficult for anyone to stand in Ketu\'s way. We must accept and comprehend the divine plan that is part of our destiny, and Ketu is working to produce in you the enlightenment that will lead to genuine enlightenment and respect. The effect of Ketu problems is comparable to undergoing a fire ritual from which one emerges stronger and more capable of tackling the problems thrown at us. ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w500,
                                            lineHeight: 1.5,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 10)),
                                    );
                                  } else  if (_model.selectedindex == 8)  {
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: Image.network(
                                            'https://www.rudraksha-ratna.com/assets/img/consultation/rahu.jpg',
                                            width: double.infinity,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text("Rahu is the head part of the celestial snake. It is the north that indicates the direction of our lives. Rahu has a very definite purpose in doing so. It wants you to learn, taste and feel everything so that from the full satiation of your senses you turn a new leaf on the path of self-realization and find their true enlightenment. Rahu on a physical plane gives you insatiable desire to achieve, to conquer. \n Once you have reached the pinnacle of achievement, you realize this success you have achieved has not brought with it happiness because you were in fact chasing an illusion. There are many cults in India which preach satiation of all your mundane and carnal desires so that we can learn the important lesson of fulfilment of all your desires do not give you the true happiness.  "
                    ,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w500,
                                            lineHeight: 1.5,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 10)),
                                    );
                                  }
                                  else
                                    return Container();
                                },
                              ),
                            ].divide(SizedBox(height: 10)),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(),
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
                                                carouselController: _model.carouselController ??= CarouselSliderController(),
                                                options: CarouselOptions(
                                                  initialPage: max(0,
                                                      min(valueOrDefault<int>(
                                                        _model.countControllerValue, 0,),
                                                          testimonials.length - 1)),
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
                                              '01. What is the timing of consultation? ',
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
                                              'Once the consultation is booked, our expert will connect with you to decide on a mutually convenient time for the consultation ',
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
                                          controller: _model.expandableExpandableController2,
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
                                              'The consultation can be done in English or Hindi ',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                letterSpacing: 0,
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
                                              '03. I don’t know my exact time of birth. Can we still do my astrology reading? ',
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
                                              'If you are not sure about your time of birth, we strongly recommend you to opt for either Consult With Sakhashree OR Rudraksha & Gems Recommendation. The reason is that without your time of birth an accurate astrology chart cannot be made. ',
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
                              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                        child: Text(
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
                                height:734,
                                child: const AstrologyConsultationBookNowWidget(),
                              ),
                            ),
                          );
                        },
                      ).then(
                              (value) => safeSetState(() {}));
                    },
                    text: 'Book Now   INR 1,100',
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
