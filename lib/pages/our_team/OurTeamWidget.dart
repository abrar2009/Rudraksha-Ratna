import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'OurTeamModel.dart';


class OurTeamWidget extends StatefulWidget {
  const OurTeamWidget({super.key});

  @override
  State<OurTeamWidget> createState() => _OurTeamWidgetState();
}

class _OurTeamWidgetState extends State<OurTeamWidget> {
  late OurTeamModel _model;

  final OurTeamWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OurTeamModel());
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
        key: OurTeamWidgetscaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(0, 4),
                  blurRadius: 6,
                  spreadRadius: 1,
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
                'Our Team',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Color(0xFF272728),
                  fontSize: 16,
                  letterSpacing: 0,
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
          child: Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textScaler: MediaQuery.of(context).textScaler,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Terms at Rudra Centre work in unison 10 provide the customer service experiences possible. Teams such as Client Coordination, Artisan. Packaging and Handling, Artisans. Dispatch. Web Designing and Development, SEO and Content Creation. Accounts and Support Starr ate cornrviLted 10 giving a class apart service to Line existing clientele and the prospect customers.',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            letterSpacing: 0,
                            lineHeight: 1.5,
                          ),
                        )
                      ],
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        letterSpacing: 0,
                        lineHeight: 1.5,
                      ),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    'About Rudra Centre Team',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      fadeInDuration: Duration(milliseconds: 500),
                      fadeOutDuration: Duration(milliseconds: 500),
                      imageUrl:
                      '${FFAppConstants.ourTeam}/team.jpg',
                      width: double.infinity,
                      height: 228,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    'Rudra Centre is a company that takes pride in having a well-coordinated and dedicated team of professionals. \n\n Each team works together seamlessly to ensure exceptional customer service experiences. \n\n The company has several teams, each specializing in different aspects of their operations. \n\n These teams work together to maintain the company\'s commitment to providing top-notch services to both their existing clients and potential customers. ',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                      letterSpacing: 0,
                      lineHeight: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Client Coordination Team',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/client-coordinator-1.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/client-coordinator-2.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/client-coordinator-3.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10)),
                      ),
                      Text(
                        'Our client coordinators handle all client queries, recommend the right products, and ensure all orders are processed, executed, and dispatched in time.',
                        textAlign: TextAlign.justify,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                          lineHeight: 1.5,
                        ),
                      ),
                    ].divide(SizedBox(height: 10)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Artisan Team',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/artisan-1.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/artisan-2.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/artisan-3.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10)),
                      ),
                      Text(
                        'Our team of artisans are skilled in various crafting techniques and create new, innovative product designs using Rudraksha beads, gemstones, and other materials.',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                          lineHeight: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ].divide(SizedBox(height: 10)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sorting Team',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/sorting-team-1.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/sorting-team-2.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/sorting-team-3.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/sorting-team-4.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10)),
                      ),
                      Text(
                        'This team is dedicated to choosing only the highest quality Rudraksha and Cemstones that perfectly match the unique needs of our valued customers.',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                          lineHeight: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ].divide(SizedBox(height: 10)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Inventory Team',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/inventory-team-1.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10)),
                      ),
                      Text(
                        'This team is responsible for inventory management, stock maintenance, and procurement from vendors. Their duties encompass tracking and organizing stocks while ensuring a steady supply of products to meet the organization\'s needs.',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                          lineHeight: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ].divide(SizedBox(height: 10)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Packaging Team',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/packing-team-1.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/packing-team-2.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/packing-team-3.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/packing-team-4.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/packing-team-5.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/packing-team-6.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10)),
                      ),
                      Text(
                        'The Packaging Team ensures all products are expertly packed for safe and secure delivery, prioritizing ergonomic packaging.',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                          lineHeight: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ].divide(SizedBox(height: 10)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dispatch Team',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/logistics.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10)),
                      ),
                      Text(
                        'This team manages the logistics of sending out orders to customers. They ensure timely delivery and track shipments to guarantee that products reach clients in perfect condition.',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                          lineHeight: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ].divide(SizedBox(height: 10)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Web Developers',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/web-developer-1.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/web-developer-2.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10)),
                      ),
                      Text(
                        'The Web developers handle the programming of the website modules and features while also ensuring the continuous upkeep and maintenance of the website.',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                          lineHeight: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ].divide(SizedBox(height: 10)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Web Designing Team',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/web-designing-team-1.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/web-designing-team-2.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/web-designing-team-3.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/web-designing-team-4.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/web-designing-team-5.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/web-designing-team-6.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10)),
                      ),
                      Text(
                        'This team is responsible for creating and maintaining the company\'s online presence, making it easier for customers to explore and purchase products.',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                          lineHeight: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ].divide(SizedBox(height: 10)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Content Writers',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/content-writers-1.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10)),
                      ),
                      Text(
                        'The Content Team is tasked with maintaining flawless website content, and creating unique and informative articles. Their work contributes to engaging and informing the audience while enhancing the website\'s quality and appeal.',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                          lineHeight: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ].divide(SizedBox(height: 10)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Video Editing and Graphic Designing Team',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/video-editing-team-1.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/video-editing-team-2.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/video-editing-team-3.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10)),
                      ),
                      Text(
                        'This team specializes in making captivating videos, which include product showcases and creative promotional and educational content- Their artistic skills enhance the visual appeal of the brand, contributing to effective marketing.',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                          lineHeight: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ].divide(SizedBox(height: 10)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Search Engine Optimizer',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/seo-1.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10)),
                      ),
                      Text(
                        'This team focuses on optimizing Rudra Centre\'s online visibility. They work on improving the website\'s search engine ranking and creating valuable content to educate and engage customers.',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                          lineHeight: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ].divide(SizedBox(height: 10)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Accounts Team',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/accountants-1.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/accountants-2.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/accountants-3.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10)),
                      ),
                      Text(
                        'The Accounts Team meticulously maintains the organization\'s financial records and ensures strict legal compliance, contributing to the flawless financial management of the company',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                          lineHeight: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ].divide(SizedBox(height: 10)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Support Staff',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/support-staff-1.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/support-staff-2.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/support-staff-3.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/support-staff-4.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10)),
                      ),
                      Text(
                        'The Support Team plays a crucial role in ensuring the seamless functioning of the organization by providing essential support. ',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                          lineHeight: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ].divide(SizedBox(height: 10)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'System Administrator',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 500),
                                fadeOutDuration: Duration(milliseconds: 500),
                                imageUrl:
                                '${FFAppConstants.ourTeam}/system-administrator.jpg',
                                width: 129,
                                height: 108,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10)),
                      ),
                      Text(
                        'The HR Admin plays a vital role in ensuring the efficient administration of the organization by overseeing various aspects of human resource management. ',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                          lineHeight: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3CCE3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'The success of Rudra Centre can be attributed to the collective efforts of these dedicated teams, who work together cohesively. The mention of the company\'s workforce comprising 90 members emphasizes the depth of expertise and resources available to serve the clientele.',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ].divide(SizedBox(height: 10)),
                  ),
                ].divide(SizedBox(height: 16)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
