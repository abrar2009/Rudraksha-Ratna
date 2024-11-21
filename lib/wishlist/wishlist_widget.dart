import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import '../auth/custom_auth/auth_util.dart';
import '../components/delete_dialog.dart';
import '../components/shimmer_widget.dart';
import '../flutter_flow/custom_functions.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'wishlist_model.dart';
export 'wishlist_model.dart';
import 'package:badges/badges.dart' as badges;

class WishlistWidget extends StatefulWidget {
  const WishlistWidget({super.key});

  @override
  State<WishlistWidget> createState() => _WishlistWidgetState();
}

class _WishlistWidgetState extends State<WishlistWidget> {
  late WishlistModel _model;

  final WishlistWidgetscaffoldKey = GlobalKey<ScaffoldState>();

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
        key: WishlistWidgetscaffoldKey,
        backgroundColor: Colors.white,
        appBar:  PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15), // Shadow color with opacity
                  offset: Offset(0, 4), // Move shadow downwards by 4 pixels
                  blurRadius: 6, // Blur radius for a softer shadow
                  spreadRadius: 1, // Spread radius for shadow expansion
                ),
              ],
            ),
            child: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              /*leading: FlutterFlowIconButton(
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
              ),*/
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
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15, top: 10),
                  child: FutureBuilder<ApiCallResponse>(
                    future: CartCall.call(
                      hosturl: FFAppConstants.hosturl,
                      token: currentAuthenticationToken,
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return const Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: ShimmerWidget(),
                          ),
                        );
                      }
                      final badgeCartResponse = snapshot.data!;
                      // Get the cart count
                      final cartCount = cartBadgeCount(badgeCartResponse.jsonBody);

                      // Check if the cart count is null or 0
                      if (cartCount == null || cartCount == '0') {
                        return InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(
                              'Cart',
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.rightToLeft,
                                  duration: Duration(milliseconds: 400),
                                ),
                              },
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                            ),
                            child: Image.asset(
                              'assets/images/Buy.png',
                              width: 30,
                              height: 30,
                              //fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }

                      return badges.Badge(
                        badgeContent: Text(
                          cartCount,
                          style: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            letterSpacing: 0,
                          ),
                        ),
                        showBadge: true,
                        position: badges.BadgePosition.topEnd(),
                        badgeAnimation: badges.BadgeAnimation.scale(),
                        badgeStyle: badges.BadgeStyle(
                          badgeColor: FlutterFlowTheme.of(context).primary,
                          elevation: 4,
                          padding: EdgeInsetsDirectional.fromSTEB(10, 2, 10, 2),
                        ),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(
                              'Cart',
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.rightToLeft,
                                  duration: Duration(milliseconds: 400),
                                ),
                              },
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                            ),
                            child: Image.asset(
                              'assets/images/Buy.png',
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
              centerTitle: true,
              elevation: 0.0,
            ),
          ),
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
                  print("wishList:${wishList}");
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
                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 18.0, 16.0, 60.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 7.0,
                        mainAxisSpacing: 7,
                        childAspectRatio: 0.7,
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: wishList.length,
                      itemBuilder: (context, wishListIndex) {
                        final wishListItem = wishList[wishListIndex];
                        return Stack(
                          children: [
                            Container(
                              //width: 168.0,
                              //height: 244.0,
                              height: MediaQuery.of(context).size.height * 0.30,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                borderRadius: BorderRadius.circular(2.0),
                                border: Border.all(
                                  color: Color(0xFFE7E7E8),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: CachedNetworkImage(
                                            fadeInDuration: Duration(milliseconds: 100),
                                            fadeOutDuration: Duration(milliseconds: 100),
                                            imageUrl: getJsonField(wishListItem, r'''$.thumbnail_image''').toString(),
                                            //width: 150,
                                            height: 104.65,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                                                            ),
                                      ),
                                      /*Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: CachedNetworkImage(
                                          fadeInDuration: Duration(milliseconds: 100),
                                          fadeOutDuration: Duration(milliseconds: 100),
                                          imageUrl: getJsonField(wishListItem, r'''$.thumbnail_image''').toString(),
                                          width: double.infinity,
                                          height: 104.65,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),*/
                                      Align(
                                        //alignment: AlignmentDirectional(0.74, -0.95),
                                        //alignment: AlignmentDirectional(0.898, -1.074),
                                        alignment: AlignmentDirectional(0.898, -1.1),
                                        child: GestureDetector(
                                          onTap: () async {
                                            FFAppState().wishlistItemId = getJsonField(
                                              wishListItem,
                                              r'''$.id''',
                                            );
                                            FFAppState().wishlistProductType = getJsonField(
                                              wishListItem,
                                              r'''$.mainprodtype''',
                                            );
                                            setState(() {});
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
                                                    //child: const DeleteWishlistWidget(),
                                                    child: DeleteItemDialog(
                                                      deletionId: FFAppState().wishlistItemId.toString(),
                                                      title: 'Are you sure you want to remove the product from the wishlist?',
                                                      deleteButtonText: 'Delete',
                                                      deleteApiCall: (id) async {
                                                        return await RemovefromWishlistCall.call(
                                                          hosturl: FFAppConstants.hosturl,
                                                          token: currentAuthenticationToken,
                                                          productId: FFAppState().wishlistItemId,
                                                          productType: FFAppState().wishlistProductType,
                                                        );
                                                      },
                                                      successMessageField: r'''$.msg''',
                                                      errorMessageField: r'''$.status''',
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then((value) => safeSetState(() {}));
                                          },
                                          child: SvgPicture.asset(
                                            'assets/images/bin_1.svg',
                                            width: 20,
                                            height: 20,
                                          ),
                                        ),
                                      )
                                    ]
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(9.0, 8.0, 9.0, 10.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:200,
                                          //height:30,
                                          child: Text(
                                            getJsonField(wishListItem, r'''$.product_name''').toString(),
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF696969),
                                              letterSpacing: 0.0,
                                            ),
                                            maxLines: 2,
                                          ),
                                        ),
                                        RichText(
                                          textScaler: MediaQuery.of(context).textScaler,
                                          text: TextSpan(
                                            children: [
                                              /*TextSpan(
                                                text: 'INR ',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF272728),
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),*/
                                              TextSpan(
                                                text: /*getJsonField(wishListItem, r'''$.selling_price''').toString(),*/
                                                '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(
                                                  getJsonField(wishListItem, r'''$.selling_price''').toString(),
                                                  FFAppState().currencyRate,
                                                )}',
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
                                      onPressed: () async {
                                        _model.apiResulth6o =  await SlugSearchCall.call(
                                          hosturl: FFAppConstants.hosturl,
                                          slugValue: getJsonField(
                                            wishListItem,
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
                                        if(_model.mainprodtype==5)
                                        {  context.pushNamed(
                                          'OtherProductDetails',
                                          queryParameters: {
                                            'productSlugValue':
                                            serializeParam(
                                              getJsonField(
                                                wishListItem,
                                                r'''$.slug_value''',
                                              ).toString(),
                                              ParamType.String,
                                            ),
                                            'outofstockValue':
                                            serializeParam(
                                              getJsonField(
                                                wishListItem,
                                                r'''$.out_of_stock''',
                                              ).toString(),
                                              ParamType.String,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey:
                                            TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                              PageTransitionType
                                                  .bottomToTop,
                                            ),
                                          },
                                        );}
                                        else if(_model.mainprodtype==3)
                                        { context.pushNamed(
                                          'DiamondProductDetails',
                                          queryParameters: {
                                            'productSlugValue': serializeParam(
                                              getJsonField(
                                                wishListItem,
                                                r'''$.slug_value''',
                                              ).toString(),
                                              ParamType.String,
                                            ),'producttype': FFAppConstants.RudrakshaMasterProductDetailsApi,

                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: TransitionInfo(
                                              hasTransition: true,
                                              transitionType: PageTransitionType.bottomToTop,
                                              duration: Duration(milliseconds: 400),
                                            ),
                                          },
                                        );}
                                        else if(_model.mainprodtype==4)
                                        {
                                          context.pushNamed(
                                            'YantraProductDetails',
                                            queryParameters: {
                                              'productSlugValue':
                                              serializeParam(
                                                getJsonField(
                                                  wishListItem,
                                                  r'''$.slug_value''',
                                                ).toString(),
                                                ParamType.String,
                                              ),
                                              'producttype': FFAppConstants
                                                  .YantraMasterProductDetailsApi,
                                            }.withoutNulls,
                                          );
                                        }
                                        else
                                        { context.pushNamed(
                                          'DiamondProductDetails',
                                          queryParameters: {
                                            'productSlugValue': serializeParam(
                                              getJsonField(
                                                wishListItem,
                                                r'''$.slug_value''',
                                              ).toString(),
                                              ParamType.String,
                                            ),'producttype': FFAppConstants.GemstoneMasterProductDetailsApi,

                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: TransitionInfo(
                                              hasTransition: true,
                                              transitionType: PageTransitionType.bottomToTop,
                                              duration: Duration(milliseconds: 400),
                                            ),
                                          },
                                        );}
                                      },
                                      text: 'Proceed to Buy',
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
                            /*Align(
                              //alignment: AlignmentDirectional(0.74, -0.95),
                              alignment: AlignmentDirectional(0.898, -1.074),
                              child: GestureDetector(
                                onTap: () async {
                                  FFAppState().wishlistItemId = getJsonField(
                                    wishListItem,
                                    r'''$.id''',
                                  );
                                  FFAppState().wishlistProductType = getJsonField(
                                    wishListItem,
                                    r'''$.mainprodtype''',
                                  );
                                  setState(() {});
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
                                          child: DeleteWishlistWidget(),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                                child: SvgPicture.asset(
                                  'assets/images/bin_1.svg',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            )*/
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