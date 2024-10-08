import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'policy_model.dart';
export 'policy_model.dart';

class PolicyWidget extends StatefulWidget {
  const PolicyWidget({super.key});

  @override
  State<PolicyWidget> createState() => _PolicyWidgetState();
}

class _PolicyWidgetState extends State<PolicyWidget> {
  late PolicyModel _model;

  final PolicyWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PolicyModel());
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
        key: PolicyWidgetscaffoldKey,
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
                'Privacy Policy',
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: 1,
                  decoration: BoxDecoration(
                    color: Color(0xFFE7E7E8),
                    border: Border.all(
                      color: Color(0xFFE7E7E8),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                          child: Text(
                            'Privacy Policy',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: () async {
                            await launchURL(
                                'https://www.rudraksha-ratna.com');
                          },
                          child: RichText(
                            textScaler: MediaQuery.of(context).textScaler,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:'Thank you for visiting Rudra Centre ',   style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF575758),
                                  fontSize: 14,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  lineHeight: 0,
                                ),
                                ),
                                TextSpan(
                                  text:'\n(rudraksha-ratna.com)',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context)
                                        .primary,
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                    lineHeight: 2.2,
                                  ),
                                )
                              ],
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                color: FlutterFlowTheme.of(context).greyText,
                                fontSize: 14,
                              ),
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Text(
                            'We want you to know that your privacy is important to us. Our customers are at the heart of everything we do, and we strive to ensure your experience with Rudra Centre is one that you will want to repeat and share with your friends. Part of our commitment to you is to respect and protect the privacy of the personal information you provide to us. The information below is designed to inform you of what information we collect, why we collect such information, and how we use the information we collect. This Privacy Policy is incorporated into our Terms of Service. ',
                            textAlign: TextAlign.justify,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Montserrat',
                              letterSpacing: 0,
                              color: FlutterFlowTheme.of(context)
                                  .greyText,
                              fontSize: 14,

                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                          child: Text(
                            ' When you submit your personal information to us, you are giving us your consent to the collection, use, and disclosure of your information as set forth in this Privacy Policy. We are always available to discuss your questions or concerns regarding this Privacy Policy and our privacy practices. If you would like to speak to a customer service representative. ',
                            textAlign: TextAlign.justify,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Montserrat',
                              letterSpacing: 0,

                              color: FlutterFlowTheme.of(context)
                                  .greyText,
                              fontSize: 14,
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: () async {
                            final Uri mailLaunchUri = Uri(
                              scheme: 'mailto',
                              path: 'contact@rudracentre.com,info@rudracentre.com', // replace with your email address
                              queryParameters: {


                              },
                            );
                            if (await canLaunchUrl(mailLaunchUri)) {
                              await launchUrl(mailLaunchUri);
                            } else {
                              throw 'Could not launch $mailLaunchUri';
                            }
                          },
                          child: RichText(
                            textScaler: MediaQuery.of(context).textScaler,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:'Please contact us via email at ',   style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF575758),
                                  fontSize: 14,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  lineHeight: 0,
                                ),
                                ),
                                TextSpan(
                                  text:'contact@rudracentre.com',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context)
                                        .primary,
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                    lineHeight: 2.2,
                                  ),
                                )
                              ],
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                color: FlutterFlowTheme.of(context)
                                    .greyText,
                                fontSize: 14,
                              ),
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),


                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                          child: Text(
                            'Collection and Use of Information',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          ' As a welcome guest, you can browse our Website without telling us who you are or revealing any personal information about yourself. At various times, you may decide to provide us with your personal information. You should know that we receive and may store all personal information (whether written or oral) that you provide to us through whatever means you provide such information (through our Website, via e-mail, over the telephone, etc.). Personal information means any information that may be used to identify an individual, including, but not limited to, a first and last name, home, billing or other physical address or email address as well as any information associated with the foregoing. ',
                          textAlign: TextAlign.justify,
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            letterSpacing: 0,
                            color: FlutterFlowTheme.of(context)
                                .greyText,
                            fontSize: 14,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                          child: Text(
                            'Use of Your Personal Information',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          'We may use the information we collect about you to: ',
                          textAlign: TextAlign.justify,
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            letterSpacing: 0,
                            color: FlutterFlowTheme.of(context)
                                .greyText,
                            fontSize: 14,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/ArrowRightCircle.png',
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.85,
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    'Facilitate your purchases and provide the services you request ',
                                    textAlign: TextAlign.justify,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                      color: FlutterFlowTheme.of(context)
                                          .greyText,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/ArrowRightCircle.png',
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.85,
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    'Confirm and track your order',
                                    textAlign: TextAlign.justify,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0, color: FlutterFlowTheme.of(context)
                                        .greyText,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/ArrowRightCircle.png',
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.85,
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    'Respond to your inquiries and requests',
                                    textAlign: TextAlign.justify,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                      color: FlutterFlowTheme.of(context)
                                          .greyText,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/ArrowRightCircle.png',
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.85,
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    'Compare and review your personal information for errors, omissions and accuracy ',
                                    textAlign: TextAlign.justify,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                      color: FlutterFlowTheme.of(context)
                                          .greyText,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/ArrowRightCircle.png',
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.85,
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    'Prevent and detect fraud or abuse',
                                    textAlign: TextAlign.justify,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                      color: FlutterFlowTheme.of(context)
                                          .greyText,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/ArrowRightCircle.png',
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.85,
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    'Improve our website, service, product offerings, marketing and promotional efforts, and overall customer experience ',
                                    textAlign: TextAlign.justify,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                      color: FlutterFlowTheme.of(context)
                                          .greyText,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/ArrowRightCircle.png',
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.85,
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    'Identify your product and service preferences',
                                    textAlign: TextAlign.justify,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                      color: FlutterFlowTheme.of(context)
                                          .greyText,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/ArrowRightCircle.png',
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.85,
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    'Understand our customer demographics, preferences, interests, and behavior, and contact you (via email, postal mail, or telephone) regarding products and services that we believe may be of interest to you. ',
                                    textAlign: TextAlign.justify,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                      color: FlutterFlowTheme.of(context)
                                          .greyText,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                          child: Text(
                            'Personal Information that we May Share with Others',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          'In certain circumstances, we may share your personal information with trusted partners. ',
                          textAlign: TextAlign.justify,
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            letterSpacing: 0,
                            color: FlutterFlowTheme.of(context)
                                .greyText,
                            fontSize: 14,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: RichText(
                            textScaler: MediaQuery.of(context).textScaler,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Service Providers: ',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: 'We use trusted third-party service providers to perform certain services on our behalf, including: shipping, payment processing, data storage/management, web hosting, web analytics, fulfillment, assembly, marketing, mailing, emailing, etc. These service providers only receive personal information if such information is needed to perform their function(s), and they are not authorized to use any personal information for any other purpose(s) other than the purpose(s) set forth by Rudra Centre ',
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    letterSpacing: 0,
                                    color: FlutterFlowTheme.of(context).greyText,
                                    fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '(rudraksha-ratna.com)',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).primary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          launchUrlString('https://rudraksha-ratna.com');
                                        },
                                    ),
                                    TextSpan(
                                      text: '.',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        letterSpacing: 0,
                                        color: FlutterFlowTheme.of(context).greyText,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )

                              ],
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                color: FlutterFlowTheme.of(context)
                                    .greyText,
                                fontSize: 14,
                              ),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: RichText(
                            textScaler: MediaQuery.of(context).textScaler,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Special Events: ',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                  'If you choose to participate in a special event (for example, a promotion, contest, or sweepstakes), Rudra Centre (rudraksha-ratna.com) will only share your personal information with those organizations participating in the applicable event. Unless we tell you otherwise in connection with a special event, these third parties do not use your information for any other purpose other than to manage the event. We may authorize trusted partners to send you information about products and services that may be of interest to you. ',
                                  style: TextStyle(),
                                )
                              ],
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                color: FlutterFlowTheme.of(context)
                                    .greyText,
                                fontSize: 14,
                              ),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: RichText(
                            textScaler: MediaQuery.of(context).textScaler,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                  'Compliance with Law and Fraud Protection:',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                  ' We may, and you authorize us to use and disclose any information, including personal information: (1) we deem necessary, in our sole discretion, to comply with any applicable law, regulation, legal process, or governmental request; (2) in order to investigate, prevent or take action regarding illegal activities, suspected fraud, situations involving potential threats to the physical safety of any personal or as otherwise required by law; (3) to other companies and organizations for credit fraud protection and risk reduction; and (4) to enforce any agreement we have with you ',
                                  style: TextStyle(),
                                )
                              ],
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                color: FlutterFlowTheme.of(context)
                                    .greyText,
                                fontSize: 14,
                              ),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: RichText(
                            textScaler: MediaQuery.of(context).textScaler,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Anonymous information:',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                  'We may create anonymous records from personal information by excluding information (such as your name) that makes the information personally identifiable to you. We may use these records for internal purposes, such as analyzing usage patterns so that we may enhance our services, and we also reserve the right to use and disclose any information in such records at our discretion ',
                                  style: TextStyle(),
                                )
                              ],
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                color: FlutterFlowTheme.of(context)
                                    .greyText,
                                fontSize: 14,
                              ),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: RichText(
                            textScaler: MediaQuery.of(context).textScaler,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Suggestion and feedbacks:',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                  ' We value your comments, feedback, testimonials, etc., which help us improve our website, products, and services. By making such submissions to us, you assign your rights in the submissions to us, as described in the \"Submissions\" section of our Terms and Conditions page. ',
                                  style: TextStyle(),
                                )
                              ],
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                color: FlutterFlowTheme.of(context)
                                    .greyText,
                                fontSize: 14,
                              ),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                          child: Text(
                            'Personal Information that we May Share with Others',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              letterSpacing: 0,
                              color: FlutterFlowTheme.of(context).greyText,
                              fontSize: 13,
                            ),
                            children: [
                              TextSpan(
                                text: 'IP Address. When you visit our Website, Rudra Centre ',
                              ),
                              TextSpan(
                                text: '(rudraksha-ratna.com)',
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launchUrlString('https://rudraksha-ratna.com');
                                  },
                              ),
                              TextSpan(
                                text: ' collects your IP address to, among other things, help diagnose problems with its server, administer and tune the operation of its Website, analyze trends, track traffic patterns, gather demographic information for aggregate use, and track the date and duration of each session within our Website. Your IP address may also be used in combination with your personal information to prevent fraud or abuse, customize your shopping experience, improve our website, customer service, products, and promotional efforts, and to understand your preferences, patterns and interests.',
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                color: FlutterFlowTheme.of(context).greyText,
                                fontSize: 13,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Data Collection Devices, such as Cookies and Web Beacons. In some instances, Rudra Centre ',
                                ),
                                TextSpan(
                                  text: '(rudraksha-ratna.com)',
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrlString('https://rudraksha-ratna.com');
                                    },
                                ),
                                TextSpan(
                                  text: ' may collect data through cookies, web logs, web beacons (also known as pixel gifs or action tags) and other monitoring technologies to enhance your browsing and shopping experience on our website. "Cookies" are small pieces of information that are stored by your browser on your computer\'s hard drive to collect information about your activities on our website. Web beacons are small strings of code placed on a web page or within an email for the purpose of transferring information.',
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            'We use cookies and web beacons to deliver our ads, improve and measure the usability, track visits from our affiliates and partners, performance and effectiveness of our Website, improve and measure the effectiveness of our marketing programs, learn how customers use our website, estimate our audience size, deliver co-branded services, and to customize your shopping experience. Examples of the type of information that we collect through these collection devices, includes: total visitors to the website, pages viewed, unique visitors, time spent on our Website and on certain web pages, etc. ',
                            textAlign: TextAlign.justify,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Montserrat',
                              letterSpacing: 0,
                              color: FlutterFlowTheme.of(context)
                                  .greyText,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            'We may authorize third parties to use cookies, web beacons and other monitoring technologies to compile information about the use of the Website or interaction with advertisements that appear on the Website. ',
                            textAlign: TextAlign.justify,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Montserrat',
                              letterSpacing: 0,
                              color: FlutterFlowTheme.of(context)
                                  .greyText,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            'You are always free to decline cookies if your browser permits; although, by declining the use of cookies you may not be able to use certain features on the Website. ',
                            textAlign: TextAlign.justify,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Montserrat',
                              letterSpacing: 0,
                              color: FlutterFlowTheme.of(context)
                                  .greyText,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            'Our Website may provide links to other third-party Websites which are outside our control and not covered by this privacy policy. We encourage you to review the privacy policies posted on these (and all) Websites. ',
                            textAlign: TextAlign.justify,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Montserrat',
                              letterSpacing: 0,
                              color: FlutterFlowTheme.of(context)
                                  .greyText,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            'We DO NOT sell, rent, trade any of your private information. The information shared with our trusted service providers is to enhance your shopping experience and we may use anonymous information for our internal business analytics and performance. ',
                            textAlign: TextAlign.justify,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Montserrat',
                              letterSpacing: 0,
                              color: FlutterFlowTheme.of(context)
                                  .greyText,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                          child: Text(
                            'Accessing and Updating Your Information',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',

                              color: FlutterFlowTheme.of(context).greyText,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: 'If the personally identifiable information Rudra Centre ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  letterSpacing: 0,
                                  color: FlutterFlowTheme.of(context)
                                      .greyText,
                                  fontSize: 13,
                                ),
                              ),
                              TextSpan(
                                text: '(rudraksha-ratna.com)',
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context)
                                      .primary,
                                  fontSize: 13,fontWeight: FontWeight.w500,

                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launchUrlString('https://rudraksha-ratna.com');
                                  },
                              ),
                              TextSpan(
                                text: ' has gathered from you changes or you would like to access, correct, or delete such information, we will gladly provide you access to, correct, or delete (to the extent allowed by law) any personal information we have collected about you. To request access to, a correction to, or deletion of your personal information, please send an e-mail at ',
                                style:
                                FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  letterSpacing: 0,
                                  color: FlutterFlowTheme.of(context)
                                      .greyText,
                                  fontSize: 13,
                                ),
                              ),
                              TextSpan(
                                text:'contact@rudracentre.com',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context)
                                      .primary,
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,

                                ),  recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  final Uri mailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: 'contact@rudracentre.com,info@rudracentre.com', // replace with your email address
                                    queryParameters: {


                                    },
                                  );
                                  if (await canLaunchUrl(mailLaunchUri)) {
                                    await launchUrl(mailLaunchUri);
                                  } else {
                                    throw 'Could not launch $mailLaunchUri';
                                  }
                                },
                              )
                            ],
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
      ),
    );
  }
}
