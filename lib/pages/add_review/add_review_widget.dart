import 'package:rudraksha_cart/auth/custom_auth/auth_util.dart';
import 'package:rudraksha_cart/pages/add_review/add_review_model.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



class AddRatingWidget extends StatefulWidget {
  const AddRatingWidget({
    super.key,
    required this.mainproducttype,
    required this.productid,
  });

  final String? mainproducttype;
  final String? productid;

  @override
  State<AddRatingWidget> createState() => _AddRatingWidgetState();
}

class _AddRatingWidgetState extends State<AddRatingWidget> {
  late AddRatingModel _model;

  final AddRatingWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddRatingModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
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
        key: AddRatingWidgetscaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Container(
                        width: double.infinity,
                        height: 30,
                        decoration: BoxDecoration(),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            'Add  a review',
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
                      ),
                    ),
                    Container(
                      height: 35,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Your Rating:',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            RatingBar.builder(
                              onRatingUpdate: (newValue) => setState(
                                      () => _model.ratingBarValue = newValue),
                              itemBuilder: (context, index) => Icon(
                                Icons.star_rounded,
                                color: FlutterFlowTheme.of(context).tertiary,
                              ),
                              direction: Axis.horizontal,
                              initialRating: _model.ratingBarValue ??= 0,
                              unratedColor:
                              FlutterFlowTheme.of(context).accent3,
                              itemCount: 5,
                              itemSize: 25,
                              glowColor: FlutterFlowTheme.of(context).tertiary,
                            ),
                          ].divide(SizedBox(width: 10)),
                        ),
                      ),
                    ),
                    Container(
                      height: 35,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Your Review:',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: TextFormField(
                          controller: _model.textController,
                          focusNode: _model.textFieldFocusNode,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                              fontFamily: 'Montserrat',
                              letterSpacing: 0,
                            ),
                            hintText: 'Enter your Review',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                              fontFamily: 'Montserrat',
                              letterSpacing: 0,
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            letterSpacing: 0,
                          ),
                          maxLines: 5,
                          validator: _model.textControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ),
                  ],
                ),
                FFButtonWidget(
                  onPressed: () async {
                    _model.apiResult2qx = await AddReviewCall.call(
                      hosturl: FFAppConstants.hosturl,
                      main_product_type: widget.mainproducttype,
                      product_id: widget.productid,
                      comment: _model.textController.text,
                      star_rating: _model.ratingBarValue?.toString(),
                      token: currentAuthenticationToken
                    );

                    if ((_model.apiResult2qx?.succeeded ?? true)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            getJsonField(
                              (_model.apiResult2qx?.jsonBody ?? ''),
                              r'''$.msg''',
                            ).toString(),
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                          duration: Duration(milliseconds: 4000),
                          backgroundColor: FlutterFlowTheme.of(context).secondary,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            getJsonField(
                              (_model.apiResult2qx?.jsonBody ?? ''),
                              r'''$.msg''',
                            ).toString(),
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                          duration: Duration(milliseconds: 4000),
                          backgroundColor: FlutterFlowTheme.of(context).secondary,
                        ),
                      );
                    }

                    setState(() {});
                  },
                  text: 'Submit',
                  options: FFButtonOptions(
                    height: 40,
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
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ].divide(SizedBox(height: 25)),
            ),
          ),
        ),
      ),
    );
  }
}
