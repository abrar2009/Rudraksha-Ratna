import '../auth/custom_auth/auth_util.dart';
import '../flutter_flow/custom_functions.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_nav_bar_widget.dart';
import '/components/select_free_gift_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/free_gift_component/free_gift_component_widget.dart';
import 'package:flutter/material.dart';

import 'select_payment_method_model.dart';
export 'select_payment_method_model.dart';

class SelectPaymentMethodWidget extends StatefulWidget {
  const SelectPaymentMethodWidget({
    super.key,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.addressId,
    required this.name,
    required this.email,
    required this.contact,
    required this.country,
  });

  final String? address1;
  final String? address2;
  final String? city;
  final String? state;
  final String? pinCode;
  final int? addressId;
  final String? name;
  final String? email;
  final String? contact;
  final String? country;

  @override
  State<SelectPaymentMethodWidget> createState() =>
      _SelectPaymentMethodWidgetState();
}

class _SelectPaymentMethodWidgetState extends State<SelectPaymentMethodWidget> {
  late SelectPaymentMethodModel _model;
  String? _invoiceNumber;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectPaymentMethodModel());
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
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Select Payment method',
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
          elevation: 0,
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
            return Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.745,
                      decoration: BoxDecoration(),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 1,
                              decoration: BoxDecoration(
                                color: Color(0xFFE7E7E8),
                                border: Border.all(
                                  color: Color(0xFFE7E7E8),
                                ),
                              ),
                            ),
                            // Generated code for this Column Widget...
                            Builder(
                              builder: (context) {
                                final cartList = getJsonField(
                                  stackCartResponse.jsonBody,
                                  r'''$.data''',
                                ).toList();
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(cartList.length, (cartListIndex) {
                                    final cartListItem = cartList[cartListIndex];
                                    return Container(
                                      width: double.infinity,
                                      height: 72,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                        border: Border.all(
                                          color: Color(0xFFE7E7E8),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Image.network(
                                                getJsonField(
                                                  cartListItem,
                                                  r'''$.thumbnail_image''',
                                                ).toString(),
                                                width: 50,
                                                height: 48,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 250,
                                                    child: Text(
                                                      getJsonField(
                                                        cartListItem,
                                                        r'''$.product_name''',
                                                      ).toString(),
                                                      style: FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily: 'Montserrat',
                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                        fontSize: 13,
                                                        letterSpacing: 0,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    'View Details',
                                                    style:
                                                    FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      color: FlutterFlowTheme.of(context).primary,
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ].divide(SizedBox(height: 8)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              },
                            ),
                            // Generated code for this Container Widget...
                            Container(
                              width: double.infinity,
                              height: 159,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                border: Border.all(
                                  color: Color(0xFFE7E7E8),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Ship to',
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF696969),
                                            fontSize: 15,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Container(
                                          width: 200,
                                          decoration: BoxDecoration(),
                                          child: Text(
                                            '${widget.address1}, ${widget.address2}, ${widget.city}, ${widget.state}, ${widget.pinCode}',
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              letterSpacing: 0,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: FlutterFlowTheme.of(context).secondaryText,
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(16, 5, 0, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Theme(
                                          data: ThemeData(
                                            checkboxTheme: CheckboxThemeData(
                                              visualDensity: VisualDensity.compact,
                                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                            ),
                                            unselectedWidgetColor:
                                            FlutterFlowTheme.of(context).secondaryText,
                                          ),
                                          child: Checkbox(
                                            value: _model.checkboxValue1 ??= false,
                                            onChanged: (newValue) async {
                                              setState(() => _model.checkboxValue1 = newValue!);
                                            },
                                            side: BorderSide(
                                              width: 2,
                                              color: FlutterFlowTheme.of(context).secondaryText,
                                            ),
                                            activeColor: Color(0xFF740074),
                                            checkColor: FlutterFlowTheme.of(context).info,
                                          ),
                                        ),
                                        Text(
                                          'Billing address as same as shipping address',
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 327,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: Color(0xFFE7E7E8),
                                      ),
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Text(
                                        ' + Add billing address',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF696969),
                                          fontSize: 13,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 5)),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return GestureDetector(
                                      onTap: () => _model
                                          .unfocusNode.canRequestFocus
                                          ? FocusScope.of(context)
                                          .requestFocus(_model.unfocusNode)
                                          : FocusScope.of(context).unfocus(),
                                      child: Padding(
                                        padding:
                                        MediaQuery.viewInsetsOf(context),
                                        child: FreeGiftComponentWidget(),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: Container(
                                width: double.infinity,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  border: Border.all(
                                    color: Color(0xFFE7E7E8),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 14, 16, 14),
                                  child: Container(
                                    width: 343,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 4,
                                          color: Color(0x14000014),
                                          offset: Offset(
                                            0,
                                            2,
                                          ),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(16, 0, 0, 0),
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(8),
                                                child: Image.asset(
                                                  'assets/images/Vector.png',
                                                  width: 19.98,
                                                  height: 19.98,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(25, 0, 0, 0),
                                              child: Text(
                                                'Apply Coupon',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily:
                                                  'Montserrat',
                                                  fontSize: 16,
                                                  letterSpacing: 0,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 22,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 80,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                border: Border.all(
                                  color: Color(0xFFE7E7E8),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 14, 16, 14),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return GestureDetector(
                                          onTap: () => _model
                                              .unfocusNode.canRequestFocus
                                              ? FocusScope.of(context)
                                              .requestFocus(
                                              _model.unfocusNode)
                                              : FocusScope.of(context)
                                              .unfocus(),
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: Container(
                                              height: 734,
                                              child: SelectFreeGiftWidget(),
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  },
                                  child: Container(
                                    width: 343,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 4,
                                          color: Color(0x14000014),
                                          offset: Offset(
                                            0,
                                            2,
                                          ),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(16, 0, 0, 0),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                  Radius.circular(0),
                                                  bottomRight:
                                                  Radius.circular(0),
                                                  topLeft: Radius.circular(0),
                                                  topRight: Radius.circular(0),
                                                ),
                                                child: Image.asset(
                                                  'assets/images/giftbox_1.png',
                                                  width: 19.98,
                                                  height: 19.98,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(25, 0, 0, 0),
                                              child: Text(
                                                'Select a Free Gift',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily:
                                                  'Montserrat',
                                                  fontSize: 16,
                                                  letterSpacing: 0,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 22,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                border: Border.all(
                                  color: Color(0xFFE7E7E8),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 10, 16, 5),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order Summary',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        fontSize: 16,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 9, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Product',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primaryText,
                                              fontSize: 15,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'Amount',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primaryText,
                                              fontSize: 15,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Builder(
                                      builder: (context) {
                                        final cartProducts = getJsonField(
                                          stackCartResponse.jsonBody,
                                          r'''$.data''',
                                        ).toList();
                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children:
                                          List.generate(cartProducts.length,
                                                  (cartProductsIndex) {
                                                final cartProductsItem =
                                                cartProducts[cartProductsIndex];
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 9, 0, 0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 250,
                                                        child: Text(
                                                          getJsonField(
                                                            cartProductsItem,
                                                            r'''$.product_name''',
                                                          ).toString(),
                                                          style: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Montserrat',
                                                            color:
                                                            Color(0xFF222222),
                                                            fontSize: 14,
                                                            letterSpacing: 0,
                                                            fontWeight:
                                                            FontWeight.normal,
                                                          ),
                                                        ),
                                                      ),
                                                      // Generated code for this Text Widget...
                                                      /*Text(
                                                        formatPriceWithCommas(getJsonField(
                                                          cartProductsItem,
                                                          r'''$.selling_price''',
                                                        )),
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Montserrat',
                                                          color: Color(0xFF222222),
                                                          fontSize: 14,
                                                          letterSpacing: 0,
                                                          fontWeight: FontWeight.normal,
                                                        ),
                                                      )*/
                                                      Align(
                                                        alignment: AlignmentDirectional(-1, 0),
                                                        child: Text(
                                                          '${valueOrDefault<String>(
                                                            FFAppState().currencyName, 'INR',
                                                          )} ${formatNumber(currencyConversion(
                                                                FFAppState().currencyRate,
                                                                getJsonField(
                                                                  cartProductsItem,
                                                                  r'''$.selling_price''',
                                                                ).toString()),
                                                            formatType: FormatType.decimal,
                                                            decimalType: DecimalType.automatic,
                                                          )}',
                                                          textAlign: TextAlign.start,
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Montserrat',
                                                            color: Color(0xFF222222),
                                                            fontSize: 14,
                                                            letterSpacing: 0,
                                                            fontWeight: FontWeight.normal,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        );
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 9, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Subtotal',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF222222),
                                              fontSize: 14,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          // Generated code for this Text Widget...
                                          /*Text(
                                            formatPriceWithCommas(getJsonField(
                                              stackCartResponse.jsonBody,
                                              r'''$.cart_total''',
                                            )),
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF222222),
                                              fontSize: 14,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          )*/
                                          Align(
                                            alignment: AlignmentDirectional(-1, 0),
                                            child: Text(
                                              '${valueOrDefault<String>(
                                                FFAppState().currencyName,
                                                'INR',
                                              )} ${formatNumber(currencyConversion(
                                                  FFAppState().currencyRate,
                                                  getJsonField(
                                                    stackCartResponse.jsonBody,
                                                    r'''$.cart_total''',
                                                  ).toString()),
                                                formatType: FormatType.decimal,
                                                decimalType: DecimalType.automatic,
                                              )}',
                                              textAlign: TextAlign.start,
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF222222),
                                                fontSize: 14,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 9, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Discount 10%',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF009D48),
                                              fontSize: 14,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            'INR 51,000',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF009D48),
                                              fontSize: 14,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 9, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Shipping Charges',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF222222),
                                              fontSize: 14,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          /*Text(
                                            'INR 0',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF222222),
                                              fontSize: 14,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),*/
                                          Text(
                                            '${valueOrDefault<String>(
                                              FFAppState().currencyName,
                                              'INR',
                                            )} ${formatNumber(currencyConversion(
                                                FFAppState().currencyRate,
                                                FFAppState().shippingAmount!.toString()),
                                              formatType: FormatType.decimal,
                                              decimalType: DecimalType.automatic,
                                            )}',
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF222222),
                                              fontSize: 14,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 9, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Reward points earned',
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              color: FlutterFlowTheme.of(context).primary,
                                              fontSize: 14,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Text(
                                            '${formatNumber(currencyConversion(
                                                FFAppState().currencyRate,
                                                FFAppState().rewardPoints.toString()),
                                              formatType: FormatType.decimal,
                                              decimalType: DecimalType.automatic,
                                            )} (${valueOrDefault<String>(
                                              FFAppState().currencyName,
                                              'INR',
                                            )} ${formatNumber(currencyConversion(
                                                FFAppState().currencyRate,
                                                FFAppState().rewardPoints.toString()),
                                              formatType: FormatType.decimal,
                                              decimalType: DecimalType.automatic,
                                            )})',
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              color: FlutterFlowTheme.of(context).primary,
                                              fontSize: 14,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 6, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Theme(
                                                data: ThemeData(
                                                  checkboxTheme:
                                                  CheckboxThemeData(
                                                    visualDensity: VisualDensity.compact,
                                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(4),),
                                                  ),
                                                  unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                                                ),
                                                child: Checkbox(
                                                  value: _model.checkboxValue2 ??= false,
                                                  onChanged: (newValue) async {
                                                    setState(() => _model.checkboxValue2 = newValue!);
                                                  },
                                                  side: BorderSide(
                                                    width: 2,
                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                  ),
                                                  activeColor: Color(0xFF740074),
                                                  checkColor: FlutterFlowTheme.of(context).info,
                                                ),
                                              ),
                                              Text(
                                                'Use Rewards Points',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF696969),
                                                  letterSpacing: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'Total points: 414',
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              color: FlutterFlowTheme.of(context).primary,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2,
                                      color: Color(0xFFE7E7E8),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Order Total',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 15,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        // Generated code for this cartTotalAmount Widget...
                                        /*Text(
                                          formatPriceWithCommas(getJsonField(
                                            stackCartResponse.jsonBody,
                                            r'''$.cart_total''',
                                          )),
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            color: FlutterFlowTheme.of(context).primaryText,
                                            fontSize: 15,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),*/
                                        /*Align(
                                          alignment: AlignmentDirectional(-1, 0),
                                          child: Text(
                                            '${valueOrDefault<String>(
                                              FFAppState().currencyName,
                                              'INR',
                                            )} ${formatNumber(currencyConversion(
                                                FFAppState().currencyRate,
                                                getJsonField(
                                                  stackCartResponse.jsonBody,
                                                  r'''$.cart_total''',
                                                ).toString()),
                                              formatType: FormatType.decimal,
                                              decimalType: DecimalType.automatic,
                                            )}',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              color: FlutterFlowTheme.of(context).primaryText,
                                              fontSize: 15,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),*/
                                Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Builder(
                                    builder: (context) {
                                      final cartTotal = currencyConversion(
                                        FFAppState().currencyRate,
                                        getJsonField(
                                          stackCartResponse.jsonBody,
                                          r'''$.cart_total''',
                                        ).toString(),
                                      );

                                      // Update cartAmount in FFAppState
                                      FFAppState().cartAmount = cartTotal!;

                                      return Text(
                                        '${valueOrDefault<String>(
                                          FFAppState().currencyName,
                                          'INR',
                                        )} ${formatNumber(
                                          cartTotal,
                                          formatType: FormatType.decimal,
                                          decimalType: DecimalType.automatic,
                                        )}',
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          fontSize: 15,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    /*Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 14, 0, 0),
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              _model.cartTotal = getJsonField(
                                stackCartResponse.jsonBody,
                                r'''$.cart_total''',).toString();
                              setState(() {});
                              context.pushNamed(
                                'SelectPaymentMethod2',
                                queryParameters: {
                                  'currencyName': serializeParam(
                                    FFAppState().currencyName,
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: const TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 400),
                                  ),
                                },
                              );
                              print('Cart Total: ${_model.cartTotal}');
                              print('Currency Rate: ${FFAppState().currencyRate}');
                              print('Cart Amount: ${FFAppState().cartAmount}');
                            },
                            text: 'Select Payment Method',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 48,
                              padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600,
                              ),
                              elevation: 0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        )
                      ),
                    ),*/
                    // Generated code for this Container Widget...
                    Container(
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                        child: FFButtonWidget(
                          /*onPressed: () async {
                            print('Product IDs: ${getJsonField(stackCartResponse.jsonBody, r'''$.data[:].product_id''')}');
                            context.pushNamed(
                              'SelectPaymentMethod2',
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.rightToLeft,
                                  duration: Duration(milliseconds: 400),
                                ),
                              },
                            );

                            print('Cart API Response JSON: ${stackCartResponse.jsonBody}');

                            if (stackCartResponse.jsonBody == null) {
                              print('Cart API Response Data is null');
                              return; // Exit early if response data is null
                            }

                            // Check if 'data' field exists in the response
                            final responseData = getJsonField(stackCartResponse.jsonBody, r'''$.data[:]''');
                            if (responseData == null || !(responseData is List<dynamic>)) {
                              print('Invalid data format in Cart API Response');
                              return; // Exit early if data format is invalid
                            }

                            // Extract the cart list from the API response
                            final cartList = responseData as List<dynamic>;

                            print('Cart List: $cartList');

                            // Map the cart items to Product objects
                            List<Product> products = cartList.map((cartListItem) {
                              return Product.fromJson(cartListItem);
                            }).toList();

                            print('Products: ${jsonEncode(products.map((p) => p.toJson()).toList())}');

                            print('Calling AddOrder API with the following details:');
                            print('Host URL: ${FFAppConstants.hosturl}');
                            print('Token: $currentAuthenticationToken');
                            print('Delivery Address ID: ${widget.addressId}');
                            print('Billing Address ID: ${widget.addressId}');
                            print('Products: ${jsonEncode(products.map((p) => p.toJson()).toList())}');

                            final requestBody = {
                              'deliveryAddress': widget.addressId,
                              'deliveryAddressText': joinAddress(
                                widget.address1,
                                widget.address2,
                                widget.city,
                                widget.state,
                                widget.pinCode,
                              ),
                              'billingAddress': widget.addressId,
                              'billingAddressText': joinAddress(
                                widget.address1,
                                widget.address2,
                                widget.city,
                                widget.state,
                                widget.pinCode,
                              ),
                              'payment_mode': 2,
                              'currency_type': FFAppState().currencyName,
                              'deliveryCharges': 90,
                              'coupenCode': '',
                              'coupenAmount': 0,
                              'giftId': '',
                              'reward_used': false,
                              'reward_points': 0,
                              'pendingamount': 365,
                              'products': products.map((p) => p.toJson()).toList(),
                              'customer_instructions': '',
                              'shipping_type': 'Fedex/DHL',
                              'digital_source': 'not sponsored',
                            };

                            print('Request Body: ${jsonEncode(requestBody)}');

                            ApiCallResponse apiResponse = await AddOrderCall.call(
                              hosturl: FFAppConstants.hosturl,
                              token: currentAuthenticationToken,
                              deliveryAddress: widget.addressId,
                              deliveryAddressText: joinAddress(
                                widget.address1,
                                widget.address2,
                                widget.city,
                                widget.state,
                                widget.pinCode,
                              ),
                              billingAddress: widget.addressId,
                              billingAddressText: joinAddress(
                                widget.address1,
                                widget.address2,
                                widget.city,
                                widget.state,
                                widget.pinCode,
                              ),
                              paymentMode: 2,
                              currencyType: FFAppState().currencyName,
                              deliveryCharges: 90,
                              coupenCode: '',
                              coupenAmount: 0,
                              giftId: '',
                              rewardUsed: false,
                              pendingamount: 365,
                              rewardPoints: 0,
                              products: products, // Pass the List<Product> directly
                              customerInstructions: '',
                              shippingType: 'Fedex/DHL',
                              digitalSource: 'not sponsored',
                            );

                            print('API Call Result:');
                            if (apiResponse == null) {
                              print('API response is null');
                            } else {
                              print('Raw Response: ${apiResponse.jsonBody}');
                              print('Response Data: ${apiResponse.response}');
                              print('Response Headers: ${apiResponse.headers}');
                              print('Status Code: ${apiResponse.statusCode}');
                            }

                            setState(() {});
                          },*/
                          onPressed: () async {
                            print('Product IDs: ${getJsonField(stackCartResponse.jsonBody, r'''$.data[:].product_id''')}');
                            _model.cartTotal = getJsonField(
                              stackCartResponse.jsonBody,
                              r'''$.cart_total''',
                            ).toString();
                            //setState(() {});
                            /*context.pushNamed(
                              'SelectPaymentMethod2',
                              queryParameters: {
                                'totalAmount': serializeParam(
                                  _model.cartTotal,
                                  ParamType.String,
                                ),
                              }.withoutNulls,
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.rightToLeft,
                                  duration: Duration(milliseconds: 400),
                                ),
                              },
                            );*/

                            print('Cart API Response JSON: ${stackCartResponse.jsonBody}');

                            if (stackCartResponse.jsonBody == null) {
                              print('Cart API Response Data is null');
                              return; // Exit early if response data is null
                            }

                            // Check if 'data' field exists in the response
                            dynamic responseData = getJsonField(stackCartResponse.jsonBody, r'''$.data[:]''');
                            List<dynamic> cartList = [];

                            if (responseData != null) {
                              if (responseData is List) {
                                cartList = responseData;
                              } else if (responseData is Map<String, dynamic>) {
                                cartList = [responseData]; // Convert single object to list
                              } else {
                                print('Invalid data format in Cart API Response');
                                return; // Exit early if data format is invalid
                              }
                            } else {
                              print('Cart API Response Data is null');
                              return; // Exit early if response data is null
                            }

                            print('Cart List: $cartList');

                            // Map the cart items to Product objects
                            List<Product> products = cartList.map((cartListItem) {
                              return Product.fromJson(cartListItem);
                            }).toList();

                            print('Products: ${jsonEncode(products.map((p) => p.toJson()).toList())}');

                            print('Calling AddOrder API with the following details:');
                            print('Host URL: ${FFAppConstants.hosturl}');
                            print('Token: $currentAuthenticationToken');
                            print('Delivery Address ID: ${widget.addressId}');
                            print('Billing Address ID: ${widget.addressId}');
                            print('Products: ${jsonEncode(products.map((p) => p.toJson()).toList())}');

                            final requestBody = {
                              'deliveryAddress': widget.addressId,
                              'deliveryAddressText': joinAddress(
                                  widget.address1,
                                  widget.address2,
                                  widget.city,
                                  widget.state,
                                  widget.pinCode,
                                  widget.name,
                                  widget.email,
                                  widget.contact,
                                  widget.country
                              ),
                              'billingAddress': widget.addressId,
                              'billingAddressText': joinAddress(
                                  widget.address1,
                                  widget.address2,
                                  widget.city,
                                  widget.state,
                                  widget.pinCode,
                                  widget.name,
                                  widget.email,
                                  widget.contact,
                                  widget.country
                              ),
                              'payment_mode': 2,
                              'currency_type': FFAppState().currencyName,
                              'deliveryCharges': 90,
                              'coupenCode': FFAppState().couponCode,
                              'coupenAmount': 0,
                              'giftId': FFAppState().selectedGiftId,
                              'reward_used': false,
                              'reward_points': 0,
                              'pendingamount': 365,
                              'products': products.map((p) => p.toJson()).toList(),
                              'customer_instructions': '',
                              'shipping_type': 'Fedex/DHL',
                              'digital_source': 'not sponsored',
                            };

                            print('Request Body: ${jsonEncode(requestBody)}');

                            ApiCallResponse apiResponse = await AddOrderCall.call(
                              hosturl: FFAppConstants.hosturl,
                              token: currentAuthenticationToken,
                              deliveryAddress: widget.addressId,
                              deliveryAddressText: joinAddress(
                                  widget.address1,
                                  widget.address2,
                                  widget.city,
                                  widget.state,
                                  widget.pinCode,
                                  widget.name,
                                  widget.email,
                                  widget.contact,
                                  widget.country
                              ),
                              billingAddress: widget.addressId,
                              billingAddressText: joinAddress(
                                  widget.address1,
                                  widget.address2,
                                  widget.city,
                                  widget.state,
                                  widget.pinCode,
                                  widget.name,
                                  widget.email,
                                  widget.contact,
                                  widget.country
                              ),
                              paymentMode: 2,
                              currencyType: FFAppState().currencyName,
                              deliveryCharges: 90,
                              coupenCode: FFAppState().couponCode,
                              coupenAmount: 0,
                              giftId: FFAppState().selectedGiftId?.toString(),
                              rewardUsed: false,
                              pendingamount: 365,
                              rewardPoints: 0,
                              products: products, // Pass the List<Product> directly
                              customerInstructions: '',
                              shippingType: 'Fedex/DHL',
                              digitalSource: 'not sponsored',
                            );

                            print('API Call Result:');
                            if (apiResponse == null) {
                              print('API response is null');
                            } else {
                              print('Raw Response: ${apiResponse.jsonBody}');
                              print('Response Data: ${apiResponse.response}');
                              print('Response Headers: ${apiResponse.headers}');
                              print('Status Code: ${apiResponse.statusCode}');
                            }

                            if (apiResponse != null && apiResponse.statusCode == 200) {
                              FFAppState().invoiceNumber = AddOrderCall.invoiceNo(
                                (apiResponse.jsonBody),
                              )!;
                              _invoiceNumber = FFAppState().invoiceNumber;
                              print('Invoice Number: $_invoiceNumber');
                              print('Cart Amount: ${FFAppState().cartAmount}');
                              //setState(() {});

                              // Navigate to the next page and pass the invoiceNumber
                              context.pushNamed(
                                'SelectPaymentMethod2',
                                queryParameters: {
                                  'totalAmount': serializeParam(
                                    _model.cartTotal,
                                    ParamType.String,
                                  ),
                                  'invoiceNumber': serializeParam(
                                    _invoiceNumber,
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 400),
                                  ),
                                },
                              );
                            }
                          },
                          /*onPressed: () async {
                            print('Product IDs: ${getJsonField(stackCartResponse.jsonBody, r'''$.data[:].product_id''')}');
                            _model.cartTotal = getJsonField(
                              stackCartResponse.jsonBody,
                              r'''$.cart_total''',
                            ).toString();
                            setState(() {});
                            context.pushNamed(
                              'SelectPaymentMethod2',
                              queryParameters: {
                                'totalAmount': serializeParam(
                                  _model.cartTotal,
                                  ParamType.String,
                                ),
                              }.withoutNulls,
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.rightToLeft,
                                  duration: Duration(milliseconds: 400),
                                ),
                              },
                            );

                            print('Cart API Response JSON: ${stackCartResponse.jsonBody}');

                            if (stackCartResponse.jsonBody == null) {
                              print('Cart API Response Data is null');
                              return; // Exit early if response data is null
                            }

                            // Check if 'data' field exists in the response
                            dynamic responseData = getJsonField(stackCartResponse.jsonBody, r'''$.data[:]''');
                            List<dynamic> cartList = [];

                            if (responseData != null) {
                              if (responseData is List) {
                                cartList = responseData;
                              } else if (responseData is Map<String, dynamic>) {
                                cartList = [responseData]; // Convert single object to list
                              } else {
                                print('Invalid data format in Cart API Response');
                                return; // Exit early if data format is invalid
                              }
                            } else {
                              print('Cart API Response Data is null');
                              return; // Exit early if response data is null
                            }

                            print('Cart List: $cartList');

                            // Map the cart items to Product objects
                            List<Product> products = cartList.map((cartListItem) {
                              return Product.fromJson(cartListItem);
                            }).toList();

                            print('Products: ${jsonEncode(products.map((p) => p.toJson()).toList())}');

                            print('Calling AddOrder API with the following details:');
                            print('Host URL: ${FFAppConstants.hosturl}');
                            print('Token: $currentAuthenticationToken');
                            print('Delivery Address ID: ${widget.addressId}');
                            print('Billing Address ID: ${widget.addressId}');
                            print('Products: ${jsonEncode(products.map((p) => p.toJson()).toList())}');

                            final requestBody = {
                              'deliveryAddress': widget.addressId,
                              'deliveryAddressText': joinAddress(
                                widget.address1,
                                widget.address2,
                                widget.city,
                                widget.state,
                                widget.pinCode,
                                widget.name,
                                widget.email,
                                widget.contact,
                                widget.country
                              ),
                              'billingAddress': widget.addressId,
                              'billingAddressText': joinAddress(
                                widget.address1,
                                widget.address2,
                                widget.city,
                                widget.state,
                                widget.pinCode,
                                widget.name,
                                widget.email,
                                widget.contact,
                                widget.country
                              ),
                              'payment_mode': 2,
                              'currency_type': FFAppState().currencyName,
                              'deliveryCharges': 90,
                              'coupenCode': '',
                              'coupenAmount': 0,
                              'giftId': '',
                              'reward_used': false,
                              'reward_points': 0,
                              'pendingamount': 365,
                              'products': products.map((p) => p.toJson()).toList(),
                              'customer_instructions': '',
                              'shipping_type': 'Fedex/DHL',
                              'digital_source': 'not sponsored',
                            };

                            print('Request Body: ${jsonEncode(requestBody)}');

                            ApiCallResponse apiResponse = await AddOrderCall.call(
                              hosturl: FFAppConstants.hosturl,
                              token: currentAuthenticationToken,
                              deliveryAddress: widget.addressId,
                              //deliveryAddressText: 'Name: Shadab Shaikh, Email: shadab.shaikh@onerooftech.com, Contact No.: 8286473678, Address Line 1: Line 1, Address Line 2: Line 2, Country: India, State: Maharashtra, City: Mumabi, Pincode: 987987',
                              deliveryAddressText: joinAddress(
                                widget.address1,
                                widget.address2,
                                widget.city,
                                widget.state,
                                widget.pinCode,
                                widget.name,
                                widget.email,
                                widget.contact,
                                widget.country
                              ),
                              billingAddress: widget.addressId,
                              //billingAddressText: 'Name: Shadab Shaikh, Email: shadab.shaikh@onerooftech.com, Contact No.: 8286473678, Address Line 1: Line 1, Address Line 2: Line 2, Country: India, State: Maharashtra, City: Mumabi, Pincode: 987987',
                              billingAddressText: joinAddress(
                                widget.address1,
                                widget.address2,
                                widget.city,
                                widget.state,
                                widget.pinCode,
                                widget.name,
                                widget.email,
                                widget.contact,
                                widget.country
                              ),
                              paymentMode: 2,
                              currencyType: FFAppState().currencyName,
                              deliveryCharges: 90,
                              coupenCode: '',
                              coupenAmount: 0,
                              giftId: '',
                              rewardUsed: false,
                              pendingamount: 365,
                              rewardPoints: 0,
                              products: products, // Pass the List<Product> directly
                              customerInstructions: '',
                              shippingType: 'Fedex/DHL',
                              digitalSource: 'not sponsored',
                            );

                            print('API Call Result:');
                            if (apiResponse == null) {
                              print('API response is null');
                            } else {
                              print('Raw Response: ${apiResponse.jsonBody}');
                              print('Response Data: ${apiResponse.response}');
                              print('Response Headers: ${apiResponse.headers}');
                              print('Status Code: ${apiResponse.statusCode}');
                            }

                            FFAppState().intinvoiceNumber = AddOrderCall.invoiceNo(
                              (_model.apiResult3lf?.jsonBody),
                            )!;
                            print('Invoice Number: ${FFAppState().intinvoiceNumber}');
                            print('Cart Amount: ${FFAppState().cartAmount}');
                            setState(() {});
                            setState(() {});
                          },*/
                          text: 'Select Payment Method',
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
                              fontWeight: FontWeight.w600,
                            ),
                            elevation: 0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    )
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
            );
          },
        ),
      ),
    );
  }
}
