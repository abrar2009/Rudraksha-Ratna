/*
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'free_gift_component_model.dart';
export 'free_gift_component_model.dart';

class FreeGiftComponentWidget extends StatefulWidget {
  const FreeGiftComponentWidget({super.key});

  @override
  State<FreeGiftComponentWidget> createState() =>
      _FreeGiftComponentWidgetState();
}

class _FreeGiftComponentWidgetState extends State<FreeGiftComponentWidget> {
  late FreeGiftComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FreeGiftComponentModel());
    _model.coupenCode = FFAppState().couponCode; // Retrieve stored coupon code on init
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.7,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              context.safePop();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/hint.png',
                width: 72,
                height: 24,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.673,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                      child: Text(
                        'Select Coupon',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF272728),
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                        child: FutureBuilder<ApiCallResponse>(
                          future: FetchShippingCall.call(
                            hosturl: FFAppConstants.hosturl,
                            shippingCountry: FFAppState().countryName,
                            shippingWeight: FFAppState().courierTotal,
                            totalPrice: FFAppState().cartTotal,
                            orderTotal: FFAppState().orderTotal,
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
                            final columnFetchShippingResponse = snapshot.data!;

                            return Builder(
                              builder: (context) {
                                final couponList = getJsonField(
                                  columnFetchShippingResponse.jsonBody,
                                  r'''$.coupondata''',
                                ).toList();

                                return SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(couponList.length,
                                            (couponListIndex) {
                                          final couponListItem =
                                          couponList[couponListIndex];
                                          final couponCode = getJsonField(
                                            couponListItem,
                                            r'''$.coupon_code''',
                                          ).toString();

                                          // Extract coupon value
                                          final couponValue = getJsonField(
                                            couponListItem,
                                            r'''$.coupon_value''',
                                          );

                                          // Check if the coupon code matches the stored coupon code
                                          final isSelected = couponCode == _model.coupenCode;

                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              if (_model.coupenDataIndex == couponListIndex) {
                                                // Deselect the coupon
                                                _model.coupenDataIndex = null;
                                                _model.selectedCouponId = null;
                                                _model.coupenCode = null;
                                                FFAppState().couponCode = '';
                                                FFAppState().couponValue;
                                              } else {
                                                // Select the coupon
                                                _model.coupenDataIndex = couponListIndex;
                                                _model.selectedCouponId = FetchShippingCall.couponsIds(
                                                  columnFetchShippingResponse.jsonBody,
                                                )?[_model.coupenDataIndex!];
                                                _model.coupenCode = couponCode;
                                                _model.coupenValue = couponValue;
                                              }
                                              setState(() {});
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: isSelected
                                                      ? Color(0xFF740074)
                                                      : Color(0x00454545),
                                                ),
                                              ),
                                              child: Container(
                                                width: double.infinity,
                                                height: 100,
                                                child: custom_widgets.FreeGiftContainerdiscountpriceCopy(
                                                  width: double.infinity,
                                                  height: 100,
                                                  discountPercent: getJsonField(
                                                    couponListItem,
                                                    r'''$.coupon_value''',
                                                  ).toString(),
                                                  code: couponCode,
                                                  discountType: getJsonField(
                                                    couponListItem,
                                                    r'''$.discout_type''',
                                                  ).toString(),
                                                  description: getJsonField(
                                                    couponListItem,
                                                    r'''$.description''',
                                                  ).toString(),
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
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 26),
                  child: FFButtonWidget(
                    onPressed: (_model.coupenDataIndex == null)
                        ? null
                        : () async {
                      FFAppState().couponCode = _model.coupenCode!;
                      FFAppState().couponValue = _model.coupenValue!;
                      setState(() {});
                      context.safePop();
                      print('Coupon Code: ${FFAppState().couponCode}');
                      print('Coupon Value: ${FFAppState().couponValue}');
                    },
                    text: 'Select',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 48,
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: _model.coupenDataIndex == null
                          ? Color(0xFF740074)
                          : Color(0xFF740074),
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                      ),
                      elevation: 0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      disabledColor: Color(0xFFF3F3F3),
                      disabledTextColor: Color(0xFFB7B7B8),
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
*/

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'free_gift_component_model.dart';
export 'free_gift_component_model.dart';

