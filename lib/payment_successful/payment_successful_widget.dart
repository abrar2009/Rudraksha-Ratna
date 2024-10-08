import 'package:rudraksha_cart/index.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'payment_successful_model.dart';
export 'payment_successful_model.dart';

class PaymentSuccessfulWidget extends StatefulWidget {
  const PaymentSuccessfulWidget({super.key});

  @override
  State<PaymentSuccessfulWidget> createState() =>
      _PaymentSuccessfulWidgetState();
}

class _PaymentSuccessfulWidgetState extends State<PaymentSuccessfulWidget> {
  late PaymentSuccessfulModel _model;

  final successfulscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentSuccessfulModel());
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
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: successfulscaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 44, 0, 41),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ' ',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                        ),
                      ),
                      Text(
                        'Payment',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 16,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          FFAppState().couponCode = '';
                          FFAppState().selectedGiftName = '';
                          FFAppState().billingAddress1 = '';
                          FFAppState().billingAddress2 = '';
                          FFAppState().billingCity = '';
                          FFAppState().billingState = '';
                          FFAppState().billingPincode = '';
                          context.pushNamed('Homepage');
                        },
                        child: Icon(
                          Icons.close_sharp,
                          color: Color(0xFF3E3E40),
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/Group_1886.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      'Payment Successful!',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        color: FlutterFlowTheme.of(context).primary,
                        fontSize: 20,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Your Order has been placed.',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 16,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      // Navigate to PaymentSuccessfulWidget
                      FFAppState().couponCode = '';
                      FFAppState().selectedGiftName = '';
                      FFAppState().billingAddress1 = '';
                      FFAppState().billingAddress2 = '';
                      FFAppState().billingCity = '';
                      FFAppState().billingState = '';
                      FFAppState().billingPincode = '';

                      // Clear all previous routes and navigate to HomepageWidget
                      context.goNamed(
                        'Homepage',
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );
                      /*Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomepageWidget(),
                        ),
                      );*/
                    },
                    text: 'Continue Shopping',
                    options: FFButtonOptions(
                      width: double.infinity,
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
                      ),
                      borderRadius: BorderRadius.circular(12),
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
