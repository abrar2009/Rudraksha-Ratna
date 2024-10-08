import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rudraksha_cart/backend/schema/structs/index.dart';
import '../auth/custom_auth/auth_util.dart';
import '../custom_code/selected_options.dart';
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
    /*required this.billingAddress1,
    required this.billingAddress2,
    required this.billingCity,
    required this.billingState,
    required this.billingPincode,
    required this.billingAddressId,*/
    required this.initialRewardPoints
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
  /*final String? billingAddress1;
  final String? billingAddress2;
  final String? billingCity;
  final String? billingState;
  final String? billingPincode;
  final int? billingAddressId;*/
  final int initialRewardPoints;

  @override
  State<SelectPaymentMethodWidget> createState() =>
      _SelectPaymentMethodWidgetState();
}

class _SelectPaymentMethodWidgetState extends State<SelectPaymentMethodWidget> {
  late SelectPaymentMethodModel _model;
  String? _invoiceNumber;
  num? rewardPoints;
  num? rewardPointsforapi;
  //ApiCallResponse? columnBuyNowResponse;
  late List<Product> products;
  int? checkboxFinalPoints;
  int? checkboxRewardPoints;
  int? checkBoxOrderTotal;
  bool useRewardsPoints = false;
  late int earnedRewardPoints;

  @override
  void initState() {
    super.initState();
    // Fetch the initial data when the screen loads
    _initializeData();

    checkboxFinalPoints = FFAppState().finalAmount.toInt();
    checkBoxOrderTotal = FFAppState().orderTotal!.toInt();
    _model = createModel(context, () => SelectPaymentMethodModel());

    setState(() {});
    _fetchData(checkboxFinalPoints!, checkBoxOrderTotal!);
    setState(() {});
    earnedRewardPoints = widget.initialRewardPoints;
  }

  Future<void> _initializeData() async {
    try {
      // Fetch initial data
      await _fetchData(FFAppState().finalAmount.toInt(), FFAppState().orderTotal!.toInt());

      // Update the state after fetching the data
      setState(() {
        _model.checkboxValue2 = false; // Initial state of checkbox
      });
    } catch (e) {
      print('Error initializing data: $e');
    }
  }

  Future<void> _fetchData(int totalAmount, int orderTotal) async {
    try {
      final response = await FetchShippingCall.call(
        hosturl: FFAppConstants.hosturl,
        shippingCountry: FFAppState().countryName,
        shippingWeight: FFAppState().courierTotal,
        totalPrice: totalAmount,
        orderTotal: orderTotal,
      );

      print('Total amount for check box: $totalAmount');
      print('Order amount for check box: $orderTotal');

      final requestData = {
        'hosturl': FFAppConstants.hosturl,
        'shippingCountry': FFAppState().countryName,
        'shippingWeight': FFAppState().courierTotal,
        'totalPrice': totalAmount,
        'orderTotal': orderTotal,
      };

      print('Shipping API Request Data22222: $requestData');
      print(FFAppState().countryName);
      print(FFAppState().courierTotal);
      print(FFAppState().cartTotal);
      print(FFAppState().orderTotal);

      FFAppState().rewardPoints = getJsonField(
        (response.jsonBody ?? ''),
        r'''$.shippingdata[0].rewards_point''',
      ).toInt();

      print('Rewards on check box: ${FFAppState().rewardPoints}');
      print('Shipping API Response: ${response.jsonBody ?? 'No response'}');
    } catch (e) {
      print('Error fetching shipping data: $e');
    }
  }