class FreeGiftComponentWidget extends StatefulWidget {
  const FreeGiftComponentWidget({super.key});

  @override
  State<FreeGiftComponentWidget> createState() =>
      _FreeGiftComponentWidgetState();
}

class _FreeGiftComponentWidgetState extends State<FreeGiftComponentWidget> {
  late FreeGiftComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FreeGiftComponentModel());
    _model.coupenCode = FFAppState().couponCode; // Retrieve stored coupon code on init
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.7,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              context.safePop();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/hint.png',
                width: 72,
                height: 24,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.673,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                      child: Text(
                        'Select Coupon',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF272728),
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                        child: FutureBuilder<ApiCallResponse>(
                          future: FetchShippingCall.call(
                            hosturl: FFAppConstants.hosturl,
                            shippingCountry: FFAppState().countryName,
                            shippingWeight: FFAppState().courierTotal,
                            totalPrice: FFAppState().cartTotal,
                            orderTotal: FFAppState().orderTotal,
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
                            final columnFetchShippingResponse = snapshot.data!;

                            return Builder(
                              builder: (context) {
                                final couponList = getJsonField(
                                  columnFetchShippingResponse.jsonBody,
                                  r'''$.coupondata''',
                                ).toList();

                                return SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(couponList.length,
                                            (couponListIndex) {
                                          final couponListItem =
                                          couponList[couponListIndex];
                                          final couponCode = getJsonField(
                                            couponListItem,
                                            r'''$.coupon_code''',
                                          ).toString();

                                          // Extract coupon value
                                          final couponValue = getJsonField(
                                            couponListItem,
                                            r'''$.coupon_value''',
                                          );

                                          // Check if the coupon code matches the stored coupon code
                                          final isSelected = couponCode == _model.coupenCode;

                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              if (_model.coupenDataIndex == couponListIndex) {
                                                // Deselect the coupon
                                                _model.coupenDataIndex = null;
                                                _model.selectedCouponId = null;
                                                _model.coupenCode = null;
                                                _model.coupenValue = null; // Remove coupon value when deselected
                                                FFAppState().couponCode = '';
                                                FFAppState().couponValue = 0.0; // Ensure couponValue is cleared
                                              } else {
                                                // Select the coupon
                                                _model.coupenDataIndex = couponListIndex;
                                                _model.selectedCouponId = FetchShippingCall.couponsIds(
                                                  columnFetchShippingResponse.jsonBody,
                                                )?[_model.coupenDataIndex!];
                                                _model.coupenCode = couponCode;
                                                _model.coupenValue = couponValue;
                                                FFAppState().couponCode = _model.coupenCode!;
                                                FFAppState().couponValue = _model.coupenValue!;
                                              }
                                              setState(() {});
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: isSelected
                                                      ? Color(0xFF740074)
                                                      : Color(0x00454545),
                                                ),
                                              ),
                                              child: Container(
                                                width: double.infinity,
                                                height: 100,
                                                child: custom_widgets.FreeGiftContainerdiscountpriceCopy(
                                                  width: double.infinity,
                                                  height: 100,
                                                  discountPercent: getJsonField(
                                                    couponListItem,
                                                    r'''$.coupon_value''',
                                                  ).toString(),
                                                  code: couponCode,
                                                  discountType: getJsonField(
                                                    couponListItem,
                                                    r'''$.discout_type''',
                                                  ).toString(),
                                                  description: getJsonField(
                                                    couponListItem,
                                                    r'''$.description''',
                                                  ).toString(),
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
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 26),
                  child: FFButtonWidget(
                    onPressed: (_model.coupenDataIndex == null)
                        ? null
                        : () async {
                      FFAppState().couponCode = _model.coupenCode!;
                      FFAppState().couponValue = _model.coupenValue!;
                      setState(() {});
                      context.safePop();
                      print('Coupon Code: ${FFAppState().couponCode}');
                      print('Coupon Value: ${FFAppState().couponValue}');
                    },
                    text: 'Select',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 48,
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: _model.coupenDataIndex == null
                          ? Color(0xFF740074)
                          : Color(0xFF740074),
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                      ),
                      elevation: 0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      disabledColor: Color(0xFFF3F3F3),
                      disabledTextColor: Color(0xFFB7B7B8),
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
