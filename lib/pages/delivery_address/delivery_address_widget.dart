import '../../auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'delivery_address_model.dart';
export 'delivery_address_model.dart';

class DeliveryAddressWidget extends StatefulWidget {
  const DeliveryAddressWidget({super.key});

  @override
  State<DeliveryAddressWidget> createState() => _DeliveryAddressWidgetState();
}

class _DeliveryAddressWidgetState extends State<DeliveryAddressWidget> {
  late DeliveryAddressModel _model;

  final DeliveryAddressWidgetscaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedAddressIndex = 0;
  Future<ApiCallResponse>? _buyNowFuture;
  List<dynamic>? _cartList;
  double? cart_total;
  double? courier_total;
  double? total_reward_price;
  ApiCallResponse? _buyNowResponse;
  late List<Product> products;

  Future<ApiCallResponse> _buyNow() async {
    final response = await BuyNowCall.call(
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
    );
    setState(() {
      _buyNowResponse = response;

      // Log the entire response JSON body for debugging
      print("Response JSON Body: ${response.jsonBody}");

      _cartList = getJsonField(response.jsonBody, r'''$.data''').toList();
      print("_cartList: $_cartList");
      // Log the raw values being extracted
      cart_total = getJsonField(response.jsonBody, r'''$.cart_total''');
      print("cart_total: $cart_total");

      courier_total = getJsonField(response.jsonBody, r'''$.courier_total''');
      print("courier_total: $courier_total");

      total_reward_price = getJsonField(response.jsonBody, r'''$.total_reward_price''');
      print("total_reward_price: $total_reward_price");
      if (FFAppState().buynow == true) {
        // Convert double to int by using .toInt() method
        FFAppState().courierTotal = (courier_total as double?)?.toInt();
        print(FFAppState().courierTotal);

        FFAppState().cartTotal = (cart_total as double?)?.toInt();
        print(FFAppState().cartTotal);

        FFAppState().rewardPoints = (total_reward_price as double?)?.toInt();
        FFAppState().orderTotal = (total_reward_price as double?)?.toInt();
        print(FFAppState().rewardPoints);
      }
    });
    return response;
  }
  @override
  void initState() {
    super.initState();
    if(FFAppState().buynow == true)
    {
      _buyNow();
    }

    _model = createModel(context, () => DeliveryAddressModel());
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
        key: DeliveryAddressWidgetscaffoldKey,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: Offset(0, 4),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 54,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24,
                ),
                onPressed: () async {
                  final fromScreen = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

                  if (fromScreen != null) {
                    if (fromScreen['fromScreen'] == 'Cart') {
                      // Navigate back to Cart and ensure it's not navigated from DeliveryAddress again
                      Navigator.popUntil(
                        context,
                        ModalRoute.withName('/cart'),
                      );
                    } else if (fromScreen['fromScreen'] == 'SelectPaymentMethod') {
                      // Navigate back to SelectPaymentMethod
                      Navigator.popUntil(
                        context,
                        ModalRoute.withName('/selectPaymentMethod'),
                      );
                    }
                  } else {
                    // Default behavior if the source is unknown or no parameter is provided
                    Navigator.pop(context);
                  }
                  },
              ),
              title: Text('Select a delivery address',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 16,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: const [],
              centerTitle: true,
              elevation: 0,
            ),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          decoration: BoxDecoration(),
                          child: FutureBuilder<ApiCallResponse>(
                            future: AddressListCall.call(
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
                                      valueColor: AlwaysStoppedAnimation<Color>(FlutterFlowTheme.of(context).primary,),
                                    ),
                                  ),
                                );
                              }
                              final columnAddressListResponse = snapshot.data!;

                              return Builder(builder: (context) {
                                final addressDetails = getJsonField(columnAddressListResponse.jsonBody, r'''$.data''',).toList();

                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(addressDetails.length, (addressDetailsIndex) {
                                    final addressDetailsItem = addressDetails[addressDetailsIndex];
                                    return Padding(padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {

                                          _model.selectedContainer = !_model.selectedContainer;
                                          _model.address1 = getJsonField(addressDetailsItem, r'''$.address''',).toString();
                                          _model.address2 = getJsonField(addressDetailsItem, r'''$.addresstwo''',).toString();
                                          _model.city = getJsonField(addressDetailsItem, r'''$.cityname''',).toString();
                                          _model.state = getJsonField(addressDetailsItem, r'''$.statename''',).toString();
                                          _model.zipCode = getJsonField(addressDetailsItem, r'''$.pincode''',).toString();
                                          _model.id = getJsonField(addressDetailsItem, r'''$.id''',);
                                          _model.nameFL = getJsonField(addressDetailsItem, r'''$.name''',).toString();
                                          _model.emailAddress = getJsonField(addressDetailsItem, r'''$.email''',).toString();
                                          _model.contactNo = getJsonField(addressDetailsItem, r'''$.contact_no''',).toString();
                                          _model.countryName = getJsonField(addressDetailsItem, r'''$.countryname''',).toString();
                                          FFAppState().shippingAddressID = getJsonField(
                                            addressDetailsItem,
                                            r'''$.id''',
                                          );
                                          FFAppState().shippingAddress1 = getJsonField(
                                            addressDetailsItem,
                                            r'''$.address''',
                                          ).toString();
                                          FFAppState().shippingAddress2 = getJsonField(
                                            addressDetailsItem,
                                            r'''$.addresstwo''',
                                          ).toString();
                                          FFAppState().shippingCity = getJsonField(
                                            addressDetailsItem,
                                            r'''$.cityname''',
                                          ).toString();
                                          FFAppState().shippingState = getJsonField(
                                            addressDetailsItem,
                                            r'''$.statename''',
                                          ).toString();
                                          FFAppState().shippingPincode = getJsonField(
                                            addressDetailsItem,
                                            r'''$.pincode''',
                                          ).toString();
                                          setState(() {});
                                          if (_model.selectedContainer) {
                                            _model.insertAtIndexInSelectedAddress(0, addressDetailsIndex);
                                            setState(() {});
                                          } else {
                                            _model.removeAtIndexFromSelectedAddress(0);
                                            setState(() {});
                                          }
                                          setState(() {});
                                          if (_model.selectedContainer) {
                                            _model.insertAtIndexInSelectedAddress(0, addressDetailsIndex);
                                            setState(() {});
                                          } else {
                                            _model.removeAtIndexFromSelectedAddress(0);
                                            setState(() {});
                                          }
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: !_model.selectedAddress.contains(
                                              addressDetailsIndex) ? 146.0 : 194.0,
                                          decoration: BoxDecoration(
                                            color: !_model.selectedAddress.contains(
                                                addressDetailsIndex) ? Color(0x00FFFFFF) : Color(0x27740074),
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: Color(0xFFE7E7E8),
                                              width: 1,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(16, 32, 0, 25),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      getJsonField(addressDetailsItem, r'''$.name''',).toString(),
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
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: 259,
                                                          height: 52,
                                                          decoration: BoxDecoration(),
                                                          child: RichText(
                                                            textScaler: MediaQuery.of(context).textScaler,
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                  getJsonField(addressDetailsItem, r'''$.address''',).toString(),
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    fontFamily: 'Montserrat',
                                                                    color: Color(0xFF575758),
                                                                    letterSpacing: 0,
                                                                    lineHeight: 2,
                                                                  ),
                                                                ),
                                                                const TextSpan(text: ', ', style: TextStyle(),),
                                                                TextSpan(text: getJsonField(addressDetailsItem, r'''$.addresstwo''',).toString(), style: const TextStyle(),),
                                                                const TextSpan(text: ', ', style: TextStyle(),),
                                                                TextSpan(text: getJsonField(addressDetailsItem, r'''$.landmark''',).toString(), style: TextStyle(),),
                                                                TextSpan(text: ', ', style: TextStyle(),),
                                                                TextSpan(text: getJsonField(addressDetailsItem, r'''$.cityname''',).toString(), style: TextStyle(),),
                                                                TextSpan(text: ',', style: TextStyle(),),
                                                                TextSpan(text: getJsonField(addressDetailsItem, r'''$.statename''',).toString(), style: TextStyle(),),
                                                                TextSpan(text: '-', style: TextStyle(),),
                                                                TextSpan(text: getJsonField(addressDetailsItem, r'''$.pincode''',).toString(), style: TextStyle(),)
                                                              ],
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                fontFamily: 'Montserrat',
                                                                color: Color(0xFF575758),
                                                                letterSpacing: 0,
                                                                lineHeight: 2,
                                                              ),
                                                            ),
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                        Radio(
                                                          activeColor: FlutterFlowTheme.of(context).primary,
                                                          value: addressDetailsIndex,
                                                          groupValue: _model.selectedAddress.isNotEmpty
                                                              ? _model.selectedAddress.first
                                                              : -1,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              if (_model.selectedContainer) {
                                                                _model.selectedAddress.remove(addressDetailsIndex);
                                                                FFAppState().shippingAddressID = null;
                                                                FFAppState().shippingAddress1 = '';
                                                                FFAppState().shippingAddress2 = '';
                                                                FFAppState().shippingCity = '';
                                                                FFAppState().shippingState = '';
                                                                FFAppState().shippingPincode = '';
                                                              } else {
                                                                _model.selectedAddress.clear();
                                                                _model.selectedAddress.add(addressDetailsIndex);
                                                                final selectedAddressItem = addressDetails[addressDetailsIndex];
                                                                FFAppState().shippingAddressID = getJsonField(selectedAddressItem, r'''$.id''');
                                                                FFAppState().shippingAddress1 = getJsonField(selectedAddressItem, r'''$.address''').toString();
                                                                FFAppState().shippingAddress2 = getJsonField(selectedAddressItem, r'''$.addresstwo''').toString();
                                                                FFAppState().shippingCity = getJsonField(selectedAddressItem, r'''$.cityname''').toString();
                                                                FFAppState().shippingState = getJsonField(selectedAddressItem, r'''$.statename''').toString();
                                                                FFAppState().shippingPincode = getJsonField(selectedAddressItem, r'''$.pincode''').toString();
                                                              }
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (_model.selectedAddress.contains(addressDetailsIndex))
                                                Divider(thickness: 1, color: Color(0xFFD3CEF6),),
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    InkWell(
                                                      splashColor: Colors.transparent,
                                                      focusColor: Colors.transparent,
                                                      hoverColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      onTap: () async {
                                                        context.pushNamed('UpdateAddress',
                                                          queryParameters: {
                                                            'addressId': serializeParam(
                                                              getJsonField(addressDetailsItem, r'''$.id''',),
                                                              ParamType.int,
                                                            ),
                                                            'editCountryId': serializeParam(
                                                              getJsonField(addressDetailsItem, r'''$.country''',).toString(),
                                                              ParamType.String,
                                                            ),
                                                            'editStateId': serializeParam(
                                                              getJsonField(addressDetailsItem, r'''$.state''',).toString(),
                                                              ParamType.String,
                                                            ),
                                                          }.withoutNulls,
                                                          extra: <String, dynamic>{kTransitionInfoKey:
                                                          const TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType: PageTransitionType.rightToLeft,
                                                            duration: Duration(milliseconds: 400),
                                                          ),
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        width: MediaQuery.sizeOf(context).width * 0.3,
                                                        height: !_model.selectedAddress.contains(
                                                            addressDetailsIndex) ? 4.0 : 15.0,
                                                        decoration: BoxDecoration(),
                                                        child: Visibility(
                                                          visible: _model.selectedAddress.contains(addressDetailsIndex),
                                                          child: Align(alignment: AlignmentDirectional(0, 0),
                                                            child: InkWell(
                                                              splashColor: Colors.transparent,
                                                              focusColor: Colors.transparent,
                                                              hoverColor: Colors.transparent,
                                                              highlightColor: Colors.transparent,
                                                              onTap: () async {context.pushNamed('UpdateAddress',
                                                                queryParameters: {
                                                                  'addressId': serializeParam(getJsonField(addressDetailsItem, r'''$.id''',),
                                                                    ParamType.int,
                                                                  ),
                                                                  'editCountryId': serializeParam(
                                                                    getJsonField(addressDetailsItem, r'''$.country''',).toString(), ParamType.String,
                                                                  ),
                                                                  'editStateId': serializeParam(getJsonField(addressDetailsItem, r'''$.state''',).toString(),
                                                                    ParamType.String,
                                                                  ),
                                                                }.withoutNulls,
                                                                extra: <String, dynamic>{kTransitionInfoKey:
                                                                const TransitionInfo(
                                                                  hasTransition: true,
                                                                  transitionType: PageTransitionType.rightToLeft,
                                                                  duration: Duration(milliseconds: 400),
                                                                ),
                                                                },
                                                              );
                                                              },
                                                              child: Text('EDIT',
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Montserrat',
                                                                  color: Color(0xFF740074),
                                                                  fontSize: 14,
                                                                  letterSpacing: 0,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).divide(SizedBox(height: 8)),
                                );
                              },
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 120),
                          child: FFButtonWidget(
                            onPressed: () async {
                              FFAppState().isDeliveryAddress = true;
                              context.pushNamed(
                                'AddNewAddress',
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: const TransitionInfo(
                                    hasTransition: true,
                                    transitionType:
                                    PageTransitionType.bottomToTop,
                                    duration: Duration(milliseconds: 400),
                                  ),
                                },
                              );
                            },
                            text: 'Add address',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 48,
                              padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context).secondaryBackground,
                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Montserrat',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600,
                              ),
                              elevation: 0,
                              borderSide: const BorderSide(color: Color(0xFFE7E7E8), width: 1,),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ].divide(const SizedBox(height: 4)),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 1),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                child: FFButtonWidget(
                  onPressed: _model.selectedAddress.isEmpty ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select an address.'),
                        duration: Duration(seconds: 2),
                        backgroundColor: FlutterFlowTheme.of(context).primary,
                      ),
                    );
                  } : () async {
                    print('Shipping Address: ${_model.id}');
                    // Prepare the request data
                    final requestData = {
                      'hosturl': FFAppConstants.hosturl,
                      'shippingCountry': FFAppState().countryName,
                      'shippingWeight': FFAppState().courierTotal,
                      'totalPrice': FFAppState().cartTotal,
                      'orderTotal': FFAppState().orderTotal,
                    };

                    // Print the request data
                    print('Shipping API Request Data: $requestData');
                    print(FFAppState().countryName);
                    print(FFAppState().courierTotal);
                    print(FFAppState().cartTotal);
                    print(FFAppState().orderTotal);

                    // Make the API call
                    _model.fetchShippingOutput = await FetchShippingCall.call(
                      hosturl: FFAppConstants.hosturl,
                      shippingCountry: FFAppState().countryName ,
                      shippingWeight: FFAppState().courierTotal ,
                      totalPrice: FFAppState().cartTotal ,
                      orderTotal: FFAppState().orderTotal ,
                    );

                    // Print the raw response
                    print('Shipping API Response Raw: ${_model.fetchShippingOutput?.jsonBody ?? 'null'}');

                    // Parse and set the state variables
                    /*FFAppState().shippingAmount = getJsonField(
                      (_model.fetchShippingOutput?.jsonBody ?? ''),
                      r'''$.shippingdata[0].amount''', // Adjusted JSON path for single item in array
                    ).toInt();
                    FFAppState().rewardPoints = getJsonField(
                      (_model.fetchShippingOutput?.jsonBody ?? ''),
                      r'''$.shippingdata[0].rewards_point''', // Adjusted JSON path for single item in array
                    ).toInt();
                    FFAppState().freeGiftsList = (getJsonField(
                      (_model.fetchShippingOutput?.jsonBody ?? ''),
                      r'''$.giftdata''',
                      true,
                    ) as List)
                        .map<String>((s) => s.toString())
                        .toList()
                        .toList()
                        .cast<String>();
                    FFAppState().couponCodeList = (getJsonField(
                      (_model.fetchShippingOutput?.jsonBody ?? ''),
                      r'''$.coupondata''',
                      true,
                    ) as List)
                        .map<String>((s) => s.toString())
                        .toList()
                        .toList()
                        .cast<String>();*/
                    FFAppState().shippingAmount = getJsonField(
                      (_model.fetchShippingOutput?.jsonBody ?? ''),
                      r'''$.shippingdata[0].amount''', // Adjusted JSON path for single item in array
                    )?.toInt() ?? 0;
                    FFAppState().rewardPoints = getJsonField(
                      (_model.fetchShippingOutput?.jsonBody ?? ''),
                      r'''$.shippingdata[0].rewards_point''', // Adjusted JSON path for single item in array
                    )?.toInt() ?? 0;
                    _model.initialRewardPoints = getJsonField(
                      (_model.fetchShippingOutput?.jsonBody ?? ''),
                      r'''$.shippingdata[0].rewards_point''', // Adjusted JSON path for single item in array
                    )?.toInt() ?? 0;
                    FFAppState().freeGiftsList = (getJsonField(
                      (_model.fetchShippingOutput?.jsonBody ?? ''),
                      r'''$.giftdata''',
                      true,
                    ) as List?)
                        ?.map<String>((s) => s.toString())
                        .toList() ?? [];
                    FFAppState().couponCodeList = (getJsonField(
                      (_model.fetchShippingOutput?.jsonBody ?? ''),
                      r'''$.coupondata''',
                      true,
                    ) as List?)
                        ?.map<String>((s) => s.toString())
                        .toList() ?? [];
                    FFAppState().shippingAddress1 = _model.address1;
                    FFAppState().shippingAddress2 = _model.address2;
                    FFAppState().shippingCity = _model.city;
                    FFAppState().shippingState = _model.state;
                    FFAppState().shippingPincode = _model.zipCode;

                    // Print the parsed response data
                    print('Shipping Amount from delivery: ${FFAppState().shippingAmount}');
                    print('Reward points from delivery: ${FFAppState().rewardPoints}');
                    print('Reward points from delivery22222: ${_model.initialRewardPoints}');
                    print('Courier total from delivery22222: ${FFAppState().courierTotal}');
                    print('Free Gifts List from delivery: ${FFAppState().freeGiftsList}');
                    print('Coupon Code List from delivery: ${FFAppState().couponCodeList}');

                    //setState(() {});

                    // Navigate to the next screen
                    context.pushNamed(
                      'SelectPaymentMethod',
                      queryParameters: {
                        'address1': serializeParam(
                          _model.address1,
                          ParamType.String,
                        ),
                        'address2': serializeParam(
                          _model.address2,
                          ParamType.String,
                        ),
                        'city': serializeParam(
                          _model.city,
                          ParamType.String,
                        ),
                        'state': serializeParam(
                          _model.state,
                          ParamType.String,
                        ),
                        'pinCode': serializeParam(
                          _model.zipCode,
                          ParamType.String,
                        ),
                        'addressId': serializeParam(
                          _model.id,
                          ParamType.int,
                        ),
                        'name': serializeParam(
                          _model.nameFL,
                          ParamType.String,
                        ),
                        'email': serializeParam(
                          _model.emailAddress,
                          ParamType.String,
                        ),
                        'contact': serializeParam(
                          _model.contactNo,
                          ParamType.String,
                        ),
                        'country': serializeParam(
                          _model.countryName,
                          ParamType.String,
                        ),
                        'initialRewardPoints': serializeParam(
                          _model.initialRewardPoints,
                          ParamType.int,
                        )
                      }.withoutNulls,
                      extra: <String, dynamic>{
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 400),
                        ),
                      },
                    );
                    //setState(() {});
                  },
                  text: 'Proceed to Checkout',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 48,
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: Color(0xFF740074),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
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
              ),
            ),
          ],
        ),
        bottomNavigationBar: const CustomNavBarWidget(),
      ),
    );
  }
}