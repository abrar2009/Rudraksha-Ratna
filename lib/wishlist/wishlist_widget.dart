/*
import '../auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'wishlist_model.dart';
export 'wishlist_model.dart';

class WishlistWidget extends StatefulWidget {
  const WishlistWidget({super.key});

  @override
  State<WishlistWidget> createState() => _WishlistWidgetState();
}

class _WishlistWidgetState extends State<WishlistWidget> {
  late WishlistModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WishlistModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF272728),
              size: 30.0,
            ),
            onPressed: () async {context.pop();},
          ),
          title: Text(
            'Wishlist',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Outfit',
              color: Color(0xFF272728),
              fontSize: 16.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 18.0, 16.0, 0.0),
                      child: FutureBuilder<ApiCallResponse>(
                        future: WishListCall.call(
                          hosturl: FFAppConstants.hosturl,
                          token: currentAuthenticationToken,
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            );
                          }
                          final gridViewWishListResponse = snapshot.data!;
                          return Builder(
                            builder: (context) {
                              final wishList = getJsonField(
                                gridViewWishListResponse.jsonBody,
                                r'''$.data''',
                              ).toList();
                              return GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 7.0,
                                  mainAxisSpacing: 5.0,
                                  childAspectRatio: 0.7,
                                ),
                                scrollDirection: Axis.vertical,
                                itemCount: wishList.length,
                                itemBuilder: (context, wishListIndex) {
                                  final wishListItem = wishList[wishListIndex];
                                  return Stack(
                                    children: [
                                      Container(
                                        width: 168.0,
                                        height: 244.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                          borderRadius: BorderRadius.circular(2.0),
                                          border: Border.all(color: Color(0xFFE7E7E8),),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  getJsonField(wishListItem, r'''$.thumbnail_image''',).toString(),
                                                  width: double.infinity,
                                                  height: 104.65,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(9.0, 8.0, 9.0, 10.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(getJsonField(wishListItem, r'''$.product_name''',).toString(),
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF696969),
                                                      letterSpacing: 0.0,
                                                    ),
                                                  ),
                                                  RichText(
                                                    textScaler: MediaQuery.of(context).textScaler,
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'INR ',
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Montserrat',
                                                            color: Color(0xFF272728),
                                                            letterSpacing: 0.0,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: getJsonField(wishListItem, r'''$.selling_price''',).toString(),
                                                          style: TextStyle(),
                                                        )
                                                      ],
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
                                                        color: Color(0xFF272728),
                                                        letterSpacing: 0.0,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(height: 8.0)),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
                                              child: FFButtonWidget(
                                                onPressed: () {
                                                  print('Button pressed ...');
                                                },
                                                text: 'Add to Cart',
                                                options: FFButtonOptions(
                                                  width: double.infinity,
                                                  height: 40.0,
                                                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                  color: Colors.white,
                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF740074),
                                                    letterSpacing: 0.0,
                                                  ),
                                                  elevation: 0.0,
                                                  borderSide: BorderSide(color: Color(0xFF740074), width: 1.0,),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0.76, -0.9),
                                        child: FlutterFlowIconButton(
                                          borderColor: Colors.transparent,
                                          borderRadius: 20.0,
                                          borderWidth: 1.0,
                                          buttonSize: 40.0,
                                          fillColor: Color(0xA3FFFFFF),
                                          icon: Icon(
                                            Icons.delete_outline_rounded,
                                            color: Color(0xFFFB0000),
                                            size: 23.0,
                                          ),
                                          onPressed: () async {
                                            var _shouldSetState = false;
                                            _model.apiResult5ep =
                                            await RemovefromWishlistCall.call(
                                              token: currentAuthenticationToken,
                                              hosturl: FFAppConstants.hosturl,
                                              productId: getJsonField(wishListItem, r'''$.id''',),
                                              productType: getJsonField(wishListItem, r'''$.mainprodtype''',),
                                            );

                                            _shouldSetState = true;
                                            if ((_model.apiResult5ep?.succeeded ?? true)) {
                                              FFAppState().statusFailed = getJsonField((_model.apiResult5ep?.jsonBody ?? ''), r'''$.status''',).toString();
                                              setState(() {});
                                              ScaffoldMessenger.of(context).clearSnackBars();
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(getJsonField((_model.apiResult5ep?.jsonBody ?? ''), r'''$.msg''',).toString(),
                                                    style: TextStyle(
                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                  duration: Duration(milliseconds: 4000),
                                                  backgroundColor: FFAppState().statusFailed == 'success' ? Color(0xFF4BB543) : Color(0xFFFC100D),
                                                ),
                                              );
                                              if (FFAppState().statusFailed == 'success') {
                                                context.pushNamed('Wishlist',
                                                  extra: <String, dynamic>{
                                                    kTransitionInfoKey: TransitionInfo(
                                                      hasTransition: true,
                                                      transitionType: PageTransitionType.fade,
                                                      duration: Duration(milliseconds: 0),
                                                    ),
                                                  },
                                                );
                                              } else {
                                                if (_shouldSetState)
                                                  setState(() {});
                                                return;
                                              }
                                            } else {
                                              if (_shouldSetState)
                                                setState(() {});
                                              return;
                                            }

                                            if (_shouldSetState)
                                              setState(() {});
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: wrapWithModel(
                  model: _model.customNavBarModel,
                  updateCallback: () => setState(() {}),
                  child: CustomNavBarWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

import '../auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'wishlist_model.dart';
export 'wishlist_model.dart';

class WishlistWidget extends StatefulWidget {
  const WishlistWidget({super.key});

  @override
  State<WishlistWidget> createState() => _WishlistWidgetState();
}

class _WishlistWidgetState extends State<WishlistWidget> {
  late WishlistModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WishlistModel());
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF272728),
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Wishlist',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Outfit',
              color: Color(0xFF272728),
              fontSize: 16.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              FutureBuilder<ApiCallResponse>(
                future: WishListCall.call(
                  hosturl: FFAppConstants.hosturl,
                  token: currentAuthenticationToken,
                ),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    );
                  }
                  final gridViewWishListResponse = snapshot.data!;
                  final wishList = getJsonField(
                    gridViewWishListResponse.jsonBody,
                    r'''$.data''',
                  ).toList();

                  if (wishList.isEmpty) {
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
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
                              'Your wishlist is empty',
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
                  } else {
                    return GridView.builder(
                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 18.0, 16.0, 0.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 7.0,
                        mainAxisSpacing: 5.0,
                        childAspectRatio: 0.7,
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: wishList.length,
                      itemBuilder: (context, wishListIndex) {
                        final wishListItem = wishList[wishListIndex];
                        return Stack(
                          children: [
                            Container(
                              width: 168.0,
                              height: 244.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                borderRadius: BorderRadius.circular(2.0),
                                border: Border.all(
                                  color: Color(0xFFE7E7E8),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        getJsonField(wishListItem, r'''$.thumbnail_image''').toString(),
                                        width: double.infinity,
                                        height: 104.65,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(9.0, 8.0, 9.0, 10.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          getJsonField(wishListItem, r'''$.product_name''').toString(),
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF696969),
                                            letterSpacing: 0.0,
                                          ),
                                        ),
                                        RichText(
                                          textScaler: MediaQuery.of(context).textScaler,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'INR ',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF272728),
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              TextSpan(
                                                text: getJsonField(wishListItem, r'''$.selling_price''').toString(),
                                                style: TextStyle(),
                                              )
                                            ],
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF272728),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 8.0)),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        print('Button pressed ...');
                                      },
                                      text: 'Add to Cart',
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                        color: Colors.white,
                                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF740074),
                                          letterSpacing: 0.0,
                                        ),
                                        elevation: 0.0,
                                        borderSide: BorderSide(
                                          color: Color(0xFF740074),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.76, -0.9),
                              child: FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 20.0,
                                borderWidth: 1.0,
                                buttonSize: 40.0,
                                fillColor: Color(0xA3FFFFFF),
                                icon: Icon(
                                  Icons.delete_outline_rounded,
                                  color: Color(0xFFFB0000),
                                  size: 23.0,
                                ),
                                onPressed: () async {
                                  var _shouldSetState = false;
                                  _model.apiResult5ep = await RemovefromWishlistCall.call(
                                    token: currentAuthenticationToken,
                                    hosturl: FFAppConstants.hosturl,
                                    productId: getJsonField(wishListItem, r'''$.id'''),
                                    productType: getJsonField(wishListItem, r'''$.mainprodtype'''),
                                  );

                                  _shouldSetState = true;
                                  if ((_model.apiResult5ep?.succeeded ?? true)) {
                                    FFAppState().statusFailed = getJsonField(
                                        (_model.apiResult5ep?.jsonBody ?? ''), r'''$.status''').toString();
                                    setState(() {});
                                    ScaffoldMessenger.of(context).clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          getJsonField((_model.apiResult5ep?.jsonBody ?? ''), r'''$.msg''').toString(),
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor: FFAppState().statusFailed == 'success'
                                            ? Color(0xFF4BB543)
                                            : Color(0xFFFC100D),
                                      ),
                                    );
                                    if (FFAppState().statusFailed == 'success') {
                                      context.pushNamed(
                                        'Wishlist',
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

                                  if (_shouldSetState) setState(() {});
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: wrapWithModel(
                  model: _model.customNavBarModel,
                  updateCallback: () => setState(() {}),
                  child: CustomNavBarWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
