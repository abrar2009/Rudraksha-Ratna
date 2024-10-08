import 'package:rudraksha_cart/auth/custom_auth/auth_util.dart';
import 'package:rudraksha_cart/backend/api_requests/api_calls.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'AddReviewPopUp_Model.dart';



class AddReviewPopUpWidget extends StatefulWidget {
  const AddReviewPopUpWidget({
    super.key,
    required this.mainproducttype,
    required this.productid,
  });

  final String? mainproducttype;
  final String? productid;

  @override
  State<AddReviewPopUpWidget> createState() => _AddReviewPopUpWidgetState();
}

class _AddReviewPopUpWidgetState extends State<AddReviewPopUpWidget> {
  late AddReviewPopUpModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddReviewPopUpModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 347,
          //height: 316,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Text(
                            'Add a Review',
                            style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 35,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 16, 10, 0),
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
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              RatingBar.builder(
                                onRatingUpdate: (newValue) => setState(
                                        () => _model.ratingBarValue = newValue),
                                itemBuilder: (context, index) => FaIcon(
                                  FontAwesomeIcons.solidStar,
                                  color: Color(0xFFF59E0B),
                                ),
                                direction: Axis.horizontal,
                                initialRating: _model.ratingBarValue ??= 0,
                                unratedColor:
                                FlutterFlowTheme.of(context).accent3,
                                itemCount: 5,
                                itemSize: 20,
                                glowColor: Color(0xFFF59E0B),
                              ),
                            ].divide(SizedBox(width: 10)),
                          ),
                        ),
                      ),
                      Container(
                        height: 35,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Your Review',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF868687),
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        child: Text(
                          'Enter Your Review',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF272728),
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                          child: TextFormField(
                            controller: _model.textController,
                            focusNode: _model.textFieldFocusNode,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                fontFamily: 'Montserrat',
                                letterSpacing: 0,
                              ),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                fontFamily: 'Montserrat',
                                color:
                                FlutterFlowTheme.of(context).primaryBackground,
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
                                  color: FlutterFlowTheme.of(context).primary,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(0),
                              ),
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
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          text: 'Cancel',
                          options: FFButtonOptions(
                            height: 48,
                            padding: EdgeInsetsDirectional.fromSTEB(47, 0, 47, 0),
                            iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color: Colors.white,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).primary,
                              letterSpacing: 0,
                            ),
                            elevation: 0,
                            borderSide: BorderSide(
                              color: Color(0xFFE7E7E8),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
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
                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor: FlutterFlowTheme.of(context).primary,
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
                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor: FlutterFlowTheme.of(context).primary,
                              ),
                            );
                          }

                          setState(() {});
                          Navigator.pop(context);
                        },
                        text: 'Submit',
                        options: FFButtonOptions(
                          height: 48,
                          padding: EdgeInsetsDirectional.fromSTEB(47, 0, 47, 0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
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
                    ].divide(SizedBox(width: 10)),
                  ),
                ),
              ].divide(SizedBox(height: 25)),
            ),
          ),
        ),
      ],
    );
  }
}
