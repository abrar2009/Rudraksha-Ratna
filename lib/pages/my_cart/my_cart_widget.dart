import 'package:flutter_svg/svg.dart';

import '../../flutter_flow/custom_functions.dart';
import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'my_cart_model.dart';
export 'my_cart_model.dart';

class MyCartWidget extends StatefulWidget {
  const MyCartWidget({
    super.key,
  });

  @override
  State<MyCartWidget> createState() => _MyCartWidgetState();
}

class _MyCartWidgetState extends State<MyCartWidget> {
  late MyCartModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyCartModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<ApiCallResponse>(
      future: CartCall.call(
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
        final containerCartResponse = snapshot.data!;

        final cartData = getJsonField(containerCartResponse.jsonBody, r'''$.data''');

        // Check if cartData is a List
        final cartList = cartData is List ? cartData : [];

        if (cartList.isEmpty) {
          // Display image when cart is empty
          Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
          );
          Navigator.pop(context);
        }

        return Container(
          width: double.infinity,
          height: 407,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color:
                          FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                      ),
                      Text(
                        'My cart',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 20,
                            borderWidth: 1,
                            buttonSize: 40,
                            icon: Icon(
                              Icons.close_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24,
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 5,
                thickness: 2,
                color: Color(0xFFE7E7E8),
              ),
              Container(
                height: 250,
                decoration: BoxDecoration(),
                child: Builder(
                  builder: (context) {
                    // Ensure that the data is a list before using it
                    final bottomCartList = (getJsonField(
                      containerCartResponse.jsonBody,
                      r'''$.data''',
                    ));

                    // Check if bottomCartList is a List or a Map
                    final cartItems = bottomCartList is List
                        ? bottomCartList
                        : bottomCartList is Map
                        ? [bottomCartList] // If it's a map, convert it to a list with a single item
                        : [];

                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(cartItems.length, (index) {
                          final bottomCartListItem = cartItems[index];
                          return Container(
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      getJsonField(
                                        bottomCartListItem,
                                        r'''$.thumbnail_image''',
                                      ).toString(),
                                      width: 70,
                                      height: 68,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        //width: 186,
                                        width: MediaQuery.of(context).size.width * 0.55,
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          getJsonField(
                                            bottomCartListItem,
                                            r'''$.product_name''',
                                          ).toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            fontSize: 15,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      RichText(
                                        textScaler: MediaQuery.of(context).textScaler,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(
                                                getJsonField(bottomCartListItem, r'''$.selling_price''',
                                                ).toString(),
                                                FFAppState().currencyRate,
                                              )}',
                                              style: TextStyle(),
                                            )
                                          ],
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            fontSize: 15,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      RichText(
                                        textScaler: MediaQuery.of(context).textScaler,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Qty: ',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text: getJsonField(
                                                bottomCartListItem,
                                                r'''$.quantity''',
                                              ).toString(),
                                              style: TextStyle(),
                                            )
                                          ],
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 4)),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      var _shouldSetState = false;
                                      _model.apiResult5ep = await RemovefromCartlistCall.call(
                                        token: currentAuthenticationToken,
                                        hosturl: FFAppConstants.hosturl,
                                        cartId: getJsonField(bottomCartListItem, r'''$.cart_id''',),
                                      );
                                      _shouldSetState = true;
                                      if ((_model.apiResult5ep?.succeeded ?? true)) {
                                        FFAppState().statusFailed = getJsonField(bottomCartListItem, r'''$.status''',).toString();
                                        setState(() {});
                                        ScaffoldMessenger.of(context).clearSnackBars();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content:
                                          Text(getJsonField((_model.apiResult5ep?.jsonBody ?? ''), r'''$.msg''',).toString(),
                                            style: TextStyle(
                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: FFAppState().statusFailed == 'success' ? Color(0xFF4BB543) : Color(0xFFFC100D),
                                          ),
                                        );
                                        if (FFAppState().statusFailed == 'success') {
                                          context.pushNamed(
                                            'Cart',
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey: TransitionInfo(
                                                hasTransition: true,
                                                transitionType: PageTransitionType.fade,
                                                duration: Duration(milliseconds: 0),
                                              ),
                                            },
                                          );
                                        } else {
                                          if (_shouldSetState) setState(() {});
                                          return;
                                        }
                                      } else {
                                        if (_shouldSetState) setState(() {});
                                        return;
                                      }

                                      if (_shouldSetState)
                                        setState(() {});
                                    },
                                    child: SvgPicture.asset(
                                      'assets/images/bin_1.svg',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ].divide(SizedBox(width: 13)),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),
              ),
              Divider(
                height: 5,
                thickness: 2,
                color: Color(0xFFE7E7E8),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 0, 16, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cart Total',
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF696969),
                            fontSize: 12,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RichText(
                          textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(
                                  getJsonField(containerCartResponse.jsonBody, r'''$.cart_total''')?.toString() ?? '0',
                                  FFAppState().currencyRate,
                                )}',
                                style: TextStyle(),
                              )
                            ],
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Montserrat',
                              fontSize: 15,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    FFButtonWidget(
                      onPressed: () async {
                        context.pushNamed(
                          'Cart',
                          extra: <String, dynamic>{
                            kTransitionInfoKey: TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.bottomToTop,
                              duration: Duration(milliseconds: 400),
                            ),
                          },
                        );
                        Navigator.pop(context);
                      },
                      text: 'View Cart',
                      options: FFButtonOptions(
                        width: 180,
                        height: 48,
                        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: Color(0xFF740074),
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
