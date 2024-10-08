import '../../auth/custom_auth/auth_util.dart';
import '../../select_payment_method/select_payment_method_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import 'billing_address_model.dart';
export 'billing_address_model.dart';

class BillingAddressWidget extends StatefulWidget {
  const BillingAddressWidget({super.key});

  @override
  State<BillingAddressWidget> createState() => _BillingAddressWidgetState();
}

class _BillingAddressWidgetState extends State<BillingAddressWidget> {
  late BillingAddressModel _model;

  final BillingAddressWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BillingAddressModel());
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
        key: BillingAddressWidgetscaffoldKey,
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
          title: Text('Select a billing address',
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
                                          //_model.selectedContainer = !_model.selectedContainer;
                                          _model.selectedBillingContainer = !_model.selectedBillingContainer;
                                          _model.billingAddress1 = getJsonField(addressDetailsItem, r'''$.address''',).toString();
                                          _model.billingAddress2 = getJsonField(addressDetailsItem, r'''$.addresstwo''',).toString();
                                          _model.billingCity = getJsonField(addressDetailsItem, r'''$.cityname''',).toString();
                                          _model.billingState = getJsonField(addressDetailsItem, r'''$.statename''',).toString();
                                          _model.billingZipCode = getJsonField(addressDetailsItem, r'''$.pincode''',).toString();
                                          _model.billingId = getJsonField(addressDetailsItem, r'''$.id''',);
                                          _model.nameFL = getJsonField(addressDetailsItem, r'''$.name''',).toString();
                                          _model.emailAddress = getJsonField(addressDetailsItem, r'''$.email''',).toString();
                                          _model.contactNo = getJsonField(addressDetailsItem, r'''$.contact_no''',).toString();
                                          _model.countryName = getJsonField(addressDetailsItem, r'''$.countryname''',).toString();
                                          _model.selectedBillingVariable = !_model.selectedBillingVariable;
                                          FFAppState().billingAddressID = getJsonField(
                                            addressDetailsItem,
                                            r'''$.id''',
                                          );
                                          FFAppState().billingAddress1 = getJsonField(
                                            addressDetailsItem,
                                            r'''$.address''',
                                          ).toString();
                                          FFAppState().billingAddress2 = getJsonField(
                                            addressDetailsItem,
                                            r'''$.addresstwo''',
                                          ).toString();
                                          FFAppState().billingCity = getJsonField(
                                            addressDetailsItem,
                                            r'''$.cityname''',
                                          ).toString();
                                          FFAppState().billingState = getJsonField(
                                            addressDetailsItem,
                                            r'''$.statename''',
                                          ).toString();
                                          FFAppState().billingPincode = getJsonField(
                                            addressDetailsItem,
                                            r'''$.pincode''',
                                          ).toString();
                                          print('Billing FFAppState().billingAddressID: ${FFAppState().billingAddressID}');
                                          print('Billing FFAppState().billingAddress1: ${FFAppState().billingAddress1}');
                                          print('Billing FFAppState().billingCity: ${FFAppState().billingCity}');
                                          print('Billing FFAppState().billingState: ${FFAppState().billingState}');
                                          print('Billing FFAppState().billingPincode: ${FFAppState().billingPincode}');
                                          print('----------------------------------------');
                                          print('Billing Address: ${_model.billingId}');
                                          print('Billing billingAddress1: ${_model.billingAddress1}');
                                          print('Billing billingAddress2: ${_model.billingAddress2}');
                                          print('Billing billingCity: ${_model.billingCity}');
                                          print('Billing billingState: ${_model.billingState}');
                                          setState(() {});
                                          //if (_model.selectedContainer) {
                                          if (_model.selectedBillingContainer) {
                                            _model.insertAtIndexInSelectedAddress(0, addressDetailsIndex);
                                            setState(() {});
                                          } else {
                                            _model.removeAtIndexFromSelectedAddress(0);
                                            setState(() {});
                                          }
                                          setState(() {});
                                          //if (_model.selectedContainer) {
                                          if (_model.selectedBillingContainer) {
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
                                                              if (_model.selectedBillingContainer) {
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
                                                              onTap: () async {
                                                                context.pushNamed('UpdateAddress',
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
                    print('Billing Address: ${_model.billingId}');
                    print('Billing billingAddress1: ${_model.billingAddress1}');
                    print('Billing billingAddress2: ${_model.billingAddress2}');
                    print('Billing billingCity: ${_model.billingCity}');
                    print('Billing billingState: ${_model.billingState}');

                    print('Billing Address: ${FFAppState().billingAddress1}');
                  } : () async {
                    print('Billing Address 1: ${_model.billingAddress1}');
                    print('Billing Address: ${_model.billingId}');

                    // Navigate to the next screen
                    /*context.pushNamed(
                      'SelectPaymentMethod',
                      queryParameters: {
                        'billingAddress1': serializeParam(
                          _model.billingAddress1,
                          ParamType.String,
                        ),
                        'billingAddress2': serializeParam(
                          _model.billingAddress2,
                          ParamType.String,
                        ),
                        'billingCity': serializeParam(
                          _model.billingCity,
                          ParamType.String,
                        ),
                        'billingState': serializeParam(
                          _model.billingState,
                          ParamType.String,
                        ),
                        'billingZipCode': serializeParam(
                          _model.billingZipCode,
                          ParamType.String,
                        ),
                        'billingId': serializeParam(
                          _model.billingId,
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
                    );*/
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectPaymentMethodWidget(
                            address1: '',
                            address2: '',
                            city: '',
                            state: '',
                            pinCode: '',
                            addressId: null,
                            name: '', email: '',
                            contact: '', country: '',
                            initialRewardPoints: 0,)
                      )
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