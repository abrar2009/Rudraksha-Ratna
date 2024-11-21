

import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../custom_code/widgets/GoogleMap.dart';
import '../../custom_code/widgets/GoogleMap_model.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'contact_us_model.dart';
export 'contact_us_model.dart';

class ContactUsWidget extends StatefulWidget {
  const ContactUsWidget({super.key});

  @override
  State<ContactUsWidget> createState() => _ContactUsWidgetState();
}

class _ContactUsWidgetState extends State<ContactUsWidget> {
  late ContactUsModel _model;
  late FlutterFlowGoogleMapModel _GoogleMapmodel;

  final ContactUsWidgetscaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController? mapController;

  final gmaps.LatLng _companyLocation = gmaps.LatLng(19.08015306732932, 72.89606000000003); // Replace with your company's latitude and longitude



  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ContactUsModel());

    _GoogleMapmodel = FlutterFlowGoogleMapModel();


    _model.expandableExpandableController1 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController2 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController3 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController4 =
        ExpandableController(initialExpanded: false);
    _model.nameTextController ??= TextEditingController();
    _model.nameFocusNode ??= FocusNode();

    _model.emailTextController ??= TextEditingController();
    _model.emailFocusNode ??= FocusNode();

    _model.phoneTextController ??= TextEditingController();
    _model.phoneFocusNode ??= FocusNode();

    _model.subjectTextController ??= TextEditingController();
    _model.subjectFocusNode ??= FocusNode();

    _model.queryTextController ??= TextEditingController();
    _model.queryFocusNode ??= FocusNode();
  }
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: ContactUsWidgetscaffoldKey,
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
                'Contact Us',
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFE7E7E8),
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 6, 16, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFE3CCE3),
                              borderRadius: BorderRadius.circular(4),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                            ),
                            child: Container(
                              width: double.infinity,
                              color: Color(0x00000000),
                              child: ExpandableNotifier(
                                controller:
                                _model.expandableExpandableController1,
                                child: ExpandablePanel(
                                  header: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                    child: Text(
                                      'Contact',
                                      style: FlutterFlowTheme.of(context).displaySmall.override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context).primary,
                                        fontSize: 14,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  collapsed: Container(),
                                  expanded: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                          border: Border.all(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                                              child: Text(
                                                'Product Related Enquiry/ Ask Expert',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(8),
                                                        child: Image.asset(
                                                          'assets/images/Call.png',
                                                          width: 20,
                                                          height: 20,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Mobile: +91-70211 80033 / +91-98191 11150',
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Montserrat',
                                                          color: Color(0xFF6F6F6F),
                                                          letterSpacing: 0,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ].divide(SizedBox(width: 15)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(8),
                                                        child: Image.asset(
                                                          'assets/images/whatsapp_2.png',
                                                          width: 20,
                                                          height: 20,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          final Uri whatsappLaunchUri = Uri(
                                                            scheme: 'https',
                                                            host: 'api.whatsapp.com',
                                                            path: '/send',
                                                            queryParameters: {
                                                              'phone': '919819111150',

                                                            },
                                                          );

                                                          if (await canLaunchUrl(whatsappLaunchUri)) {
                                                            await launchUrl(whatsappLaunchUri, mode: LaunchMode.externalApplication);
                                                          } else {
                                                            throw 'Could not launch $whatsappLaunchUri';
                                                          }
                                                        },
                                                        child: Text(
                                                          'WhatsApp: +91-98191 11150',
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Montserrat',
                                                            color: Color(0xFF6F6F6F),
                                                            letterSpacing: 0,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(SizedBox(width: 15)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(8),
                                                        child: Image.asset(
                                                          'assets/images/Message.png',
                                                          width: 20,
                                                          height: 20,
                                                          fit: BoxFit.cover,
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
                                                        child: Text(
                                                          'Mail: contact@rudracentre.com',
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Montserrat',
                                                            color: Color(0xFF6F6F6F),
                                                            letterSpacing: 0,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(SizedBox(width: 15)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                                              child: Text(
                                                'Puja Services Enquiry',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(8),
                                                        child: Image.asset(
                                                          'assets/images/Call.png',
                                                          width: 20,
                                                          height: 20,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          final Uri phoneLaunchUri = Uri(
                                                            scheme: 'tel',
                                                            path: '+9193268 81243', // replace with your phone number
                                                          );
                                                          if (await canLaunchUrl(phoneLaunchUri)) {
                                                            await launchUrl(phoneLaunchUri);
                                                          } else {
                                                            throw 'Could not launch $phoneLaunchUri';
                                                          }
                                                        },
                                                        child: Text(
                                                          'Mobile: +91-93268 81243',
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Montserrat',
                                                            color: Color(0xFF6F6F6F),
                                                            letterSpacing: 0,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(SizedBox(width: 15)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(8),
                                                        child: Image.asset(
                                                          'assets/images/whatsapp_2.png',
                                                          width: 20,
                                                          height: 20,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          final Uri whatsappLaunchUri = Uri(
                                                            scheme: 'https',
                                                            host: 'api.whatsapp.com',
                                                            path: '/send',
                                                            queryParameters: {
                                                              'phone': '9326881243',

                                                            },
                                                          );

                                                          if (  await canLaunchUrl(whatsappLaunchUri)) {
                                                            await launchUrl(whatsappLaunchUri, mode: LaunchMode.externalApplication);
                                                          } else {
                                                            throw 'Could not launch $whatsappLaunchUri';
                                                          }
                                                        },
                                                        child: Text(
                                                          'WhatsApp: +91-93268 81243',
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Montserrat',
                                                            color: Color(0xFF6F6F6F),
                                                            letterSpacing: 0,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(SizedBox(width: 15)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(8),
                                                        child: Image.asset(
                                                          'assets/images/Message.png',
                                                          width: 20,
                                                          height: 20,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          final Uri mailLaunchUri = Uri(
                                                            scheme: 'mailto',
                                                            path: 'pujaservices@rudracentre.com', // replace with your email address
                                                            queryParameters: {


                                                            },
                                                          );
                                                          if (await canLaunchUrl(mailLaunchUri)) {
                                                            await launchUrl(mailLaunchUri);
                                                          } else {
                                                            throw 'Could not launch $mailLaunchUri';
                                                          }
                                                        },
                                                        child: Text(
                                                          'Mail: pujaservices@rudracentre.com',
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Montserrat',
                                                            color: Color(0xFF6F6F6F),
                                                            letterSpacing: 0,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(SizedBox(width: 15)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  theme: ExpandableThemeData(
                                    tapHeaderToExpand: true,
                                    tapBodyToExpand: false,
                                    tapBodyToCollapse: false,
                                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                                    hasIcon: true,
                                    iconSize: 30,
                                    iconColor: Color(0xFF740074),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 6, 16, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFE3CCE3),
                              borderRadius: BorderRadius.circular(4),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                            ),
                            child: Container(
                              width: double.infinity,
                              color: Color(0x00000000),
                              child: ExpandableNotifier(
                                controller: _model.expandableExpandableController2,
                                child: ExpandablePanel(
                                  header: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                    child: Text(
                                      'Head Office, Mumbai',
                                      style: FlutterFlowTheme.of(context).displaySmall.override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context).primary,
                                        fontSize: 14,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  collapsed: Container(),
                                  expanded: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                          border: Border.all(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                                              child: Text(
                                                'Address',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(8),
                                                        child: Image.asset(
                                                          'assets/images/location_color.png',
                                                          width: 20,
                                                          height: 20,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 250,
                                                        child: Text(
                                                          'Rudraksha Ratna D-319/320, Neelkanth Business Park, Nathani Road, Behind Vidyavihar Railway Station, Vidyavihar West, Mumbai- 400086, INDIA',
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Montserrat',
                                                            color: Color(0xFF6F6F6F),
                                                            letterSpacing: 0,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(SizedBox(width: 15)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  theme: ExpandableThemeData(
                                    tapHeaderToExpand: true,
                                    tapBodyToExpand: false,
                                    tapBodyToCollapse: false,
                                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                                    hasIcon: true,
                                    iconSize: 30,
                                    iconColor: Color(0xFF740074),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 6, 16, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFE3CCE3),
                              borderRadius: BorderRadius.circular(4),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                            ),
                            child: Container(
                              width: double.infinity,
                              color: Color(0x00000000),
                              child: ExpandableNotifier(
                                controller: _model.expandableExpandableController3,
                                child: ExpandablePanel(
                                  header: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                    child: Text(
                                      'Office Timings',
                                      style: FlutterFlowTheme.of(context).displaySmall.override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context).primary,
                                        fontSize: 14,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  collapsed: Container(),
                                  expanded: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                          border: Border.all(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                                              child: Text(
                                                'Gallery',
                                                style:
                                                FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(8),
                                                        child: Image.asset(
                                                          'assets/images/clock_color.png',
                                                          width: 20,
                                                          height: 20,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Monday – Saturday: 9:00 AM – 7:00 PM IST \n Sunday: Closed',
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Montserrat',
                                                          color: Color(0xFF6F6F6F),
                                                          letterSpacing: 0,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ].divide(SizedBox(width: 15)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(8),
                                                        child: Image.asset(
                                                          'assets/images/Call.png',
                                                          width: 20,
                                                          height: 20,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          final Uri phoneLaunchUri = Uri(
                                                            scheme: 'tel',
                                                            path: '+912262102938', // replace with your phone number
                                                          );
                                                          if (await canLaunchUrl(phoneLaunchUri)) {
                                                            await launchUrl(phoneLaunchUri);
                                                          } else {
                                                            throw 'Could not launch $phoneLaunchUri';
                                                          }
                                                        },
                                                        child: Text(
                                                          'Landline: +91 22 62102938',
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Montserrat',
                                                            color: Color(0xFF6F6F6F),
                                                            letterSpacing: 0,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(SizedBox(width: 15)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(8),
                                                        child: Image.asset(
                                                          'assets/images/Call.png',
                                                          width: 20,
                                                          height: 20,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          final Uri phoneLaunchUri = Uri(
                                                            scheme: 'tel',
                                                            path: '+919321866566', // replace with your phone number
                                                          );
                                                          if (await canLaunchUrl(phoneLaunchUri)) {
                                                            await launchUrl(phoneLaunchUri);
                                                          } else {
                                                            throw 'Could not launch $phoneLaunchUri';
                                                          }
                                                        },

                                                        child: Text(
                                                          'Mobile: +91-9321866566',
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Montserrat',
                                                            color: Color(0xFF6F6F6F),
                                                            letterSpacing: 0,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(SizedBox(width: 15)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                                              child: Text(
                                                'Consultation With Neeta Singhal (By Appointment Only) ',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 5),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(8),
                                                        child: Image.asset(
                                                          'assets/images/clock_color.png',
                                                          width: 20,
                                                          height: 20,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Monday – Saturday: 9:00 AM – 7:00 PM IST',
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Montserrat',
                                                          color: Color(0xFF6F6F6F),
                                                          letterSpacing: 0,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ].divide(SizedBox(width: 15)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  theme: ExpandableThemeData(
                                    tapHeaderToExpand: true,
                                    tapBodyToExpand: false,
                                    tapBodyToCollapse: false,
                                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                                    hasIcon: true,
                                    iconSize: 30,
                                    iconColor: Color(0xFF740074),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 6, 16, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFE3CCE3),
                              borderRadius: BorderRadius.circular(4),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                            ),
                            child: Container(
                              width: double.infinity,
                              color: Color(0x00000000),
                              child: ExpandableNotifier(
                                controller: _model.expandableExpandableController4,
                                child: ExpandablePanel(
                                  header: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                    child: Text(
                                      'For Return / Repair Shipments',
                                      style: FlutterFlowTheme.of(context).displaySmall.override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context).primary,
                                        fontSize: 14,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  collapsed: Container(),
                                  expanded: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                          border: Border.all(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                                              child: Text(
                                                'Canada',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  letterSpacing: 0,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                                              child: Text(
                                                'Gopinathan Ponmanadiyil ',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(8),
                                                        child: Image.asset(
                                                          'assets/images/location_color.png',
                                                          width: 20,
                                                          height: 20,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(context).size.width * 0.75,
                                                        decoration: BoxDecoration(),
                                                        child: Text(
                                                          '5076 Guildwood Way, Mississauga, Ontario, Canada ',
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Montserrat',
                                                            color: Color(0xFF6F6F6F),
                                                            letterSpacing: 0,
                                                            fontWeight:FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(SizedBox(width: 15)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(8),
                                                        child: Image.asset(
                                                          'assets/images/Call.png',
                                                          width: 20,
                                                          height: 20,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          final Uri phoneLaunchUri = Uri(
                                                            scheme: 'tel',
                                                            path: '+19058900733', // replace with your phone number
                                                          );
                                                          if (await canLaunchUrl(phoneLaunchUri)) {
                                                            await launchUrl(phoneLaunchUri);
                                                          } else {
                                                            throw 'Could not launch $phoneLaunchUri';
                                                          }
                                                        },

                                                        child: Text(
                                                          '+1 9058900733',
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Montserrat',
                                                            color: Color(0xFF6F6F6F),
                                                            letterSpacing: 0,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(SizedBox(width: 15)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                                              child: Text(
                                                'USA',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                                              child: Text(
                                                'Rishi Hans ',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(8),
                                                        child: Image.asset(
                                                          'assets/images/location_color.png',
                                                          width: 20,
                                                          height: 20,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(context).size.width * 0.75,
                                                        decoration:
                                                        BoxDecoration(),
                                                        child: Text(
                                                          '21913 Manor Crest Ln. Boyds, MD 20841 USA ',
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Montserrat',
                                                            color: Color(0xFF6F6F6F),
                                                            letterSpacing: 0,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(SizedBox(width: 15)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(8),
                                                        child: Image.asset(
                                                          'assets/images/Call.png',
                                                          width: 20,
                                                          height: 20,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          final Uri phoneLaunchUri = Uri(
                                                            scheme: 'tel',
                                                            path: '+13013651111', // replace with your phone number
                                                          );
                                                          if (await canLaunchUrl(phoneLaunchUri)) {
                                                            await launchUrl(phoneLaunchUri);
                                                          } else {
                                                            throw 'Could not launch $phoneLaunchUri';
                                                          }
                                                        },
                                                        child: Text(
                                                          '+1 3013651111',
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Montserrat',
                                                            color: Color(0xFF6F6F6F),
                                                            letterSpacing: 0,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(SizedBox(width: 15)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                                              child: Text(
                                                'Asheesh K Gupta ',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(8),
                                                        child: Image.asset(
                                                          'assets/images/location_color.png',
                                                          width: 20,
                                                          height: 20,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(context).size.width * 0.75,
                                                        decoration:
                                                        BoxDecoration(),
                                                        child: Text(
                                                          '208 Legends Ln Ste 130 Lexington, KY 40505 ',
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily:
                                                            'Montserrat',
                                                            color: Color(0xFF6F6F6F),
                                                            letterSpacing: 0,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(SizedBox(width: 15)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(5, 10, 5, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(8),
                                                        child: Image.asset(
                                                          'assets/images/Call.png',
                                                          width: 20,
                                                          height: 20,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          final Uri phoneLaunchUri = Uri(
                                                            scheme: 'tel',
                                                            path: '+18594021400', // replace with your phone number
                                                          );
                                                          if (await canLaunchUrl(phoneLaunchUri)) {
                                                            await launchUrl(phoneLaunchUri);
                                                          } else {
                                                            throw 'Could not launch $phoneLaunchUri';
                                                          }
                                                        },
                                                        child: Text(
                                                          '+1 8594021400',
                                                          style: FlutterFlowTheme
                                                              .of(context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Montserrat',
                                                            color: Color(
                                                                0xFF6F6F6F),
                                                            letterSpacing: 0,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 15)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5, 10, 0, 0),
                                              child: Text(
                                                'Malaysia',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily:
                                                  'Montserrat',
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  letterSpacing: 0,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5, 10, 0, 0),
                                              child: Text(
                                                'Baladevan Balakrishnan ',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily:
                                                  'Montserrat',
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  letterSpacing: 0,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          5, 10, 5, 0),
                                                      child: Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                8),
                                                            child: Image.asset(
                                                              'assets/images/location_color.png',
                                                              width: 20,
                                                              height: 20,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of(context).size.width * 0.75,
                                                            decoration:
                                                            BoxDecoration(),
                                                            child: Text(
                                                              'No 5 Aria Park, Jalan Bukit Citra 2, Taman Bukit Citra, 71800 Nilai, Negeri Sembilan Malaysia ',
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                fontFamily:
                                                                'Montserrat',
                                                                color: Color(
                                                                    0xFF6F6F6F),
                                                                letterSpacing:
                                                                0,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 15)),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          5, 10, 5, 5),
                                                      child: Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                8),
                                                            child: Image.asset(
                                                              'assets/images/Call.png',
                                                              width: 20,
                                                              height: 20,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              final Uri phoneLaunchUri = Uri(
                                                                scheme: 'tel',
                                                                path: '+608591551561', // replace with your phone number
                                                              );
                                                              if (await canLaunchUrl(phoneLaunchUri)) {
                                                                await launchUrl(phoneLaunchUri);
                                                              } else {
                                                                throw 'Could not launch $phoneLaunchUri';
                                                              }
                                                            },
                                                            child: Text(
                                                              '+60 8591551561',
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                fontFamily:
                                                                'Montserrat',
                                                                color: Color(
                                                                    0xFF6F6F6F),
                                                                letterSpacing:
                                                                0,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 15)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  theme: ExpandableThemeData(
                                    tapHeaderToExpand: true,
                                    tapBodyToExpand: false,
                                    tapBodyToCollapse: false,
                                    headerAlignment:
                                    ExpandablePanelHeaderAlignment.center,
                                    hasIcon: true,
                                    iconSize: 30,
                                    iconColor: Color(0xFF740074),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 24, 0, 16),
                                      child: Text(
                                        'Have a Question?',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontSize: 18,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Form(
                                  key: _model.formKey5,
                                  autovalidateMode: AutovalidateMode.always,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 24),
                                    child: TextFormField(
                                      controller: _model.nameTextController,
                                      focusNode: _model.nameFocusNode,
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Name*',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 0,
                                        ),
                                        hintText: 'Enter Full Name',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16,
                                          letterSpacing: 0,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF868687),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(0),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(0),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(0),
                                        ),
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(0),
                                        ),
                                        contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0, 6, 0, 6),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        letterSpacing: 0,
                                      ),
                                      keyboardType: TextInputType.name,
                                      validator: _model
                                          .nameTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                Form(
                                  key: _model.formKey4,
                                  autovalidateMode: AutovalidateMode.always,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 24),
                                    child: TextFormField(
                                      controller: _model.emailTextController,
                                      focusNode: _model.emailFocusNode,
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Email*',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 0,
                                        ),
                                        hintText: 'Enter Email Address',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16,
                                          letterSpacing: 0,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF868687),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(0),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(0),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(0),
                                        ),
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(0),
                                        ),
                                        contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0, 6, 0, 6),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        letterSpacing: 0,
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: _model
                                          .emailTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                Form(
                                  key: _model.formKey1,
                                  autovalidateMode: AutovalidateMode.always,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 24),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: AlignmentDirectional(0, 1),
                                          child: FlutterFlowDropDown<String>(
                                            controller: _model.dropDownValueValueController ??= FormFieldController<String>(null),
                                            options: functions.countryCodes()!,
                                            onChanged: (val) => setState(() => _model.dropDownValueValue = val),
                                            width: 75,
                                            maxHeight: 350,
                                            searchHintTextStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                              fontFamily: 'Montserrat',
                                              letterSpacing: 0,
                                            ),
                                            searchTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              letterSpacing: 0,
                                            ),
                                            textStyle: FlutterFlowTheme.of(
                                                context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            hintText: '+00',
                                            searchHintText: '',
                                            icon: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color: FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                              size: 24,
                                            ),
                                            fillColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            elevation: 2,
                                            borderColor: Colors.transparent,
                                            borderWidth: 0,
                                            borderRadius: 0,
                                            margin:
                                            EdgeInsetsDirectional.fromSTEB(
                                                6, 6, 0, 12),
                                            isOverButton: true,
                                            isSearchable: true,
                                            isMultiSelect: false,
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            controller:
                                            _model.phoneTextController,
                                            focusNode: _model.phoneFocusNode,
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Phone Number*',
                                              labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                letterSpacing: 0,
                                              ),
                                              hintText: 'Enter Phone Number',
                                              hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                color:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .primaryText,
                                                fontSize: 16,
                                                letterSpacing: 0,
                                              ),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFF868687),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(0),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(0),
                                              ),
                                              errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(0),
                                              ),
                                              focusedErrorBorder:
                                              UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(0),
                                              ),
                                              contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 6, 0, 12),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              fontSize: 16,
                                              letterSpacing: 0,
                                            ),
                                            keyboardType: TextInputType.phone,
                                            validator: _model
                                                .phoneTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 6)),
                                    ),
                                  ),
                                ),
                                Form(
                                  key: _model.formKey2,
                                  autovalidateMode: AutovalidateMode.always,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 24),
                                    child: TextFormField(
                                      controller: _model.subjectTextController,
                                      focusNode: _model.subjectFocusNode,
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Subject*',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 0,
                                        ),
                                        hintText: 'Enter Subject',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16,
                                          letterSpacing: 0,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF868687),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(0),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(0),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(0),
                                        ),
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(0),
                                        ),
                                        contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0, 6, 0, 6),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        letterSpacing: 0,
                                      ),
                                      keyboardType: TextInputType.name,
                                      validator: _model
                                          .subjectTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                Form(
                                  key: _model.formKey3,
                                  autovalidateMode: AutovalidateMode.always,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 24),
                                    child: TextFormField(
                                      controller: _model.queryTextController,
                                      focusNode: _model.queryFocusNode,
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Query*',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 0,
                                        ),
                                        hintText: 'Enter Query',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16,
                                          letterSpacing: 0,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF868687),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(0),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(0),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(0),
                                        ),
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(0),
                                        ),
                                        contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0, 6, 0, 6),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        letterSpacing: 0,
                                      ),
                                      keyboardType: TextInputType.name,
                                      validator: _model
                                          .queryTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                /*Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 24, 0, 24),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      // Validate fields
                                      if (_model.emailTextController.text.isEmpty ||
                                          _model.phoneTextController.text.isEmpty ||
                                          _model.nameTextController.text.isEmpty ||
                                          _model.subjectTextController.text.isEmpty ||
                                          _model.queryTextController.text.isEmpty) {
                                        ScaffoldMessenger.of(context).clearSnackBars();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Please fill in all the fields',
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).primaryText,
                                                fontSize: 16,
                                              ),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                        return;
                                      }

                                      if (_model.dropDownValueValue == null) {
                                        ScaffoldMessenger.of(context).clearSnackBars();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Please select a country code',
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).primaryText,
                                                fontSize: 16,
                                              ),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                        return;
                                      }

                                      final requestBody = {
                                        'name': _model.nameTextController.text,
                                        'email': _model.emailTextController.text,
                                        'mobilenumber': _model.phoneTextController.text,
                                        'subject': _model.subjectTextController.text,
                                        'query': _model.queryTextController.text,
                                        'phoneCode': _model.dropDownValueValue,
                                      };

                                      print('Contact Us request body: ${requestBody}');

                                      // Print detailed information about the API request
                                      print('API Request Details:');
                                      print('Sanity URL: ${FFAppConstants.sanityurl}');
                                      print('Name: ${_model.nameTextController.text}');
                                      print('Email: ${_model.emailTextController.text}');
                                      print('Mobile Number: ${_model.phoneTextController.text}');
                                      print('Subject: ${_model.subjectTextController.text}');
                                      print('Query: ${_model.queryTextController.text}');
                                      print('Phone Code: ${_model.dropDownValueValue}');

                                      var _shouldSetState = false;
                                      _model.apiResulteem =
                                      await ContactUsCall.call(
                                        sanityurl: FFAppConstants.sanityurl,
                                        name: _model.nameTextController.text,
                                        email: _model.emailTextController.text,
                                        mobilenumber: _model.phoneTextController.text,
                                        subject: _model.subjectTextController.text,
                                        query: _model.queryTextController.text,
                                        phoneCode: _model.dropDownValueValue,
                                      );

                                      print('API Call Result:');
                                      if (_model.apiResulteem == null) {
                                        print('API response is null');
                                      } else {
                                        print('Raw Response: ${_model.apiResulteem?.jsonBody}');
                                        print('Response Data: ${_model.apiResulteem?.response}');
                                        print('Response Headers: ${_model.apiResulteem?.headers}');
                                        print('Status Code: ${_model.apiResulteem?.statusCode}');
                                      }

                                      _shouldSetState = true;
                                      if ((_model.apiResulteem?.succeeded ??
                                          true)) {
                                        ScaffoldMessenger.of(context)
                                            .clearSnackBars();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              getJsonField(
                                                (_model.apiResulteem?.jsonBody ?? ''), r'''$.msg''',).toString(),
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                fontSize: 16,
                                              ),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: FlutterFlowTheme.of(context).primary,
                                          ),
                                        );

                                        // Reset all text fields
                                        _model.nameTextController?.clear();
                                        _model.emailTextController?.clear();
                                        _model.phoneTextController?.clear();
                                        _model.subjectTextController?.clear();
                                        _model.queryTextController?.clear();
                                        _model.dropDownValueValue = null;
                                      } else {
                                        ScaffoldMessenger.of(context).clearSnackBars();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Failed to submit the form. Please try again later.',
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).primaryText,
                                                fontSize: 16,
                                              ),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: Colors.red,
                                          )
                                        );
                                        if (_shouldSetState) setState(() {});
                                        return;
                                      }

                                      if (_shouldSetState) setState(() {});
                                    },
                                    text: 'SUBMIT',
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
                                      elevation: 0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),*/
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        // Validate fields
                                        if (_model.emailTextController.text.isEmpty ||
                                            _model.phoneTextController.text.isEmpty ||
                                            _model.nameTextController.text.isEmpty ||
                                            _model.subjectTextController.text.isEmpty ||
                                            _model.queryTextController.text.isEmpty) {
                                          ScaffoldMessenger.of(context).clearSnackBars();
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Please fill in all the fields',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              duration: Duration(milliseconds: 4000),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                          return;
                                        }

                                        if (_model.dropDownValueValue == null) {
                                          ScaffoldMessenger.of(context).clearSnackBars();
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Please select a country code',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              duration: Duration(milliseconds: 4000),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                          return;
                                        }

                                        final requestBody = {
                                          'name': _model.nameTextController.text,
                                          'email': _model.emailTextController.text,
                                          'mobilenumber': _model.phoneTextController.text,
                                          'subject': _model.subjectTextController.text,
                                          'query': _model.queryTextController.text,
                                          'phoneCode': _model.dropDownValueValue,
                                        };

                                        print('Contact Us request body: $requestBody');

                                        // Print detailed information about the API request
                                        print('API Request Details:');
                                        print('Sanity URL: ${FFAppConstants.sanityurl}');
                                        print('Name: ${_model.nameTextController.text}');
                                        print('Email: ${_model.emailTextController.text}');
                                        print('Mobile Number: ${_model.phoneTextController.text}');
                                        print('Subject: ${_model.subjectTextController.text}');
                                        print('Query: ${_model.queryTextController.text}');
                                        print('Phone Code: ${_model.dropDownValueValue}');

                                        var _shouldSetState = false;
                                        try {
                                          _model.apiResulteem = await ContactUsCall.call(
                                            sanityurl: FFAppConstants.sanityurl,
                                            name: _model.nameTextController.text,
                                            email: _model.emailTextController.text,
                                            mobilenumber: _model.phoneTextController.text,
                                            subject: _model.subjectTextController.text,
                                            query: _model.queryTextController.text,
                                            phoneCode: _model.dropDownValueValue,
                                          );

                                          print('API Call Result:');
                                          if (_model.apiResulteem == null) {
                                            print('API response is null');
                                          } else {
                                            print('Raw Response: ${_model.apiResulteem?.jsonBody}');
                                            print('Response Data: ${_model.apiResulteem?.response}');
                                            print('Response Headers: ${_model.apiResulteem?.headers}');
                                            print('Status Code: ${_model.apiResulteem?.statusCode}');
                                          }

                                          _shouldSetState = true;
                                          if ((_model.apiResulteem?.succeeded ?? false)) {
                                            ScaffoldMessenger.of(context).clearSnackBars();
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  getJsonField((_model.apiResulteem?.jsonBody ?? ''), r'''$.msg''').toString(),
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                duration: Duration(milliseconds: 4000),
                                                backgroundColor: FlutterFlowTheme.of(context).primary,
                                              ),
                                            );

                                            // Reset all text fields
                                            _model.nameTextController?.clear();
                                            _model.emailTextController?.clear();
                                            _model.phoneTextController?.clear();
                                            _model.subjectTextController?.clear();
                                            _model.queryTextController?.clear();
                                            _model.dropDownValueValue = null;
                                          } else {
                                            ScaffoldMessenger.of(context).clearSnackBars();
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Failed to submit the form. Please try again later.',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                duration: Duration(milliseconds: 4000),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          print('API Call Error: $e');
                                          ScaffoldMessenger.of(context).clearSnackBars();
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Network error. Please check your connection and try again.',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              duration: Duration(milliseconds: 4000),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }

                                        if (_shouldSetState) setState(() {});
                                      },
                                      text: 'SUBMIT',
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

                              ]
                          ),
                        ),
                        /*   Container(
                            width: 400,
                          height: 400,
                          child: Html(
                            data:  '<html><body><iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3770.631564639431!2d72.89606000000003!3d19.079929999999997!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3be7ce7623f39289%3A0x58b37e853f989643!2sRudra%20Centre%20(Rudraksha%20Ratna)!5e0!3m2!1sen!2sus!4v1722578622642!5m2!1sen!2sus" width="400" height="300" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe></body></html>'
                          ),
                        ),*/
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            width: 400,
                            height: 350,
                            child: GoogleMap(
                                mapType: MapType.hybrid,
                                onMapCreated: _onMapCreated,
                                initialCameraPosition: CameraPosition(
                                  target: _companyLocation,
                                  zoom: 14.0,

                                ),

                                markers: {
                                  Marker(
                                    markerId: MarkerId('companyLocation'),
                                    position: _companyLocation,

                                    infoWindow: InfoWindow(
                                      title: 'Rudraksha Ratna',
                                      snippet: 'We are here!',




                                    ),
                                  ),

                                  // Generated code for this Container Widget...
                                  /*     Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Container(
                                      width: double.infinity,
                                      height: 300,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                      ),
                                      child: FlutterFlowGoogleMap(
                                        controller: _GoogleMapmodel.googleMapsController,
                                        onCameraIdle: (latLng) => _GoogleMapmodel.googleMapsCenter = latLng,
                                        initialLocation: _GoogleMapmodel.googleMapsCenter,
                                     //  markerColor: GoogleMarkerColor.violet,
                                       // mapType: MapType.normal,
                                       //mapStyle: GoogleMapStyle.standard,
                                        initialZoom: 14,
                                        allowInteraction: true,
                                        allowZoom: true,
                                        showZoomControls: true,
                                        showLocation: true,
                                        showCompass: false,
                                        showMapToolbar: false,
                                        showTraffic: false,
                                        centerMapOnMarkerTap: true,
                                      ),
                                    ),
                                  )*/
                                }
                            ),
                          ),
                        )
                      ],
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
