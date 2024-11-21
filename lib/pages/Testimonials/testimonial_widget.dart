import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:rudraksha_cart/components/shimmer_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import 'testimonials_model.dart';
export 'testimonials_model.dart';

class TestimonialsWidget extends StatefulWidget {
  const TestimonialsWidget({
    super.key,
    this.reviewlist,
    this.producttype,
  });

  final List<dynamic>? reviewlist;
  final String? producttype;

  @override
  State<TestimonialsWidget> createState() => _TestimonialsWidgetState();
}

class _TestimonialsWidgetState extends State<TestimonialsWidget> {
  late TestimonialsModel _model;

  final TestimonialsWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TestimonialsModel());
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
        key: TestimonialsWidgetscaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
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
                'Testimonials',
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
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          _model.selectedtype = true;
                          setState(() {});
                        },
                        text: 'Text',
                        options: FFButtonOptions(
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: _model.selectedtype == true
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).primaryBackground,
                          textStyle: _model.selectedtype == true
                            ? FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).primaryBackground,
                            letterSpacing: 0,
                          ) : FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).primary,
                            letterSpacing: 0,
                          ),
                          elevation: 0,
                          borderSide: BorderSide(
                            color: _model.selectedtype == true
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).primary,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          _model.selectedtype = false;
                          setState(() {});
                        },
                        text: 'Videos',
                        options: FFButtonOptions(
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: _model.selectedtype == false
                              ? FlutterFlowTheme.of(context).primary
                              : FlutterFlowTheme.of(context).primaryBackground,
                          textStyle: _model.selectedtype == false
                              ? FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).primaryBackground,
                            letterSpacing: 0,
                          ) : FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).primary,
                            letterSpacing: 0,
                          ),
                          elevation: 0,
                          borderSide: BorderSide(
                            color: _model.selectedtype == false
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context).primary,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ].divide(SizedBox(width: 6)),
                  ),
                  Builder(
                    builder: (context) {
                      if (_model.selectedtype) {
                        return Padding(
                          padding: EdgeInsets.all(11),
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
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              final columnExploreCategoryListResponse = snapshot.data!;
              
                              return Builder(
                                builder: (context) {
                                  final testimonialsdata = getJsonField(
                                    columnExploreCategoryListResponse.jsonBody,
                                    r'''$.data''',
                                  ).toList()
                                   .where((item) => getJsonField(item, r'''$.testimonial_type''') == 1)
                                   .toList();
              
                                  return SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children:
                                      List.generate(testimonialsdata.length,
                                              (testimonialsdataIndex) {
                                            final testimonialsdataItem = testimonialsdata[testimonialsdataIndex];

                                            final decodedDescription = utf8.decode(
                                                getJsonField(testimonialsdataItem,
                                                  r'''$.testimonial_text''',).toString().codeUnits
                                            );

                                            return Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                                              child: Material(
                                                color: Colors.transparent,
                                                elevation: 5,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                ),
                                                child: Container(
                                                  width: 343,
                                                  //height: 240,
                                                  decoration: BoxDecoration(
                                                    color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                    BorderRadius.circular(12),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                          MainAxisSize.max,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(0),
                                                              child: Image.asset(
                                                                'assets/images/image_442.png',
                                                                width: 26,
                                                                height: 19,
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          getJsonField(
                                                            testimonialsdataItem,
                                                            r'''$.name''',
                                                          ).toString(),
                                                          style: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Montserrat',
                                                            fontSize: 16,
                                                            letterSpacing: 0,
                                                            fontWeight:
                                                            FontWeight.w600,
                                                          ),
                                                        ),
                                                        HtmlWidget(decodedDescription)
                                                        
                                                        // Html(
                                                        //   data: decodedDescription,
                                                        //   style: {
                                                        //     "html": Style(
                                                        //       //fontFamily: GoogleFonts.notoSansDevanagari().fontFamily,
                                                        //       fontFamily: 'Montserrat',
                                                        //       color: FlutterFlowTheme.of(context).secondaryText,
                                                        //       letterSpacing: 0,
                                                        //       //fontSize: FontSize(18.0),
                                                        //       textAlign: TextAlign.justify,

                                                        //     ),
                                                        //   },
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).divide(SizedBox(height: 10)),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      } else {
                        return Padding(
                            padding: EdgeInsets.all(11),
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
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                final columnExploreCategoryListResponse = snapshot.data!;
                                return Builder(
                                  builder: (context) {
                                    final testimonialsdata = getJsonField(
                                      columnExploreCategoryListResponse.jsonBody,
                                      r'''$.data''',
                                    ).toList()
                                      .where((item) => getJsonField(item, r'''$.testimonial_type''') == 2)
                                      .toList();

                                    return SingleChildScrollView(
                                      primary: false,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: List.generate(testimonialsdata.length, (testimonialsdataIndex) {
                                          final testimonialsdataItem = testimonialsdata[testimonialsdataIndex];

                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await launchURL(
                                                getJsonField(
                                                  testimonialsdataItem,
                                                  r'''$.testimonial_video''',
                                                ).toString()
                                              );
                                            },
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),
                                                    child:
                                                    CachedNetworkImage(
                                                      fadeInDuration: Duration(milliseconds: 100),
                                                      fadeOutDuration: Duration(milliseconds: 100),
                                                      imageUrl: utf8.decode(
                                                        getJsonField(
                                                          testimonialsdataItem,
                                                          r'''$.thumbnail_images''',
                                                        ).toString().codeUnits,
                                                        allowMalformed: true,
                                                      ),
                                                      fit: BoxFit.contain,
                                                      placeholder: (context, url) => const ShimmerWidget(),
                                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 0,
                                                  right: 0,
                                                  top: 0,
                                                  bottom: 0,
                                                  child: Center(
                                                    child: CachedNetworkImage(
                                                      fadeInDuration: Duration(milliseconds: 500),
                                                      fadeOutDuration: Duration(milliseconds: 500),
                                                      imageUrl: '${FFAppConstants.commonImageUrl}/youtube_icon.png',
                                                      width: 64,
                                                      height: 64,
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                                  ),
                                                ),
                                                /*Align(
                                                  alignment: AlignmentDirectional(0, 0),
                                                  child: Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                    child: CachedNetworkImage(
                                                      fadeInDuration: Duration(milliseconds: 500),
                                                      fadeOutDuration: Duration(milliseconds: 500),
                                                      imageUrl: '${FFAppConstants.commonImageUrl}/youtube_icon.png',
                                                      width: 64,
                                                      height: 64,
                                                      fit: BoxFit.scaleDown,
                                                      alignment: Alignment(0, 0),
                                                    ),
                                                  ),
                                                ),*/
                                              ],
                                            ),
                                          );
                                        }).divide(SizedBox(height: 10)),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          );

                      }
                    },
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
