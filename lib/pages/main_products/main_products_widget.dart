import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import '../../auth/custom_auth/auth_util.dart';
import '../../components/custom_nav_bar_widget.dart';
import '../../flutter_flow/custom_functions.dart';
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
import 'package:badges/badges.dart' as badges;
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
  String sortby = FFAppState().sortby;
  List<dynamic> _productsList = [];
  final MainProductsWidgetscaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMoreData = true;

  @override
  void initState() {
    print("widget.producttitle:${widget.producttitle}");
    super.initState();

    _model = createModel(context, () => MainProductsModel());
    _scrollController.addListener(_onScroll);

    // Fetch initial data
    _fetchData();

    // Add listeners to FFAppState variables
    FFAppState().addListener(_onFFAppStateChange);

    // On page load action
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
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();
    _scrollController.dispose();
    // Remove listeners
    FFAppState().removeListener(_onFFAppStateChange);
    super.dispose();
  }

  // Helper method to convert values to double
  double? _toDouble(dynamic value) {
    if (value == null) {
      return null;
    } else if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else {
      throw ArgumentError('Invalid type: ${value.runtimeType}');
    }
  }

  void _onFFAppStateChange() {
    // Whenever FFAppState changes, reset the product list and fetch data
    setState(() {
      _currentPage = 1;
      _productsList.clear();
      _hasMoreData = true;
      _fetchData();
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_hasMoreData && !_isLoading) {
        _fetchData();
      }
    }
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    ApiCallResponse response;
    List<dynamic> newItems = [];

    try {
      if (widget.productType == 'Rudraksha') {
        response = await RudrakshaProductCall.call(
          hosturl: FFAppConstants.hosturl,
          slugValue: widget.productslugvalue,
          maxPrice: FFAppState().rangeendString,
          minPrice: FFAppState().rangestartString,
          beadMaxSize: FFAppState().BeadSizeMax,
          beadMinSize: FFAppState().BeadSizeMin,
          sizeGrade: FFAppState().SelectedSizeGrade,
          sort_by: FFAppState().sortby,
          pageNo: _currentPage.toString(),
        );
        newItems =
            RudrakshaProductCall.productlist(response.jsonBody)?.toList() ?? [];
      } else if (widget.productType == 'OthersMainCategory' ||
          widget.productType == 'OthersSubCategory') {
        response = await OtherProductMainCategoryCall.call(
          hosturl: FFAppConstants.hosturl,
          slugValue: widget.productslugvalue,
          maxPrice: FFAppState().rangeendString,
          minPrice: FFAppState().rangestartString,
          subMainProductCategory: widget.productType == 'OthersMainCategory'
              ? 'other-product-basedon-maincategory'
              : 'other-product-basedon-subcategory',
          sort_by: FFAppState().sortby,
          page_no: _currentPage.toString(),
        );
        newItems =
            OtherProductMainCategoryCall.yantrProductData(response.jsonBody)
                ?.toList() ??
                [];
      } else if (widget.productType == 'Gemstone') {
        response = await GemstoneProductOnSubCategoriesCall.call(
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
          sort_by: FFAppState().sortby,
          page_no: _currentPage.toString(),
        );
        newItems = GemstoneProductOnSubCategoriesCall.productDataList(
            response.jsonBody)
            ?.toList() ??
            [];
      } else if (widget.productType == 'Yantra') {
        response = await YantraProductCall.call(
          hosturl: FFAppConstants.hosturl,
          slugValue: widget.productslugvalue,
          maxPrice: FFAppState().rangeendString,
          minPrice: FFAppState().rangestartString,
          diety: FFAppState().YantrasDeityPurpose,
          sort_by: FFAppState().sortby,
          page_no: _currentPage.toString(),
        );
        newItems = YantraProductCall.yantrProductData(response.jsonBody)?.toList() ?? [];
      }

      setState(() {
        _currentPage++;
        _productsList.addAll(newItems);
        print("_productsList:${_productsList}");
        print("RudraFFAppState().SelectedSizeGrade : ${FFAppState().SelectedSizeGrade}");
        _isLoading = false;
        if (newItems.isEmpty) {
          _hasMoreData = false;
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasMoreData = false;
      });
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: PopScope(
        canPop: true,
        onPopInvoked: (didPop) async {
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

        },
        child: Scaffold(
          key: MainProductsWidgetscaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: _model.statuscode == 200
              ? PreferredSize(
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
                    buttonSize: 54,
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: Color(0xFF272728),
                      size: 30,
                    ),
                    onPressed: () async {
                      context.safePop();
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
                ),
                ),
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
                                 // fit: BoxFit.cover,
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
                                 // fit: BoxFit.,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                  centerTitle: true,
                  elevation: 0,
                ),
          body: SafeArea(
            top: true,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                  child: Container(
                    //height: MediaQuery.sizeOf(context).height * 1,
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
                                  sort_by: FFAppState().sortby,
                                  pageNo: "1"),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: ShimmerWidget(),
                                  );
                                }
                                final rudrakshaRudrakshaProductResponse = snapshot.data!;

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
                                              print(
                                                  "maxbeadsize: ${GemstoneProductOnSubCategoriesCall.constantmaxbeadsize(rudrakshaRudrakshaProductResponse.jsonBody)}");
                                              print(
                                                  "minbeadsize: ${GemstoneProductOnSubCategoriesCall.constantminbeadsize(rudrakshaRudrakshaProductResponse.jsonBody)}");
                                              await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor: Colors.transparent,
                                                context: context,
                                                builder: (context) {
                                                  return GestureDetector(
                                                    onTap: () => _model.unfocusNode.canRequestFocus
                                                        ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                        : FocusScope.of(context).unfocus(),
                                                    child: Padding(
                                                      padding: MediaQuery.viewInsetsOf(context),
                                                      child: FilterComponentWidget(
                                                        productFilterbytype: 'Gemstone',
                                                        maxprice: RudrakshaProductCall.constantmaxprice(
                                                          rudrakshaRudrakshaProductResponse.jsonBody,
                                                        )?.toDouble(),
                                                        minprice: RudrakshaProductCall.constantminprice(
                                                          rudrakshaRudrakshaProductResponse.jsonBody,
                                                        )?.toDouble(),
                                                        maxbeadsize: GemstoneProductOnSubCategoriesCall.constantmaxbeadsize(
                                                          rudrakshaRudrakshaProductResponse.jsonBody,
                                                        )?.toDouble(),
                                                        minbeadsize: GemstoneProductOnSubCategoriesCall.constantminbeadsize(
                                                          rudrakshaRudrakshaProductResponse.jsonBody,
                                                        )?.toDouble(),
                                                        sizegrade: FFAppState().SelectedSizeGrade,
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
                                                color: FlutterFlowTheme.of(context).containerFillColor,
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(context).borderColor,
                                                ),
                                              ),
                                              alignment: AlignmentDirectional(0, 0),
                                              child: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(8),
                                                      child: Image.asset(
                                                        'assets/images/sort.png',
                                                        width: 15,
                                                        height: 15,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Filter',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
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
                                            16, 18, 16, 0),
                                        child: Builder(
                                          builder: (context) {
                                            final productgridlist = _productsList;
                                            final data = RudrakshaProductCall.productlist(
                                              rudrakshaRudrakshaProductResponse.jsonBody,)?.toList() ?? [];

                                            // Sort the list
                                            productgridlist.sort((a, b) {
                                              // Check for reserved field first
                                              if (getJsonField(a, r'''$.reserved''').toString() == 'true' &&
                                                  getJsonField(b, r'''$.reserved''').toString() == 'false') {
                                                return -1;
                                              } else if (getJsonField(a, r'''$.reserved''').toString() == 'false' &&
                                                  getJsonField(b, r'''$.reserved''').toString() == 'true') {
                                                return 1;
                                              }

                                              // If both have the same reserved status, check the out_of_stock field
                                              if (getJsonField(a, r'''$.out_of_stock''').toString() == 'true' &&
                                                  getJsonField(b, r'''$.out_of_stock''').toString() == 'false') {
                                                return 1;
                                              } else if (getJsonField(a, r'''$.out_of_stock''').toString() == 'false' &&
                                                  getJsonField(b, r'''$.out_of_stock''').toString() == 'true') {
                                                return -1;
                                              }

                                              // If neither condition above applies, maintain the original order
                                              return 0;
                                            });

                                            print("data; ${productgridlist}");
                                            if (productgridlist.isEmpty) {
                                              return Center(
                                                child: Text(
                                                  'No data found',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Montserrat',
                                                    color: FlutterFlowTheme.of(context).productName,
                                                    fontSize: 16,
                                                    letterSpacing: 0,
                                                  ),
                                                ),
                                              );
                                            }
                                            return Stack(
                                              children: [
                                                GridView.builder(
                                                  controller: _scrollController,
                                                  padding: EdgeInsets.zero,
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 9,
                                                    mainAxisSpacing: 9,
                                                    childAspectRatio: 0.82,
                                                  ),
                                                  scrollDirection: Axis.vertical,
                                                  itemCount: productgridlist.length,
                                                  itemBuilder: (context, productgridlistIndex) {
                                                    final productgridlistItem =
                                                    productgridlist[
                                                    productgridlistIndex];
                                                    print(getJsonField(productgridlistItem, r'''$.out_of_stock''',).toString());
                                                    return Stack(
                                                      children: [
                                                        InkWell(
                                                          splashColor: Colors.transparent,
                                                          focusColor: Colors.transparent,
                                                          hoverColor: Colors.transparent,
                                                          highlightColor: Colors.transparent,
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
                                                                'firstLevelName': serializeParam(
                                                                  getJsonField(
                                                                    productgridlistItem,
                                                                    r'''$.first_level_name''',
                                                                  ).toString(),
                                                                  ParamType.String,
                                                                ),
                                                                'producttype': FFAppConstants.RudrakshaMasterProductDetailsApi,
                                                              }.withoutNulls,
                                                            );
                                                          },
                                                          child: Container(
                                                            // width: 168,
                                                            //height: MediaQuery.of(context).size.height * 0.23,
                                                            decoration: BoxDecoration(
                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                              borderRadius: BorderRadius.circular(2),
                                                              border: Border.all(
                                                                color: FlutterFlowTheme.of(context).borderColor,
                                                              ),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.max,
                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.all(4),
                                                                  child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(8),
                                                                    child: CachedNetworkImage(
                                                                      fadeInDuration: Duration(milliseconds: 100),
                                                                      fadeOutDuration: Duration(milliseconds: 100),
                                                                      imageUrl: utf8.decode(
                                                                        (widget.productType == 'OthersMainCategory'
                                                                            ? getJsonField(productgridlistItem, r'''$.image''').toString()
                                                                            : getJsonField(productgridlistItem, r'''$.image''').toString())
                                                                            .codeUnits.toList(),
                                                                        allowMalformed: true,
                                                                      ),
                                                                      width: double.infinity,
                                                                      height: 104.65,
                                                                      fit: BoxFit.cover,
                                                                      placeholder: (context, url) => ShimmerWidget(),
                                                                      errorWidget: (context, url, error) => Icon(Icons.image),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional.fromSTEB(9, 8, 9, 10),
                                                                  child: Column(
                                                                    mainAxisSize: MainAxisSize.max,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Container(
                                                                        width: double.infinity,
                                                                        height: 36,
                                                                        decoration: BoxDecoration(),
                                                                        child: Text(
                                                                          getJsonField(
                                                                            productgridlistItem,
                                                                            r'''$.product_name''',
                                                                          ).toString(),
                                                                          maxLines: 2,
                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            fontFamily: 'Montserrat',
                                                                            color: FlutterFlowTheme.of(context).productName,
                                                                            letterSpacing: 0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      RichText(
                                                                        textScaler: MediaQuery.of(context).textScaler,
                                                                        text: TextSpan(
                                                                          children: [
                                                                            TextSpan(
                                                                              text:
                                                                              //     getJsonField(
                                                                              //   productgridlistItem,
                                                                              //   r'''$.selling_price''',
                                                                              // ).toString(),
                                                                              '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(
                                                                                getJsonField(
                                                                                  productgridlistItem,
                                                                                  r'''$.selling_price''',).toString(), FFAppState().currencyRate,
                                                                              )}',
                                                                              style: TextStyle(),
                                                                            )
                                                                          ],
                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            fontFamily: 'Montserrat',
                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                            letterSpacing: 0,
                                                                            fontWeight: FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ].divide(SizedBox(height: 8)),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),

                                                        if (getJsonField(productgridlistItem, r'''$.out_of_stock''').toString() == 'true')
                                                          Align(
                                                            alignment: AlignmentDirectional(-1, -1),
                                                            child: Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0),
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                  color: Colors.red,
                                                                  borderRadius: BorderRadius.only(
                                                                    topRight: Radius.circular(12),
                                                                    bottomRight: Radius.circular(12),
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(5.0),
                                                                  child: Text(
                                                                    "OUT OF STOCK",
                                                                    style: TextStyle(color: Colors.white),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        if (getJsonField(productgridlistItem, r'''$.reserved''').toString() == 'true')
                                                          Align(
                                                            alignment: AlignmentDirectional(-1, -1),
                                                            child: Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0),
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                  color: Colors.green,
                                                                  borderRadius: BorderRadius.only(
                                                                    topRight: Radius.circular(12),
                                                                    bottomRight: Radius.circular(12),
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(5.0),
                                                                  child: Text(
                                                                    "RESERVED",
                                                                    style: TextStyle(color: Colors.white),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),


                                                        Align(
                                                        alignment: AlignmentDirectional(1, 1),
                                                        child: Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0),
                                                        child: FutureBuilder<ApiCallResponse>(
                                                        future: WishListCall.call(
                                                        hosturl: FFAppConstants.sanityurl,
                                                        token: currentAuthenticationToken,
                                                        ),
                                                        builder: (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
                                                        return Container(
                                                        width: 1,
                                                        height: 1,
                                                        child: ShimmerWidget(),
                                                        );
                                                        }
                                                        final containerWishlistResponse = snapshot.data!;

                                                        return Container(
                                                        decoration: BoxDecoration(
                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                        borderRadius: BorderRadius.circular(24),
                                                        ),
                                                        child: Builder(
                                                        builder: (context) {
                                                        final wishlistIds = WishListCall.id(containerWishlistResponse.jsonBody);
                                                        final productId = getJsonField(productgridlistItem, r'''$.product_id''');

                                                        print(wishlistIds);
                                                        print(productId);

                                                        if (!wishlistIds.contains(productId)) {
                                                        return Padding(
                                                        padding: EdgeInsets.all(5),
                                                        child: InkWell(
                                                        splashColor: Colors.transparent,
                                                        focusColor: Colors.transparent,
                                                        hoverColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        onTap: () async {
                                                        if (currentAuthenticationToken == null) {
                                                        context.pushNamed(
                                                        'LoginPage',
                                                        extra: <String, dynamic>{
                                                        kTransitionInfoKey: TransitionInfo(
                                                        hasTransition: true,
                                                        transitionType: PageTransitionType.fade,
                                                        duration: Duration(milliseconds: 0),
                                                        ),
                                                        },
                                                        );
                                                        } else {
                                                        _model.addToProductid(productgridlistIndex.toString());
                                                        _model.addtoWishlist = await AddToWishlistCall.call(
                                                        hosturl: FFAppConstants.sanityurl,
                                                        token: currentAuthenticationToken,
                                                        productid: productId,
                                                        productType: getJsonField(productgridlistItem, r'''$.mainprodtype'''),
                                                        );
                                                        if ((_model.addtoWishlist?.succeeded ?? true)) {
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
                                                        setState(() {});
                                                        } else {
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                        content: Text(
                                                        getJsonField((_model.addtoWishlist?.jsonBody ?? ''), r'''$.status''').toString(),
                                                        style: TextStyle(
                                                        color: FlutterFlowTheme.of(context).containerFillColor,
                                                        ),
                                                        ),
                                                        duration: Duration(milliseconds: 4000),
                                                        backgroundColor: FlutterFlowTheme.of(context).primary,
                                                        ),
                                                        );
                                                        }
                                                        HapticFeedback.lightImpact();
                                                        }
                                                        },
                                                        child: Container(
                                                        width: 24,
                                                        height: 24,
                                                        clipBehavior: Clip.antiAlias,
                                                        decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                          color: Colors.transparent
                                                        ),
                                                        child: Image.asset(
                                                        'assets/images/HeartEmpty.png',
                                                        fit: BoxFit.cover,
                                                        ),
                                                        ),
                                                        /*SvgPicture.asset(
                                                          'assets/images/heart.svg', // Ensure this path points to your SVG file
                                                          width: 24,
                                                          height: 24,
                                                          fit: BoxFit.cover,
                                                        ),*/
                                                        ),
                                                        );
                                                        } else {
                                                        return Padding(
                                                        padding: EdgeInsets.all(5),
                                                        child: InkWell(
                                                        splashColor: Colors.transparent,
                                                        focusColor: Colors.transparent,
                                                        hoverColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        onTap: () async {
                                                        var _shouldSetState = false;
                                                        _model.apiResult5ep = await RemovefromWishlistCall.call(
                                                        token: currentAuthenticationToken,
                                                        hosturl: FFAppConstants.hosturl,
                                                        productId: productId,
                                                        productType: getJsonField(productgridlistItem, r'''$.mainprodtype'''),
                                                        );
                                                        _shouldSetState = true;
                                                        if ((_model.apiResult5ep?.succeeded ?? true)) {
                                                        FFAppState().statusFailed = getJsonField((_model.apiResult5ep?.jsonBody ?? ''), r'''$.status''').toString();
                                                        setState(() {});
                                                        ScaffoldMessenger.of(context).clearSnackBars();
                                                        ScaffoldMessenger.of(context).showSnackBar(
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
                                                        if (FFAppState().statusFailed == 'success') {
                                                        } else {
                                                        if (_shouldSetState) setState(() {});
                                                        return;
                                                        }
                                                        } else {
                                                        if (_shouldSetState) setState(() {});
                                                        return;
                                                        }
                                                        _model.removeFromProductid(productgridlistIndex.toString());
                                                        setState(() {});
                                                        HapticFeedback.lightImpact();
                                                        },
                                                        child: Container(
                                                        width: 24,
                                                        height: 24,
                                                        clipBehavior: Clip.antiAlias,
                                                        decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        ),
                                                        child: Image.asset(
                                                        'assets/images/HeartFilled.png',
                                                        fit: BoxFit.cover,
                                                        ),
                                                        ),
                                                        ),
                                                        );
                                                        }
                                                        },
                                                        ),
                                                        );
                                                        },
                                                        ),
                                                        ),
                                                        )
        
        
                                                        ],
                                                    );
                                                  },
                                                ),
                                                if (_isLoading)
                                                  Positioned(
                                                    left: 0,
                                                    right: 0,
                                                    bottom: 16.0,
                                                    child: Center(
                                                      child: CircularProgressIndicator(
                                                        color: Color(0xFF740074),
                                                      ),
                                                    ),
                                                  ),
                                              ],
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
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                            child: FutureBuilder<ApiCallResponse>(
                              future: YantraProductCall.call(
                                hosturl: FFAppConstants.hosturl,
                                slugValue: widget.productslugvalue,
                                maxPrice: FFAppState().rangeendString,
                                minPrice: FFAppState().rangeendString,
                                diety: FFAppState().YantrasDeityPurpose,
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
                                final yantrasYantraProductResponse = snapshot.data!;
                                final data = YantraProductCall.yantrProductData(yantrasYantraProductResponse.jsonBody,
                                )?.toList() ?? [];

                                if (data.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'No data found',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).productName,
                                        fontSize: 16,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  );
                                }
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
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
                                                    onTap: () => _model.unfocusNode.canRequestFocus
                                                        ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                        : FocusScope.of(context).unfocus(),
                                                    child: Padding(
                                                      padding: MediaQuery.viewInsetsOf(context),
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
                                              width: 90.0,
                                              height: 40.0,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.of(context).containerFillColor,
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(context).borderColor,
                                                ),
                                              ),
                                              alignment: AlignmentDirectional(0.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(8.0),
                                                      child: Image.asset(
                                                        'assets/images/Swap.png',
                                                        width: 15.0,
                                                        height: 15.0,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Sort',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
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
                                                    onTap: () => _model.unfocusNode.canRequestFocus
                                                        ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                        : FocusScope.of(context).unfocus(),
                                                    child: Padding(
                                                      padding: MediaQuery.viewInsetsOf(context),
                                                      child: FilterComponentWidget(
                                                        productFilterbytype: 'Yantras',
                                                        maxprice: YantraProductCall.yantraconstantmaxprice(
                                                          yantrasYantraProductResponse.jsonBody,
                                                        )?.toDouble(),
                                                        minprice: YantraProductCall.yantraconstantminprice(
                                                          yantrasYantraProductResponse.jsonBody,
                                                        )?.toDouble(),
                                                        deityPurpose: YantraProductCall.yantraconstantdietylist(
                                                          yantrasYantraProductResponse.jsonBody,
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
                                                color: FlutterFlowTheme.of(context).containerFillColor,
                                                borderRadius: BorderRadius.circular(10.0),
                                                border: Border.all(color: FlutterFlowTheme.of(context).borderColor,),
                                              ),
                                              alignment: AlignmentDirectional(0.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(8.0),
                                                      child: Image.asset(
                                                        'assets/images/sort.png',
                                                        width: 15.0,
                                                        height: 15.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Filter',
                                                      style: FlutterFlowTheme.of(context).bodyMedium
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
                                            16.0, 18.0, 16.0, 0),
                                        child: Builder(
                                          builder: (context) {
                                            final yantrasgridlist =
                                                YantraProductCall.yantrProductData(
                                                  yantrasYantraProductResponse
                                                      .jsonBody,
                                                )?.toList() ??
                                                    [];

                                            // Sort the list
                                            yantrasgridlist.sort((a, b) {
                                              // Check for reserved field first
                                              if (getJsonField(a, r'''$.reserved''').toString() == 'true' &&
                                                  getJsonField(b, r'''$.reserved''').toString() == 'false') {
                                                return -1;
                                              } else if (getJsonField(a, r'''$.reserved''').toString() == 'false' &&
                                                  getJsonField(b, r'''$.reserved''').toString() == 'true') {
                                                return 1;
                                              }

                                              // If both have the same reserved status, check the out_of_stock field
                                              if (getJsonField(a, r'''$.out_of_stock''').toString() == 'true' &&
                                                  getJsonField(b, r'''$.out_of_stock''').toString() == 'false') {
                                                return 1;
                                              } else if (getJsonField(a, r'''$.out_of_stock''').toString() == 'false' &&
                                                  getJsonField(b, r'''$.out_of_stock''').toString() == 'true') {
                                                return -1;
                                              }

                                              // If neither condition above applies, maintain the original order
                                              return 0;
                                            });

                                            return GridView.builder(
                                              padding: EdgeInsets.zero,
                                              gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
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
                                                      child:

                                                      Container(
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
                                                            color: FlutterFlowTheme.of(
                                                                context)
                                                                .borderColor,
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.max,
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                              EdgeInsets.all(4.0),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(8.0),
                                                                child: CachedNetworkImage(
                                                                  fadeInDuration: Duration(milliseconds: 100),
                                                                  fadeOutDuration: Duration(milliseconds: 100),
                                                                  imageUrl: utf8.decode(
                                                                    (widget.productType == 'OthersMainCategory'
                                                                        ? getJsonField(yantrasgridlistItem, r'''$.image''').toString()
                                                                        : getJsonField(yantrasgridlistItem, r'''$.image''').toString())
                                                                        .codeUnits.toList(),
                                                                    allowMalformed: true,
                                                                  ),
                                                                  width: double.infinity,
                                                                  height: 104.65,
                                                                  fit: BoxFit.contain,
                                                                  placeholder: (context, url) => ShimmerWidget(),
                                                                  errorWidget: (context, url, error) => Icon(Icons.image),
                                                                ),
                                                                /*CachedNetworkImage(
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
                                                                    yantrasgridlistItem,
                                                                    r'''$.image''',
                                                                  ).toString(),
                                                                  width:
                                                                  double.infinity,
                                                                  height: 104.65,
                                                                  fit: BoxFit.cover,
                                                                ),*/
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
                                                                        yantrasgridlistItem,
                                                                        r'''$.product_name''',
                                                                      ).toString(),
                                                                      maxLines: 2,
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Montserrat',
                                                                        color: FlutterFlowTheme.of(context).productName,
                                                                        letterSpacing: 0.0,
                                                                        fontSize: 14,
                                                                        fontWeight: FontWeight.w400
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  if (getJsonField(yantrasgridlistItem, r'''$.contact_for_price''').toString() == 'false')
                                                                  RichText(
                                                                    textScaler:
                                                                    MediaQuery.of(
                                                                        context)
                                                                        .textScaler,
                                                                    text: TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                          //     getJsonField(
                                                                          //   yantrasgridlistItem,
                                                                          //   r'''$.selling_price''',
                                                                          // ).toString(),
                                                                          '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(
                                                                            getJsonField(yantrasgridlistItem, r'''$.selling_price''',).toString(),
                                                                            FFAppState().currencyRate,
                                                                          )}',
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
                                                                  if (getJsonField(yantrasgridlistItem, r'''$.contact_for_price''').toString() == 'true')
                                                                    RichText(
                                                                      textScaler:
                                                                      MediaQuery.of(
                                                                          context)
                                                                          .textScaler,
                                                                      text: TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text: "Contact For Price",
                                                                            style:
                                                                            TextStyle(color:  FlutterFlowTheme.of(
                                                                                context)
                                                                                .primary),
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
                                                                              .primary,
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
                                                    if (getJsonField(yantrasgridlist, r'''$.out_of_stock''').toString() == 'true')
                                                      Align(
                                                        alignment: AlignmentDirectional(-1, -1),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius: BorderRadius.only(
                                                                topRight: Radius.circular(12),
                                                                bottomRight: Radius.circular(12),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(5.0),
                                                              child: Text(
                                                                "OUT OF STOCK",
                                                                style: TextStyle(color: Colors.white),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    if (getJsonField(yantrasgridlist, r'''$.reserved''').toString() == 'true')
                                                      Align(
                                                        alignment: AlignmentDirectional(-1, -1),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              color: Colors.green,
                                                              borderRadius: BorderRadius.only(
                                                                topRight: Radius.circular(12),
                                                                bottomRight: Radius.circular(12),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(5.0),
                                                              child: Text(
                                                                "RESERVED",
                                                                style: TextStyle(color: Colors.white),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),


                                                    Align(
                                                      //alignment: AlignmentDirectional(1, -1),
                                                      alignment: AlignmentDirectional(1, 1),
                                                      child: Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0),
                                                        child: FutureBuilder<ApiCallResponse>(
                                                          future: WishListCall.call(
                                                            hosturl: FFAppConstants.sanityurl,
                                                            token: currentAuthenticationToken,
                                                          ),
                                                          builder: (context, snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot.hasData) {
                                                              return Container(
                                                                width: 1,
                                                                height: 1,
                                                                child: ShimmerWidget(),
                                                              );
                                                            }
                                                            final containerWishlistResponse = snapshot.data!;

                                                            return Container(
                                                              decoration: BoxDecoration(
                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                borderRadius: BorderRadius.circular(24),
                                                              ),
                                                              child: Builder(
                                                                builder: (context) {
                                                                  final wishlistIds = WishListCall.id(containerWishlistResponse.jsonBody);
                                                                  final productId = getJsonField(yantrasgridlistItem, r'''$.product_id''');

                                                                  print(wishlistIds);
                                                                  print(productId);

                                                                  if (!wishlistIds.contains(productId)) {
                                                                    return Padding(
                                                                      padding: EdgeInsets.all(5),
                                                                      child: InkWell(
                                                                        splashColor: Colors.transparent,
                                                                        focusColor: Colors.transparent,
                                                                        hoverColor: Colors.transparent,
                                                                        highlightColor: Colors.transparent,
                                                                        onTap: () async {
                                                                          if (currentAuthenticationToken == null) {
                                                                            context.pushNamed(
                                                                              'LoginPage',
                                                                              extra: <String, dynamic>{
                                                                                kTransitionInfoKey: TransitionInfo(
                                                                                  hasTransition: true,
                                                                                  transitionType: PageTransitionType.fade,
                                                                                  duration: Duration(milliseconds: 0),
                                                                                ),
                                                                              },
                                                                            );
                                                                          } else {
                                                                            _model.addToProductid(yantrasgridlistItem.toString());
                                                                            _model.addtoWishlist = await AddToWishlistCall.call(
                                                                              hosturl: FFAppConstants.sanityurl,
                                                                              token: currentAuthenticationToken,
                                                                              productid: productId,
                                                                              productType: getJsonField(yantrasgridlistItem, r'''$.mainprodtype'''),
                                                                            );
                                                                            if ((_model.addtoWishlist?.succeeded ?? true)) {
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
                                                                              setState(() {});
                                                                            } else {
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackBar(
                                                                                  content: Text(
                                                                                    getJsonField((_model.addtoWishlist?.jsonBody ?? ''), r'''$.status''').toString(),
                                                                                    style: TextStyle(
                                                                                      color: FlutterFlowTheme.of(context).containerFillColor,
                                                                                    ),
                                                                                  ),
                                                                                  duration: Duration(milliseconds: 4000),
                                                                                  backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                                ),
                                                                              );
                                                                            }
                                                                            HapticFeedback.lightImpact();
                                                                          }
                                                                        },
                                                                        child: Container(
                                                                          width: 24,
                                                                          height: 24,
                                                                          clipBehavior: Clip.antiAlias,
                                                                          decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                          ),
                                                                          child: Image.asset(
                                                                            'assets/images/HeartEmpty.png',
                                                                            fit: BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  } else {
                                                                    return Padding(
                                                                      padding: EdgeInsets.all(5),
                                                                      child: InkWell(
                                                                        splashColor: Colors.transparent,
                                                                        focusColor: Colors.transparent,
                                                                        hoverColor: Colors.transparent,
                                                                        highlightColor: Colors.transparent,
                                                                        onTap: () async {
                                                                          var _shouldSetState = false;
                                                                          _model.apiResult5ep = await RemovefromWishlistCall.call(
                                                                            token: currentAuthenticationToken,
                                                                            hosturl: FFAppConstants.hosturl,
                                                                            productId: productId,
                                                                            productType: getJsonField(yantrasgridlistItem, r'''$.mainprodtype'''),
                                                                          );
                                                                          _shouldSetState = true;
                                                                          if ((_model.apiResult5ep?.succeeded ?? true)) {
                                                                            FFAppState().statusFailed = getJsonField((_model.apiResult5ep?.jsonBody ?? ''), r'''$.status''').toString();
                                                                            setState(() {});
                                                                            ScaffoldMessenger.of(context).clearSnackBars();
                                                                            ScaffoldMessenger.of(context).showSnackBar(
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
                                                                            if (FFAppState().statusFailed == 'success') {
                                                                            } else {
                                                                              if (_shouldSetState) setState(() {});
                                                                              return;
                                                                            }
                                                                          } else {
                                                                            if (_shouldSetState) setState(() {});
                                                                            return;
                                                                          }
                                                                          _model.removeFromProductid(yantrasgridlistItem.toString());
                                                                          setState(() {});
                                                                          HapticFeedback.lightImpact();
                                                                        },
                                                                        child: Container(
                                                                          width: 24,
                                                                          height: 24,
                                                                          clipBehavior: Clip.antiAlias,
                                                                          decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                          ),
                                                                          child: Image.asset(
                                                                            'assets/images/HeartFilled.png',
                                                                            fit: BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                },
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    )


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
                                  sort_by: FFAppState().sortby),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: ShimmerWidget(),
                                  );
                                }
                                final columnGemstoneProductOnSubCategoriesResponse = snapshot.data!;
                                final data = GemstoneProductOnSubCategoriesCall
                                    .productDataList(
                                  columnGemstoneProductOnSubCategoriesResponse
                                      .jsonBody,
                                )?.toList() ??
                                    [];
        
                                if (data.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'No data found',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).productName,
                                        fontSize: 16,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  );
                                }
        
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
                                                    onTap: () => _model.unfocusNode.canRequestFocus
                                                        ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                        : FocusScope.of(context).unfocus(),
                                                    child: Padding(
                                                      padding: MediaQuery.viewInsetsOf(context),
                                                      child: FilterComponentWidget(
                                                        productFilterbytype:
                                                        //'Rurakasha',
                                                        'Rudraksha',
                                                        maxprice: GemstoneProductOnSubCategoriesCall.constantmaxprice(
                                                          columnGemstoneProductOnSubCategoriesResponse
                                                              .jsonBody,)?.toDouble(),
                                                        minprice: GemstoneProductOnSubCategoriesCall.constantminprice(
                                                          columnGemstoneProductOnSubCategoriesResponse
                                                              .jsonBody,)?.toDouble(),
                                                        maxcaratweight: GemstoneProductOnSubCategoriesCall.constantmaxcaratweight(
                                                          columnGemstoneProductOnSubCategoriesResponse
                                                              .jsonBody,),
                                                        mincaratweight: GemstoneProductOnSubCategoriesCall.constantmincaratweight(
                                                          columnGemstoneProductOnSubCategoriesResponse
                                                              .jsonBody,),
                                                        maxrattiweight: GemstoneProductOnSubCategoriesCall.constantmaxrattiweight(
                                                          columnGemstoneProductOnSubCategoriesResponse
                                                              .jsonBody,),
                                                        /*minrattiweight: GemstoneProductOnSubCategoriesCall.constantminrattiweight(
                                                          columnGemstoneProductOnSubCategoriesResponse
                                                              .jsonBody,)?.toDouble(),*/
                                                        maxpricepercarat: GemstoneProductOnSubCategoriesCall.constantmaxpricepercara(
                                                          columnGemstoneProductOnSubCategoriesResponse
                                                              .jsonBody,)?.toDouble(),
                                                        minpricepercarat: GemstoneProductOnSubCategoriesCall.constantminpricepercarat(
                                                          columnGemstoneProductOnSubCategoriesResponse
                                                              .jsonBody,)?.toDouble(),
                                                        originlist: GemstoneProductOnSubCategoriesCall.constantoriginlist(
                                                          columnGemstoneProductOnSubCategoriesResponse
                                                              .jsonBody,),
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
                                            16.0, 18.0, 16.0, 0),
                                        child: Builder(
                                          builder: (context) {
                                            final productgridlist = _productsList;

                                            // Sort the list
                                            productgridlist.sort((a, b) {
                                              // Check for reserved field first
                                              if (getJsonField(a, r'''$.reserved''').toString() == 'true' &&
                                                  getJsonField(b, r'''$.reserved''').toString() == 'false') {
                                                return -1;
                                              } else if (getJsonField(a, r'''$.reserved''').toString() == 'false' &&
                                                  getJsonField(b, r'''$.reserved''').toString() == 'true') {
                                                return 1;
                                              }

                                              // If both have the same reserved status, check the out_of_stock field
                                              if (getJsonField(a, r'''$.out_of_stock''').toString() == 'true' &&
                                                  getJsonField(b, r'''$.out_of_stock''').toString() == 'false') {
                                                return 1;
                                              } else if (getJsonField(a, r'''$.out_of_stock''').toString() == 'false' &&
                                                  getJsonField(b, r'''$.out_of_stock''').toString() == 'true') {
                                                return -1;
                                              }

                                              // If neither condition above applies, maintain the original order
                                              return 0;
                                            });

                                            return Stack(
                                              children: [
                                                GridView.builder(
                                                  controller: _scrollController,
                                                  padding: EdgeInsets.zero,
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 9,
                                                    mainAxisSpacing: 9,
                                                    childAspectRatio: 0.82,
                                                  ),
                                                  scrollDirection: Axis.vertical,
                                                  itemCount: productgridlist.length,
                                                  itemBuilder: (context, productgridlistIndex) {
                                                    final productgridlistItem = productgridlist[productgridlistIndex];
                                                    return Stack(
                                                      children: [
                                                        InkWell(
                                                          splashColor: Colors.transparent,
                                                          focusColor: Colors.transparent,
                                                          hoverColor: Colors.transparent,
                                                          highlightColor: Colors.transparent,
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
                                                                'producttype': FFAppConstants.GemstoneMasterProductDetailsApi,
                                                              }.withoutNulls,
                                                            );
                                                          },
                                                          child: Container(
                                                            //width: 168.0,
                                                            //height: 193.0,
                                                            decoration: BoxDecoration(
                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                              borderRadius: BorderRadius.circular(2.0),
                                                              border: Border.all(color: Color(0xFFE7E7E8)),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.max,
                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.all(4.0),
                                                                  child: Center(
                                                                    child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                      child: CachedNetworkImage(
                                                                        fadeInDuration: Duration(milliseconds: 100),
                                                                        fadeOutDuration: Duration(milliseconds: 100),
                                                                        imageUrl: utf8.decode(
                                                                          (widget.productType == 'OthersMainCategory'
                                                                              ? getJsonField(productgridlistItem, r'''$.image''').toString()
                                                                              : getJsonField(productgridlistItem, r'''$.image''').toString())
                                                                              .codeUnits.toList(),
                                                                          allowMalformed: true,
                                                                        ),
                                                                        //width: double.infinity,
                                                                        height: 104.65,
                                                                        fit: BoxFit.contain,
                                                                        placeholder: (context, url) => ShimmerWidget(),
                                                                        errorWidget: (context, url, error) => Icon(Icons.image),
                                                                      ),
                                                                      /*CachedNetworkImage(
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
                                                                        width: double
                                                                            .infinity,
                                                                        height: 104.65,
                                                                        fit: BoxFit.cover,
                                                                      ),*/
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional.fromSTEB(9.0, 8.0, 9.0, 10.0),
                                                                  child: Column(
                                                                    mainAxisSize: MainAxisSize.max,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Container(
                                                                        width: double.infinity,
                                                                        height: 36.0,
                                                                        decoration: BoxDecoration(),
                                                                        child: Text(
                                                                          getJsonField(
                                                                            productgridlistItem,
                                                                            r'''$.product_name''',
                                                                          ).toString(),
                                                                          maxLines: 2,
                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            fontFamily: 'Montserrat',
                                                                            color: Color(0xFF696969),
                                                                            letterSpacing: 0.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      if (getJsonField(productgridlistItem, r'''$.contact_for_price''').toString() == 'false')
                                                                      RichText(
                                                                        textScaler: MediaQuery.of(context).textScaler,
                                                                        text: TextSpan(
                                                                          children: [
                                                                            TextSpan(
                                                                              text: '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(
                                                                                getJsonField(productgridlistItem, r'''$.selling_price''',).toString(),
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
                                                                      if (getJsonField(productgridlistItem, r'''$.contact_for_price''').toString() == 'true')
                                                                        RichText(
                                                                          textScaler: MediaQuery.of(context).textScaler,
                                                                          text: TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: "Contact For Price",
                                                                                style: TextStyle(color:  FlutterFlowTheme.of(context).primary),
                                                                              )
                                                                            ],
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                              fontFamily: 'Montserrat',
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                    ].divide(SizedBox(height: 8.0)),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),

                                                        if (getJsonField(productgridlistItem, r'''$.out_of_stock''').toString() == 'true')
                                                          Align(
                                                            alignment: AlignmentDirectional(-1, -1),
                                                            child: Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0),
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                  color: Colors.red,
                                                                  borderRadius: BorderRadius.only(
                                                                    topRight: Radius.circular(12),
                                                                    bottomRight: Radius.circular(12),
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(5.0),
                                                                  child: Text(
                                                                    "OUT OF STOCK",
                                                                    style: TextStyle(color: Colors.white),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        if (getJsonField(productgridlistItem, r'''$.reserved''').toString() == 'true')
                                                          Align(
                                                            alignment: AlignmentDirectional(-1, -1),
                                                            child: Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0),
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                  color: Colors.green,
                                                                  borderRadius: BorderRadius.only(
                                                                    topRight: Radius.circular(12),
                                                                    bottomRight: Radius.circular(12),
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(5.0),
                                                                  child: Text(
                                                                    "RESERVED",
                                                                    style: TextStyle(color: Colors.white),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),


                                                        Align(
                                                          //alignment: AlignmentDirectional(1, -1),
                                                          alignment: AlignmentDirectional(1, 1),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0),
                                                            child: FutureBuilder<ApiCallResponse>(
                                                              future: WishListCall.call(
                                                                hosturl: FFAppConstants.sanityurl,
                                                                token: currentAuthenticationToken,
                                                              ),
                                                              builder: (context, snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot.hasData) {
                                                                  return Container(
                                                                    width: 1,
                                                                    height: 1,
                                                                    child: ShimmerWidget(),
                                                                  );
                                                                }
                                                                final containerWishlistResponse = snapshot.data!;
        
                                                                return Container(
                                                                  decoration: BoxDecoration(
                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                    borderRadius: BorderRadius.circular(24),
                                                                  ),
                                                                  child: Builder(
                                                                    builder: (context) {
                                                                      final wishlistIds = WishListCall.id(containerWishlistResponse.jsonBody);
                                                                      final productId = getJsonField(productgridlistItem, r'''$.product_id''');
        
                                                                      print(wishlistIds);
                                                                      print(productId);
        
                                                                      if (!wishlistIds.contains(productId)) {
                                                                        return Padding(
                                                                          padding: EdgeInsets.all(5),
                                                                          child: InkWell(
                                                                            splashColor: Colors.transparent,
                                                                            focusColor: Colors.transparent,
                                                                            hoverColor: Colors.transparent,
                                                                            highlightColor: Colors.transparent,
                                                                            onTap: () async {
                                                                              if (currentAuthenticationToken == null) {
                                                                                context.pushNamed(
                                                                                  'LoginPage',
                                                                                  extra: <String, dynamic>{
                                                                                    kTransitionInfoKey: TransitionInfo(
                                                                                      hasTransition: true,
                                                                                      transitionType: PageTransitionType.fade,
                                                                                      duration: Duration(milliseconds: 0),
                                                                                    ),
                                                                                  },
                                                                                );
                                                                              } else {
                                                                                _model.addToProductid(productgridlistItem.toString());
                                                                                _model.addtoWishlist = await AddToWishlistCall.call(
                                                                                  hosturl: FFAppConstants.sanityurl,
                                                                                  token: currentAuthenticationToken,
                                                                                  productid: productId,
                                                                                  productType: getJsonField(productgridlistItem, r'''$.mainprodtype'''),
                                                                                );
                                                                                if ((_model.addtoWishlist?.succeeded ?? true)) {
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
                                                                                  setState(() {});
                                                                                } else {
                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                    SnackBar(
                                                                                      content: Text(
                                                                                        getJsonField((_model.addtoWishlist?.jsonBody ?? ''), r'''$.status''').toString(),
                                                                                        style: TextStyle(
                                                                                          color: FlutterFlowTheme.of(context).containerFillColor,
                                                                                        ),
                                                                                      ),
                                                                                      duration: Duration(milliseconds: 4000),
                                                                                      backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                                    ),
                                                                                  );
                                                                                }
                                                                                HapticFeedback.lightImpact();
                                                                              }
                                                                            },
                                                                            child: Container(
                                                                              width: 24,
                                                                              height: 24,
                                                                              clipBehavior: Clip.antiAlias,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                              child: Image.asset(
                                                                                'assets/images/HeartEmpty.png',
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        return Padding(
                                                                          padding: EdgeInsets.all(5),
                                                                          child: InkWell(
                                                                            splashColor: Colors.transparent,
                                                                            focusColor: Colors.transparent,
                                                                            hoverColor: Colors.transparent,
                                                                            highlightColor: Colors.transparent,
                                                                            onTap: () async {
                                                                              var _shouldSetState = false;
                                                                              _model.apiResult5ep = await RemovefromWishlistCall.call(
                                                                                token: currentAuthenticationToken,
                                                                                hosturl: FFAppConstants.hosturl,
                                                                                productId: productId,
                                                                                productType: getJsonField(productgridlistItem, r'''$.mainprodtype'''),
                                                                              );
                                                                              _shouldSetState = true;
                                                                              if ((_model.apiResult5ep?.succeeded ?? true)) {
                                                                                FFAppState().statusFailed = getJsonField((_model.apiResult5ep?.jsonBody ?? ''), r'''$.status''').toString();
                                                                                setState(() {});
                                                                                ScaffoldMessenger.of(context).clearSnackBars();
                                                                                ScaffoldMessenger.of(context).showSnackBar(
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
                                                                                if (FFAppState().statusFailed == 'success') {
                                                                                } else {
                                                                                  if (_shouldSetState) setState(() {});
                                                                                  return;
                                                                                }
                                                                              } else {
                                                                                if (_shouldSetState) setState(() {});
                                                                                return;
                                                                              }
                                                                              _model.removeFromProductid(productgridlistItem.toString());
                                                                              setState(() {});
                                                                              HapticFeedback.lightImpact();
                                                                            },
                                                                            child: Container(
                                                                              width: 24,
                                                                              height: 24,
                                                                              clipBehavior: Clip.antiAlias,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                              child: Image.asset(
                                                                                'assets/images/HeartFilled.png',
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                    },
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        )
        
                                                      ],
                                                    );
                                                  },
                                                ),
                                                if (_isLoading)
                                                  Positioned(
                                                    left: 0,
                                                    right: 0,
                                                    bottom: 16.0,
                                                    child: Center(
                                                      child: CircularProgressIndicator(
                                                        color: Color(0xFF740074),
                                                      ),
                                                    ),
                                                  ),
                                              ],
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
                                            16.0, 18.0, 16.0, 0),
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
                                                        MainAxisAlignment.spaceAround,
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
                                                                fadeInDuration: Duration(milliseconds: 100),
                                                                fadeOutDuration: Duration(milliseconds: 100),
                                                                imageUrl: utf8.decode(
                                                                  (widget.productType == 'OthersMainCategory'
                                                                      ? getJsonField(productgridlistItem, r'''$.image''').toString()
                                                                      : getJsonField(productgridlistItem, r'''$.image''').toString())
                                                                      .codeUnits.toList(),
                                                                  allowMalformed: true,
                                                                ),
                                                                width: double.infinity,
                                                                height: 104.65,
                                                                fit: BoxFit.contain,
                                                                placeholder: (context, url) => ShimmerWidget(),
                                                                errorWidget: (context, url, error) => Icon(Icons.image),
                                                              ),
                                                              /*CachedNetworkImage(
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
                                                              ),*/
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
                                                                        text:
                                                                        //     getJsonField(
                                                                        //   productgridlistItem,
                                                                        //   r'''$.selling_price''',
                                                                        // ).toString(),
                                                                        '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(
                                                                          getJsonField(productgridlistItem, r'''$.selling_price''',).toString(),
                                                                          FFAppState().currencyRate,
                                                                        )}',
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
                                                      //alignment: AlignmentDirectional(1, -1),
                                                      alignment: AlignmentDirectional(1, 1),
                                                      child: Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0),
                                                        child: FutureBuilder<ApiCallResponse>(
                                                          future: WishListCall.call(
                                                            hosturl: FFAppConstants.sanityurl,
                                                            token: currentAuthenticationToken,
                                                          ),
                                                          builder: (context, snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot.hasData) {
                                                              return Container(
                                                                width: 1,
                                                                height: 1,
                                                                child: ShimmerWidget(),
                                                              );
                                                            }
                                                            final containerWishlistResponse = snapshot.data!;
        
                                                            return Container(
                                                              decoration: BoxDecoration(
                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                borderRadius: BorderRadius.circular(24),
                                                              ),
                                                              child: Builder(
                                                                builder: (context) {
                                                                  final wishlistIds = WishListCall.id(containerWishlistResponse.jsonBody);
                                                                  final productId = getJsonField(productgridlistItem, r'''$.product_id''');
        
                                                                  print(wishlistIds);
                                                                  print(productId);
        
                                                                  if (!wishlistIds.contains(productId)) {
                                                                    return Padding(
                                                                      padding: EdgeInsets.all(5),
                                                                      child: InkWell(
                                                                        splashColor: Colors.transparent,
                                                                        focusColor: Colors.transparent,
                                                                        hoverColor: Colors.transparent,
                                                                        highlightColor: Colors.transparent,
                                                                        onTap: () async {
                                                                          if (currentAuthenticationToken == null) {
                                                                            context.pushNamed(
                                                                              'LoginPage',
                                                                              extra: <String, dynamic>{
                                                                                kTransitionInfoKey: TransitionInfo(
                                                                                  hasTransition: true,
                                                                                  transitionType: PageTransitionType.fade,
                                                                                  duration: Duration(milliseconds: 0),
                                                                                ),
                                                                              },
                                                                            );
                                                                          } else {
                                                                            _model.addToProductid(productgridlistItem.toString());
                                                                            _model.addtoWishlist = await AddToWishlistCall.call(
                                                                              hosturl: FFAppConstants.sanityurl,
                                                                              token: currentAuthenticationToken,
                                                                              productid: productId,
                                                                              productType: getJsonField(productgridlistItem, r'''$.mainprodtype'''),
                                                                            );
                                                                            if ((_model.addtoWishlist?.succeeded ?? true)) {
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
                                                                              setState(() {});
                                                                            } else {
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackBar(
                                                                                  content: Text(
                                                                                    getJsonField((_model.addtoWishlist?.jsonBody ?? ''), r'''$.status''').toString(),
                                                                                    style: TextStyle(
                                                                                      color: FlutterFlowTheme.of(context).containerFillColor,
                                                                                    ),
                                                                                  ),
                                                                                  duration: Duration(milliseconds: 4000),
                                                                                  backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                                ),
                                                                              );
                                                                            }
                                                                            HapticFeedback.lightImpact();
                                                                          }
                                                                        },
                                                                        child: Container(
                                                                          width: 24,
                                                                          height: 24,
                                                                          clipBehavior: Clip.antiAlias,
                                                                          decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                          ),
                                                                          child: Image.asset(
                                                                            'assets/images/HeartEmpty.png',
                                                                            fit: BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  } else {
                                                                    return Padding(
                                                                      padding: EdgeInsets.all(5),
                                                                      child: InkWell(
                                                                        splashColor: Colors.transparent,
                                                                        focusColor: Colors.transparent,
                                                                        hoverColor: Colors.transparent,
                                                                        highlightColor: Colors.transparent,
                                                                        onTap: () async {
                                                                          var _shouldSetState = false;
                                                                          _model.apiResult5ep = await RemovefromWishlistCall.call(
                                                                            token: currentAuthenticationToken,
                                                                            hosturl: FFAppConstants.hosturl,
                                                                            productId: productId,
                                                                            productType: getJsonField(productgridlistItem, r'''$.mainprodtype'''),
                                                                          );
                                                                          _shouldSetState = true;
                                                                          if ((_model.apiResult5ep?.succeeded ?? true)) {
                                                                            FFAppState().statusFailed = getJsonField((_model.apiResult5ep?.jsonBody ?? ''), r'''$.status''').toString();
                                                                            setState(() {});
                                                                            ScaffoldMessenger.of(context).clearSnackBars();
                                                                            ScaffoldMessenger.of(context).showSnackBar(
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
                                                                            if (FFAppState().statusFailed == 'success') {
                                                                            } else {
                                                                              if (_shouldSetState) setState(() {});
                                                                              return;
                                                                            }
                                                                          } else {
                                                                            if (_shouldSetState) setState(() {});
                                                                            return;
                                                                          }
                                                                          _model.removeFromProductid(productgridlistItem.toString());
                                                                          setState(() {});
                                                                          HapticFeedback.lightImpact();
                                                                        },
                                                                        child: Container(
                                                                          width: 24,
                                                                          height: 24,
                                                                          clipBehavior: Clip.antiAlias,
                                                                          decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                          ),
                                                                          child: Image.asset(
                                                                            'assets/images/HeartFilled.png',
                                                                            fit: BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                },
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    )
        
        
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
                                sort_by: FFAppState().sortby,
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
                                final data = PujaProductCall.productlist(
                                  pujaProductPujaProductResponse
                                      .jsonBody,
                                )?.toList() ??
                                    [];
        
                                if (data.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'No data found',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).productName,
                                        fontSize: 16,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  );
                                }
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
                                            16.0, 18.0, 16.0, 0),
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
                                                      child: InkWell(
                                                        onTap: () {
                                                          context.pushNamed(
                                                            'PujaProductDetails',
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
                                                                  .PujaMasterProductDetailsApi,
                                                            }.withoutNulls,
                                                          );
                                                        },
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.max,
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                              EdgeInsets.all(4.0),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(8.0),
                                                                child: CachedNetworkImage(
                                                                  fadeInDuration: Duration(milliseconds: 100),
                                                                  fadeOutDuration: Duration(milliseconds: 100),
                                                                  imageUrl: utf8.decode(
                                                                    (widget.productType == 'OthersMainCategory'
                                                                        ? getJsonField(productgridlistItem, r'''$.image''').toString()
                                                                        : getJsonField(productgridlistItem, r'''$.image''').toString())
                                                                        .codeUnits.toList(),
                                                                    allowMalformed: true,
                                                                  ),
                                                                  width: double.infinity,
                                                                  height: 104.65,
                                                                  fit: BoxFit.contain,
                                                                  placeholder: (context, url) => ShimmerWidget(),
                                                                  errorWidget: (context, url, error) => Icon(Icons.image),
                                                                ),
                                                                /*CachedNetworkImage(
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
                                                                ),*/
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
                                                                mainAxisSize: MainAxisSize.max,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                                                          text:
                                                                          //     getJsonField(
                                                                          //   productgridlistItem,
                                                                          //   r'''$.selling_price''',
                                                                          // ).toString(),
                                                                          '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(
                                                                            getJsonField(productgridlistItem, r'''$.selling_price''',).toString(),
                                                                            FFAppState().currencyRate,
                                                                          )}',
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
                                                      //alignment: AlignmentDirectional(1, -1),
                                                      alignment: AlignmentDirectional(1, 1),
                                                      child: Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0),
                                                        child: FutureBuilder<ApiCallResponse>(
                                                          future: WishListCall.call(
                                                            hosturl: FFAppConstants.sanityurl,
                                                            token: currentAuthenticationToken,
                                                          ),
                                                          builder: (context, snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot.hasData) {
                                                              return Container(
                                                                width: 1,
                                                                height: 1,
                                                                child: ShimmerWidget(),
                                                              );
                                                            }
                                                            final containerWishlistResponse = snapshot.data!;
        
                                                            return Container(
                                                              decoration: BoxDecoration(
                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                borderRadius: BorderRadius.circular(24),
                                                              ),
                                                              child: Builder(
                                                                builder: (context) {
                                                                  final wishlistIds = WishListCall.id(containerWishlistResponse.jsonBody);
                                                                  final productId = getJsonField(productgridlistItem, r'''$.product_id''');
        
                                                                  print(wishlistIds);
                                                                  print(productId);
        
                                                                  if (!wishlistIds.contains(productId)) {
                                                                    return Padding(
                                                                      padding: EdgeInsets.all(5),
                                                                      child: InkWell(
                                                                        splashColor: Colors.transparent,
                                                                        focusColor: Colors.transparent,
                                                                        hoverColor: Colors.transparent,
                                                                        highlightColor: Colors.transparent,
                                                                        onTap: () async {
                                                                          if (currentAuthenticationToken == null) {
                                                                            context.pushNamed(
                                                                              'LoginPage',
                                                                              extra: <String, dynamic>{
                                                                                kTransitionInfoKey: TransitionInfo(
                                                                                  hasTransition: true,
                                                                                  transitionType: PageTransitionType.fade,
                                                                                  duration: Duration(milliseconds: 0),
                                                                                ),
                                                                              },
                                                                            );
                                                                          } else {
                                                                            _model.addToProductid(productgridlistItem.toString());
                                                                            _model.addtoWishlist = await AddToWishlistCall.call(
                                                                              hosturl: FFAppConstants.sanityurl,
                                                                              token: currentAuthenticationToken,
                                                                              productid: productId,
                                                                              productType: getJsonField(productgridlistItem, r'''$.mainprodtype'''),
                                                                            );
                                                                            if ((_model.addtoWishlist?.succeeded ?? true)) {
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
                                                                              setState(() {});
                                                                            } else {
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackBar(
                                                                                  content: Text(
                                                                                    getJsonField((_model.addtoWishlist?.jsonBody ?? ''), r'''$.status''').toString(),
                                                                                    style: TextStyle(
                                                                                      color: FlutterFlowTheme.of(context).containerFillColor,
                                                                                    ),
                                                                                  ),
                                                                                  duration: Duration(milliseconds: 4000),
                                                                                  backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                                ),
                                                                              );
                                                                            }
                                                                            HapticFeedback.lightImpact();
                                                                          }
                                                                        },
                                                                        child: Container(
                                                                          width: 24,
                                                                          height: 24,
                                                                          clipBehavior: Clip.antiAlias,
                                                                          decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                          ),
                                                                          child: Image.asset(
                                                                            'assets/images/HeartEmpty.png',
                                                                            fit: BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  } else {
                                                                    return Padding(
                                                                      padding: EdgeInsets.all(5),
                                                                      child: InkWell(
                                                                        splashColor: Colors.transparent,
                                                                        focusColor: Colors.transparent,
                                                                        hoverColor: Colors.transparent,
                                                                        highlightColor: Colors.transparent,
                                                                        onTap: () async {
                                                                          var _shouldSetState = false;
                                                                          _model.apiResult5ep = await RemovefromWishlistCall.call(
                                                                            token: currentAuthenticationToken,
                                                                            hosturl: FFAppConstants.hosturl,
                                                                            productId: productId,
                                                                            productType: getJsonField(productgridlistItem, r'''$.mainprodtype'''),
                                                                          );
                                                                          _shouldSetState = true;
                                                                          if ((_model.apiResult5ep?.succeeded ?? true)) {
                                                                            FFAppState().statusFailed = getJsonField((_model.apiResult5ep?.jsonBody ?? ''), r'''$.status''').toString();
                                                                            setState(() {});
                                                                            ScaffoldMessenger.of(context).clearSnackBars();
                                                                            ScaffoldMessenger.of(context).showSnackBar(
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
                                                                            if (FFAppState().statusFailed == 'success') {
                                                                            } else {
                                                                              if (_shouldSetState) setState(() {});
                                                                              return;
                                                                            }
                                                                          } else {
                                                                            if (_shouldSetState) setState(() {});
                                                                            return;
                                                                          }
                                                                          _model.removeFromProductid(productgridlistItem.toString());
                                                                          setState(() {});
                                                                          HapticFeedback.lightImpact();
                                                                        },
                                                                        child: Container(
                                                                          width: 24,
                                                                          height: 24,
                                                                          clipBehavior: Clip.antiAlias,
                                                                          decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                          ),
                                                                          child: Image.asset(
                                                                            'assets/images/HeartFilled.png',
                                                                            fit: BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                },
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    )
        
        
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
                        else if (/*((_model.otherSubProductResult?.statusCode ?? 200) ==
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
                                  sort_by: FFAppState().sortby,
                                  page_no: ""),
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
                                final data = OtherProductMainCategoryCall.yantrProductData(
                                  othersProductsOtherProductMainCategoryResponse.jsonBody,
                                )?.toList() ?? [];
                                if (data.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'No data found',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).productName,
                                        fontSize: 16,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  );
                                }
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
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
                                                    onTap: () => _model.unfocusNode.canRequestFocus
                                                        ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                        : FocusScope.of(context).unfocus(),
                                                    child: Padding(
                                                      padding: MediaQuery.viewInsetsOf(context),
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
                                                color: FlutterFlowTheme.of(context).containerFillColor,
                                                borderRadius: BorderRadius.circular(10.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(context).borderColor,
                                                ),
                                              ),
                                              alignment: AlignmentDirectional(0.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(8.0),
                                                      child: Image.asset(
                                                        'assets/images/Swap.png',
                                                        width: 15.0,
                                                        height: 15.0,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Sort',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
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
                                                    onTap: () => _model.unfocusNode.canRequestFocus
                                                        ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                        : FocusScope.of(context).unfocus(),
                                                    child: Padding(
                                                      padding: MediaQuery.viewInsetsOf(context),
                                                      child: FilterComponentWidget(
                                                        productFilterbytype: 'Others',
                                                        maxprice: OtherProductMainCategoryCall.yantraconstantmaxprice(
                                                          othersProductsOtherProductMainCategoryResponse.jsonBody,
                                                        )?.toDouble(),
                                                        minprice: OtherProductMainCategoryCall.yantraconstantminprice(
                                                          othersProductsOtherProductMainCategoryResponse.jsonBody,
                                                        )?.toDouble(),
                                                        deityPurpose: OtherProductMainCategoryCall.yantraconstantdietylist(
                                                          othersProductsOtherProductMainCategoryResponse.jsonBody,
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
                                                color: FlutterFlowTheme.of(context).containerFillColor,
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(context).borderColor,
                                                ),
                                              ),
                                              alignment: AlignmentDirectional(0.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(8.0),
                                                      child: Image.asset(
                                                        'assets/images/sort.png',
                                                        width: 15.0,
                                                        height: 15.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Filter',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
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
                                        padding: EdgeInsetsDirectional.fromSTEB(16.0, 18.0, 16.0, 0),
                                        child: Builder(
                                          builder: (context) {
                                            return Stack(
                                              children: [
                                                GridView.builder(
                                                  controller: _scrollController,
                                                  padding: EdgeInsets.zero,
                                                  gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 9,
                                                    mainAxisSpacing: 9,
                                                    childAspectRatio: 0.82,
                                                  ),
                                                  scrollDirection: Axis.vertical,
                                                  itemCount: _productsList.length,
                                                  itemBuilder: (context, index) {
                                                    if (index == _productsList.length) {
                                                      return Container(
                                                        height: 1,
                                                      );
                                                    }
                                                    final yantrasgridlistItem = _productsList[index];
                                                    return Stack(
                                                      children: [
                                                        InkWell(
                                                          splashColor: Colors.transparent,
                                                          focusColor: Colors.transparent,
                                                          hoverColor: Colors.transparent,
                                                          highlightColor: Colors.transparent,
                                                          onTap: () async {
                                                            print('Slug nownownwo: ${getJsonField(
                                                              yantrasgridlistItem, r'''$.slug_value''',
                                                            ).toString()}');
                                                            print('out of stock nownownwo: ${getJsonField(
                                                              yantrasgridlistItem, r'''$.out_of_stock''',
                                                            ).toString()}');
                                                            context.pushNamed(
                                                              'OtherProductDetails',
                                                              queryParameters: {
                                                                'productSlugValue': serializeParam(
                                                                  getJsonField(yantrasgridlistItem,
                                                                    r'''$.slug_value''',).toString(),
                                                                  ParamType.String,
                                                                ),
                                                                'outofstockValue': serializeParam(
                                                                  getJsonField(yantrasgridlistItem,
                                                                    r'''$.out_of_stock''',).toString(),
                                                                  ParamType.String,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          },
                                                          child: Container(
                                                            // width: 168.0,
                                                            //height: 193.0,
                                                            decoration: BoxDecoration(
                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                              borderRadius: BorderRadius.circular(2.0),
                                                              border: Border.all(
                                                                color: FlutterFlowTheme.of(context).borderColor,
                                                              ),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.max,
                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Padding(padding: EdgeInsets.all(4.0),
                                                                  child: Center(
                                                                    child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                      child: /*CachedNetworkImage(
                                                                        fadeInDuration: Duration(milliseconds: 100),
                                                                        fadeOutDuration: Duration(milliseconds: 100),
                                                                        imageUrl: utf8.decode(
                                                                          (widget.productType == 'OthersMainCategory'
                                                                              ? getJsonField(yantrasgridlistItem, r'''$.image''').toString()
                                                                              : getJsonField(yantrasgridlistItem, r'''$.image''').toString()).codeUnits.toList(),
                                                                          allowMalformed: true,
                                                                        ),
                                                                        width: double.infinity,
                                                                        height: double.infinity,
                                                                        fit: BoxFit.cover,
                                                                        placeholder: (context, url) => ShimmerWidget(),
                                                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                                                      ),*/
                                                                      CachedNetworkImage(
                                                                        fadeInDuration: Duration(milliseconds: 100),
                                                                        fadeOutDuration: Duration(milliseconds: 100),
                                                                        imageUrl: utf8.decode(
                                                                          (widget.productType == 'OthersMainCategory'
                                                                              ? getJsonField(yantrasgridlistItem, r'''$.image''').toString()
                                                                              : getJsonField(yantrasgridlistItem, r'''$.image''').toString()).codeUnits,
                                                                          allowMalformed: true,
                                                                        ),
                                                                        //width: double.infinity,
                                                                        height: 104.65,
                                                                        fit: BoxFit.contain,
                                                                        placeholder: (context, url) => ShimmerWidget(),
                                                                        errorWidget: (context, url, error) => Icon(Icons.image),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional.fromSTEB(9.0, 8.0, 9.0, 10.0),
                                                                  child: Column(
                                                                    mainAxisSize: MainAxisSize.max,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                    children: [
                                                                      Container(
                                                                        width: double.infinity,
                                                                        height: 36.0,
                                                                        decoration: BoxDecoration(),
                                                                        child: Text(
                                                                          widget.productType == 'OthersSubCategory'
                                                                              ? getJsonField(yantrasgridlistItem,
                                                                            r'''$.product_name''',).toString()
                                                                              : getJsonField(yantrasgridlistItem,
                                                                            r'''$.name''',).toString(),
                                                                          maxLines: 2,
                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            fontFamily: 'Montserrat',
                                                                            color: FlutterFlowTheme.of(context).productName,
                                                                            letterSpacing: 0.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      if (getJsonField(yantrasgridlistItem, r'''$.contact_for_price''').toString() == 'false')
                                                                      RichText(
                                                                        textScaler: MediaQuery.of(context).textScaler,
                                                                        text: TextSpan(
                                                                          children: [
                                                                            TextSpan(
                                                                              text:
                                                                              '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(
                                                                                getJsonField(yantrasgridlistItem, r'''$.selling_price''',).toString(),
                                                                                FFAppState().currencyRate,
                                                                              )}',
                                                                              style:
                                                                              TextStyle(),
                                                                            )
                                                                          ],
                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            fontFamily: 'Montserrat',
                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                            letterSpacing: 0.0,
                                                                            fontWeight: FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      if (getJsonField(yantrasgridlistItem, r'''$.contact_for_price''').toString() == 'true')
                                                                        RichText(
                                                                          textScaler: MediaQuery.of(context).textScaler,
                                                                          text: TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: "Contact For Price",
                                                                                style: TextStyle(color:  FlutterFlowTheme.of(context).primary),
                                                                              )
                                                                            ],
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                              fontFamily: 'Montserrat',
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                    ].divide(SizedBox(height: 8.0)),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),

                                                        if (getJsonField(yantrasgridlistItem, r'''$.out_of_stock''').toString() == 'true')
                                                          Align(
                                                            alignment: AlignmentDirectional(-1, -1),
                                                            child: Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0),
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                  color: Colors.red,
                                                                  borderRadius: BorderRadius.only(
                                                                    topRight: Radius.circular(12),
                                                                    bottomRight: Radius.circular(12),
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(5.0),
                                                                  child: Text(
                                                                    "OUT OF STOCK",
                                                                    style: TextStyle(color: Colors.white),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        if (getJsonField(yantrasgridlistItem, r'''$.reserved''').toString() == 'true')
                                                          Align(
                                                            alignment: AlignmentDirectional(-1, -1),
                                                            child: Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0),
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                  color: Colors.green,
                                                                  borderRadius: BorderRadius.only(
                                                                    topRight: Radius.circular(12),
                                                                    bottomRight: Radius.circular(12),
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(5.0),
                                                                  child: Text(
                                                                    "RESERVED",
                                                                    style: TextStyle(color: Colors.white),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),


                                                        Align(
                                                          //alignment: AlignmentDirectional(1, -1),
                                                          alignment: AlignmentDirectional(1, 1),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0),
                                                            child: FutureBuilder<ApiCallResponse>(
                                                              future: WishListCall.call(
                                                                hosturl: FFAppConstants.sanityurl,
                                                                token: currentAuthenticationToken,
                                                              ),
                                                              builder: (context, snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot.hasData) {
                                                                  return Container(
                                                                    width: 1,
                                                                    height: 1,
                                                                    child: ShimmerWidget(),
                                                                  );
                                                                }
                                                                final containerWishlistResponse = snapshot.data!;
        
                                                                return Container(
                                                                  decoration: BoxDecoration(
                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                    borderRadius: BorderRadius.circular(24),
                                                                  ),
                                                                  child: Builder(
                                                                    builder: (context) {
                                                                      final wishlistIds = WishListCall.id(containerWishlistResponse.jsonBody);
                                                                      final productId = getJsonField(yantrasgridlistItem, r'''$.product_id''');
        
                                                                      print(wishlistIds);
                                                                      print(productId);
        
                                                                      if (!wishlistIds.contains(productId)) {
                                                                        return Padding(
                                                                          padding: EdgeInsets.all(5),
                                                                          child: InkWell(
                                                                            splashColor: Colors.transparent,
                                                                            focusColor: Colors.transparent,
                                                                            hoverColor: Colors.transparent,
                                                                            highlightColor: Colors.transparent,
                                                                            onTap: () async {
                                                                              if (currentAuthenticationToken == null) {
                                                                                context.pushNamed(
                                                                                  'LoginPage',
                                                                                  extra: <String, dynamic>{
                                                                                    kTransitionInfoKey: TransitionInfo(
                                                                                      hasTransition: true,
                                                                                      transitionType: PageTransitionType.fade,
                                                                                      duration: Duration(milliseconds: 0),
                                                                                    ),
                                                                                  },
                                                                                );
                                                                              } else {
                                                                                _model.addToProductid(yantrasgridlistItem.toString());
                                                                                _model.addtoWishlist = await AddToWishlistCall.call(
                                                                                  hosturl: FFAppConstants.sanityurl,
                                                                                  token: currentAuthenticationToken,
                                                                                  productid: productId,
                                                                                  productType: getJsonField(yantrasgridlistItem, r'''$.mainprodtype'''),
                                                                                );
                                                                                if ((_model.addtoWishlist?.succeeded ?? true)) {
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
                                                                                  setState(() {});
                                                                                } else {
                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                    SnackBar(
                                                                                      content: Text(
                                                                                        getJsonField((_model.addtoWishlist?.jsonBody ?? ''), r'''$.status''').toString(),
                                                                                        style: TextStyle(
                                                                                          color: FlutterFlowTheme.of(context).containerFillColor,
                                                                                        ),
                                                                                      ),
                                                                                      duration: Duration(milliseconds: 4000),
                                                                                      backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                                    ),
                                                                                  );
                                                                                }
                                                                                HapticFeedback.lightImpact();
                                                                              }
                                                                            },
                                                                            child: Container(
                                                                              width: 24,
                                                                              height: 24,
                                                                              clipBehavior: Clip.antiAlias,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                              child: Image.asset(
                                                                                'assets/images/HeartEmpty.png',
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        return Padding(
                                                                          padding: EdgeInsets.all(5),
                                                                          child: InkWell(
                                                                            splashColor: Colors.transparent,
                                                                            focusColor: Colors.transparent,
                                                                            hoverColor: Colors.transparent,
                                                                            highlightColor: Colors.transparent,
                                                                            onTap: () async {
                                                                              var _shouldSetState = false;
                                                                              _model.apiResult5ep = await RemovefromWishlistCall.call(
                                                                                token: currentAuthenticationToken,
                                                                                hosturl: FFAppConstants.hosturl,
                                                                                productId: productId,
                                                                                productType: getJsonField(yantrasgridlistItem, r'''$.mainprodtype'''),
                                                                              );
                                                                              _shouldSetState = true;
                                                                              if ((_model.apiResult5ep?.succeeded ?? true)) {
                                                                                FFAppState().statusFailed = getJsonField((_model.apiResult5ep?.jsonBody ?? ''), r'''$.status''').toString();
                                                                                setState(() {});
                                                                                ScaffoldMessenger.of(context).clearSnackBars();
                                                                                ScaffoldMessenger.of(context).showSnackBar(
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
                                                                                if (FFAppState().statusFailed == 'success') {
                                                                                } else {
                                                                                  if (_shouldSetState) setState(() {});
                                                                                  return;
                                                                                }
                                                                              } else {
                                                                                if (_shouldSetState) setState(() {});
                                                                                return;
                                                                              }
                                                                              _model.removeFromProductid(yantrasgridlistItem.toString());
                                                                              setState(() {});
                                                                              HapticFeedback.lightImpact();
                                                                            },
                                                                            child: Container(
                                                                              width: 24,
                                                                              height: 24,
                                                                              clipBehavior: Clip.antiAlias,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                              child: Image.asset(
                                                                                'assets/images/HeartFilled.png',
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                    },
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        )
        
                                                      ],
                                                    );
                                                  },
                                                ),
                                                if (_isLoading)
                                                  Positioned(
                                                    left: 0,
                                                    right: 0,
                                                    bottom: 16.0,
                                                    child: Center(
                                                      child: CircularProgressIndicator(
                                                        color: Color(0xFF740074),
                                                      ),
                                                    ),
                                                  ),
                                              ],
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
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(80),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: SvgPicture.network(
                                  'https://rudraksha.cloudjiffy.net/assets/product/no-products-found.svg',
                                  fit: BoxFit.contain,
                                  placeholderBuilder: (context) => ShimmerWidget(), // Optional: Add a loading indicator
                                ),
                              ),
                            ),
                          );
                          /*wrapWithModel(
                            model: _model.error404ScreenModel,
                            updateCallback: () => setState(() {}),
                            child: Error404ScreenWidget(),
                          );*/
                        }
                      },
                    ),
                  ),
                ),
                /*Align(
                  alignment: AlignmentDirectional(0, 1),
                  child: wrapWithModel(
                    model: _model.customNavBarModel,
                    updateCallback: () => setState(() {}),
                    child: CustomNavBarWidget(),
                  ),
                ),*/
              ]
            ),
          ),
          bottomNavigationBar: CustomNavBarWidget(),
        ),
      ),
    );
  }
}
