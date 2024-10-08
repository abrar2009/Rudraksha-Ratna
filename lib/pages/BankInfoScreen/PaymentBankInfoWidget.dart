import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'PaymentBankInfoModel.dart';



class PaymentBankInfoWidget extends StatefulWidget {
  const PaymentBankInfoWidget({super.key});

  @override
  State<PaymentBankInfoWidget> createState() => _PaymentBankInfoWidgetState();
}

class _PaymentBankInfoWidgetState extends State<PaymentBankInfoWidget> {
  late PaymentBankInfoModel _model;

  final PaymentBankInfoWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentBankInfoModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => _model.unfocusNode.canRequestFocus
            ? FocusScope.of(context).requestFocus(_model.unfocusNode)
            : FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: PaymentBankInfoWidgetscaffoldKey,
          backgroundColor: Colors.white,

          body: SafeArea(
            top: true,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(25, 60, 30, 25),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.asset(
                        'assets/images/Group_1886.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      'Your Order has been placed!',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF740074),
                        fontSize: 20,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Your order amount is more than 5lac Kindly make payment on below account details',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 296,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Color(0xFF740074),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                              child: Text(
                                'India Account',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(
                                'HSBC Bank',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Account Name: Rudraksha Ratna',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Account:  # 005116827001',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'IFSC Code:  HSBC0400006',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Bank Name: HSBC Bank',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ].divide(SizedBox(height: 5)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bank Address: ',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Container(
                                  width: 180,
                                  decoration: BoxDecoration(),
                                  child: Text(
                                    ' Grd Flr, Sanket Apartments, Central Avenue Road, 14th Road Corner, Chembur E, Mumbai - 400071 ',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      fontSize: 13,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                      lineHeight: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ].divide(SizedBox(height: 10)),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 325,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Color(0xFF740074),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                              child: Text(
                                'International Account ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(
                                'ICICI Bank Limited',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Account Name:  Rudra Centre Services Pvt. Ltd.',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Account:   # 195705001068',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'IFSC Code:   ICIC0001957',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Swift Code:  ICICINBBCTS',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Bank Name:   ICICI Bank Limited',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ].divide(SizedBox(height: 5)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bank Address: ',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Container(
                                  width: 180,
                                  decoration: BoxDecoration(),
                                  child: Text(
                                    ' Shop No 4,5, Om Ashirwad Chs.Ltd., N.C. Kelkar Marg, Opp.Shivaji Mandir, Shivaji Park, Dadar (W), Mumbai-400028, Maharashtra, India ',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      fontSize: 13,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                      lineHeight: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ].divide(SizedBox(height: 10)),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 325,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Color(0xFF740074),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                              child: Text(
                                'International Account ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(
                                'HDFC Bank',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Account Name:  Rudra Centre Services Pvt. Ltd.',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Account:    # 59209322688120',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'IFSC Code:    HDFC0000084',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Swift Code:  HDFCINBB',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Bank Name:  HDFC Bank',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ].divide(SizedBox(height: 5)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bank Address: ',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Container(
                                  width: 180,
                                  decoration: BoxDecoration(),
                                  child: Text(
                                    ' Dadar TT Imperial Mahal, GR Floor, Khodad Circle, Dadar TT, Mumbai – 400014, Maharashtra, India. ',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      fontSize: 13,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                      lineHeight: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ].divide(SizedBox(height: 10)),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          context.pushNamed(
                            'Homepage',
                            extra: <String, dynamic>{
                              kTransitionInfoKey: TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.scale,
                                alignment: Alignment.bottomCenter,
                                duration: Duration(milliseconds: 400),
                              ),
                            },
                          );
                        },
                        text: 'HOME',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 48,
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          ),
                          elevation: 0,
                          borderSide: BorderSide(color: Colors.transparent,),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 16)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
