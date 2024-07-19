import 'package:cached_network_image/cached_network_image.dart';
import '../../auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/error404_screen_widget.dart';
import '/components/filter_component_widget.dart';
import '/components/shimmer_widget.dart';
import '/components/sort_by_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'main_products_model.dart';
export 'main_products_model.dart';

class MainProductsWidget extends StatefulWidget {
  const MainProductsWidget({
    super.key,
    required this.productType,
    required this.productslugvalue,
    required this.producttitle,
  });

  final String? productType;
  final String? productslugvalue;
  final String? producttitle;

  @override
  State<MainProductsWidget> createState() => _MainProductsWidgetState();
}

class _MainProductsWidgetState extends State<MainProductsWidget> {
  late MainProductsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    print("widget.producttitle:${widget.producttitle}");
    super.initState();
    _model = createModel(context, () => MainProductsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if ((widget.productType == 'Rudraksha')) {
        _model.apiResultd4z = await RudrakshaProductCall.call(
          slugValue: widget.productslugvalue,
          hosturl: FFAppConstants.hosturl,
        );

        _model.statuscode = (_model.apiResultd4z?.statusCode ?? 200);
        setState(() {});
        print(_model.statuscode);
      } else if (widget.productType == 'Yantras') {
        _model.apiResultk1p = await YantraProductCall.call();

        _model.statuscode = (_model.apiResultk1p?.statusCode ?? 200);
        print(widget.productType);
        setState(() {});
      } else if (widget.productType == 'PujaMainCategory') {
        _model.pujaMainActionResult = await PujaProductCall.call();

        _model.statuscode = (_model.pujaMainActionResult?.statusCode ?? 200);
        print(widget.productType);
        setState(() {});
      } else if (widget.productType == 'PujaSubCategory') {
        _model.pujaSubActionResult = await PujaProductCall.call();

        _model.statuscode = (_model.pujaSubActionResult?.statusCode ?? 200);
        print(widget.productType);
        setState(() {});
      } else if (widget.productType == 'OthersSubCategory') {
        _model.otherSubProductResult =
            await OtherProductMainCategoryCall.call();

        _model.statuscode = (_model.otherSubProductResult?.statusCode ?? 200);
        print(widget.productType);
        setState(() {});
      } else if (widget.productType == 'OthersMainCategory') {
        _model.otherMainProductResult =
            await OtherProductMainCategoryCall.call();

        _model.statuscode = (_model.otherMainProductResult?.statusCode ?? 200);
        print(widget.productType);
        setState(() {});
      } /*else if (widget.productType == 'Puja') {
        _model.pujaActionResult = await PujaProductCall.call(
          slugValue: widget.productslugvalue,
          hosturl: FFAppConstants.hosturl,
        );


        _model.statuscode = (_model.pujaActionResult?.statusCode ?? 200);
        setState(() {});
      }*/
    });
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: _model.statuscode == 200
            ? AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                leading: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30,
                  borderWidth: 1,
                  buttonSize: 54,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Color(0xFF272728),
                    size: 30,
                  ),
                  onPressed: () async {
                    context.safePop();
                  },
                ),
                title: Text(
                  // 'Page Title',
                  widget.producttitle!,

                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Outfit',
                        color: Color(0xFF272728),
                        fontSize: 16,
                        letterSpacing: 0,
                      ),
                ),
                actions: [],
                centerTitle: true,
                elevation: 0,
              )
            : //null,
            AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                leading: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30,
                  borderWidth: 1,
                  buttonSize: 54,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Color(0xFF272728),
                    size: 30,
                  ),
                  onPressed: () async {
                    context.pop();
                    //  context.safePop();
                    FFAppState().SelectedSizeGrade = '';
                    FFAppState().BeadSizeMax = '';
                    FFAppState().BeadSizeMin = '';
                    FFAppState().YantraMaxPrice = '';
                    FFAppState().YantraMinPrice = '';
                    FFAppState().YantrasDeityPurpose = '';
                    FFAppState().minpricepercaratString = '';
                    FFAppState().maxpricepercaratString = '';
                    FFAppState().minrattiweightString = '';
                    FFAppState().maxrattiweightString = '';
                    FFAppState().mincaratweightString = '';
                    FFAppState().maxcaratweightString = '';
                    FFAppState().rangeendString = '';
                    FFAppState().rangestartString = '';
                    setState(() {});
                  },
                ),
                title: Text(
                  widget.producttitle!,
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Outfit',
                        color: Color(0xFF272728),
                        fontSize: 16,
                        letterSpacing: 0,
                      ),
                ),
                actions: [],
                centerTitle: true,
                elevation: 0,
              ),
        body: SafeArea(
          top: true,
          child: Container(
            decoration: BoxDecoration(),
            child: Builder(
              builder: (context) {
                if (((_model.apiResultd4z?.statusCode ?? 200) == 200) &&
                    (widget.productType == 'Rudraksha')) {
                  return Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: FutureBuilder<ApiCallResponse>(
                      future: RudrakshaProductCall.call(
                        hosturl: FFAppConstants.hosturl,
                        slugValue: widget.productslugvalue,
                        maxPrice: FFAppState().rangeendString,
                        minPrice: FFAppState().rangestartString,
                        sizeGrade: FFAppState().SelectedSizeGrade,
                        sort_by: FFAppState().sortby
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: ShimmerWidget(),
                          );
                        }
                        final rudrakshaRudrakshaProductResponse =
                            snapshot.data!;
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
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
                                                    .requestFocus(
                                                        _model.unfocusNode)
                                                : FocusScope.of(context)
                                                    .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: Container(
                                                height: 356,
                                                child: SortByWidget(),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Container(
                                      width: 90,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .containerFillColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .borderColor,
                                        ),
                                      ),
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/Swap.png',
                                                width: 15.0,
                                                height: 15.0,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Text(
                                              'Sort',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        letterSpacing: 0,
                                                      ),
                                            ),
                                          ].divide(SizedBox(width: 8)),
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
                                              child: FilterComponentWidget(
                                                productFilterbytype: 'Gemstone',
                                                maxprice: RudrakshaProductCall
                                                    .constantmaxprice(
                                                  rudrakshaRudrakshaProductResponse
                                                      .jsonBody,
                                                )?.toDouble(),
                                                minprice: RudrakshaProductCall
                                                    .constantminprice(
                                                  rudrakshaRudrakshaProductResponse
                                                      .jsonBody,
                                                )?.toDouble(),
                                                sizegrade: FFAppState()
                                                    .SelectedSizeGrade,
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Container(
                                      width: 90,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .containerFillColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .borderColor,
                                        ),
                                      ),
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.asset(
                                                'assets/images/sort.png',
                                                width: 15,
                                                height: 15,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Text(
                                              'Filter',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        letterSpacing: 0,
                                                      ),
                                            ),
                                          ].divide(SizedBox(width: 8)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 10)),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 18, 16, 16),
                                child: Builder(
                                  builder: (context) {
                                    final productgridlist =
                                        RudrakshaProductCall.productlist(
                                              rudrakshaRudrakshaProductResponse
                                                  .jsonBody,
                                            )?.toList() ??
                                            [];
                                    return GridView.builder(
                                      padding: EdgeInsets.zero,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 9,
                                        mainAxisSpacing: 9,
                                        childAspectRatio: 0.82,
                                      ),
                                      scrollDirection: Axis.vertical,
                                      itemCount: productgridlist.length,
                                      itemBuilder:
                                          (context, productgridlistIndex) {
                                        final productgridlistItem =
                                            productgridlist[
                                                productgridlistIndex];
                                        return Stack(
                                          children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  'DiamondProductDetails',
                                                  queryParameters: {
                                                    'productSlugValue':
                                                        serializeParam(
                                                      getJsonField(
                                                        productgridlistItem,
                                                        r'''$.slug_value''',
                                                      ).toString(),
                                                      ParamType.String,
                                                    ),
                                                    'producttype': FFAppConstants
                                                        .RudrakshaMasterProductDetailsApi,
                                                  }.withoutNulls,
                                                );
                                              },
                                              child: Container(
                                                // width: 168,
                                                //height: 193,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .borderColor,
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child:
                                                            CachedNetworkImage(
                                                          fadeInDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      100),
                                                          fadeOutDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      100),
                                                          imageUrl:
                                                              getJsonField(
                                                            productgridlistItem,
                                                            r'''$.image''',
                                                          ).toString(),
                                                          width:
                                                              double.infinity,
                                                          height: 104.65,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  9, 8, 9, 10),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            height: 36,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Text(
                                                              getJsonField(
                                                                productgridlistItem,
                                                                r'''$.product_name''',
                                                              ).toString(),
                                                              maxLines: 2,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .productName,
                                                                    letterSpacing:
                                                                        0,
                                                                  ),
                                                            ),
                                                          ),
                                                          RichText(
                                                            textScaler:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .textScaler,
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: 'INR ',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        color: Color(
                                                                            0xFF272728),
                                                                        letterSpacing:
                                                                            0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                ),
                                                                TextSpan(
                                                                  text:
                                                                      getJsonField(
                                                                    productgridlistItem,
                                                                    r'''$.selling_price''',
                                                                  ).toString(),
                                                                  style:
                                                                      TextStyle(),
                                                                )
                                                              ],
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    letterSpacing:
                                                                        0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 8)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(1, -1),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 5, 5, 0),
                                                child:
                                                    FutureBuilder<
                                                            ApiCallResponse>(
                                                        future:
                                                            WishListCall.call(
                                                          hosturl:
                                                              FFAppConstants
                                                                  .sanityurl,
                                                          token: currentAuthenticationToken
                                                            ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Container(
                                                              width: 1,
                                                              height: 1,
                                                              child:
                                                                  ShimmerWidget(),
                                                            );
                                                          }
                                                          final containerWishlistResponse =
                                                              snapshot.data!;

                                                          return Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24),
                                                            ),
                                                            child: Builder(
                                                              builder:
                                                                  (context) {
                                                                print(WishListCall.id(
                                                                    containerWishlistResponse
                                                                        .jsonBody));
                                                                print(
                                                                  getJsonField(
                                                                    productgridlistItem,
                                                                    r'''$.product_id''',
                                                                  ).toString(),
                                                                );
                                                                if (!WishListCall
                                                                        .id(
                                                                  containerWishlistResponse
                                                                      .jsonBody,
                                                                )!
                                                                    .contains(
                                                                        getJsonField(
                                                                  productgridlistItem,
                                                                  r'''$.product_id''',
                                                                ))) {
                                                                  return Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        _model.addToProductid(
                                                                            productgridlistIndex.toString());
                                                                        if (currentAuthenticationToken !=
                                                                                null &&
                                                                            currentAuthenticationToken !=
                                                                                '') {
                                                                          _model.addtoWishlist =
                                                                              await AddToWishlistCall.call(
                                                                            hosturl:
                                                                                FFAppConstants.sanityurl,
                                                                            token:
                                                                                currentAuthenticationToken,
                                                                            productid:
                                                                                getJsonField(
                                                                              productgridlistItem,
                                                                              r'''$.product_id''',
                                                                            ),
                                                                            productType:
                                                                                getJsonField(
                                                                              productgridlistItem,
                                                                              r'''$.mainprodtype''',
                                                                            ),
                                                                          );
                                                                          if ((_model.addtoWishlist?.succeeded ??
                                                                              true)) {
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                content: Text(
                                                                                  "Product added in wishlist",
                                                                                  style: TextStyle(
                                                                                    color: FlutterFlowTheme.of(context).containerFillColor,
                                                                                  ),
                                                                                ),
                                                                                duration: Duration(milliseconds: 4000),
                                                                                backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                              ),
                                                                            );
                                                                          } else {
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                content: Text(
                                                                                  getJsonField(
                                                                                    (_model.addtoWishlist?.jsonBody ?? ''),
                                                                                    r'''$.status''',
                                                                                  ).toString(),
                                                                                  style: TextStyle(
                                                                                    color: FlutterFlowTheme.of(context).containerFillColor,
                                                                                  ),
                                                                                ),
                                                                                duration: Duration(milliseconds: 4000),
                                                                                backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                              ),
                                                                            );
                                                                          }

                                                                          setState(
                                                                              () {});
                                                                        } else {
                                                                          context
                                                                              .pushNamed(
                                                                            'LoginPage',
                                                                            extra: <String,
                                                                                dynamic>{
                                                                              kTransitionInfoKey: TransitionInfo(
                                                                                hasTransition: true,
                                                                                transitionType: PageTransitionType.fade,
                                                                                duration: Duration(milliseconds: 0),
                                                                              ),
                                                                            },
                                                                          );
                                                                        }

                                                                        setState(
                                                                            () {});
                                                                        HapticFeedback
                                                                            .lightImpact();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            24,
                                                                        height:
                                                                            24,
                                                                        clipBehavior:
                                                                            Clip.antiAlias,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/HeartEmpty.png',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        var _shouldSetState =
                                                                            false;
                                                                        _model.apiResult5ep =
                                                                            await RemovefromWishlistCall.call(
                                                                          token:
                                                                              currentAuthenticationToken,
                                                                          hosturl:
                                                                              FFAppConstants.hosturl,
                                                                          productId:
                                                                              getJsonField(
                                                                            productgridlistItem,
                                                                            r'''$.product_id''',
                                                                          ),
                                                                          productType:
                                                                              getJsonField(
                                                                            productgridlistItem,
                                                                            r'''$.mainprodtype''',
                                                                          ),
                                                                        );

                                                                        _shouldSetState =
                                                                            true;
                                                                        if ((_model.apiResult5ep?.succeeded ??
                                                                            true)) {
                                                                          FFAppState().statusFailed =
                                                                              getJsonField((_model.apiResult5ep?.jsonBody ?? ''), r'''$.status''').toString();
                                                                          setState(
                                                                              () {});
                                                                          ScaffoldMessenger.of(context)
                                                                              .clearSnackBars();
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            SnackBar(
                                                                              content: Text(
                                                                                getJsonField((_model.apiResult5ep?.jsonBody ?? ''), r'''$.msg''').toString(),
                                                                                style: TextStyle(
                                                                                  color: FlutterFlowTheme.of(context).containerFillColor,
                                                                                ),
                                                                              ),
                                                                              duration: Duration(milliseconds: 4000),
                                                                              backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                            ),
                                                                          );
                                                                          if (FFAppState().statusFailed ==
                                                                              'success') {
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
                                                                        _model.removeFromProductid(
                                                                            productgridlistIndex.toString());
                                                                        setState(
                                                                            () {});

                                                                        setState(
                                                                            () {});
                                                                        HapticFeedback
                                                                            .lightImpact();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            24,
                                                                        height:
                                                                            24,
                                                                        clipBehavior:
                                                                            Clip.antiAlias,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/HeartFilled.png',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                          );
                                                        }),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                } else if (/*((_model.apiResultd4z?.statusCode ?? 200) == 200) &&*/
                    (widget.productType == 'Yantras')) {
                  return Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                    child: FutureBuilder<ApiCallResponse>(
                      future: YantraProductCall.call(
                        hosturl: FFAppConstants.hosturl,
                        slugValue: widget.productslugvalue,
                        maxPrice: FFAppState().rangeendString,
                        minPrice: FFAppState().rangeendString,
                        diety: FFAppState().YantrasDeityPurpose,

                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: ShimmerWidget(),
                          );
                        }
                        final yantrasYantraProductResponse = snapshot.data!;
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
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
                                                    .requestFocus(
                                                        _model.unfocusNode)
                                                : FocusScope.of(context)
                                                    .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: FilterComponentWidget(
                                                productFilterbytype: 'Yantras',
                                                maxprice: YantraProductCall
                                                    .yantraconstantmaxprice(
                                                  yantrasYantraProductResponse
                                                      .jsonBody,
                                                )?.toDouble(),
                                                minprice: YantraProductCall
                                                    .yantraconstantminprice(
                                                  yantrasYantraProductResponse
                                                      .jsonBody,
                                                )?.toDouble(),
                                                deityPurpose: YantraProductCall
                                                    .yantraconstantdietylist(
                                                  yantrasYantraProductResponse
                                                      .jsonBody,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Container(
                                      width: 90.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .containerFillColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .borderColor,
                                        ),
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/Swap.png',
                                                width: 15.0,
                                                height: 15.0,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Text(
                                              'Sort',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ].divide(SizedBox(width: 8.0)),
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
                                              child: FilterComponentWidget(
                                                productFilterbytype: 'Yantras',
                                                maxprice: YantraProductCall
                                                    .yantraconstantmaxprice(
                                                  yantrasYantraProductResponse
                                                      .jsonBody,
                                                )?.toDouble(),
                                                minprice: YantraProductCall
                                                    .yantraconstantminprice(
                                                  yantrasYantraProductResponse
                                                      .jsonBody,
                                                )?.toDouble(),
                                                deityPurpose: YantraProductCall
                                                    .yantraconstantdietylist(
                                                  yantrasYantraProductResponse
                                                      .jsonBody,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Container(
                                      width: 90.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .containerFillColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .borderColor,
                                        ),
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/sort.png',
                                                width: 15.0,
                                                height: 15.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Text(
                                              'Filter',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ].divide(SizedBox(width: 8.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 10.0)),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 18.0, 16.0, 16),
                                child: Builder(
                                  builder: (context) {
                                    final yantrasgridlist =
                                        YantraProductCall.yantrProductData(
                                              yantrasYantraProductResponse
                                                  .jsonBody,
                                            )?.toList() ??
                                            [];
                                    return GridView.builder(
                                      padding: EdgeInsets.zero,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        /*crossAxisCount: 2,
                                        crossAxisSpacing: 7.0,
                                        mainAxisSpacing: 0.0,
                                        childAspectRatio: 0.8,*/
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 9,
                                        mainAxisSpacing: 9,
                                        childAspectRatio: 0.82,
                                      ),
                                      scrollDirection: Axis.vertical,
                                      itemCount: yantrasgridlist.length,
                                      itemBuilder:
                                          (context, yantrasgridlistIndex) {
                                        final yantrasgridlistItem =
                                            yantrasgridlist[
                                                yantrasgridlistIndex];
                                        return Stack(
                                          children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                              Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  'YantraProductDetails',
                                                  queryParameters: {
                                                    'productSlugValue':
                                                    serializeParam(
                                                      getJsonField(
                                                        yantrasgridlistItem,
                                                        r'''$.slug_value''',
                                                      ).toString(),
                                                      ParamType.String,
                                                    ),
                                                    'producttype': FFAppConstants
                                                        .YantraMasterProductDetailsApi,
                                                  }.withoutNulls,
                                                );
                                              },
                                              child: Container(
                                                //width: 168.0,
                                                //height: 193.0,
                                                decoration: BoxDecoration(
                                                  color:
                                                      FlutterFlowTheme.of(context)
                                                          .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(2.0),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .borderColor,
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(4.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                8.0),
                                                        child: CachedNetworkImage(
                                                          fadeInDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      100),
                                                          fadeOutDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      100),
                                                          imageUrl: getJsonField(
                                                            yantrasgridlistItem,
                                                            r'''$.image''',
                                                          ).toString(),
                                                          width: double.infinity,
                                                          height: 104.65,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(9.0, 8.0,
                                                                  9.0, 10.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            height: 36.0,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Text(
                                                              getJsonField(
                                                                yantrasgridlistItem,
                                                                r'''$.product_name''',
                                                              ).toString(),
                                                              maxLines: 2,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .productName,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                          RichText(
                                                            textScaler:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .textScaler,
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: 'INR ',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        color: Color(
                                                                            0xFF272728),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                      ),
                                                                ),
                                                                TextSpan(
                                                                  text:
                                                                      getJsonField(
                                                                    yantrasgridlistItem,
                                                                    r'''$.selling_price''',
                                                                  ).toString(),
                                                                  style:
                                                                      TextStyle(),
                                                                )
                                                              ],
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 8.0)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, -1.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 5.0, 5.0, 0.0),
                                                child:
                                                    FutureBuilder<
                                                            ApiCallResponse>(
                                                        future:
                                                            WishListCall.call(
                                                          hosturl:
                                                              FFAppConstants
                                                                  .sanityurl,
                                                          token: currentAuthenticationToken
                                                            ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Container(
                                                              width: 1,
                                                              height: 1,
                                                              child:
                                                                  ShimmerWidget(),
                                                            );
                                                          }
                                                          final containerWishlistResponse =
                                                              snapshot.data!;

                                                          return Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24),
                                                            ),
                                                            child: Builder(
                                                              builder:
                                                                  (context) {
                                                                print(WishListCall.id(
                                                                    containerWishlistResponse
                                                                        .jsonBody));
                                                                print(
                                                                  getJsonField(
                                                                    yantrasgridlistItem,
                                                                    r'''$.product_id''',
                                                                  ).toString(),
                                                                );
                                                                if (!WishListCall
                                                                        .id(
                                                                  containerWishlistResponse
                                                                      .jsonBody,
                                                                )!
                                                                    .contains(
                                                                        getJsonField(
                                                                  yantrasgridlistItem,
                                                                  r'''$.product_id''',
                                                                ))) {
                                                                  return Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            5.0),
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        if (currentAuthenticationToken !=
                                                                                null &&
                                                                            currentAuthenticationToken !=
                                                                                '') {
                                                                          _model.addtoWishlist =
                                                                              await AddToWishlistCall.call(
                                                                            hosturl:
                                                                                FFAppConstants.sanityurl,
                                                                            token:
                                                                                currentAuthenticationToken,
                                                                            productid:
                                                                                getJsonField(
                                                                                  yantrasgridlistItem,
                                                                              r'''$.product_id''',
                                                                            ),
                                                                            productType:
                                                                                getJsonField(
                                                                                  yantrasgridlistItem,
                                                                              r'''$.mainprodtype''',
                                                                            ),
                                                                          );
                                                                          if ((_model.addtoWishlist?.succeeded ??
                                                                              true)) {
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                content: Text(
                                                                                  "Product added in wishlist",
                                                                                  style: TextStyle(
                                                                                    color: FlutterFlowTheme.of(context).containerFillColor,
                                                                                  ),
                                                                                ),
                                                                                duration: Duration(milliseconds: 4000),
                                                                                backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                              ),
                                                                            );
                                                                          } else {
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                content: Text(
                                                                                  getJsonField(
                                                                                    (_model.addtoWishlist?.jsonBody ?? ''),
                                                                                    r'''$.status''',
                                                                                  ).toString(),
                                                                                  style: TextStyle(
                                                                                    color: FlutterFlowTheme.of(context).containerFillColor,
                                                                                  ),
                                                                                ),
                                                                                duration: Duration(milliseconds: 4000),
                                                                                backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                              ),
                                                                            );
                                                                          }
                                                                          _model
                                                                              .addToProductid(yantrasgridlistIndex.toString());
                                                                          setState(
                                                                              () {});
                                                                        } else {
                                                                          context
                                                                              .pushNamed(
                                                                            'LoginPage',
                                                                            extra: <String,
                                                                                dynamic>{
                                                                              kTransitionInfoKey: TransitionInfo(
                                                                                hasTransition: true,
                                                                                transitionType: PageTransitionType.fade,
                                                                                duration: Duration(milliseconds: 0),
                                                                              ),
                                                                            },
                                                                          );
                                                                        }

                                                                        setState(
                                                                            () {});
                                                                        HapticFeedback
                                                                            .lightImpact();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            24.0,
                                                                        height:
                                                                            24.0,
                                                                        clipBehavior:
                                                                            Clip.antiAlias,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/HeartEmpty.png',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            5.0),
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                            var _shouldSetState =
                                                                            false;
                                                                            _model.apiResult5ep =
                                                                            await RemovefromWishlistCall.call(
                                                                              token:
                                                                              currentAuthenticationToken,
                                                                              hosturl:
                                                                              FFAppConstants.hosturl,
                                                                              productId:
                                                                              getJsonField(
                                                                                yantrasgridlistItem,
                                                                                r'''$.product_id''',
                                                                              ),
                                                                              productType:
                                                                              getJsonField(
                                                                                yantrasgridlistItem,
                                                                                r'''$.mainprodtype''',
                                                                              ),
                                                                            );

                                                                            _shouldSetState =
                                                                            true;
                                                                            if ((_model.apiResult5ep?.succeeded ??
                                                                                true)) {
                                                                              FFAppState().statusFailed =
                                                                                  getJsonField((_model.apiResult5ep?.jsonBody ?? ''), r'''$.status''').toString();
                                                                              setState(
                                                                                      () {});
                                                                              ScaffoldMessenger.of(context)
                                                                                  .clearSnackBars();
                                                                              ScaffoldMessenger.of(context)
                                                                                  .showSnackBar(
                                                                                SnackBar(
                                                                                  content: Text(
                                                                                    getJsonField((_model.apiResult5ep?.jsonBody ?? ''), r'''$.msg''').toString(),
                                                                                    style: TextStyle(
                                                                                      color: FlutterFlowTheme.of(context).containerFillColor,
                                                                                    ),
                                                                                  ),
                                                                                  duration: Duration(milliseconds: 4000),
                                                                                  backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                                ),
                                                                              );
                                                                              if (FFAppState().statusFailed ==
                                                                                  'success') {
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

                                                                            setState(
                                                                                    () {});

                                                                            _model.removeFromProductid(
                                                                            yantrasgridlistIndex.toString());
                                                                        setState(
                                                                            () {});

                                                                        setState(
                                                                            () {});
                                                                        HapticFeedback
                                                                            .lightImpact();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            24.0,
                                                                        height:
                                                                            24.0,
                                                                        clipBehavior:
                                                                            Clip.antiAlias,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/HeartFilled.png',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                          );
                                                        }),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                } else if (/*((_model.apiResultd4z?.statusCode ?? 200) == 200) &&*/
                    (widget.productType == 'Gemstone')) {
                  return Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                    child: FutureBuilder<ApiCallResponse>(
                      future: GemstoneProductOnSubCategoriesCall.call(
                        sanityurl: FFAppConstants.sanityurl,
                        slugValue: widget.productslugvalue,
                        maxCaratWeight: FFAppState().maxcaratweightString,
                        minCaratWeight: FFAppState().mincaratweightString,
                        maxRattiWeight: FFAppState().maxrattiweightString,
                        minRattiWeight: FFAppState().minrattiweightString,
                        maxPricePerCarat: FFAppState().maxpricepercaratString,
                        minPricePerCarat: FFAppState().minpricepercaratString,
                        maxPrice: FFAppState().rangeendString,
                        minPrice: FFAppState().rangestartString,
                        origi: FFAppState().originlist,
                          sort_by: FFAppState().sortby
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: ShimmerWidget(),
                          );
                        }
                        final columnGemstoneProductOnSubCategoriesResponse =
                            snapshot.data!;
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
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
                                                    .requestFocus(
                                                        _model.unfocusNode)
                                                : FocusScope.of(context)
                                                    .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: Container(
                                                height: 356.0,
                                                child: SortByWidget(),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Container(
                                      width: 90.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF5F6FA),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: Color(0xFFE7E7E8),
                                        ),
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/Swap.png',
                                                width: 15.0,
                                                height: 15.0,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Text(
                                              'Sort',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ].divide(SizedBox(width: 8.0)),
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
                                              child: FilterComponentWidget(
                                                productFilterbytype: 'Gemstone',
                                                maxprice:
                                                    GemstoneProductOnSubCategoriesCall
                                                        .constantmaxprice(
                                                  columnGemstoneProductOnSubCategoriesResponse
                                                      .jsonBody,
                                                )?.toDouble(),
                                                minprice:
                                                    GemstoneProductOnSubCategoriesCall
                                                        .constantminprice(
                                                  columnGemstoneProductOnSubCategoriesResponse
                                                      .jsonBody,
                                                )?.toDouble(),
                                                maxcaratweight:
                                                    GemstoneProductOnSubCategoriesCall
                                                        .constantmaxcaratweight(
                                                  columnGemstoneProductOnSubCategoriesResponse
                                                      .jsonBody,
                                                ),
                                                mincaratweight:
                                                    GemstoneProductOnSubCategoriesCall
                                                        .constantmincaratweight(
                                                  columnGemstoneProductOnSubCategoriesResponse
                                                      .jsonBody,
                                                ),
                                                maxrattiweight:
                                                    GemstoneProductOnSubCategoriesCall
                                                        .constantmaxrattiweight(
                                                  columnGemstoneProductOnSubCategoriesResponse
                                                      .jsonBody,
                                                ),
                                                minrattiweight:
                                                    GemstoneProductOnSubCategoriesCall
                                                        .constantminrattiweight(
                                                  columnGemstoneProductOnSubCategoriesResponse
                                                      .jsonBody,
                                                )?.toDouble(),
                                                maxpricepercarat:
                                                    GemstoneProductOnSubCategoriesCall
                                                        .constantmaxpricepercara(
                                                  columnGemstoneProductOnSubCategoriesResponse
                                                      .jsonBody,
                                                )?.toDouble(),
                                                minpricepercarat:
                                                    GemstoneProductOnSubCategoriesCall
                                                        .constantminpricepercarat(
                                                  columnGemstoneProductOnSubCategoriesResponse
                                                      .jsonBody,
                                                )?.toDouble(),
                                                originlist:
                                                    GemstoneProductOnSubCategoriesCall
                                                        .constantoriginlist(
                                                  columnGemstoneProductOnSubCategoriesResponse
                                                      .jsonBody,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Container(
                                      width: 90.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF5F6FA),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: Color(0xFFE7E7E8),
                                        ),
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/sort.png',
                                                width: 15.0,
                                                height: 15.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Text(
                                              'Filter',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ].divide(SizedBox(width: 8.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 10.0)),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 18.0, 16.0, 16),
                                child: Builder(
                                  builder: (context) {
                                    final productgridlist =
                                        GemstoneProductOnSubCategoriesCall
                                                .productDataList(
                                              columnGemstoneProductOnSubCategoriesResponse
                                                  .jsonBody,
                                            )?.toList() ??
                                            [];
                                    return GridView.builder(
                                      padding: EdgeInsets.zero,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        /*crossAxisCount: 2,
                                        crossAxisSpacing: 7.0,
                                        mainAxisSpacing: 0.0,
                                        childAspectRatio: 0.8,*/
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 9,
                                        mainAxisSpacing: 9,
                                        childAspectRatio: 0.82,
                                      ),
                                      scrollDirection: Axis.vertical,
                                      itemCount: productgridlist.length,
                                      itemBuilder:
                                          (context, productgridlistIndex) {
                                        final productgridlistItem =
                                            productgridlist[
                                                productgridlistIndex];
                                        return Stack(
                                          children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  'DiamondProductDetails',
                                                  queryParameters: {
                                                    'productSlugValue':
                                                        serializeParam(
                                                      getJsonField(
                                                        productgridlistItem,
                                                        r'''$.slug_value''',
                                                      ).toString(),
                                                      ParamType.String,
                                                    ),
                                                    'producttype': FFAppConstants
                                                        .GemstoneMasterProductDetailsApi,
                                                  }.withoutNulls,
                                                );
                                              },
                                              child: Container(
                                                //width: 168.0,
                                                //height: 193.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0),
                                                  border: Border.all(
                                                    color: Color(0xFFE7E7E8),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(4.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child:
                                                            CachedNetworkImage(
                                                          fadeInDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      100),
                                                          fadeOutDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      100),
                                                          imageUrl:
                                                              getJsonField(
                                                            productgridlistItem,
                                                            r'''$.image''',
                                                          ).toString(),
                                                          width:
                                                              double.infinity,
                                                          height: 104.65,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  9.0,
                                                                  8.0,
                                                                  9.0,
                                                                  10.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            height: 36.0,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Text(
                                                              getJsonField(
                                                                productgridlistItem,
                                                                r'''$.product_name''',
                                                              ).toString(),
                                                              maxLines: 2,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: Color(
                                                                        0xFF696969),
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                          RichText(
                                                            textScaler:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .textScaler,
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: 'INR ',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        color: Color(
                                                                            0xFF272728),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                ),
                                                                TextSpan(
                                                                  text:
                                                                      getJsonField(
                                                                    productgridlistItem,
                                                                    r'''$.selling_price''',
                                                                  ).toString(),
                                                                  style:
                                                                      TextStyle(),
                                                                )
                                                              ],
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: Color(
                                                                        0xFF272728),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 8.0)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(1, -1),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 5, 5, 0),
                                                child:
                                                    FutureBuilder<
                                                            ApiCallResponse>(
                                                        future:
                                                            WishListCall.call(
                                                          hosturl:
                                                              FFAppConstants
                                                                  .sanityurl,
                                                          token: currentAuthenticationToken
                                                            ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Container(
                                                              width: 1,
                                                              height: 1,
                                                              child:
                                                                  ShimmerWidget(),
                                                            );
                                                          }
                                                          final containerWishlistResponse =
                                                              snapshot.data!;

                                                          return Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24),
                                                            ),
                                                            child: Builder(
                                                              builder:
                                                                  (context) {
                                                                print(WishListCall.id(
                                                                    containerWishlistResponse
                                                                        .jsonBody));
                                                                print(
                                                                  getJsonField(
                                                                    productgridlistItem,
                                                                    r'''$.product_id''',
                                                                  ).toString(),
                                                                );
                                                                if (!WishListCall
                                                                        .id(
                                                                  containerWishlistResponse
                                                                      .jsonBody,
                                                                )!
                                                                    .contains(
                                                                        getJsonField(
                                                                  productgridlistItem,
                                                                  r'''$.product_id''',
                                                                ))) {
                                                                  return Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        if (currentAuthenticationToken !=
                                                                                null &&
                                                                            currentAuthenticationToken !=
                                                                                '') {
                                                                          _model.addtoWishlist =
                                                                              await AddToWishlistCall.call(
                                                                            hosturl:
                                                                                FFAppConstants.sanityurl,
                                                                            token:
                                                                                currentAuthenticationToken,
                                                                            productid:
                                                                                getJsonField(
                                                                              productgridlistItem,
                                                                              r'''$.product_id''',
                                                                            ),
                                                                            productType:
                                                                                getJsonField(
                                                                              productgridlistItem,
                                                                              r'''$.mainprodtype''',
                                                                            ),
                                                                          );
                                                                          if ((_model.addtoWishlist?.succeeded ??
                                                                              true)) {
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                content: Text(
                                                                                  "Product added in wishlist",
                                                                                  style: TextStyle(
                                                                                    color: FlutterFlowTheme.of(context).containerFillColor,
                                                                                  ),
                                                                                ),
                                                                                duration: Duration(milliseconds: 4000),
                                                                                backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                              ),
                                                                            );
                                                                          } else {
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                content: Text(
                                                                                  getJsonField(
                                                                                    (_model.addtoWishlist?.jsonBody ?? ''),
                                                                                    r'''$.status''',
                                                                                  ).toString(),
                                                                                  style: TextStyle(
                                                                                    color: FlutterFlowTheme.of(context).containerFillColor,
                                                                                  ),
                                                                                ),
                                                                                duration: Duration(milliseconds: 4000),
                                                                                backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                              ),
                                                                            );
                                                                          }
                                                                          _model
                                                                              .addToProductid(productgridlistIndex.toString());
                                                                          setState(
                                                                              () {});
                                                                        } else {
                                                                          context
                                                                              .pushNamed(
                                                                            'LoginPage',
                                                                            extra: <String,
                                                                                dynamic>{
                                                                              kTransitionInfoKey: TransitionInfo(
                                                                                hasTransition: true,
                                                                                transitionType: PageTransitionType.fade,
                                                                                duration: Duration(milliseconds: 0),
                                                                              ),
                                                                            },
                                                                          );
                                                                        }

                                                                        setState(
                                                                            () {});
                                                                        HapticFeedback
                                                                            .lightImpact();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            24,
                                                                        height:
                                                                            24,
                                                                        clipBehavior:
                                                                            Clip.antiAlias,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/HeartEmpty.png',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        var _shouldSetState =
                                                                            false;
                                                                        _model.apiResult5ep =
                                                                            await RemovefromWishlistCall.call(
                                                                          token:
                                                                              currentAuthenticationToken,
                                                                          hosturl:
                                                                              FFAppConstants.hosturl,
                                                                          productId:
                                                                              getJsonField(
                                                                            productgridlistItem,
                                                                            r'''$.product_id''',
                                                                          ),
                                                                          productType:
                                                                              getJsonField(
                                                                            productgridlistItem,
                                                                            r'''$.mainprodtype''',
                                                                          ),
                                                                        );

                                                                        _shouldSetState =
                                                                            true;
                                                                        if ((_model.apiResult5ep?.succeeded ??
                                                                            true)) {
                                                                          FFAppState().statusFailed =
                                                                              getJsonField((_model.apiResult5ep?.jsonBody ?? ''), r'''$.status''').toString();
                                                                          setState(
                                                                              () {});
                                                                          ScaffoldMessenger.of(context)
                                                                              .clearSnackBars();
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            SnackBar(
                                                                              content: Text(
                                                                                getJsonField((_model.apiResult5ep?.jsonBody ?? ''), r'''$.msg''').toString(),
                                                                                style: TextStyle(
                                                                                  color: FlutterFlowTheme.of(context).containerFillColor,
                                                                                ),
                                                                              ),
                                                                              duration: Duration(milliseconds: 4000),
                                                                              backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                            ),
                                                                          );
                                                                          if (FFAppState().statusFailed ==
                                                                              'success') {
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
                                                                        _model.removeFromProductid(
                                                                            productgridlistIndex.toString());
                                                                        setState(
                                                                            () {});

                                                                        setState(
                                                                            () {});
                                                                        HapticFeedback
                                                                            .lightImpact();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            24,
                                                                        height:
                                                                            24,
                                                                        clipBehavior:
                                                                            Clip.antiAlias,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/HeartFilled.png',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                          );
                                                        }),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                } else if (((_model.pujaActionResult?.statusCode ?? 200) ==
                        200) &&
                    (widget.productType == 'Puja')) {
                  return Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                    child: FutureBuilder<ApiCallResponse>(
                      future: PujaProductCall.call(
                        slugValue: widget.productslugvalue,
                        hosturl: FFAppConstants.hosturl,

                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: ShimmerWidget(),
                          );
                        }
                        final pujaProductPujaProductResponse = snapshot.data!;
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
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
                                                    .requestFocus(
                                                        _model.unfocusNode)
                                                : FocusScope.of(context)
                                                    .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: Container(
                                                height: 356.0,
                                                child: SortByWidget(),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Container(
                                      width: 90.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .containerFillColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .borderColor,
                                        ),
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/Swap.png',
                                                width: 15.0,
                                                height: 15.0,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Text(
                                              'Sort',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ].divide(SizedBox(width: 8.0)),
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
                                              child: FilterComponentWidget(
                                                productFilterbytype: 'Puja',
                                                maxprice: PujaProductCall
                                                    .constantmaxprice(
                                                  pujaProductPujaProductResponse
                                                      .jsonBody,
                                                )?.toDouble(),
                                                minprice: PujaProductCall
                                                    .constantminprice(
                                                  pujaProductPujaProductResponse
                                                      .jsonBody,
                                                )?.toDouble(),
                                                sizegrade: FFAppState()
                                                    .SelectedSizeGrade,
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Container(
                                      width: 90.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .containerFillColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .borderColor,
                                        ),
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/sort.png',
                                                width: 15.0,
                                                height: 15.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Text(
                                              'Filter',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ].divide(SizedBox(width: 8.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 10.0)),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 18.0, 16.0, 16),
                                child: Builder(
                                  builder: (context) {
                                    final productgridlist =
                                        PujaProductCall.productlist(
                                              pujaProductPujaProductResponse
                                                  .jsonBody,
                                            )?.toList() ??
                                            [];
                                    return GridView.builder(
                                      padding: EdgeInsets.zero,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        /*crossAxisCount: 2,
                                        crossAxisSpacing: 7.0,
                                        mainAxisSpacing: 0.0,
                                        childAspectRatio: 0.8,*/
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 9,
                                        mainAxisSpacing: 9,
                                        childAspectRatio: 0.82,
                                      ),
                                      scrollDirection: Axis.vertical,
                                      itemCount: productgridlist.length,
                                      itemBuilder:
                                          (context, productgridlistIndex) {
                                        final productgridlistItem =
                                            productgridlist[
                                                productgridlistIndex];
                                        return Stack(
                                          children: [
                                            Container(
                                              //width: 168.0,
                                              //height: 193.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(2.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .borderColor,
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: CachedNetworkImage(
                                                        fadeInDuration:
                                                            Duration(
                                                                milliseconds:
                                                                    100),
                                                        fadeOutDuration:
                                                            Duration(
                                                                milliseconds:
                                                                    100),
                                                        imageUrl: getJsonField(
                                                          productgridlistItem,
                                                          r'''$.image''',
                                                        ).toString(),
                                                        width: double.infinity,
                                                        height: 104.65,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(9.0, 8.0,
                                                                9.0, 10.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          height: 36.0,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Text(
                                                            getJsonField(
                                                              productgridlistItem,
                                                              r'''$.product_name''',
                                                            ).toString(),
                                                            maxLines: 2,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .productName,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                        RichText(
                                                          textScaler:
                                                              MediaQuery.of(
                                                                      context)
                                                                  .textScaler,
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: 'INR ',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      color: Color(
                                                                          0xFF272728),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    getJsonField(
                                                                  productgridlistItem,
                                                                  r'''$.selling_price''',
                                                                ).toString(),
                                                                style:
                                                                    TextStyle(),
                                                              )
                                                            ],
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 8.0)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(1, -1),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 5, 5, 0),
                                                child:
                                                    FutureBuilder<
                                                            ApiCallResponse>(
                                                        future:
                                                            WishListCall.call(
                                                          hosturl:
                                                              FFAppConstants
                                                                  .sanityurl,
                                                          token: currentAuthenticationToken
                                                            ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Container(
                                                              width: 1,
                                                              height: 1,
                                                              child:
                                                                  ShimmerWidget(),
                                                            );
                                                          }
                                                          final containerWishlistResponse =
                                                              snapshot.data!;

                                                          return Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24),
                                                            ),
                                                            child: Builder(
                                                              builder:
                                                                  (context) {
                                                                print(WishListCall.id(
                                                                    containerWishlistResponse
                                                                        .jsonBody));
                                                                print(
                                                                  getJsonField(
                                                                    productgridlistItem,
                                                                    r'''$.product_id''',
                                                                  ).toString(),
                                                                );
                                                                if (!WishListCall
                                                                        .id(
                                                                  containerWishlistResponse
                                                                      .jsonBody,
                                                                )!
                                                                    .contains(
                                                                        getJsonField(
                                                                  productgridlistItem,
                                                                  r'''$.product_id''',
                                                                ))) {
                                                                  return Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        if (currentAuthenticationToken !=
                                                                                null &&
                                                                            currentAuthenticationToken !=
                                                                                '') {
                                                                          _model.addtoWishlist =
                                                                              await AddToWishlistCall.call(
                                                                            hosturl:
                                                                                FFAppConstants.sanityurl,
                                                                            token:
                                                                                currentAuthenticationToken,
                                                                            productid:
                                                                                getJsonField(
                                                                              productgridlistItem,
                                                                              r'''$.product_id''',
                                                                            ),
                                                                            productType:
                                                                                getJsonField(
                                                                              productgridlistItem,
                                                                              r'''$.mainprodtype''',
                                                                            ),
                                                                          );
                                                                          if ((_model.addtoWishlist?.succeeded ??
                                                                              true)) {
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                content: Text(
                                                                                  "Product added in wishlist",
                                                                                  style: TextStyle(
                                                                                    color: FlutterFlowTheme.of(context).containerFillColor,
                                                                                  ),
                                                                                ),
                                                                                duration: Duration(milliseconds: 4000),
                                                                                backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                              ),
                                                                            );
                                                                          } else {
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                content: Text(
                                                                                  getJsonField(
                                                                                    (_model.addtoWishlist?.jsonBody ?? ''),
                                                                                    r'''$.status''',
                                                                                  ).toString(),
                                                                                  style: TextStyle(
                                                                                    color: FlutterFlowTheme.of(context).containerFillColor,
                                                                                  ),
                                                                                ),
                                                                                duration: Duration(milliseconds: 4000),
                                                                                backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                              ),
                                                                            );
                                                                          }
                                                                          _model
                                                                              .addToProductid(productgridlistIndex.toString());
                                                                          setState(
                                                                              () {});
                                                                        } else {
                                                                          context
                                                                              .pushNamed(
                                                                            'LoginPage',
                                                                            extra: <String,
                                                                                dynamic>{
                                                                              kTransitionInfoKey: TransitionInfo(
                                                                                hasTransition: true,
                                                                                transitionType: PageTransitionType.fade,
                                                                                duration: Duration(milliseconds: 0),
                                                                              ),
                                                                            },
                                                                          );
                                                                        }

                                                                        setState(
                                                                            () {});
                                                                        HapticFeedback
                                                                            .lightImpact();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            24,
                                                                        height:
                                                                            24,
                                                                        clipBehavior:
                                                                            Clip.antiAlias,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/HeartEmpty.png',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        var _shouldSetState =
                                                                            false;
                                                                        _model.apiResult5ep =
                                                                            await RemovefromWishlistCall.call(
                                                                          token:
                                                                              currentAuthenticationToken,
                                                                          hosturl:
                                                                              FFAppConstants.hosturl,
                                                                          productId:
                                                                              getJsonField(
                                                                            productgridlistItem,
                                                                            r'''$.product_id''',
                                                                          ),
                                                                          productType:
                                                                              getJsonField(
                                                                            productgridlistItem,
                                                                            r'''$.mainprodtype''',
                                                                          ),
                                                                        );

                                                                        _shouldSetState =
                                                                            true;
                                                                        if ((_model.apiResult5ep?.succeeded ??
                                                                            true)) {
                                                                          FFAppState().statusFailed =
                                                                              getJsonField((_model.apiResult5ep?.jsonBody ?? ''), r'''$.status''').toString();
                                                                          setState(
                                                                              () {});
                                                                          ScaffoldMessenger.of(context)
                                                                              .clearSnackBars();
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            SnackBar(
                                                                              content: Text(
                                                                                getJsonField((_model.apiResult5ep?.jsonBody ?? ''), r'''$.msg''').toString(),
                                                                                style: TextStyle(
                                                                                  color: FlutterFlowTheme.of(context).containerFillColor,
                                                                                ),
                                                                              ),
                                                                              duration: Duration(milliseconds: 4000),
                                                                              backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                            ),
                                                                          );
                                                                          if (FFAppState().statusFailed ==
                                                                              'success') {
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
                                                                        _model.removeFromProductid(
                                                                            productgridlistIndex.toString());
                                                                        setState(
                                                                            () {});

                                                                        setState(
                                                                            () {});
                                                                        HapticFeedback
                                                                            .lightImpact();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            24,
                                                                        height:
                                                                            24,
                                                                        clipBehavior:
                                                                            Clip.antiAlias,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/HeartFilled.png',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                          );
                                                        }),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
                /* else  if (((_model.apiResultd4z?.statusCode ?? 200) == 200) &&
                    (widget.productType == 'Puja')) {
                  return Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                    child: FutureBuilder<ApiCallResponse>(
                      future: PujaProductCall.call(
                        slugValue: widget.productslugvalue,
                        hosturl: FFAppConstants.hosturl,
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: ShimmerWidget(),
                          );
                        }
                        final pujaProductPujaProductResponse = snapshot.data!;
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
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
                                                .requestFocus(
                                                _model.unfocusNode)
                                                : FocusScope.of(context)
                                                .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: Container(
                                                height: 386.0,
                                                child: SortByWidget(),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Container(
                                      width: 90.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .containerFillColor,
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .borderColor,
                                        ),
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/Swap.png',
                                                width: 15.0,
                                                height: 15.0,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Text(
                                              'Sort',
                                              style:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily:
                                                'Montserrat',
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 8.0)),
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
                                              child: FilterComponentWidget(
                                                productFilterbytype: 'Puja',
                                                maxprice: PujaProductCall
                                                    .constantmaxprice(
                                                  pujaProductPujaProductResponse
                                                      .jsonBody,
                                                )?.toDouble(),
                                                minprice: PujaProductCall
                                                    .constantminprice(
                                                  pujaProductPujaProductResponse
                                                      .jsonBody,
                                                )?.toDouble(),
                                                sizegrade: FFAppState()
                                                    .SelectedSizeGrade,
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Container(
                                      width: 90.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .containerFillColor,
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .borderColor,
                                        ),
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/sort.png',
                                                width: 15.0,
                                                height: 15.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Text(
                                              'Filter',
                                              style:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily:
                                                'Montserrat',
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 8.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 10.0)),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 18.0, 16.0, 0.0),
                                child: Builder(
                                  builder: (context) {
                                    final productgridlist =
                                        PujaProductCall.productlist(
                                          pujaProductPujaProductResponse
                                              .jsonBody,
                                        )?.toList() ??
                                            [];
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
                                      itemCount: productgridlist.length,
                                      itemBuilder:
                                          (context, productgridlistIndex) {
                                        final productgridlistItem =
                                        productgridlist[
                                        productgridlistIndex];
                                        return Stack(
                                          children: [
                                            Container(
                                              width: 168.0,
                                              height: 244.0,
                                              decoration: BoxDecoration(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                                borderRadius:
                                                BorderRadius.circular(2.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .borderColor,
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.all(4.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                      child: Image.network(
                                                        getJsonField(
                                                          productgridlistItem,
                                                          r'''$.image''',
                                                        ).toString(),
                                                        width: double.infinity,
                                                        height: 104.65,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(9.0, 8.0,
                                                        9.0, 10.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                      MainAxisSize.max,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Container(
                                                          width:
                                                          double.infinity,
                                                          height: 36.0,
                                                          decoration:
                                                          BoxDecoration(),
                                                          child: Text(
                                                            getJsonField(
                                                              productgridlistItem,
                                                              r'''$.product_name''',
                                                            ).toString(),
                                                            maxLines: 2,
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Montserrat',
                                                              color: FlutterFlowTheme.of(
                                                                  context)
                                                                  .productName,
                                                              letterSpacing:
                                                              0.0,
                                                            ),
                                                          ),
                                                        ),
                                                        RichText(
                                                          textScaler:
                                                          MediaQuery.of(
                                                              context)
                                                              .textScaler,
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: 'INR ',
                                                                style: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodyMedium
                                                                    .override(
                                                                  fontFamily:
                                                                  'Montserrat',
                                                                  color: Color(
                                                                      0xFF272728),
                                                                  letterSpacing:
                                                                  0.0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                getJsonField(
                                                                  productgridlistItem,
                                                                  r'''$.selling_price''',
                                                                ).toString(),
                                                                style:
                                                                TextStyle(),
                                                              )
                                                            ],
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Montserrat',
                                                              color: FlutterFlowTheme.of(
                                                                  context)
                                                                  .primaryText,
                                                              letterSpacing:
                                                              0.0,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 8.0)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(4.0, 0.0,
                                                        4.0, 0.0),
                                                    child: FFButtonWidget(
                                                      onPressed: () {
                                                        print(
                                                            'Button pressed ...');
                                                      },
                                                      text: 'Add to Cart',
                                                      options: FFButtonOptions(
                                                        width: double.infinity,
                                                        height: 40.0,
                                                        padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            24.0,
                                                            0.0,
                                                            24.0,
                                                            0.0),
                                                        iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            0.0),
                                                        color: Colors.white,
                                                        textStyle:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .titleSmall
                                                            .override(
                                                          fontFamily:
                                                          'Montserrat',
                                                          color: FlutterFlowTheme.of(
                                                              context)
                                                              .primary,
                                                          letterSpacing:
                                                          0.0,
                                                        ),
                                                        elevation: 0.0,
                                                        borderSide: BorderSide(
                                                          color:
                                                          Color(0xFF740074),
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(8.0),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, -1.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 5.0, 5.0, 0.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xA5FFFFFF),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        24.0),
                                                  ),
                                                  child: Builder(
                                                    builder: (context) {
                                                      if (!_model.productid
                                                          .contains(
                                                          productgridlistIndex
                                                              .toString())) {
                                                        return Padding(
                                                          padding:
                                                          EdgeInsets.all(
                                                              5.0),
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                            Colors
                                                                .transparent,
                                                            onTap: () async {
                                                              _model.addToProductid(
                                                                  productgridlistIndex
                                                                      .toString());
                                                              setState(() {});

                                                              setState(() {});
                                                              HapticFeedback
                                                                  .lightImpact();
                                                            },
                                                            child: Container(
                                                              width: 24.0,
                                                              height: 24.0,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                              BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                              Image.asset(
                                                                'assets/images/HeartEmpty.png',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        return Padding(
                                                          padding:
                                                          EdgeInsets.all(
                                                              5.0),
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                            Colors
                                                                .transparent,
                                                            onTap: () async {
                                                              _model.removeFromProductid(
                                                                  productgridlistIndex
                                                                      .toString());
                                                              setState(() {});

                                                              setState(() {});
                                                              HapticFeedback
                                                                  .lightImpact();
                                                            },
                                                            child: Container(
                                                              width: 24.0,
                                                              height: 24.0,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                              BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                              Image.asset(
                                                                'assets/images/HeartFilled.png',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                } */
                else if (/*((_model.pujaMainActionResult?.statusCode ?? 200) == 200) &&*/
                    ((widget.productType == 'PujaMainCategory') ||
                        (widget.productType == 'PujaSubCategory'))) {
                  return Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                    child: FutureBuilder<ApiCallResponse>(
                      future: PujaProductCall.call(
                        slugValue: widget.productslugvalue,
                        hosturl: FFAppConstants.hosturl,
                        maxPrice: FFAppState().rangeendString,
                        minPrice: FFAppState().rangestartString,
                        subMainCategoryType:
                            widget.productType == 'PujaMainCategory'
                                ? 'puja-product-basedon-maincategory'
                                : 'puja-product-basedon-subcategory',

                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: ShimmerWidget(),
                          );
                        }
                        final pujaProductPujaProductResponse = snapshot.data!;
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
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
                                                    .requestFocus(
                                                        _model.unfocusNode)
                                                : FocusScope.of(context)
                                                    .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: Container(
                                                height: 356.0,
                                                child: SortByWidget(),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Container(
                                      width: 90.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .containerFillColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .borderColor,
                                        ),
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/Swap.png',
                                                width: 15.0,
                                                height: 15.0,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Text(
                                              'Sort',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ].divide(SizedBox(width: 8.0)),
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
                                              child: FilterComponentWidget(
                                                productFilterbytype: 'Puja',
                                                maxprice: PujaProductCall
                                                    .constantmaxprice(
                                                  pujaProductPujaProductResponse
                                                      .jsonBody,
                                                )?.toDouble(),
                                                minprice: PujaProductCall
                                                    .constantminprice(
                                                  pujaProductPujaProductResponse
                                                      .jsonBody,
                                                )?.toDouble(),
                                                sizegrade: FFAppState()
                                                    .SelectedSizeGrade,
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Container(
                                      width: 90.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .containerFillColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .borderColor,
                                        ),
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/sort.png',
                                                width: 15.0,
                                                height: 15.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Text(
                                              'Filter',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ].divide(SizedBox(width: 8.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 10.0)),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 18.0, 16.0, 16),
                                child: Builder(
                                  builder: (context) {
                                    final productgridlist =
                                        PujaProductCall.productlist(
                                              pujaProductPujaProductResponse
                                                  .jsonBody,
                                            )?.toList() ??
                                            [];
                                    return GridView.builder(
                                      padding: EdgeInsets.zero,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        /*crossAxisCount: 2,
                                        crossAxisSpacing: 7.0,
                                        mainAxisSpacing: 0.0,
                                        childAspectRatio: 0.8,*/
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 9,
                                        mainAxisSpacing: 9,
                                        childAspectRatio: 0.82,
                                      ),
                                      scrollDirection: Axis.vertical,
                                      itemCount: productgridlist.length,
                                      itemBuilder:
                                          (context, productgridlistIndex) {
                                        final productgridlistItem =
                                            productgridlist[
                                                productgridlistIndex];
                                        return Stack(
                                          children: [
                                            Container(
                                              // width: 168.0,
                                              //height: 193.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(2.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .borderColor,
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: CachedNetworkImage(
                                                        fadeInDuration:
                                                            Duration(
                                                                milliseconds:
                                                                    100),
                                                        fadeOutDuration:
                                                            Duration(
                                                                milliseconds:
                                                                    100),
                                                        imageUrl: getJsonField(
                                                          productgridlistItem,
                                                          r'''$.image''',
                                                        ).toString(),
                                                        width: double.infinity,
                                                        height: 104.65,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(9.0, 8.0,
                                                                9.0, 10.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          height: 36.0,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Text(
                                                            getJsonField(
                                                              productgridlistItem,
                                                              r'''$.product_name''',
                                                            ).toString(),
                                                            maxLines: 2,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .productName,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                        RichText(
                                                          textScaler: MediaQuery.of(context).textScaler,
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: 'INR ',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      color: Color(
                                                                          0xFF272728),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    getJsonField(
                                                                  productgridlistItem,
                                                                  r'''$.selling_price''',
                                                                ).toString(),
                                                                style:
                                                                    TextStyle(),
                                                              )
                                                            ],
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 8.0)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(1, -1),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 5, 5, 0),
                                                child:
                                                    FutureBuilder<
                                                            ApiCallResponse>(
                                                        future:
                                                            WishListCall.call(
                                                          hosturl:
                                                              FFAppConstants
                                                                  .sanityurl,
                                                          token: currentAuthenticationToken
                                                            ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Container(
                                                              width: 1,
                                                              height: 1,
                                                              child:
                                                                  ShimmerWidget(),
                                                            );
                                                          }
                                                          final containerWishlistResponse =
                                                              snapshot.data!;

                                                          return Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24),
                                                            ),
                                                            child: Builder(
                                                              builder:
                                                                  (context) {
                                                                print(WishListCall.id(
                                                                    containerWishlistResponse
                                                                        .jsonBody));
                                                                print(
                                                                  getJsonField(
                                                                    productgridlistItem,
                                                                    r'''$.product_id''',
                                                                  ).toString(),
                                                                );
                                                                if (!WishListCall
                                                                        .id(
                                                                  containerWishlistResponse
                                                                      .jsonBody,
                                                                )!
                                                                    .contains(
                                                                        getJsonField(
                                                                  productgridlistItem,
                                                                  r'''$.product_id''',
                                                                ))) {
                                                                  return Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        if (currentAuthenticationToken !=
                                                                                null &&
                                                                            currentAuthenticationToken !=
                                                                                '') {
                                                                          _model.addtoWishlist =
                                                                              await AddToWishlistCall.call(
                                                                            hosturl:
                                                                                FFAppConstants.sanityurl,
                                                                            token:
                                                                                currentAuthenticationToken,
                                                                            productid:
                                                                                getJsonField(
                                                                              productgridlistItem,
                                                                              r'''$.product_id''',
                                                                            ),
                                                                            productType:
                                                                                getJsonField(
                                                                              productgridlistItem,
                                                                              r'''$.mainprodtype''',
                                                                            ),
                                                                          );
                                                                          if ((_model.addtoWishlist?.succeeded ??
                                                                              true)) {
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                content: Text(
                                                                                  "Product added in wishlist",
                                                                                  style: TextStyle(
                                                                                    color: FlutterFlowTheme.of(context).containerFillColor,
                                                                                  ),
                                                                                ),
                                                                                duration: Duration(milliseconds: 4000),
                                                                                backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                              ),
                                                                            );
                                                                          } else {
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                content: Text(
                                                                                  getJsonField(
                                                                                    (_model.addtoWishlist?.jsonBody ?? ''),
                                                                                    r'''$.status''',
                                                                                  ).toString(),
                                                                                  style: TextStyle(
                                                                                    color: FlutterFlowTheme.of(context).containerFillColor,
                                                                                  ),
                                                                                ),
                                                                                duration: Duration(milliseconds: 4000),
                                                                                backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                              ),
                                                                            );
                                                                          }
                                                                          _model
                                                                              .addToProductid(productgridlistIndex.toString());
                                                                          setState(
                                                                              () {});
                                                                        } else {
                                                                          context
                                                                              .pushNamed(
                                                                            'LoginPage',
                                                                            extra: <String,
                                                                                dynamic>{
                                                                              kTransitionInfoKey: TransitionInfo(
                                                                                hasTransition: true,
                                                                                transitionType: PageTransitionType.fade,
                                                                                duration: Duration(milliseconds: 0),
                                                                              ),
                                                                            },
                                                                          );
                                                                        }

                                                                        setState(
                                                                            () {});
                                                                        HapticFeedback
                                                                            .lightImpact();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            24,
                                                                        height:
                                                                            24,
                                                                        clipBehavior:
                                                                            Clip.antiAlias,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/HeartEmpty.png',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        var _shouldSetState =
                                                                            false;
                                                                        _model.apiResult5ep =
                                                                            await RemovefromWishlistCall.call(
                                                                          token:
                                                                              currentAuthenticationToken,
                                                                          hosturl:
                                                                              FFAppConstants.hosturl,
                                                                          productId:
                                                                              getJsonField(
                                                                            productgridlistItem,
                                                                            r'''$.product_id''',
                                                                          ),
                                                                          productType:
                                                                              getJsonField(
                                                                            productgridlistItem,
                                                                            r'''$.mainprodtype''',
                                                                          ),
                                                                        );

                                                                        _shouldSetState =
                                                                            true;
                                                                        if ((_model.apiResult5ep?.succeeded ??
                                                                            true)) {
                                                                          FFAppState().statusFailed =
                                                                              getJsonField((_model.apiResult5ep?.jsonBody ?? ''), r'''$.status''').toString();
                                                                          setState(
                                                                              () {});
                                                                          ScaffoldMessenger.of(context)
                                                                              .clearSnackBars();
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            SnackBar(
                                                                              content: Text(
                                                                                getJsonField((_model.apiResult5ep?.jsonBody ?? ''), r'''$.msg''').toString(),
                                                                                style: TextStyle(
                                                                                  color: FlutterFlowTheme.of(context).containerFillColor,
                                                                                ),
                                                                              ),
                                                                              duration: Duration(milliseconds: 4000),
                                                                              backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                            ),
                                                                          );
                                                                          if (FFAppState().statusFailed ==
                                                                              'success') {
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
                                                                        _model.removeFromProductid(
                                                                            productgridlistIndex.toString());
                                                                        setState(
                                                                            () {});

                                                                        setState(
                                                                            () {});
                                                                        HapticFeedback
                                                                            .lightImpact();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            24,
                                                                        height:
                                                                            24,
                                                                        clipBehavior:
                                                                            Clip.antiAlias,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/HeartFilled.png',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                          );
                                                        }),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                } else if (/*((_model.otherSubProductResult?.statusCode ?? 200) ==
                    200) &&*/
                    ((widget.productType == 'OthersSubCategory') ||
                        (widget.productType == 'OthersMainCategory'))) {
                  return Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                    child: FutureBuilder<ApiCallResponse>(
                      future: OtherProductMainCategoryCall.call(
                        hosturl: FFAppConstants.hosturl,
                        slugValue: widget.productslugvalue,
                        maxPrice: FFAppState().rangeendString,
                        minPrice: FFAppState().rangestartString,
                        subMainProductCategory:
                            widget.productType == 'OthersMainCategory'
                                ? 'other-product-basedon-maincategory'
                                : 'other-product-basedon-subcategory',
                          sort_by: FFAppState().sortby
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: ShimmerWidget(),
                          );
                        }
                        final othersProductsOtherProductMainCategoryResponse =
                            snapshot.data!;
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
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
                                                    .requestFocus(
                                                        _model.unfocusNode)
                                                : FocusScope.of(context)
                                                    .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: Container(
                                                height: 356.0,
                                                child: SortByWidget(),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Container(
                                      width: 90.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .containerFillColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .borderColor,
                                        ),
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/Swap.png',
                                                width: 15.0,
                                                height: 15.0,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Text(
                                              'Sort',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ].divide(SizedBox(width: 8.0)),
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
                                              child: FilterComponentWidget(
                                                productFilterbytype: 'Others',
                                                maxprice:
                                                    OtherProductMainCategoryCall
                                                        .yantraconstantmaxprice(
                                                  othersProductsOtherProductMainCategoryResponse
                                                      .jsonBody,
                                                )?.toDouble(),
                                                minprice:
                                                    OtherProductMainCategoryCall
                                                        .yantraconstantminprice(
                                                  othersProductsOtherProductMainCategoryResponse
                                                      .jsonBody,
                                                )?.toDouble(),
                                                deityPurpose:
                                                    OtherProductMainCategoryCall
                                                        .yantraconstantdietylist(
                                                  othersProductsOtherProductMainCategoryResponse
                                                      .jsonBody,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Container(
                                      width: 90.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .containerFillColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .borderColor,
                                        ),
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/sort.png',
                                                width: 15.0,
                                                height: 15.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Text(
                                              'Filter',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ].divide(SizedBox(width: 8.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 10.0)),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 18.0, 16.0, 16),
                                child: Builder(
                                  builder: (context) {
                                    final yantrasgridlist =
                                        OtherProductMainCategoryCall
                                                .yantrProductData(
                                              othersProductsOtherProductMainCategoryResponse
                                                  .jsonBody,
                                            )?.toList() ??
                                            [];
                                    return GridView.builder(
                                      padding: EdgeInsets.zero,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        /*crossAxisCount: 2,
                                        crossAxisSpacing: 7.0,
                                        mainAxisSpacing: 0.0,
                                        childAspectRatio: 0.8,*/
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 9,
                                        mainAxisSpacing: 9,
                                        childAspectRatio: 0.82,
                                      ),
                                      scrollDirection: Axis.vertical,
                                      itemCount: yantrasgridlist.length,
                                      itemBuilder:
                                          (context, yantrasgridlistIndex) {
                                        final yantrasgridlistItem =
                                            yantrasgridlist[
                                                yantrasgridlistIndex];
                                        return Stack(
                                          children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  'OtherProductDetails',
                                                  queryParameters: {
                                                    'productSlugValue':
                                                        serializeParam(
                                                      getJsonField(
                                                        yantrasgridlistItem,
                                                        r'''$.slug_value''',
                                                      ).toString(),
                                                      ParamType.String,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                              child: Container(
                                                // width: 168.0,
                                                //height: 193.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .borderColor,
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(4.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child:
                                                            CachedNetworkImage(
                                                          fadeInDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      100),
                                                          fadeOutDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      100),
                                                          imageUrl: widget
                                                                      .productType ==
                                                                  'OthersMainCategory'
                                                              ? getJsonField(
                                                                  yantrasgridlistItem,
                                                                  r'''$.image''',
                                                                ).toString()
                                                              : getJsonField(
                                                                  yantrasgridlistItem,
                                                                  r'''$.image''',
                                                                ).toString(),
                                                          width:
                                                              double.infinity,
                                                          height: 104.65,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  9.0,
                                                                  8.0,
                                                                  9.0,
                                                                  10.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            height: 36.0,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Text(
                                                              widget.productType ==
                                                                      'OthersSubCategory'
                                                                  ? getJsonField(
                                                                      yantrasgridlistItem,
                                                                      r'''$.product_name''',
                                                                    ).toString()
                                                                  : getJsonField(
                                                                      yantrasgridlistItem,
                                                                      r'''$.name''',
                                                                    ).toString(),
                                                              maxLines: 2,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .productName,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                          RichText(
                                                            textScaler:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .textScaler,
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: 'INR ',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        color: Color(
                                                                            0xFF272728),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                ),
                                                                TextSpan(
                                                                  text:
                                                                      getJsonField(
                                                                    yantrasgridlistItem,
                                                                    r'''$.selling_price''',
                                                                  ).toString(),
                                                                  style:
                                                                      TextStyle(),
                                                                )
                                                              ],
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 8.0)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(1, -1),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 5, 5, 0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xA5FFFFFF),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24),
                                                  ),
                                                  child: Builder(
                                                    builder: (context) {
                                                      if (!_model.productid
                                                          .contains(
                                                              yantrasgridlistItem
                                                                  .toString())) {
                                                        return Padding(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              if (currentAuthenticationToken !=
                                                                      null &&
                                                                  currentAuthenticationToken !=
                                                                      '') {
                                                                _model.addtoWishlist =
                                                                    await AddToWishlistCall
                                                                        .call(
                                                                  hosturl:
                                                                      FFAppConstants
                                                                          .sanityurl,
                                                                  token:
                                                                      currentAuthenticationToken,
                                                                  productid:
                                                                      getJsonField(
                                                                    yantrasgridlistItem,
                                                                    r'''$.product_id''',
                                                                  ),
                                                                  productType:
                                                                      getJsonField(
                                                                    yantrasgridlistItem,
                                                                    r'''$.mainprodtype''',
                                                                  ),
                                                                );
                                                                if ((_model
                                                                        .addtoWishlist
                                                                        ?.succeeded ??
                                                                    true)) {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content:
                                                                          Text(
                                                                        "Product added in wishlist",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).containerFillColor,
                                                                        ),
                                                                      ),
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              4000),
                                                                      backgroundColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                    ),
                                                                  );
                                                                } else {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content:
                                                                          Text(
                                                                        getJsonField(
                                                                          (_model.addtoWishlist?.jsonBody ??
                                                                              ''),
                                                                          r'''$.status''',
                                                                        ).toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).containerFillColor,
                                                                        ),
                                                                      ),
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              4000),
                                                                      backgroundColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                    ),
                                                                  );
                                                                }
                                                                _model.addToProductid(
                                                                    yantrasgridlistItem
                                                                        .toString());
                                                                setState(() {});
                                                              } else {
                                                                context
                                                                    .pushNamed(
                                                                  'LoginPage',
                                                                  extra: <String,
                                                                      dynamic>{
                                                                    kTransitionInfoKey:
                                                                        TransitionInfo(
                                                                      hasTransition:
                                                                          true,
                                                                      transitionType:
                                                                          PageTransitionType
                                                                              .fade,
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              0),
                                                                    ),
                                                                  },
                                                                );
                                                              }

                                                              setState(() {});
                                                              HapticFeedback
                                                                  .lightImpact();
                                                            },
                                                            child: Container(
                                                              width: 24,
                                                              height: 24,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/HeartEmpty.png',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        return Padding(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              var _shouldSetState =
                                                                  false;
                                                              _model.apiResult5ep =
                                                                  await RemovefromWishlistCall
                                                                      .call(
                                                                token:
                                                                    currentAuthenticationToken,
                                                                hosturl:
                                                                    FFAppConstants
                                                                        .hosturl,
                                                                productId:
                                                                    getJsonField(
                                                                  yantrasgridlistItem,
                                                                  r'''$.product_id''',
                                                                ),
                                                                productType:
                                                                    getJsonField(
                                                                  yantrasgridlistItem,
                                                                  r'''$.mainprodtype''',
                                                                ),
                                                              );

                                                              _shouldSetState =
                                                                  true;
                                                              if ((_model
                                                                      .apiResult5ep
                                                                      ?.succeeded ??
                                                                  true)) {
                                                                FFAppState()
                                                                    .statusFailed = getJsonField(
                                                                        (_model.apiResult5ep?.jsonBody ??
                                                                            ''),
                                                                        r'''$.status''')
                                                                    .toString();
                                                                setState(() {});
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .clearSnackBars();
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      getJsonField(
                                                                              (_model.apiResult5ep?.jsonBody ?? ''),
                                                                              r'''$.msg''')
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .containerFillColor,
                                                                      ),
                                                                    ),
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            4000),
                                                                    backgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                  ),
                                                                );
                                                                if (FFAppState()
                                                                        .statusFailed ==
                                                                    'success') {
                                                                } else {
                                                                  if (_shouldSetState)
                                                                    setState(
                                                                        () {});
                                                                  return;
                                                                }
                                                              } else {
                                                                if (_shouldSetState)
                                                                  setState(
                                                                      () {});
                                                                return;
                                                              }
                                                              _model.removeFromProductid(
                                                                  yantrasgridlistItem
                                                                      .toString());
                                                              setState(() {});

                                                              setState(() {});
                                                              HapticFeedback
                                                                  .lightImpact();
                                                            },
                                                            child: Container(
                                                              width: 24,
                                                              height: 24,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/HeartFilled.png',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return wrapWithModel(
                    model: _model.error404ScreenModel,
                    updateCallback: () => setState(() {}),
                    child: Error404ScreenWidget(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