  /*Future<void> _fetchData() async {
    try {
      final response = await FetchShippingCall.call(
        hosturl: FFAppConstants.hosturl,
        shippingCountry: FFAppState().countryName,
        shippingWeight: FFAppState().courierTotal,
        totalPrice: FFAppState().finalAmount.toInt(),
        orderTotal: FFAppState().finalAmount.toInt(),
      );

      final requestData = {
        'hosturl': FFAppConstants.hosturl,
        'shippingCountry': FFAppState().countryName,
        'shippingWeight': FFAppState().courierTotal,
        'totalPrice': FFAppState().finalAmount.toInt(),
        'orderTotal': FFAppState().finalAmount.toInt(),
      };

      print('Shipping API Request Data: $requestData');

      FFAppState().rewardPoints = getJsonField(
        (response.jsonBody ?? ''),
        r'''$.shippingdata[0].rewards_point''', // Adjusted JSON path for single item in array
      ).toInt();

      print('Rewards on check box: ${FFAppState().rewardPoints}');

      // Optionally, you can handle any additional logic or state updates here
      print('Shipping API Response: ${response.jsonBody ?? 'No response'}');
    } catch (e) {
      print('Error fetching shipping data: $e');
    }
  }*/


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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: Offset(0, 4), // Move shadow downwards by 4 pixels
                  blurRadius: 6, // Blur radius for a softer shadow
                  spreadRadius: 1, // Spread radius for shadow expansion
                ),
              ],
            ),
            child: AppBar(
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
                  /*context.pushReplacement(
                    'DeliveryAddress',
                    extra: <String, dynamic>{
                      kTransitionInfoKey: TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.fade,
                        duration: Duration(milliseconds: 0),
                      ),
                    },
                  );*/
                },
              ),
              title: Text(
                'Select Payment Method',
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
          ),
        ),
        body: FutureBuilder<ApiCallResponse>(
          future: CartCall.call(
              hosturl: FFAppConstants.hosturl,
              token: currentAuthenticationToken),
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
                FutureBuilder<ApiCallResponse>(
                    future: BuyNowCall.call(
                      hosturl: FFAppConstants.hosturl,
                      token: currentAuthenticationToken,
                      productid: FFAppState().productid,
                      productType: FFAppState().productType,
                      productvariation: FFAppState().productvariation,
                      productvariationId: FFAppState().productvariationId,
                      quantity: FFAppState().quantity,
                      design: FFAppState().desingId,
                      energization: FFAppState().energizationId,
                      certification: (FFAppState().selectedCertificationId ?? '0').toString(),
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
                      final columnBuyNowResponse = snapshot.data!;
                      print("columnBuyNowResponse.statuscode${columnBuyNowResponse.statusCode}");
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            //height: MediaQuery.sizeOf(context).height * 0.7,
                            height: MediaQuery.sizeOf(context).height * 0.72,
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
                                      if (FFAppState().buynow == false) {
                                        return Builder(
                                          builder: (context) {
                                            final cartList = getJsonField(
                                              stackCartResponse.jsonBody,
                                              r'''$.data''',
                                            ).toList();
                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(cartList.length, (cartListIndex) {
                                                final cartListItem = cartList[cartListIndex];
                                                return InkWell(
                                                  splashColor: Colors.transparent,
                                                  focusColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  onTap: () async {
                                                    _model.slugvalue = getJsonField(
                                                      cartListItem,
                                                      r'''$.slug_value''',).toString();
                                                    setState(() {});
                                                    _model.apiResulth6o = await SlugSearchCall.call(
                                                      hosturl: FFAppConstants.hosturl,
                                                      slugValue: getJsonField(
                                                        cartListItem,
                                                        r'''$.slug_value''',
                                                      ).toString(),
                                                    );
                                                    _model.mainprodtype = SlugSearchCall.datamainprodtype(
                                                      (_model.apiResulth6o?.jsonBody ?? ''),
                                                    );
                                                    _model.level = SlugSearchCall.datalevel(
                                                      (_model.apiResulth6o?.jsonBody ?? ''),
                                                    );
                                                    _model.productlist = SlugSearchCall.dataproductlist(
                                                      (_model.apiResulth6o?.jsonBody ?? ''),
                                                    )!;
                                                    setState(() {
                                                      print("_model.mainprodtype${_model.mainprodtype}");
                                                      print("_model.level${_model.level}");
                                                      print("_model.productlist${_model.productlist}");
                                                    });
                                                    print('Cart id while passing from select payment method screen : ${getJsonField(cartListItem,
                                                      r'''$.cart_id''',).toString()}');
                                                    if (_model.mainprodtype == 5) {
                                                      context.pushNamed(
                                                        'OtherProductDetails',
                                                        queryParameters: {
                                                          'productSlugValue': serializeParam(
                                                            getJsonField(
                                                              cartListItem, r'''$.slug_value''',).toString(),
                                                            ParamType.String,
                                                          ),
                                                          'producttype': FFAppConstants.RudrakshaMasterProductDetailsApi,
                                                          'isFromPaymentScreen': serializeParam(
                                                            true,
                                                            ParamType.bool,
                                                          ),
                                                          'cartId': serializeParam(
                                                            getJsonField(cartListItem,
                                                              r'''$.cart_id''',).toString(),
                                                            ParamType.String,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String, dynamic>{
                                                          kTransitionInfoKey: TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType: PageTransitionType.bottomToTop,
                                                            duration: Duration(milliseconds: 400),
                                                          ),
                                                        },
                                                      );
                                                    } else if (_model.mainprodtype == 3) {
                                                      context.pushNamed(
                                                        'DiamondProductDetails',
                                                        queryParameters: {
                                                          'productSlugValue': serializeParam(
                                                            getJsonField(
                                                              cartListItem, r'''$.slug_value''',
                                                            ).toString(),
                                                            ParamType.String,
                                                          ),
                                                          'producttype': FFAppConstants.RudrakshaMasterProductDetailsApi,
                                                          'isFromPaymentScreen': serializeParam(
                                                            true,
                                                            ParamType.bool,
                                                          ),
                                                          'cartId': serializeParam(
                                                            getJsonField(cartListItem,
                                                              r'''$.cart_id''',).toString(),
                                                            ParamType.String,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String, dynamic>{
                                                          kTransitionInfoKey: TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType: PageTransitionType.bottomToTop,
                                                            duration: Duration(milliseconds: 400),
                                                          ),
                                                        },
                                                      );
                                                    } else if (_model.mainprodtype == 4) {
                                                      context.pushNamed(
                                                        'YantraProductDetails',
                                                        queryParameters: {
                                                          'productSlugValue': serializeParam(
                                                            getJsonField(cartListItem,
                                                              r'''$.slug_value''',).toString(),
                                                            ParamType.String,
                                                          ),
                                                          'producttype': FFAppConstants.YantraMasterProductDetailsApi,
                                                          'isFromPaymentScreen': serializeParam(
                                                            true,
                                                            ParamType.bool,
                                                          ),
                                                          'cartId': serializeParam(
                                                            getJsonField(cartListItem,
                                                              r'''$.cart_id''',).toString(),
                                                            ParamType.String,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    } else if (_model.mainprodtype == 1) {
                                                      context.pushNamed(
                                                        'PujaProductDetails',
                                                        queryParameters: {
                                                          'productSlugValue': serializeParam(
                                                            getJsonField(cartListItem,
                                                              r'''$.slug_value''',).toString(),
                                                            ParamType.String,
                                                          ),
                                                          'producttype': FFAppConstants.PujaMasterProductDetailsApi,
                                                        }.withoutNulls,
                                                        extra: <String, dynamic>{
                                                          kTransitionInfoKey: TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType: PageTransitionType.bottomToTop,
                                                            duration: Duration(milliseconds: 400),
                                                          ),
                                                        },
                                                      );
                                                    } else {
                                                      context.pushNamed(
                                                        'DiamondProductDetails',
                                                        queryParameters: {
                                                          'productSlugValue': serializeParam(
                                                            getJsonField(cartListItem,
                                                              r'''$.slug_value''',).toString(),
                                                            ParamType.String,
                                                          ),
                                                          'producttype': FFAppConstants.GemstoneMasterProductDetailsApi,
                                                          'isFromPaymentScreen': serializeParam(
                                                            true,
                                                            ParamType.bool,
                                                          ),
                                                          'cartId': serializeParam(
                                                            getJsonField(cartListItem,
                                                              r'''$.cart_id''',).toString(),
                                                            ParamType.String,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String, dynamic>{
                                                          kTransitionInfoKey: TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType: PageTransitionType.bottomToTop,
                                                            duration: Duration(milliseconds: 400),
                                                          ),
                                                        },
                                                      );
                                                    }
                                                    ;
                                                  },
                                                  child: Container(
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
                                                              getJsonField(cartListItem,
                                                                r'''$.thumbnail_image''',).toString(),
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
                                                                    getJsonField(cartListItem,
                                                                      r'''$.product_name''',
                                                                    ).toString(),
                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                                                  ),
                                                );
                                              }),
                                            );
                                          },
                                        );
                                      } else {
                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                onTap: () async {
                                                  _model.slugvalue = getJsonField(
                                                    columnBuyNowResponse.jsonBody,
                                                    r'''$.data[:].slug_value''',).toString();
                                                  setState(() {});
                                                  _model.apiResulth6o = await SlugSearchCall.call(
                                                    hosturl: FFAppConstants.hosturl,
                                                    slugValue: getJsonField(
                                                      columnBuyNowResponse.jsonBody,
                                                      r'''$.data[:].slug_value''',).toString());
                                                  _model.mainprodtype = SlugSearchCall.datamainprodtype(
                                                    (_model.apiResulth6o?.jsonBody ?? ''),
                                                  );
                                                  _model.level = SlugSearchCall.datalevel(
                                                    (_model.apiResulth6o?.jsonBody ?? ''),
                                                  );
                                                  _model.productlist = SlugSearchCall.dataproductlist(
                                                    (_model.apiResulth6o?.jsonBody ?? ''),
                                                  )!;
                                                  setState(() {
                                                    print("_model.mainprodtype${_model.mainprodtype}");
                                                    print("_model.level${_model.level}");
                                                    print("_model.productlist${_model.productlist}");
                                                    print("_model.slugvalue ${_model.slugvalue}");
                                                    print("slug_value y8tyttrdkgh: ${getJsonField(
                                                      columnBuyNowResponse,
                                                      r'''$.slug_value''',).toString()}");
                                                  });
                                                  if (_model.mainprodtype == 5) {
                                                    context.pushNamed(
                                                      'OtherProductDetails',
                                                      queryParameters: {
                                                        /*'productSlugValue': serializeParam(
                                                          getJsonField(
                                                            columnBuyNowResponse.jsonBody,
                                                            r'''$.slug_value''',).toString(),
                                                          ParamType.String,
                                                        ),*/
                                                        'productSlugValue': serializeParam(
                                                          _model.slugvalue,
                                                          ParamType.String,
                                                        ),
                                                        'outofstockValue': serializeParam(
                                                          getJsonField(
                                                            columnBuyNowResponse.jsonBody,
                                                            r'''$.out_of_stock''',).toString(),
                                                          ParamType.String,
                                                        ),
                                                      }.withoutNulls,
                                                      extra: <String, dynamic>{
                                                        kTransitionInfoKey: TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType: PageTransitionType.bottomToTop,
                                                        ),
                                                      },
                                                    );
                                                  } else if (_model.mainprodtype == 3) {
                                                    context.pushNamed(
                                                      'DiamondProductDetails',
                                                      queryParameters: {
                                                        'productSlugValue': serializeParam(
                                                          getJsonField(
                                                            columnBuyNowResponse.jsonBody,
                                                            r'''$.data[:].slug_value''',).toString(),
                                                          ParamType.String,
                                                        ),
                                                        'producttype': FFAppConstants.RudrakshaMasterProductDetailsApi,
                                                      }.withoutNulls,
                                                      extra: <String, dynamic>{
                                                        kTransitionInfoKey: TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType: PageTransitionType.bottomToTop,
                                                          duration: Duration(milliseconds: 400),
                                                        ),
                                                      },
                                                    );
                                                  } else if (_model.mainprodtype == 4) {
                                                    context.pushNamed(
                                                      'YantraProductDetails',
                                                      queryParameters: {
                                                        'productSlugValue': serializeParam(
                                                          getJsonField(
                                                            columnBuyNowResponse.jsonBody,
                                                            r'''$.data[:].slug_value''',).toString(),
                                                          ParamType.String,
                                                        ),
                                                        'producttype': FFAppConstants.YantraMasterProductDetailsApi,
                                                      }.withoutNulls,
                                                    );
                                                  } else if (_model.mainprodtype == 1) {
                                                    context.pushNamed(
                                                      'PujaProductDetails',
                                                      queryParameters: {
                                                        'productSlugValue': serializeParam(
                                                          getJsonField(
                                                            columnBuyNowResponse.jsonBody,
                                                            r'''$.data[:].slug_value''',).toString(),
                                                          ParamType.String,
                                                        ),
                                                        'producttype': FFAppConstants.PujaMasterProductDetailsApi,
                                                      }.withoutNulls,
                                                      extra: <String, dynamic>{
                                                        kTransitionInfoKey: TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType: PageTransitionType.bottomToTop,
                                                          duration: Duration(milliseconds: 400),
                                                        ),
                                                      },
                                                    );
                                                  } else {
                                                    context.pushNamed(
                                                      'DiamondProductDetails',
                                                      queryParameters: {
                                                        'productSlugValue': serializeParam(
                                                          getJsonField(
                                                            columnBuyNowResponse.jsonBody,
                                                            r'''$.data[:].slug_value''',).toString(),
                                                          ParamType.String,
                                                        ),
                                                        'producttype': FFAppConstants.GemstoneMasterProductDetailsApi,
                                                      }.withoutNulls,
                                                      extra: <String, dynamic>{
                                                        kTransitionInfoKey: TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType: PageTransitionType.bottomToTop,
                                                          duration: Duration(milliseconds: 400),
                                                        ),
                                                      },
                                                    );
                                                  };
                                                },
                                                child: Container(
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
                                                          child: CachedNetworkImage(
                                                            fadeInDuration: Duration(milliseconds: 100),
                                                            fadeOutDuration: Duration(milliseconds: 100),
                                                            imageUrl: getJsonField(
                                                              columnBuyNowResponse.jsonBody,
                                                              r'''$.data[0].thumbnail_image''',
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
                                                                width: 220,
                                                                child: Text(
                                                                  getJsonField(
                                                                    columnBuyNowResponse.jsonBody,
                                                                    r'''$.data[:].product_name''',
                                                                  ).toString(),
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    fontFamily: 'Montserrat',
                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                    fontSize: 13,
                                                                    letterSpacing: 0,
                                                                    fontWeight:
                                                                    FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                'View Details',
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                  // Generated code for this Container Widget...
                                  Container(
                                    width: double.infinity,
                                    //height: 159,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      border: Border.all(
                                        color: Color(0xFFE7E7E8),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 12, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Ship to:    ',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF696969),
                                                      fontSize: 15,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  //SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                                                ],
                                              ),
                                              Container(
                                                width: 240,
                                                decoration: BoxDecoration(),
                                                child: Text(
                                                  '${FFAppState().shippingAddress1}, ${FFAppState().shippingAddress2}, ${FFAppState().shippingCity}, ${FFAppState().shippingState}, ${FFAppState().shippingPincode}',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Montserrat',
                                                    letterSpacing: 0,
                                                    lineHeight: 1.3,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: FlutterFlowTheme.of(context).primaryText
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 12),
                                                child: InkWell(
                                                  splashColor: Colors.transparent,
                                                  focusColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  onTap: () async {
                                                    /*context.pushNamed(
                                                      'DeliveryAddress',
                                                      extra: <String, dynamic>{
                                                        kTransitionInfoKey: TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType: PageTransitionType.rightToLeft,
                                                          duration: Duration(milliseconds: 400),
                                                        ),
                                                      },
                                                    );*/
                                                    context.pushNamed(
                                                      'DeliveryAddress',
                                                      queryParameters: {
                                                        'fromScreen': serializeParam('SelectPaymentMethod', ParamType.String),
                                                      }.withoutNulls,
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                    size: 20,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        if (FFAppState().billingAddress1!.isNotEmpty &&
                                            FFAppState().billingAddress2!.isNotEmpty &&
                                            FFAppState().billingCity!.isNotEmpty &&
                                            FFAppState().billingState!.isNotEmpty &&
                                            FFAppState().billingPincode!.isNotEmpty)
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 12, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Bill to:    ',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF696969),
                                                      fontSize: 15,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  //SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                                                ],
                                              ),
                                              Container(
                                                width: 240,
                                                decoration: BoxDecoration(),
                                                child: Text(
                                                  '${FFAppState().billingAddress1}, ${FFAppState().billingAddress2}, ${FFAppState().billingCity}, ${FFAppState().billingState}-${FFAppState().billingPincode}',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      letterSpacing: 0,
                                                      lineHeight: 1.3,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w500,
                                                      color: FlutterFlowTheme.of(context).primaryText
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 12),
                                                child: InkWell(
                                                  splashColor: Colors.transparent,
                                                  focusColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  onTap: () async {
                                                    context.pushNamed(
                                                      'BillingAddress',
                                                      extra: <String, dynamic>{
                                                        kTransitionInfoKey: TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType: PageTransitionType.rightToLeft,
                                                          duration: Duration(milliseconds: 400),
                                                        ),
                                                      },
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                    size: 20,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        /*if (FFAppState().billingAddress1!.isNotEmpty &&
                                            FFAppState().billingAddress2!.isNotEmpty &&
                                            FFAppState().billingCity!.isNotEmpty &&
                                            FFAppState().billingState!.isNotEmpty &&
                                            FFAppState().billingPincode!.isNotEmpty)
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(16, 10, 12, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Bill to: ',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
                                                        color: Color(0xFF696969),
                                                        fontSize: 15,
                                                        letterSpacing: 0,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                                                  ],
                                                ),
                                                Container(
                                                  width: 280,
                                                  decoration: BoxDecoration(),
                                                  child: Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(),
                                                    child: Text(
                                                      '${FFAppState().billingAddress1}, ${FFAppState().billingAddress2}, ${FFAppState().billingCity}, ${FFAppState().billingState}-${FFAppState().billingPincode}',
                                                      maxLines: 3,
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
                                                        letterSpacing: 0,
                                                        fontSize: 15,
                                                        lineHeight: 1.3,
                                                        fontWeight: FontWeight.w500,
                                                        color: FlutterFlowTheme.of(context).primaryText
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
                                                    context.pushNamed(
                                                      'BillingAddress',
                                                      extra: <String, dynamic>{
                                                        kTransitionInfoKey: TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType: PageTransitionType.rightToLeft,
                                                          duration: Duration(milliseconds: 400),
                                                        ),
                                                      },
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                    size: 20,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),*/
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            //mainAxisAlignment: MainAxisAlignment.center,
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
                                                  unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                                                ),
                                                child: Checkbox(
                                                  value: _model.checkboxValue1 ??= false,
                                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                  visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                                                  onChanged: (newValue) async {
                                                    //setState(() => _model.checkboxValue1 = newValue!);
                                                    setState(() {_model.checkboxValue1 = newValue!;
                                                      if (_model.checkboxValue1 == true) {
                                                        FFAppState().billingAddress1 = FFAppState().shippingAddress1;
                                                        FFAppState().billingAddressID = FFAppState().shippingAddressID;
                                                        FFAppState().billingAddress2 = FFAppState().shippingAddress2;
                                                        FFAppState().billingCity = FFAppState().shippingCity;
                                                        FFAppState().billingState = FFAppState().shippingState;
                                                        FFAppState().billingPincode = FFAppState().shippingPincode;
                                                        print('Billing address set to shipping address');
                                                        print('Billing address set to shipping address: ${FFAppState().billingAddress1}');
                                                      } else {
                                                        FFAppState().billingAddress1 = '';
                                                        FFAppState().billingAddress2 = '';
                                                        FFAppState().billingCity = '';
                                                        FFAppState().billingState = '';
                                                        FFAppState().billingPincode = '';
                                                        print('Billing address cleared');
                                                      }
                                                    });
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
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Generated code for this Container Widget...
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                'BillingAddress',
                                                extra: <String, dynamic>{
                                                  kTransitionInfoKey: const TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType: PageTransitionType.rightToLeft,
                                                    duration: Duration(milliseconds: 400),
                                                  ),
                                                },
                                              );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 16, right: 16),
                                              child: Container(
                                                width: double.infinity,
                                                height: 48,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFE7E7E8),
                                                  borderRadius: BorderRadius.circular(4),
                                                  border: Border.all(
                                                    color: Color(0xFFE7E7E8),
                                                  ),
                                                ),
                                                child: Align(
                                                  alignment: AlignmentDirectional(0, 0),
                                                  child: Text(
                                                    '+ Add billing address',
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
                                            ),
                                          ),
                                        )
                                      ].divide(SizedBox(height: 5)),
                                    ),
                                  ),
                                  if (FFAppState().couponCodeList.isNotEmpty && _model.checkboxValue2 == false )
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
                                              onTap: () => _model.unfocusNode
                                                      .canRequestFocus
                                                  ? FocusScope.of(context)
                                                      .requestFocus(
                                                          _model.unfocusNode)
                                                  : FocusScope.of(context)
                                                      .unfocus(),
                                              child: Padding(
                                                padding:
                                                    MediaQuery.viewInsetsOf(
                                                        context),
                                                child:
                                                    FreeGiftComponentWidget(),
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
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 14, 16, 14),
                                          child: Container(
                                            width: 343,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16, 0, 0, 0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.asset(
                                                          'assets/images/Vector.png',
                                                          width: 19.98,
                                                          height: 19.98,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  25, 0, 0, 0),
                                                      child: Text(
                                                        'Apply Coupon',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: 16,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 22,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (FFAppState().freeGiftsList.isNotEmpty)
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
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (context) {
                                                return GestureDetector(
                                                  onTap: () => _model
                                                          .unfocusNode
                                                          .canRequestFocus
                                                      ? FocusScope.of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode)
                                                      : FocusScope.of(context)
                                                          .unfocus(),
                                                  child: Padding(
                                                    padding:
                                                        MediaQuery.viewInsetsOf(
                                                            context),
                                                    child: Container(
                                                      height: 734,
                                                      child:
                                                          const SelectFreeGiftWidget(),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then(
                                                (value) => safeSetState(() {}));
                                          },
                                          child: Container(
                                            width: 343,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16, 0, 0, 0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  0),
                                                          topRight:
                                                              Radius.circular(
                                                                  0),
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
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  25, 0, 0, 0),
                                                      child: Text(
                                                        'Select a Free Gift',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: 16,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: FlutterFlowTheme.of(
                                                          context)
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Order Summary',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 16,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 9, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Product',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 15,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                                Text(
                                                  'Amount',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 15,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Builder(
                                            builder: (context) {
                                              if (FFAppState().buynow ==
                                                  false) {
                                                return Builder(
                                                  builder: (context) {
                                                    final cartProducts =
                                                        getJsonField(
                                                      stackCartResponse
                                                          .jsonBody,
                                                      r'''$.data''',
                                                    ).toList();
                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: List.generate(
                                                          cartProducts.length,
                                                          (cartProductsIndex) {
                                                        final cartProductsItem =
                                                            cartProducts[
                                                                cartProductsIndex];

                                                        return Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      9, 0, 0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
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
                                                                        color: Color(
                                                                            0xFF222222),
                                                                        fontSize:
                                                                            14,
                                                                        letterSpacing:
                                                                            0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        -1, 0),
                                                                child: Text(
                                                                  '${valueOrDefault<String>(
                                                                    FFAppState()
                                                                        .currencyName,
                                                                    'INR',
                                                                  )} ${formatNumber(
                                                                    currencyConversion(
                                                                        FFAppState()
                                                                            .currencyRate,
                                                                        getJsonField(
                                                                          cartProductsItem,
                                                                          r'''$.selling_price''',
                                                                        ).toString()),
                                                                    formatType:
                                                                        FormatType
                                                                            .decimal,
                                                                    decimalType:
                                                                        DecimalType
                                                                            .automatic,
                                                                  )}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        color: Color(
                                                                            0xFF222222),
                                                                        fontSize:
                                                                            14,
                                                                        letterSpacing:
                                                                            0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                    );
                                                  },
                                                );
                                              } else {
                                                return Builder(
                                                  builder: (context) {
                                                    return Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 250,
                                                          child: Text(
                                                            getJsonField(
                                                              columnBuyNowResponse
                                                                  .jsonBody,
                                                              r'''$.data[:].product_name''',
                                                            ).toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  color: Color(
                                                                      0xFF222222),
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                        ),
                                                        Text(
                                                          getJsonField(
                                                            columnBuyNowResponse
                                                                .jsonBody,
                                                            r'''$.data[:].selling_price''',
                                                          ).toString(),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Color(
                                                                    0xFF222222),
                                                                fontSize: 14,
                                                                letterSpacing:
                                                                    0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                          ),
                                          Builder(
                                            builder: (context) {
                                              if (FFAppState().buynow ==
                                                  false) {
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 9, 0, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Subtotal',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color(
                                                                  0xFF222222),
                                                              fontSize: 14,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1, 0),
                                                        child: Text(
                                                          '${valueOrDefault<String>(
                                                            FFAppState()
                                                                .currencyName,
                                                            'INR',
                                                          )} ${formatNumber(
                                                            currencyConversion(
                                                                FFAppState()
                                                                    .currencyRate,
                                                                getJsonField(
                                                                  stackCartResponse
                                                                      .jsonBody,
                                                                  r'''$.cart_total''',
                                                                ).toString()),
                                                            formatType:
                                                                FormatType
                                                                    .decimal,
                                                            decimalType:
                                                                DecimalType
                                                                    .automatic,
                                                          )}',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Color(
                                                                    0xFF222222),
                                                                fontSize: 14,
                                                                letterSpacing:
                                                                    0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              } else {
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 9, 0, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Subtotal',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color(
                                                                  0xFF222222),
                                                              fontSize: 14,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1, 0),
                                                        child: Text(
                                                          '${valueOrDefault<String>(
                                                            FFAppState()
                                                                .currencyName,
                                                            'INR',
                                                          )} ${formatNumber(
                                                            currencyConversion(
                                                                FFAppState()
                                                                    .currencyRate,
                                                                getJsonField(
                                                                  columnBuyNowResponse
                                                                      .jsonBody,
                                                                  r'''$.data[:].productsubtotal''',
                                                                ).toString()),
                                                            formatType:
                                                                FormatType
                                                                    .decimal,
                                                            decimalType:
                                                                DecimalType
                                                                    .automatic,
                                                          )}',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Color(
                                                                    0xFF222222),
                                                                fontSize: 14,
                                                                letterSpacing:
                                                                    0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                          if (FFAppState().couponCode.isNotEmpty)
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 9, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Discount',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color:
                                                              Color(0xFF009D48),
                                                          fontSize: 14,
                                                          letterSpacing: 0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                  /*currencyConversion(FFAppState().currencyRate, getJsonField(stackCartResponse.jsonBody, r'''$.cart_total''',
                                                ) * (FFAppState().couponValue / 100))*/
                                                  /*Text(
                                                  '-${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatNumber(
                                                    currencyConversion(FFAppState().currencyRate, getJsonField(stackCartResponse.jsonBody, r'''$.cart_total''',
                                                    ) * (FFAppState().couponValue / 100)),
                                                      formatType: FormatType.decimal,
                                                      decimalType: DecimalType.automatic,
                                                    )}',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF009D48),
                                                    fontSize: 14,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )*/
                                                  if (FFAppState().buynow == false)
                                                    Text(
                                                      '-${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatNumber(
                                                        currencyConversion(
                                                          FFAppState().currencyRate,
                                                          (
                                                              (getJsonField(stackCartResponse.jsonBody, r'''$.cart_total''') ?? 0.0) *
                                                                  (FFAppState().couponValue ?? 0.0) / 100
                                                          ).toString(),
                                                        ),
                                                        formatType: FormatType.decimal,
                                                        decimalType: DecimalType.automatic,
                                                      )}',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
                                                        color: const Color(0xFF009D48),
                                                        fontSize: 14,
                                                        letterSpacing: 0,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),

                                                  if (FFAppState().buynow ==
                                                      true)
                                                    Text(
                                                      '-${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatNumber(
                                                        currencyConversion(
                                                            FFAppState()
                                                                .currencyRate,
                                                            ((getJsonField(
                                                                            columnBuyNowResponse
                                                                                .jsonBody,
                                                                            r'''$.cart_total''')
                                                                        as double) *
                                                                    (FFAppState()
                                                                            .couponValue /
                                                                        100))
                                                                .toString()),
                                                        formatType:
                                                            FormatType.decimal,
                                                        decimalType: DecimalType
                                                            .automatic,
                                                      )}',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: const Color(
                                                                0xFF009D48),
                                                            fontSize: 14,
                                                            letterSpacing: 0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    )
                                                ],
                                              ),
                                            ),
                                          if (FFAppState().selectedGiftName!.isNotEmpty)
                                            Padding(
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
                                                      '${FFAppState().selectedGiftName}',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: Color(
                                                                0xFF009D48),
                                                            fontSize: 14,
                                                            letterSpacing: 0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Free Gift',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color:
                                                              Color(0xFF009D48),
                                                          fontSize: 14,
                                                          letterSpacing: 0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 9, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Shipping Charges',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF222222),
                                                    fontSize: 14,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                                Text(
                                                  '${valueOrDefault<String>(
                                                    FFAppState().currencyName,
                                                    'INR',
                                                  )} ${formatNumber(
                                                    currencyConversion(FFAppState().currencyRate, FFAppState().shippingAmount!.toString()),
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
                                                //if(FFAppState().finalAmount != 0.0)
                                                Text(
                                                  '${valueOrDefault<String>(
                                                  FFAppState().currencyName,
                                                  'INR',
                                                  )} ${formatNumber(
                                                  currencyConversion(
                                                  FFAppState().currencyRate,
                                                  earnedRewardPoints.toString()),
                                                  formatType: FormatType.decimal,
                                                  decimalType: DecimalType.automatic,
                                                  )}',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Montserrat',
                                                    color: FlutterFlowTheme.of(context).primary,
                                                    fontSize: 14,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                                /*Text(
                                                  '${valueOrDefault<String>(
                                                  FFAppState().currencyName,
                                                  'INR',
                                                  )} ${formatNumber(
                                                  currencyConversion(
                                                  FFAppState().currencyRate,
                                                  FFAppState().rewardPoints.toString()),
                                                  formatType: FormatType.decimal,
                                                  decimalType: DecimalType.automatic,
                                                  )}',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Montserrat',
                                                    color: FlutterFlowTheme.of(context).primary,
                                                    fontSize: 14,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),*/
                                              ],
                                            ),
                                          ),
                                          //if (rewardPointsforapi != 0.0)
                                          FutureBuilder<ApiCallResponse>(
                                            future: CustomerDetailsCall.call(
                                              token: currentAuthenticationToken,
                                              hosturl: FFAppConstants.hosturl,
                                            ),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child: SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child:
                                                        CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                              final columnCustomerDetailsResponse =
                                                  snapshot.data!;
                                              rewardPointsforapi = getJsonField(
                                                    columnCustomerDetailsResponse
                                                        .jsonBody,
                                                    r'''$.data.reward_points''',
                                                  ) ??
                                                  0.0;
                                              rewardPointsforapi = getJsonField(
                                                    columnCustomerDetailsResponse
                                                        .jsonBody,
                                                    r'''$.data.reward_points''',
                                                  ) ??
                                                  0.0;
                                              print("rewardPointsforapi : ${rewardPointsforapi}");
                                              print("FFAppState().rewardPointsprofil ${FFAppState().rewardPointsprofile.toString()}");
                                              return Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  if (FFAppState().rewardPointsprofile.toString() != '0' && FFAppState().couponCode.isEmpty)
                                                  //if (FFAppState().couponCode.isEmpty)
                                                    if (rewardPointsforapi != 0.0)
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.start,
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
                                                                  unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                                                                ),
                                                                child: /*Checkbox(
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
                                                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                  visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                                                                ),*/
                                                                Checkbox(
                                                                  value: _model.checkboxValue2 ??= false,
                                                                  onChanged: (newValue) async {
                                                                    setState(() {
                                                                      _model.checkboxValue2 = newValue!;
                                                                    });

                                                                    // Determine the updated total amount
                                                                    int updatedTotalAmount;
                                                                    int updatedOrderTotal;
                                                                    if (_model.checkboxValue2 == true) {
                                                                      updatedTotalAmount = FFAppState().finalAmount.toInt() - rewardPointsforapi!.toInt();
                                                                      updatedOrderTotal = FFAppState().orderTotal!.toInt() - rewardPointsforapi!.toInt();
                                                                      print('subtracted updatedOrderTotal: $updatedOrderTotal');
                                                                    } else {
                                                                      updatedTotalAmount = FFAppState().finalAmount.toInt() + rewardPointsforapi!.toInt();
                                                                      updatedOrderTotal = FFAppState().orderTotal!.toInt();
                                                                      print('added updatedOrderTotal: $updatedOrderTotal');
                                                                    }

                                                                    print('Updated Total Amount when checkbox: $updatedTotalAmount');
                                                                    print('Updated Order Amount when checkbox: $updatedOrderTotal');

                                                                    // Fetch the shipping data with the updated total amount
                                                                    await _fetchData(updatedTotalAmount, updatedOrderTotal);

                                                                    // Update the earnedRewardPoints based on the fetched reward points
                                                                    setState(() {
                                                                      earnedRewardPoints = FFAppState().rewardPoints!;
                                                                    });

                                                                    print('CheckBox: ${FFAppState().rewardPoints}');
                                                                    print('Reward Points Updated: ${FFAppState().rewardPoints}');
                                                                  },
                                                                  side: BorderSide(
                                                                    width: 2,
                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                  ),
                                                                  activeColor: Color(0xFF740074),
                                                                  checkColor: FlutterFlowTheme.of(context).info,
                                                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                  visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                                                                ),
                                                                /*Checkbox(
                                                                  value: _model.checkboxValue2 ??= false,
                                                                  onChanged: (newValue) async {
                                                                    setState(() {
                                                                      _model.checkboxValue2 = newValue!;
                                                                    });

                                                                    // Determine the updated total amount
                                                                    int updatedTotalAmount;
                                                                    if (_model.checkboxValue2 == true) {
                                                                      updatedTotalAmount = FFAppState().finalAmount.toInt() - rewardPointsforapi!.toInt();
                                                                    } else {
                                                                      updatedTotalAmount = FFAppState().finalAmount.toInt() + rewardPointsforapi!.toInt();
                                                                    }

                                                                    print('Updated Total Amount when checked box: $updatedTotalAmount}');

                                                                    // Fetch the shipping data with the updated total amount
                                                                    await _fetchData(updatedTotalAmount);

                                                                    print('CheckBox: ${FFAppState().rewardPoints}');
                                                                    print('Reward Points Updated: ${FFAppState().rewardPoints}');
                                                                  },
                                                                  side: BorderSide(
                                                                    width: 2,
                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                  ),
                                                                  activeColor: Color(0xFF740074),
                                                                  checkColor: FlutterFlowTheme.of(context).info,
                                                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                  visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                                                                ),*/
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
                                                          Container(
                                                            width: MediaQuery.sizeOf(context).height * 0.2,
                                                            child: Text(

                                                              //'Total points: ${rewardPoints.toString()}',
                                                              /*'${formatNumber(
                                                                currencyConversion(
                                                                    FFAppState()
                                                                        .currencyRate,
                                                                    FFAppState()
                                                                        .rewardPointsprofile
                                                                        .toString()),
                                                                formatType:
                                                                    FormatType
                                                                        .decimal,
                                                                decimalType:
                                                                    DecimalType
                                                                        .automatic,
                                                              )} (${valueOrDefault<String>(
                                                                FFAppState()
                                                                    .currencyName,
                                                                'INR',
                                                              )} ${formatNumber(
                                                                currencyConversion(
                                                                    FFAppState()
                                                                        .currencyRate,
                                                                    FFAppState()
                                                                        .rewardPointsprofile
                                                                        .toString()),
                                                                formatType:
                                                                    FormatType
                                                                        .decimal,
                                                                decimalType:
                                                                    DecimalType
                                                                        .automatic,
                                                              )})',*/
                                                              'Total points: ${valueOrDefault<String>(
                                                                FFAppState().currencyName, 'INR',
                                                              )} ${formatNumber(
                                                                currencyConversion(
                                                                    FFAppState().currencyRate,
                                                                    //FFAppState().rewardPointsprofile.toString()),
                                                                  rewardPointsforapi.toString()
                                                                ),
                                                                formatType: FormatType.decimal,
                                                                decimalType: DecimalType.automatic,
                                                              )}',
                                                              style: FlutterFlowTheme.of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily: 'Montserrat',
                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                    letterSpacing: 0,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                              textAlign: TextAlign.right
                                                              ,
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
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Order Total',
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Montserrat',
                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                          fontSize: 15,
                                                          letterSpacing: 0,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      Builder(
                                                        builder: (context) {
                                                          if (FFAppState().buynow == false) {
                                                            return Align(
                                                              alignment: AlignmentDirectional(-1, 0),
                                                              child: Builder(
                                                                builder:
                                                                    (context) {
                                                                  final cartTotal =
                                                                      currencyConversion(
                                                                    FFAppState().currencyRate, getJsonField(stackCartResponse.jsonBody,r'''$.cart_total''').toString(),
                                                                  )!;
                                                                  print(
                                                                      'cartTotal:${cartTotal}');
                                                                  final shippingAmount = currencyConversion(
                                                                    FFAppState().currencyRate,
                                                                    FFAppState().shippingAmount!.toDouble().toString(),
                                                                  )!;
                                                                  print('shippingAmount:${shippingAmount}');
                                                                  // Check if couponValue is valid
                                                                  final discountAmount = FFAppState().couponValue != null &&
                                                                      FFAppState().couponValue > 0
                                                                      ? getJsonField(stackCartResponse.jsonBody,
                                                                              r'''$.cart_total''') *
                                                                          (FFAppState().couponValue / 100) : 0.0;
                                                                  FFAppState().finalDiscount = discountAmount;
                                                                  print('discountAmount:${discountAmount}');
                                                                  final finalDiscount = currencyConversion(
                                                                    FFAppState().currencyRate,
                                                                    discountAmount.toString(),
                                                                  )!;
                                                                  print('finalDiscount:${finalDiscount}');

                                                                  double totalAmount = shippingAmount + cartTotal - finalDiscount;
                                                                  print('totalAmount:${totalAmount}');
                                                                  // Apply reward points deduction if the checkbox is selected
                                                                  // Apply reward points deduction if the checkbox is selected
                                                                  rewardPoints = _model.checkboxValue2 == true
                                                                      ? rewardPointsforapi : 0.0;

                                                                  print("rewardPoints : ${rewardPoints}");
                                                                  // Check if reward points exceed the total amount
                                                                  final finalAmount = (totalAmount - rewardPoints!)
                                                                      .clamp(0.0, double.infinity);
                                                                  // Store the final amount in FFAppState
                                                                  FFAppState().finalAmount = finalAmount;
                                                                  print("finalAmount :${finalAmount}");
                                                                  print("FFAppState().finalAmount :${FFAppState().finalAmount}");

                                                                  return Align(
                                                                    alignment: AlignmentDirectional(-1, 0),
                                                                    child: Text(
                                                                      '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(finalAmount.toStringAsFixed(2), 1)}',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Montserrat',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            fontSize:
                                                                                15,
                                                                            letterSpacing:
                                                                                0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          } else {
                                                            return Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      -1, 0),
                                                              child: Builder(
                                                                builder:
                                                                    (context) {
                                                                  final cartTotal =
                                                                      currencyConversion(
                                                                          FFAppState()
                                                                              .currencyRate,
                                                                          getJsonField(
                                                                            columnBuyNowResponse.jsonBody,
                                                                            r'''$.cart_total''',
                                                                          ).toString());
                                                                  print(
                                                                      'cartTotal:${cartTotal}');
                                                                  //final shippingAmount = FFAppState().shippingAmount!.toDouble();
                                                                  final shippingAmount =
                                                                      currencyConversion(
                                                                    FFAppState()
                                                                        .currencyRate,
                                                                    FFAppState()
                                                                        .shippingAmount!
                                                                        .toDouble()
                                                                        .toString(),
                                                                  )!;
                                                                  print(
                                                                      'shippingAmount:${shippingAmount}');

                                                                  // Check if couponValue is valid
                                                                  final discountAmount = FFAppState().couponValue !=
                                                                              null &&
                                                                          FFAppState().couponValue >
                                                                              0
                                                                      ? getJsonField(
                                                                              columnBuyNowResponse
                                                                                  .jsonBody,
                                                                              r'''$.cart_total''') *
                                                                          (FFAppState().couponValue /
                                                                              100)
                                                                      : 0.0;
                                                                  print(
                                                                      'discountAmount:${discountAmount}');
                                                                  FFAppState()
                                                                          .finalDiscount =
                                                                      discountAmount;
                                                                  final finalDiscount =
                                                                      currencyConversion(
                                                                    FFAppState()
                                                                        .currencyRate,
                                                                    discountAmount
                                                                        .toString(),
                                                                  )!;
                                                                  print(
                                                                      'finalDiscount:${finalDiscount}');
                                                                  final totalAmount =
                                                                      shippingAmount +
                                                                          cartTotal! -
                                                                          finalDiscount;
                                                                  print(
                                                                      'totalAmount:${totalAmount}');
                                                                  // Apply reward points deduction if the checkbox is selected
                                                                  /*final finalAmount = _model.checkboxValue2 == true
            ? totalAmount - rewardPoints
            : totalAmount;*/
                                                                  /*    final finalAmount =
                                                                      totalAmount;*/

                                                                  // Store the final amount in FFAppState

                                                                  // Update cartAmount in FFAppState
                                                                  /*      FFAppState()
                                                                          .cartAmount =
                                                                      cartTotal!;
*/
                                                                  // Apply reward points deduction if the checkbox is selected
                                                                  /*rewardPoints = _model.checkboxValue2 == true
                                                                      ? FFAppState().rewardPointsprofile
                                                                      : 0.0;*/
                                                                  rewardPoints = _model.checkboxValue2 == true
                                                                      ? rewardPointsforapi : 0.0;
                                                                  print(
                                                                      "rewardPoints : ${rewardPoints}");

                                                                  // Check if reward points exceed the total amount
                                                                  final finalAmount = (totalAmount -
                                                                          rewardPoints!)
                                                                      .clamp(
                                                                          0.0,
                                                                          double
                                                                              .infinity);
                                                                  print(
                                                                      "finalAmount : ${finalAmount}");
                                                                  // Store the final amount in FFAppState
                                                                  FFAppState().finalAmount = finalAmount;

                                                                  return Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1,
                                                                            0),
                                                                    child: Text(
                                                                      /*'${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatNumber(
              currencyConversion(FFAppState().currencyRate, cartTotal.toString()),
              //finalAmount,
              formatType: FormatType.decimal,
              decimalType: DecimalType.automatic,
            )}',*/
                                                                      //'${getJsonField(stackCartResponse.jsonBody, r'''$.cart_total''')}',
                                                                      '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(finalAmount.toStringAsFixed(2), 1)}',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Montserrat',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            fontSize:
                                                                                15,
                                                                            letterSpacing:
                                                                                0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                    ),
                                                                  ); /*Text(
                                                                    '${valueOrDefault<String>(
                                                                      FFAppState()
                                                                          .currencyName,
                                                                      'INR',
                                                                    )} ${formatNumber(
                                                                      cartTotal,
                                                                      formatType:
                                                                          FormatType
                                                                              .decimal,
                                                                      decimalType:
                                                                          DecimalType
                                                                              .automatic,
                                                                    )}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          fontSize:
                                                                              15,
                                                                          letterSpacing:
                                                                              0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                  );*/
                                                                },
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0, 1),
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      print(
                                          "Billingid :${FFAppState().billingAddressID}");
                                      print(
                                          "FFAppState().billingAddressID :${FFAppState().shippingAddressID}");
                                      print(
                                          'Product IDs: ${getJsonField(stackCartResponse.jsonBody, r'''$.data[:].product_id''')}');
                                      _model.cartTotal = getJsonField(
                                        stackCartResponse.jsonBody,
                                        r'''$.cart_total''',
                                      ).toString();

                                      print(
                                          'Cart API Response JSON: ${stackCartResponse.jsonBody}');

                                      if (stackCartResponse.jsonBody == null) {
                                        print('Cart API Response Data is null');
                                        return; // Exit early if response data is null
                                      }

                                      dynamic responseData;
                                      if (FFAppState().buynow == true) {
                                        responseData = getJsonField(
                                            columnBuyNowResponse.jsonBody,
                                            r'''$.data[:]''');
                                      } else {
                                        responseData = getJsonField(
                                            stackCartResponse.jsonBody,
                                            r'''$.data[:]''');
                                      }
                                      dynamic BuynowproductData = getJsonField(
                                          columnBuyNowResponse.jsonBody,
                                          r'''$.data[:]''');
                                      print("BuynowproductData: ${BuynowproductData}");
                                      List<dynamic> cartList = [];

                                      if (responseData != null) {
                                        if (responseData is List) {
                                          cartList = responseData;
                                        } else if (responseData
                                        is Map<String, dynamic>) {
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
                                      // Assuming cartList is a List of Map<String, dynamic>
                                      products = cartList.map((cartListItem) {
                                            return Product.fromJson(cartListItem);
                                          }).toList();

                                      // Store the list in FFAppState
                                      FFAppState().products = products;

                                      // If you need the JSON representation of the products list
                                      String productsJson = jsonEncode(FFAppState()
                                          .products
                                          .map((p) => p.toJson())
                                          .toList());

                                      // Print the stored products list (as objects)
                                      print(
                                          "FFAppState().products: ${FFAppState().products.map((p) => p.toJson()).toList()}");

                                      // Print the JSON-encoded products list
                                      print('Products JSON: $productsJson');

                                      // Check if billing address is selected
                                      if (FFAppState().billingAddressID == null || FFAppState().billingAddressID == '') {
                                        ScaffoldMessenger.of(context)
                                            .clearSnackBars();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Please select a billing address'),
                                            duration: Duration(seconds: 2),
                                            backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        );
                                        return; // Exit early if billing address is not selected
                                      }

                                      print(
                                          'Calling AddOrder API with the following details:');
                                      print('Host URL: ${FFAppConstants.hosturl}');
                                      print('Token: $currentAuthenticationToken');
                                      print(
                                          'Delivery Address ID: ${FFAppState().shippingAddressID}');
                                      print(
                                          'Billing Address ID: ${FFAppState().billingAddressID}');
                                      print(
                                          'Products: ${jsonEncode(products.map((p) => p.toJson()).toList())}');

                                      final requestBody = {
                                        'deliveryAddress':
                                        FFAppState().shippingAddressID,
                                        'deliveryAddressText': joinAddress(
                                            FFAppState().shippingAddress1,
                                            FFAppState().shippingAddress2,
                                            FFAppState().shippingCity,
                                            FFAppState().shippingState,
                                            FFAppState().shippingPincode,
                                            widget.name,
                                            widget.email,
                                            widget.contact,
                                            widget.country),
                                        'billingAddress':
                                        _model.checkboxValue1 == true
                                            ? FFAppState().shippingAddressID
                                            : FFAppState().billingAddressID,
                                        'billingAddressText':
                                        _model.checkboxValue1 == true
                                            ? joinAddress(
                                          FFAppState().shippingAddress1,
                                          FFAppState().shippingAddress2,
                                          FFAppState().shippingCity,
                                          FFAppState().shippingState,
                                          FFAppState().shippingPincode,
                                          widget.name,
                                          widget.email,
                                          widget.contact,
                                          widget.country,
                                        ) : joinAddress(
                                          FFAppState().billingAddress1,
                                          FFAppState().billingAddress2,
                                          FFAppState().billingCity,
                                          FFAppState().billingState,
                                          FFAppState().billingPincode,
                                          widget.name,
                                          widget.email,
                                          widget.contact,
                                          widget.country,
                                        ),
                                        'payment_mode': 2,
                                        'currency_type': FFAppState().currencyName,
                                        'deliveryCharges':
                                        FFAppState().shippingAmount!,
                                        'coupenCode': FFAppState().couponCode,
                                        'giftId': FFAppState().selectedGiftId,
                                        'reward_used': _model.checkboxValue2,
                                        'pendingamount': 365,
                                        'products': products
                                            .map((p) => p.toJson())
                                            .toList(),
                                        'customer_instructions': '',
                                        'shipping_type': 'Fedex/DHL',
                                        'digital_source': 'not sponsored',
                                      };

                                      print('Main Request Body: ${jsonEncode(requestBody)}');
                                      /*if(FFAppState().finalAmount == 0 || FFAppState().finalAmount > 500000 )
                                        { ApiCallResponse apiResponse =
                                        await AddOrderCall.call(
                                        hosturl: FFAppConstants.hosturl,
                                        token: currentAuthenticationToken,
                                        deliveryAddress:
                                        FFAppState().shippingAddressID,
                                        billingAddress:
                                        _model.checkboxValue1 == true
                                        ? FFAppState().shippingAddressID
                                            : FFAppState().billingAddressID,
                                        paymentMode: 2,
                                        currencyType: FFAppState().currencyName,
                                        coupenCode: FFAppState().couponCode,
                                        giftId:FFAppState().selectedGiftId?.toString(),
                                        rewardUsed: _model.checkboxValue2,
                                        products: products, // Pass the List<Product> directly
                                        customerInstructions: '',
                                        shippingType: 'Fedex/DHL',
                                        digitalSource: 'not sponsored',
                                        );

                                        print('API Call Result:');
                                        if (apiResponse == null) {
                                        print('API response is null');
                                        } else {
                                        print(
                                        'Raw Response: ${apiResponse.jsonBody}');
                                        print(
                                        'Response Data: ${apiResponse.response}');
                                        print(
                                        'Response Headers: ${apiResponse.headers}');
                                        print(
                                        'Status Code: ${apiResponse.statusCode}');
                                        }

                                        if (apiResponse != null &&
                                        apiResponse.statusCode == 200) {
                                        FFAppState().invoiceNumber =
                                        AddOrderCall.invoiceNo(
                                        (apiResponse.jsonBody),
                                        )!;
                                        _invoiceNumber = FFAppState().invoiceNumber;
                                        print('Invoice Number: $_invoiceNumber');
                                        print(
                                        'data data: ${AddOrderCall.getData(
                                        apiResponse.jsonBody)}');
                                        print(
                                        'DataBody: ${AddOrderCall.DataBody(
                                        apiResponse.jsonBody)}');
                                        print(
                                        'Cart Amount: ${FFAppState()
                                            .cartAmount}');
                                        print(
                                        'Final Amount: ${FFAppState()
                                            .finalAmount}');
                                        //setState(() {});

                                        Navigator.of(context).push(
                                        PageTransition(
                                        type: PageTransitionType.fade,
                                        duration: Duration(milliseconds: 300),
                                        child: PaymentBankInfoWidget(),
                                        ),
                                        );
                                        context.pushNamed(
                                        'PaymentBankInfoWidget',

                                        );
                                        // Navigate to the next page and pass the invoiceNumber
                                         }

                                        } else  {*/
                                      context.pushNamed(
                                        'SelectPaymentMethod2',
                                        queryParameters: {
                                          'totalAmount': serializeParam(
                                            FFAppState().finalAmount,
                                            ParamType.double,
                                          ),
                                          'invoiceNumber': serializeParam(
                                            _invoiceNumber,
                                            ParamType.String,
                                          ),
                                          'checkbox1': serializeParam(
                                            _model.checkboxValue1,
                                            ParamType.bool,
                                          ),
                                          'checkbox2': serializeParam(
                                            _model.checkboxValue2,
                                            ParamType.bool,
                                          ),
                                          'productlist':  jsonEncode(products
                                              .map((p) => p.toJson())

                                              .toList())
                                        },
                                        extra: <String, dynamic>{

                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,

                                            duration: Duration(milliseconds: 400),
                                          ),
                                        },
                                      );
                                    },
                                    //text: 'Select Payment Method',
                                    text: 'Proceed to Pay',
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
                              ),
                            ),
                          )
                        ],
                      );
                    }),
              ],
            );
          },
        ),
        bottomNavigationBar: CustomNavBarWidget(),
      ),
    );
  }
}