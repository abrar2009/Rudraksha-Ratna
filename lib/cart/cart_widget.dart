import '../auth/custom_auth/auth_util.dart';
import '../custom_code/widgets/quantity_counter_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_model.dart';
export 'cart_model.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  late CartModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CartModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    // Check authentication token
    if (currentAuthenticationToken == null || currentAuthenticationToken!.isEmpty) {
      // Navigate to login page or show login prompt
      Navigator.of(context).pushNamed('/loginPage');
      return Container();
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
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
            onPressed: () async {context.pop();},
          ),
          title: Text(
            'Shopping cart',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Outfit',
              color: FlutterFlowTheme.of(context).primaryText,
              fontSize: 16,
              letterSpacing: 0,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 1,
        ),
        body: FutureBuilder<ApiCallResponse>(
          future: CartCall.call(
              hosturl: FFAppConstants.hosturl,
              token: currentAuthenticationToken
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
            final stackCartResponse = snapshot.data!;
            final cartData = getJsonField(stackCartResponse.jsonBody, r'''$.data''');

            // Check if cartData is a List
            final cartList = cartData is List ? cartData : [];

            if (cartList.isEmpty) {
              // Display image when cart is empty
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration (
                  image: DecorationImage(
                    image: AssetImage('assets/images/empty_cart_image.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Your cart is empty',
                        style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Montserrat',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 24,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 31,),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(108, 0, 108, 0),
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
              );
            }

            // Render cart items when cart is not empty
            return Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 1,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 200),
                    child: Builder(builder: (context) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(cartList.length, (cartListIndex) {
                            final cartListItem = cartList[cartListIndex];
                            return Container(

                              width: MediaQuery.of(context).size.width * 0.9999,//double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                border: Border.all(color: Color(0xFFE7E7E8),),
                              ),
                              child: Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(7, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.network(
                                              getJsonField(cartListItem, r'''$.thumbnail_image''',).toString(),
                                              width: MediaQuery.of(context).size.width * 0.18,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Container(
                                            height: 142,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(7, 0, 0, 44),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 10),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: 230,
                                                          decoration: BoxDecoration(),
                                                          child: Align(alignment: AlignmentDirectional(-1, -1),
                                                            child: Text(getJsonField(cartListItem, r'''$.product_name''',).toString(),
                                                              maxLines: 2,
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                fontFamily: 'Montserrat',
                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                fontSize: 16,
                                                                letterSpacing: 0,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                          ),
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
                                                              cartId: getJsonField(cartListItem, r'''$.cart_id''',),
                                                            );
                                                            _shouldSetState = true;
                                                            if ((_model.apiResult5ep?.succeeded ?? true)) {
                                                              FFAppState().statusFailed = getJsonField(cartListItem, r'''$.status''',).toString();
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
                                                          child: const Icon(
                                                            Icons.delete_outline_rounded,
                                                            color: Color(0xFFFB0000),
                                                            size: 26,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  if(getJsonField(cartListItem, r'''$.design_type''',).toString()!="")
                                                    RichText(
                                                      textScaler: MediaQuery.of(context).textScaler,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: 'Design Type: ',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Montserrat',
                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                              letterSpacing: 0,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: getJsonField(cartListItem, r'''$.design_type''',).toString(),
                                                            style: const TextStyle(
                                                              color: Color(0xFF696969),
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 14,
                                                            ),
                                                          )
                                                        ],
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Montserrat',
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                    ),

                                                  if(getJsonField(cartListItem, r'''$.variant_name''',).toString()!="null" || getJsonField(cartListItem, r'''$.variant_status''',).toString()==false)
                                                    Container(
                                                      width:250,
                                                      child: RichText(
                                                        textScaler: MediaQuery.of(context).textScaler,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: 'Variant: ',
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                fontFamily: 'Montserrat',
                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                letterSpacing: 0,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: getJsonField(cartListItem, r'''$.variant_name''',).toString(),
                                                              style: const TextStyle(
                                                                color: Color(0xFF696969),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14,
                                                              ),
                                                            )
                                                          ],
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Montserrat',
                                                            letterSpacing: 0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  RichText(
                                                    textScaler: MediaQuery.of(context).textScaler,
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Design: ',
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Montserrat',
                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                            letterSpacing: 0,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: getJsonField(cartListItem, r'''$.design_name''',).toString(),
                                                          style: const TextStyle(
                                                            color: Color(0xFF696969),
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 14,
                                                          ),
                                                        )
                                                      ],
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
                                                        letterSpacing: 0,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 260,
                                                    child: RichText(
                                                      textScaler: MediaQuery.of(context).textScaler,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(text: 'Energization: ',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Montserrat',
                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                              letterSpacing: 0,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: getJsonField(cartListItem, r'''$.energization_name''',).toString(),
                                                            style: const TextStyle(
                                                              color: Color(0xFF696969),
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 14,
                                                            ),
                                                          )
                                                        ],
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Montserrat',
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 150,
                                                        decoration: BoxDecoration(),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 38, 0),
                                                          child: Align(alignment: AlignmentDirectional(-1, 0),
                                                            child: Text('${valueOrDefault<String>(FFAppState().currencyName, 'INR',)} '
                                                                '${formatNumber(functions.currencyConversion(FFAppState().currencyRate, getJsonField(cartListItem, r'''$.selling_price''',).toString()),
                                                              formatType: FormatType.decimal,
                                                              decimalType: DecimalType.automatic,
                                                            )}',
                                                              textAlign: TextAlign.start,
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                fontFamily: 'Montserrat',
                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                fontSize: 18,
                                                                letterSpacing: 0,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        splashColor: Colors.transparent,
                                                        focusColor: Colors.transparent,
                                                        hoverColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        onTap: () async {
                                                          _model.apiResultiltCopy = await CartCall.call(
                                                              hosturl: FFAppConstants.hosturl,
                                                              token: currentAuthenticationToken
                                                          );
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          width: 120,
                                                          height: 35,
                                                          child: QuantityCounterWidget(
                                                            width: 120,
                                                            height: 35,
                                                            hosturl: FFAppConstants.hosturl,
                                                            token: currentAuthenticationToken,
                                                            cartId: getJsonField(cartListItem, r'''$.cart_id''',).toString(),
                                                            initialQuantity: getJsonField(cartListItem, r'''$.quantity''',),
                                                            currentStock: getJsonField(cartListItem, r'''$.current_stock''',),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ].divide(const SizedBox(height: 13)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).divide(const SizedBox(height: 0)).addToStart(const SizedBox(height: 0)),
                        ),
                      );
                    },
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 68,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          border: Border.all(color: Color(0xFFE7E7E8),),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(24, 8, 24, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(textScaler: MediaQuery.of(context).textScaler,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(text: 'Cart Total',
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            color: FlutterFlowTheme.of(context).primaryText,
                                            fontSize: 16,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(text: ' (Inc all taxes)',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context).primaryText,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'View Details',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context).primary,
                                      fontSize: 16,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Text(
                                  '${valueOrDefault<String>(FFAppState().currencyName, 'INR',
                                  )} ${formatNumber(functions.currencyConversion(FFAppState().currencyRate, getJsonField(stackCartResponse.jsonBody, r'''$.cart_total''',).toString()),
                                    formatType: FormatType.decimal,
                                    decimalType: DecimalType.automatic,
                                  )}',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    fontSize: 18,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          border: Border.all(color: Color(0xFFE7E7E8),),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                          child: FFButtonWidget(
                            onPressed: () async {
                              FFAppState().buynow = false;
                              FFAppState().cartTotal = getJsonField(
                                stackCartResponse.jsonBody,
                                r'''$.cart_total''',
                              ).toInt();
                              FFAppState().orderTotal = getJsonField(
                                stackCartResponse.jsonBody,
                                r'''$.total_reward_price''',
                              ).toInt();
                              FFAppState().courierTotal = getJsonField(
                                stackCartResponse.jsonBody,
                                r'''$.courier_total''',
                              ).toInt();
                              setState(() {});
                              context.pushNamed(
                                'DeliveryAddress',
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.bottomToTop,
                                    duration: Duration(milliseconds: 400),
                                  ),
                                },
                              );
                            },
                            text: 'Proceed to Select address',
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
                                width: 0,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                    Align(
                      alignment: AlignmentDirectional(0, 1),
                      child: wrapWithModel(
                        model: _model.customNavBarModel,
                        updateCallback: () => setState(() {}),
                        child: CustomNavBarWidget(),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}