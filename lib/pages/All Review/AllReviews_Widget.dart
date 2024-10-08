import '../../flutter_flow/flutter_flow_icon_button.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/ratingreview_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'AllReviews_model.dart';



class AllReviewWidget extends StatefulWidget {
  const AllReviewWidget({
    super.key,
    this.producttype,
    this.productSlugValue,
  });

  final String? producttype;
  final String? productSlugValue;

  @override
  State<AllReviewWidget> createState() => _AllReviewWidgetState();
}

class _AllReviewWidgetState extends State<AllReviewWidget> {
  late AllReviewModel _model;

  final AllReviewWidgetscaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> reviewdata = [];
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllReviewModel());
  }
  String formatDate(String dateTimeString) {
    final DateTime dateTime = DateTime.parse(dateTimeString);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
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
        key: AllReviewWidgetscaffoldKey,
        appBar: // Generated code for this AppBar Widget...
        AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading:   FlutterFlowIconButton(
            borderRadius: 20,
            borderWidth: 1,
            buttonSize: 40,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF272728),
              size: 30,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            'All Reviews',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Outfit',
              color: FlutterFlowTheme.of(context).primaryText,
              fontSize: 22,
              letterSpacing: 0,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0,
        )
        ,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 0),
            child: FutureBuilder<ApiCallResponse>(
              future: OtherProductsDetailsCall.call(
                sanityurl: FFAppConstants.sanityurl,
                productslugvalue: widget.productSlugValue,
                producttype: widget.producttype,
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
                final columnOtherProductsDetailsResponse = snapshot.data!;

                return Builder(
                  builder: (context) {
                    if(widget.producttype==FFAppConstants.OtherMasterProductDetailsApi)
                      {   reviewdata = OtherProductsDetailsCall.reviewdata(
                        columnOtherProductsDetailsResponse.jsonBody,
                      )?.toList() ??
                          [];}
                    else if(widget.producttype==FFAppConstants.YantraMasterProductDetailsApi)
                    {   reviewdata = OtherProductsDetailsCall.reviewdata(
                      columnOtherProductsDetailsResponse.jsonBody,
                    )?.toList() ??
                        [];}
                    else
                      {
                        reviewdata = OtherProductsDetailsCall.reviewData(
                          columnOtherProductsDetailsResponse.jsonBody,
                        )?.toList() ??
                            [];

                      }

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children:
                      List.generate(reviewdata.length, (reviewdataIndex) {
                        final reviewdataItem = reviewdata[reviewdataIndex];
                        return Container(
                          width: double.infinity,

                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            border: Border.all(
                              color: Color(0xFFE7E7E8),
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(11),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RatingreviewWidget(
                                  key: Key(
                                      'Key59z_${reviewdataIndex}_of_${reviewdata.length}'),
                                  parameter1: getJsonField(
                                    reviewdataItem,
                                    r'''$.star_rating''',
                                  ),
                                ),
                            /*    Text(
                                  'Truly impressed!',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),*/
                                Text(
                                  getJsonField(
                                    reviewdataItem,
                                    r'''$.comment''',
                                  ).toString(),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    letterSpacing: 0,
                                  ),
                                ),
                                RichText(
                                  textScaler: MediaQuery.of(context).textScaler,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: getJsonField(
                                          reviewdataItem,
                                          r'''$.customer_name''',
                                        ).toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF696969),
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' , ',
                                        style: TextStyle(),
                                      ),
                                      TextSpan(
                                        text:
                                        formatDate(getJsonField(
                                          reviewdataItem,
                                          r'''$.createdAt''',
                                        ).toString()),
                                        style: TextStyle(),
                                      )
                                    ],
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF696969),
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(height: 10)),
                            ),
                          ),
                        );
                      }).divide(SizedBox(height: 16)),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
