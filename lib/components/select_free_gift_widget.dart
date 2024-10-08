import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'select_free_gift_model.dart';
export 'select_free_gift_model.dart';

class SelectFreeGiftWidget extends StatefulWidget {
  const SelectFreeGiftWidget({super.key});

  @override
  State<SelectFreeGiftWidget> createState() => _SelectFreeGiftWidgetState();
}

class _SelectFreeGiftWidgetState extends State<SelectFreeGiftWidget> {
  late SelectFreeGiftModel _model;
  int? _selectedGiftId; // Variable to hold the selected gift ID

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectFreeGiftModel());
    _loadSelectedGift(); // Load the selected gift when the widget initializes
  }

  Future<void> _loadSelectedGift() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedGiftId = prefs.getInt('selectedGiftId');
    });
  }

  Future<void> _saveSelectedGift(int? giftId) async {
    final prefs = await SharedPreferences.getInstance();
    if (giftId != null) {
      await prefs.setInt('selectedGiftId', giftId);
    } else {
      await prefs.remove('selectedGiftId');
    }
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
      height: 734,
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
            child: Container(
              width: 100,
              height: 28,
              decoration: BoxDecoration(
                color: Color(0x00FFFFFF),
              ),
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
          ),
          Container(
            width: double.infinity,
            height: 706,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Select Free Gifts',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF272728),
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: FutureBuilder<ApiCallResponse>(
                        future: FetchShippingCall.call(
                          hosturl: FFAppConstants.hosturl,
                          shippingCountry: FFAppState().countryName,
                          shippingWeight: FFAppState().courierTotal,
                          totalPrice: FFAppState().cartTotal,
                          orderTotal: FFAppState().orderTotal,
                        ),
                        builder: (context, snapshot) {
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
                          final gridViewFetchShippingResponse = snapshot.data!;

                          return Builder(
                            builder: (context) {
                              final freeGiftsList = getJsonField(
                                gridViewFetchShippingResponse.jsonBody,
                                r'''$.giftdata''',
                              ).toList();

                              return GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 7,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 1,
                                ),
                                scrollDirection: Axis.vertical,
                                itemCount: freeGiftsList.length,
                                itemBuilder: (context, freeGiftsListIndex) {
                                  final freeGiftsListItem = freeGiftsList[freeGiftsListIndex];
                                  final int giftId = FetchShippingCall.giftsIds(
                                    gridViewFetchShippingResponse.jsonBody,
                                  )?[freeGiftsListIndex] ?? -1;
                                  bool isSelected = _selectedGiftId == giftId;

                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      setState(() {
                                        if (_selectedGiftId == giftId) {
                                          _selectedGiftId = null;
                                          _model.selectedGiftName = null;
                                          FFAppState().selectedGiftName = '';
                                        } else {
                                          _selectedGiftId = giftId;
                                          _model.selectedGiftName =
                                              getJsonField(
                                                freeGiftsListItem,
                                                r'''$.gift_name''',
                                              ).toString();
                                        }
                                        _saveSelectedGift(_selectedGiftId);
                                      });
                                    },
                                    child: Container(
                                      width: 160,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: isSelected ? Color(0xFF740074) : Color(0xFFE7E7E8),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 6),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Image.network(
                                                getJsonField(freeGiftsListItem, r'''$.image''').toString(),
                                                width: 160,
                                                height: 104,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 1,
                                            color: Color(0xFFE7E7E8),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                            child: Text(
                                              getJsonField(freeGiftsListItem, r'''$.gift_name''').toString(),
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF272728),
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                    child: FFButtonWidget(
                      onPressed: (_selectedGiftId == null)
                          ? null
                          : () async {
                        FFAppState().selectedGiftId = _selectedGiftId!;
                        FFAppState().selectedGiftName = _model.selectedGiftName!;
                        setState(() {});
                        context.safePop();
                        print('Gift Id: ${FFAppState().selectedGiftId}');
                      },
                      text: 'Select',
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
                        disabledColor: Color(0xFFF3F3F3),
                        disabledTextColor: Color(0xFFB7B7B8),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


/*
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'select_free_gift_model.dart';
export 'select_free_gift_model.dart';

class SelectFreeGiftWidget extends StatefulWidget {
  const SelectFreeGiftWidget({super.key});

  @override
  State<SelectFreeGiftWidget> createState() => _SelectFreeGiftWidgetState();
}

class _SelectFreeGiftWidgetState extends State<SelectFreeGiftWidget> {
  late SelectFreeGiftModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectFreeGiftModel());
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
      height: 734,
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
            child: Container(
              width: 100,
              height: 28,
              decoration: BoxDecoration(
                color: Color(0x00FFFFFF),
              ),
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
          ),
          Container(
            width: double.infinity,
            height: 706,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Select Free Gifts',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF272728),
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16),
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
                          final gridViewFetchShippingResponse = snapshot.data!;

                          return Builder(
                            builder: (context) {
                              final freeGiftsList = getJsonField(
                                gridViewFetchShippingResponse.jsonBody,
                                r'''$.giftdata''',
                              ).toList();

                              return GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 7,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 1,
                                ),
                                scrollDirection: Axis.vertical,
                                itemCount: freeGiftsList.length,
                                itemBuilder: (context, freeGiftsListIndex) {
                                  final freeGiftsListItem =
                                  freeGiftsList[freeGiftsListIndex];
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      setState(() {
                                        if (_model.giftDataIndex == freeGiftsListIndex) {
                                          // If the same gift is tapped again, deselect it.
                                          _model.selected = false;
                                          _model.giftDataIndex = null;
                                          _model.selectedGiftId = null;
                                          _model.selectedGiftName = null;
                                        } else {
                                          // Select a new gift.
                                          _model.selected = true;
                                          _model.giftDataIndex = freeGiftsListIndex;
                                          _model.selectedGiftId =
                                          FetchShippingCall.giftsIds(
                                            gridViewFetchShippingResponse.jsonBody,
                                          )?[_model.giftDataIndex!];
                                          _model.selectedGiftName =
                                              getJsonField(
                                                freeGiftsListItem,
                                                r'''$.gift_name''',
                                              ).toString();
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: 160,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: freeGiftsListIndex ==
                                              _model.giftDataIndex
                                              ? Color(0xFF740074)
                                              : Color(0xFFE7E7E8),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(0, 4, 0, 6),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(8),
                                              child: Image.network(
                                                getJsonField(
                                                  freeGiftsListItem,
                                                  r'''$.image''',
                                                ).toString(),
                                                width: 160,
                                                height: 104,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 1,
                                            color: Color(0xFFE7E7E8),
                                          ),
                                          Text(
                                            getJsonField(
                                              freeGiftsListItem,
                                              r'''$.gift_name''',
                                            ).toString(),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF272728),
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                    child: FFButtonWidget(
                      onPressed: (_model.giftDataIndex == null)
                          ? null
                          : () async {
                        FFAppState().selectedGiftId = _model.selectedGiftId!;
                        FFAppState().selectedGiftName = _model.selectedGiftName!;
                        setState(() {});
                        context.safePop();
                        print('Gift Id: ${FFAppState().selectedGiftId}');
                        print('Gift Name: ${FFAppState().selectedGiftName}');
                      },
                      text: 'Select',
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
                        disabledColor: Color(0xFFF3F3F3),
                        disabledTextColor: Color(0xFFB7B7B8),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
