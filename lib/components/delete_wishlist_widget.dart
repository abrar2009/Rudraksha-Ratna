import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'delete_wishlist_model.dart';
export 'delete_wishlist_model.dart';

class DeleteWishlistWidget extends StatefulWidget {
  const DeleteWishlistWidget({super.key});

  @override
  State<DeleteWishlistWidget> createState() => _DeleteWishlistWidgetState();
}

class _DeleteWishlistWidgetState extends State<DeleteWishlistWidget> {
  late DeleteWishlistModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeleteWishlistModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<ApiCallResponse>(
            future: WishListCall.call(
              hosturl: FFAppConstants.hosturl,
              token: currentAuthenticationToken,
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
              final containerWishListResponse = snapshot.data!;

              return Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Are you sure you want to remove the product from the wishlist?',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 16,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {
                              context.safePop();
                            },
                            text: 'Cancel',
                            options: FFButtonOptions(
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              height: 40,
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF3E3E40),
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,
                              ),
                              elevation: 0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              _model.apiResult8b9 =
                              await RemovefromWishlistCall.call(
                                hosturl: FFAppConstants.hosturl,
                                token: currentAuthenticationToken,
                                productId: FFAppState().wishlistItemId,
                                productType: FFAppState().wishlistProductType,
                              );

                              if ((_model.apiResult8b9?.succeeded ?? true)) {
                                FFAppState().statusFailed = getJsonField(
                                  (_model.apiResult8b9?.jsonBody ?? ''),
                                  r'''$.status''',
                                ).toString();
                                setState(() {});
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      getJsonField(
                                        (_model.apiResult8b9?.jsonBody ?? ''),
                                        r'''$.msg''',
                                      ).toString(),
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                    FFAppState().statusFailed == 'success'
                                        ? Color(0xFF4BB543)
                                        : Color(0x00000000),
                                  ),
                                );
                                if (FFAppState().statusFailed == 'success') {
                                  Navigator.pop(context);
                                }
                              }

                              setState(() {});
                            },
                            text: 'Delete',
                            options: FFButtonOptions(
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              height: 40,
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: 0,
                              ),
                              elevation: 0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
