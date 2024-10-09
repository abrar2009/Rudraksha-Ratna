import '../../auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_nav_bar_widget.dart';
import '/components/delete_dialog_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import 'my_addresses_model.dart';
export 'my_addresses_model.dart';

class MyAddressesWidget extends StatefulWidget {
  const MyAddressesWidget({super.key});

  @override
  State<MyAddressesWidget> createState() => _MyAddressesWidgetState();
}

class _MyAddressesWidgetState extends State<MyAddressesWidget> {
  late MyAddressesModel _model;

  final MyAddressesWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyAddressesModel());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_model.selectedAddress.isEmpty) {
        setState(() {
          _model.selectedAddress.add(0); // Add the first index as selected
        });
      }
    });
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
        key: MyAddressesWidgetscaffoldKey,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(0, 4), // Move shadow downwards by 4 pixels
                  blurRadius: 6, // Blur radius for a softer shadow
                  spreadRadius: 1, // Spread radius for shadow expansion
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
                  context.pop();
                },
              ),
              title: Text(
                'My address',
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
                  Container(
                    width: double.infinity,
                    height: 1,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).borderColor,
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).borderColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
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
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              final columnAddressListResponse = snapshot.data!;
                              return Builder(
                                builder: (context) {
                                  final addressDetails = getJsonField(
                                    columnAddressListResponse.jsonBody,
                                    r'''$.data''',).toList();
                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: List.generate(addressDetails.length, (addressDetailsIndex) {
                                          final addressDetailsItem = addressDetails[addressDetailsIndex];
                                          return Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor: Colors.transparent,
                                              onTap: () async {
                                                _model.selectedContainer = !_model.selectedContainer;
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
                                                height: !_model.selectedAddress.contains(addressDetailsIndex)
                                                    ? 146.0
                                                    : 194.0,
                                                decoration: BoxDecoration(
                                                  color: !_model.selectedAddress.contains(addressDetailsIndex)
                                                      ? const Color(0x00FFFFFF)
                                                      : const Color(0x27740074),
                                                  borderRadius: BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(context).borderColor,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsetsDirectional.fromSTEB(16, 32, 0, 25),
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.max,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            getJsonField(addressDetailsItem,
                                                              r'''$.name''',).toString(),
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
                                                                decoration: const BoxDecoration(),
                                                                child: RichText(
                                                                  textScaler: MediaQuery.of(context).textScaler,
                                                                  text: TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text: getJsonField(addressDetailsItem,
                                                                          r'''$.address''',).toString(),
                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                          fontFamily: 'Montserrat',
                                                                          color: FlutterFlowTheme.of(context).greyText,
                                                                          letterSpacing: 0,
                                                                          lineHeight: 2,
                                                                        ),
                                                                      ),
                                                                      const TextSpan(
                                                                        text: ', ',
                                                                        style: TextStyle(),
                                                                      ),
                                                                      TextSpan(
                                                                        text: getJsonField(addressDetailsItem,
                                                                          r'''$.addresstwo''',).toString(),
                                                                        style: const TextStyle(),
                                                                      ),
                                                                      const TextSpan(
                                                                        text: ', ',
                                                                        style: TextStyle(),
                                                                      ),
                                                                      TextSpan(
                                                                        text: getJsonField(addressDetailsItem,
                                                                          r'''$.landmark''',).toString(),
                                                                        style: const TextStyle(),
                                                                      ),
                                                                      const TextSpan(
                                                                        text: ', ',
                                                                        style: TextStyle(),
                                                                      ),
                                                                      TextSpan(
                                                                        text: getJsonField(addressDetailsItem,
                                                                          r'''$.cityname''',).toString(),
                                                                        style: const TextStyle(),
                                                                      ),
                                                                      const TextSpan(
                                                                        text: ',',
                                                                        style: TextStyle(),
                                                                      ),
                                                                      TextSpan(
                                                                        text: getJsonField(addressDetailsItem,
                                                                          r'''$.statename''',).toString(),
                                                                        style: const TextStyle(),
                                                                      ),
                                                                      const TextSpan(
                                                                        text: '-',
                                                                        style: TextStyle(),
                                                                      ),
                                                                      TextSpan(
                                                                        text: getJsonField(addressDetailsItem,
                                                                          r'''$.pincode''',).toString(),
                                                                        style: const TextStyle(),
                                                                      )
                                                                    ],
                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                      fontFamily: 'Montserrat',
                                                                      color: FlutterFlowTheme.of(context).greyText,
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
                                                      const Divider(
                                                        thickness: 1,
                                                        color: Color(0xFFD3CEF6),
                                                      ),
                                                    Padding(
                                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
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
                                                              context.pushNamed(
                                                                'UpdateAddress',
                                                                queryParameters: {
                                                                  'addressId': serializeParam(
                                                                    getJsonField(addressDetailsItem,
                                                                      r'''$.id''',), ParamType.int,
                                                                  ),
                                                                  'editCountryId': serializeParam(
                                                                    getJsonField(addressDetailsItem,
                                                                      r'''$.country''',).toString(),
                                                                    ParamType.String,
                                                                  ),
                                                                  'editStateId': serializeParam(getJsonField(
                                                                      addressDetailsItem, r'''$.state''',
                                                                    ).toString(), ParamType.String,
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
                                                            },
                                                            child: Container(
                                                              width: MediaQuery.sizeOf(context).width * 0.3,
                                                              height: !_model.selectedAddress.contains(addressDetailsIndex)
                                                                  ? 4.0
                                                                  : 15.0,
                                                              decoration: const BoxDecoration(),
                                                              child: Visibility(
                                                                visible: _model.selectedAddress.contains(addressDetailsIndex),
                                                                child: Align(
                                                                  alignment: const AlignmentDirectional(0, 0),
                                                                  child: InkWell(
                                                                    splashColor: Colors.transparent,
                                                                    focusColor: Colors.transparent,
                                                                    hoverColor: Colors.transparent,
                                                                    highlightColor: Colors.transparent,
                                                                    onTap: () async {
                                                                      context.pushNamed(
                                                                        'UpdateAddress',
                                                                        queryParameters: {
                                                                          'addressId': serializeParam(
                                                                            getJsonField(addressDetailsItem,
                                                                              r'''$.id''',),
                                                                            ParamType.int,
                                                                          ),
                                                                          'editCountryId': serializeParam(
                                                                            getJsonField(addressDetailsItem,
                                                                              r'''$.country''',).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                          'editStateId': serializeParam(
                                                                            getJsonField(addressDetailsItem,
                                                                              r'''$.state''',).toString(),
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
                                                                    },
                                                                    child: Text(
                                                                      'EDIT',
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Montserrat',
                                                                        color: FlutterFlowTheme.of(context).primary,
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
                                                          InkWell(
                                                            splashColor: Colors.transparent,
                                                            focusColor: Colors.transparent,
                                                            hoverColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () async {
                                                              await showModalBottomSheet(
                                                                isScrollControlled: true,
                                                                backgroundColor: Colors.transparent,
                                                                enableDrag: false,
                                                                context: context,
                                                                builder: (context) {
                                                                  return GestureDetector(
                                                                    onTap: () => _model.unfocusNode.canRequestFocus
                                                                        ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                                        : FocusScope.of(context).unfocus(),
                                                                    child: Padding(
                                                                      padding: MediaQuery.viewInsetsOf(context),
                                                                      child: DeleteDialogWidget(
                                                                        deletionId: getJsonField(addressDetailsItem,
                                                                          r'''$.id''',).toString(),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) => safeSetState(() {}));
                                                            },
                                                            child: Container(
                                                              width: MediaQuery.sizeOf(context).width * 0.3,
                                                              height: !_model.selectedAddress.contains(addressDetailsIndex)
                                                                  ? 4.0
                                                                  : 15.0,
                                                              decoration: const BoxDecoration(),
                                                              child: Visibility(
                                                                visible: _model.selectedAddress.contains(addressDetailsIndex),
                                                                child: Align(
                                                                  alignment: const AlignmentDirectional(0, 0),
                                                                  child: InkWell(
                                                                    splashColor: Colors.transparent,
                                                                    focusColor: Colors.transparent,
                                                                    hoverColor: Colors.transparent,
                                                                    highlightColor: Colors.transparent,
                                                                    onTap: () async {
                                                                      await showModalBottomSheet(
                                                                        isScrollControlled: true,
                                                                        backgroundColor: Colors.transparent,
                                                                        enableDrag: false,
                                                                        context: context,
                                                                        builder: (context) {
                                                                          return GestureDetector(
                                                                            onTap: () => _model.unfocusNode.canRequestFocus
                                                                                ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                                                : FocusScope.of(context).unfocus(),
                                                                            child: Padding(
                                                                              padding: MediaQuery.viewInsetsOf(context),
                                                                              child: DeleteDialogWidget(
                                                                                deletionId: getJsonField(addressDetailsItem,
                                                                                  r'''$.id''',).toString(),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ).then((value) => safeSetState(() {}));
                                                                    },
                                                                    child: Text(
                                                                      'DELETE',
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Montserrat',
                                                                        color: FlutterFlowTheme.of(context).primary,
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
                                        }).divide(const SizedBox(height: 8)),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 70),
                          child: FFButtonWidget(
                            onPressed: () async {
                              context.pushNamed(
                                'AddNewAddress',
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: const TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.bottomToTop,
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
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).borderColor,
                                width: 1,
                              ),
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
          ],
        ),
        bottomNavigationBar: const CustomNavBarWidget(),
      ),
    );
  }
}
