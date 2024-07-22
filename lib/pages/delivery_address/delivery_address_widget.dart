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

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
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
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
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
            onPressed: () async {context.pop();},
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
          elevation: 1,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
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
                                                              InkWell(
                                                                splashColor: Colors.transparent,
                                                                focusColor: Colors.transparent,
                                                                hoverColor: Colors.transparent,
                                                                highlightColor: Colors.transparent,
                                                                onTap: () async {
                                                                  _model.selectedvariable = !_model.selectedvariable;
                                                                  _model.addToSelectedAddress(addressDetailsIndex);
                                                                  setState(() {});
                                                                },
                                                                child: Builder(
                                                                  builder: (context) {
                                                                    if (_model.selectedAddress.contains(addressDetailsIndex)) {
                                                                      return FlutterFlowIconButton(
                                                                        borderColor: Colors.transparent,
                                                                        borderRadius: 20,
                                                                        borderWidth: 1,
                                                                        buttonSize: 40,
                                                                        icon: const Icon(Icons.radio_button_checked, color: Color(0xFF740074), size: 24,),
                                                                        //onPressed: () {print('IconButton pressed ...');},
                                                                        onPressed: () async {
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
                                                                          //setState(() {});
                                                                          if (_model.selectedContainer) {
                                                                            _model.insertAtIndexInSelectedAddress(0, addressDetailsIndex);
                                                                            //setState(() {});
                                                                          } else {
                                                                            _model.removeAtIndexFromSelectedAddress(0);
                                                                            //setState(() {});
                                                                          }
                                                                          //setState(() {});
                                                                          if (_model.selectedContainer) {
                                                                            _model.insertAtIndexInSelectedAddress(0, addressDetailsIndex);
                                                                            //setState(() {});
                                                                          } else {
                                                                            _model.removeAtIndexFromSelectedAddress(0);
                                                                            //setState(() {});
                                                                          }
                                                                        },
                                                                      );
                                                                    } else {
                                                                      return FlutterFlowIconButton(
                                                                        borderColor: Colors.transparent,
                                                                        borderRadius: 20,
                                                                        borderWidth: 1,
                                                                        buttonSize: 40,
                                                                        icon: const Icon(Icons.circle_outlined, color: Color(0xFF6E6E70), size: 24,),
                                                                        onPressed: () {print('IconButton pressed ...');},
                                                                      );
                                                                    }
                                                                  },
                                                                ),
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
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 60),
                child: FFButtonWidget(
                  onPressed: _model.selectedAddress.isEmpty ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select an address.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } : () async {
                    // Fetch cart details
                    /*_model.fetchCartforShipping = await CartCall.call(
                      hosturl: FFAppConstants.hosturl,
                      token: currentAuthenticationToken,
                    );

                    // Check if the cart API call was successful and contains data
                    if (_model.fetchCartforShipping != null && _model.fetchCartforShipping?.jsonBody['data'] != null) {
                      List<dynamic> cartData = _model.fetchCartforShipping?.jsonBody['data'];

                      // Map cart items to Product objects
                      List<Product> products = cartData.map((cartListItem) {
                        return Product.fromJson(cartListItem);
                      }).toList();

                      // Fetch checkout details
                      _model.fetchShippingOutput = await FetchcheckoutDetailsCall.call(
                        hosturl: FFAppConstants.hosturl,
                        shippingCountry: FFAppState().countryName,
                        shippingMethod: 'fedex',
                        rewardUsed: false,
                        couponCode: FFAppState().couponCode,
                        products: products,
                        token: currentAuthenticationToken,
                      );

                      final requestData2 = {
                        'hosturl': FFAppConstants.hosturl,
                        'shippingCountry': FFAppState().countryName,
                        'shippingMethod': 'fedex',
                        'rewardUsed': false,
                        'couponCode': FFAppState().couponCode,
                        'products': products,
                        'token': currentAuthenticationToken,
                      };

                      print('Reuest  Data 2: $requestData2');

                      // Handle the response from FetchcheckoutDetailsCall
                      if (_model.fetchShippingOutput != null && _model.fetchShippingOutput?.jsonBody['data'] != null) {
                        // Process the shipping output as needed
                        var shippingDetails = _model.fetchShippingOutput?.jsonBody['data'];
                        print("Shipping Details: $shippingDetails");
                      } else {
                        print("Failed to fetch shipping details");
                      }
                    } else {
                      print("Failed to fetch cart details");
                    }*/

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

                    // Make the API call
                    _model.fetchShippingOutput = await FetchShippingCall.call(
                      hosturl: FFAppConstants.hosturl,
                      shippingCountry: FFAppState().countryName,
                      shippingWeight: FFAppState().courierTotal,
                      totalPrice: FFAppState().cartTotal,
                      orderTotal: FFAppState().orderTotal,
                    );

                    // Print the raw response
                    print('Shipping API Response Raw: ${_model.fetchShippingOutput?.jsonBody ?? 'null'}');

                    // Parse and set the state variables
                    FFAppState().shippingAmount = getJsonField(
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
                        .toList()!
                        .toList()
                        .cast<String>();
                    FFAppState().couponCodeList = (getJsonField(
                      (_model.fetchShippingOutput?.jsonBody ?? ''),
                      r'''$.coupondata''',
                      true,
                    ) as List)
                        .map<String>((s) => s.toString())
                        .toList()!
                        .toList()
                        .cast<String>();

                    // Print the parsed response data
                    print('Shipping Amount from delivery: ${FFAppState().shippingAmount}');
                    print('Reward points from delivery: ${FFAppState().rewardPoints}');
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
      ),
    );
  }
}
