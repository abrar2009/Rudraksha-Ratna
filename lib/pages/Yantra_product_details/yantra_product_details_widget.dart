import 'dart:convert';

import 'package:flutter_svg/svg.dart';
import 'package:rudraksha_cart/auth/custom_auth/auth_util.dart';
import 'package:rudraksha_cart/components/shimmer_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/AddReviewPopUp_Widget.dart';
import '../../components/custom_nav_bar_widget.dart';
import '../../components/ratingreview_widget.dart';
import '../../custom_code/image_zoom_screen.dart';
import '../../custom_code/product_images.dart';
import '../../flutter_flow/custom_functions.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/my_cart/my_cart_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'yantra_product_details_model.dart';
export 'yantra_product_details_model.dart';

class YantraProductDetailsWidget extends StatefulWidget {
  const YantraProductDetailsWidget({
    super.key,
    String? productSlugValue,
    String? producttype,
    required this.isFromPaymentScreen,
    required this.cartId,
  })  : this.productSlugValue = productSlugValue ?? 'buy/kuber-yantra',
        this.producttype =producttype ?? 'yantras/web-yantraproduct-detail?yantraproduct';

  final String productSlugValue;
  final String producttype;
  final bool isFromPaymentScreen;
  final int? cartId;

  @override
  State<YantraProductDetailsWidget> createState() => _YantraProductDetailsWidgetState();
}

class _YantraProductDetailsWidgetState extends State<YantraProductDetailsWidget> {
  late YantraProductDetailsModel _model;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _YantraProductDetailsWidgetratingKey = GlobalKey();
  final YantraProductDetailsWidgetscaffoldKey = GlobalKey<ScaffoldState>();
  ApiCallResponse? containerOtherProductsDetailsResponse;
  bool _isLoading = false;
  bool isLoading = true;

  //For preselected values when navigate from payment screen after clicking "View Details"
  bool isLoadingForPreselection = false;
  ApiCallResponse? cartDataResponse;
  String? selectedVariation;
  String? preSelectedDesign;
  String? productVariationID;
  int? productVariationIdIndex;
  String? designGroupID;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => YantraProductDetailsModel());

    _model.expandableExpandableController1 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController2 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController3 =
        ExpandableController(initialExpanded: false);
    _fetchData();
    fetchCartData();
  }

  @override
  void dispose() {
    _model.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchCartData() async {
    setState(() {
      isLoadingForPreselection = true;

      // Reset the variables to null or initial values before making a new API call
      selectedVariation = null;
      preSelectedDesign = null;
      productVariationID = null;
      designGroupID = null;
      productVariationIdIndex = null;
    });

    try {
      // Call the Cart API
      cartDataResponse = await CartCall.call(
        hosturl: FFAppConstants.hosturl,
        token: currentAuthenticationToken,
      );

      // Store the JSON response from the API call
      final cartJsonData = getJsonField(cartDataResponse!.jsonBody, r'''$.data''');

      // Find the cart item with the matching cartId
      final cartItem = (cartJsonData as List).firstWhere(
            (item) => getJsonField(item, r'''$.cart_id''') == widget.cartId,
        orElse: () => null,
      );

      // Check if a matching cart item was found
      if (cartItem != null) {
        String? newSelectedVariation = getJsonField(cartItem, r'''$.product_variation_name''').toString();
        String? newPreSelectedDesign = getJsonField(cartItem, r'''$.design_name''').toString();
        String? newProductVariationID = getJsonField(cartItem, r'''$.product_variation_id''').toString();
        String? newDesignGroupID = getJsonField(cartItem, r'''$.id''').toString();

        setState(() {
          isLoadingForPreselection = false;
          // Update the state variables with the values from the matching cart item
          selectedVariation = newSelectedVariation;
          preSelectedDesign = newPreSelectedDesign;
          productVariationID = newProductVariationID;
          designGroupID = newDesignGroupID;

          print('preselected selected variation: $selectedVariation');
          print('preselected selected design: $preSelectedDesign');
        });
      } else {
        // Handle case where the cart item with the given cartId is not found
        setState(() {
          isLoadingForPreselection = false;
        });
        print('No cart item found with cartId: ${widget.cartId}');
      }
    } catch (e) {
      // Handle API error
      setState(() {
        isLoadingForPreselection = false;
      });
      print('Error fetching cart data: $e');
    }
  }

  String _formattedRating(double? rating) {
    if (rating == null) {
      return '0/5'; // Default value if no rating is provided
    }

    // Check if the decimal part is greater than zero
    if (rating % 1 > 0) {
      // Format as decimal number if there is a decimal part
      return '${rating.toStringAsFixed(1)}/5';
    } else {
      // Format as whole number if there is no decimal part
      return '${rating.toStringAsFixed(0)}/5';
    }
  }

  Future<void> _fetchData() async {
    try {
      final response = await OtherProductsDetailsCall.call(
        sanityurl: FFAppConstants.sanityurl,
        producttype: FFAppConstants.YantraMasterProductDetailsApi,
        productslugvalue: widget.productSlugValue,
      );

      if (response.succeeded) {
        setState(() {
          containerOtherProductsDetailsResponse = response;
          isLoading = false;
        });
      } else {
        // Handle the error response
        //print('Failed to load data: ${response.errorMessage}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      // Handle exception
      print('Exception occurred: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: YantraProductDetailsWidgetscaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: isLoadingForPreselection
            ? Center(child: CircularProgressIndicator(color: FlutterFlowTheme.of(context).primary,))
            : widget.isFromPaymentScreen && cartDataResponse != null
            ? buildPreselectedValues()
            : buildDefaultProductDetails(),
        bottomNavigationBar: CustomNavBarWidget(),
      ),
    );
  }

  Widget buildPreselectedValues() {
    return SafeArea(
      top: true,
      child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 4),
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 20,
                            borderWidth: 1,
                            buttonSize: 40,
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: Color(0xFF272728),
                              size: 30,
                            ),
                            onPressed: () async {
                              context.safePop();
                            },
                          ),
                          FutureBuilder<ApiCallResponse>(
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
                              final cartCount = functions.cartBadgeCount(badgeCartResponse.jsonBody);

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
                                      fit: BoxFit.cover,
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
                          )
                        ],
                      ),
                    ),
                  ),
                  FutureBuilder<ApiCallResponse>(
                    future: OtherProductsDetailsCall.call(
                      sanityurl: FFAppConstants.sanityurl,
                      producttype: FFAppConstants.YantraMasterProductDetailsApi,
                      productslugvalue: widget.productSlugValue,
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
                      containerOtherProductsDetailsResponse = snapshot.data!;
                      print("data: ${getJsonField(
                        containerOtherProductsDetailsResponse?.jsonBody, r'''$.data''',
                      ).toString()}");
                      return Container(
                        height: MediaQuery.sizeOf(context).height * 0.85,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xFFE7E7E8),
                                      width: 2,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: Stack(
                                        alignment: AlignmentDirectional(1, 1),
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
                                                enableDrag: false,
                                                context: context,
                                                builder: (context) {
                                                  return GestureDetector(
                                                    onTap: () => _model.unfocusNode.canRequestFocus
                                                        ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                        : FocusScope.of(context).unfocus(),
                                                    child: Padding(
                                                      padding: MediaQuery.viewInsetsOf(context),
                                                      child: /*ImageZoomScreen(
                                                        imageUrl:
                                                        OtherProductsDetailsCall.yantraproductimageurlpath(
                                                          containerOtherProductsDetailsResponse?.jsonBody,
                                                        )!.first,
                                                      ),*/
                                                      imageZoomScreen(
                                                        imageUrls: widget.producttype == FFAppConstants.YantraMasterProductDetailsApi
                                                            ? OtherProductsDetailsCall.otherproductimageurlpath(
                                                          containerOtherProductsDetailsResponse?.jsonBody,
                                                        )?.toList() ?? []
                                                            : parseImageUrls(
                                                            getJsonField(
                                                                containerOtherProductsDetailsResponse?.jsonBody,
                                                                r'''$.data.image_url[*].path'''
                                                            ) ?? []
                                                        ),
                                                        initialIndex: 0,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).then((value) => safeSetState(() {}));
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(0),
                                              child: Stack(
                                                children: [
                                                  ProductImagesWidget(
                                                    imageUrls: OtherProductsDetailsCall.otherproductvariantdata(
                                                      containerOtherProductsDetailsResponse?.jsonBody,
                                                    ) != null &&
                                                        (OtherProductsDetailsCall.otherproductvariantdata(
                                                          containerOtherProductsDetailsResponse?.jsonBody,
                                                        ))!.isNotEmpty
                                                        ? parseImageUrls(OtherProductsDetailsCall.otherproductimageurlpath(
                                                      containerOtherProductsDetailsResponse?.jsonBody,
                                                    ) ?? [])
                                                        : parseImageUrls(
                                                        getJsonField(
                                                            containerOtherProductsDetailsResponse?.jsonBody,
                                                            r'''$.data.image_url[*].path'''
                                                        ) ?? []
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: AlignmentDirectional(1,1),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top: 10,right: 10),
                                                      child: SvgPicture.asset(
                                                        'assets/images/zoom_image.svg',
                                                        width: 25,
                                                        height: 25,
                                                        color: FlutterFlowTheme.of(context).primary,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                            AlignmentDirectional(0.99, 1),
                                            child: Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(0, 0, 10, 10),
                                              child: currentAuthenticationToken == null
                                                  ? InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                onTap: () async {
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
                                                },
                                                child: Container(
                                                  width: 28,
                                                  height: 28,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/HeartEmpty.png',
                                                    fit: BoxFit.cover,
                                                    color: FlutterFlowTheme.of(context).primary,
                                                  ),
                                                ),
                                              ) : FutureBuilder<ApiCallResponse>(
                                                future: WishListCall.call(
                                                  hosturl: FFAppConstants.sanityurl,
                                                  token: currentAuthenticationToken,
                                                ),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Container(
                                                      width: 5,
                                                      height: 5,
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
                                                        final wishlistIds = WishListCall.id(containerWishlistResponse.jsonBody) ?? [];
                                                        final productId = OtherProductsDetailsCall.rudrakshaProductid(containerOtherProductsDetailsResponse?.jsonBody);

                                                        print(wishlistIds);
                                                        print("productId${productId}");
                                                        print(WishListCall.id(containerWishlistResponse?.jsonBody));
                                                        print(OtherProductsDetailsCall.rudrakshaProductid(
                                                            containerOtherProductsDetailsResponse?.jsonBody));
                                                        if (!wishlistIds.contains(
                                                          OtherProductsDetailsCall.rudrakshaProductid(
                                                            containerOtherProductsDetailsResponse?.jsonBody),
                                                        )) {
                                                          return Padding(
                                                            padding: EdgeInsets.all(5),
                                                            child: InkWell(
                                                              splashColor: Colors.transparent,
                                                              focusColor: Colors.transparent,
                                                              hoverColor: Colors.transparent,
                                                              highlightColor: Colors.transparent,
                                                              onTap: () async {
                                                                if (currentAuthenticationToken != null &&
                                                                    currentAuthenticationToken != '') {
                                                                  _model.addtoWishlist = await AddToWishlistCall.call(
                                                                    hosturl: FFAppConstants.sanityurl,
                                                                    token: currentAuthenticationToken,
                                                                    productid: OtherProductsDetailsCall.rudrakshaProductid(
                                                                      containerOtherProductsDetailsResponse?.jsonBody,
                                                                    ),
                                                                    productType: OtherProductsDetailsCall.rudrakshaMainProductType(
                                                                      containerOtherProductsDetailsResponse?.jsonBody,
                                                                    ),
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
                                                                  setState(() {});
                                                                  _model.wishlistlikedislike = !_model.wishlistlikedislike;
                                                                  setState(() {});
                                                                  HapticFeedback.lightImpact();
                                                                } else {
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
                                                                }
                                                              },
                                                              child: Container(
                                                                width: 28,
                                                                height: 28,
                                                                clipBehavior: Clip.antiAlias,
                                                                decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                ),
                                                                child: Image.asset(
                                                                  'assets/images/HeartEmpty.png',
                                                                  fit: BoxFit.cover,
                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          return Padding(
                                                            padding: EdgeInsets.all(5),
                                                            child: InkWell(
                                                              onTap: () async {
                                                                var _shouldSetState = false;
                                                                _model.apiResult5ep = await RemovefromWishlistCall.call(
                                                                  token: currentAuthenticationToken,
                                                                  hosturl: FFAppConstants.hosturl,
                                                                  productId: OtherProductsDetailsCall.rudrakshaProductid(
                                                                    containerOtherProductsDetailsResponse?.jsonBody,
                                                                  ),
                                                                  productType: OtherProductsDetailsCall.rudrakshaMainProductType(
                                                                    containerOtherProductsDetailsResponse?.jsonBody,
                                                                  ),
                                                                );

                                                                _shouldSetState = true;
                                                                if ((_model.apiResult5ep?.succeeded ?? true)) {
                                                                  FFAppState().statusFailed = getJsonField(
                                                                        (_model.apiResult5ep?.jsonBody ?? ''),
                                                                        r'''$.status''',).toString();
                                                                  setState(() {});
                                                                  ScaffoldMessenger.of(context).clearSnackBars();
                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                    SnackBar(
                                                                      content: Text(
                                                                        getJsonField(
                                                                          (_model.apiResult5ep?.jsonBody ?? ''),
                                                                          r'''$.msg''',
                                                                        ).toString(),
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
                                                                    if (_shouldSetState)
                                                                      setState(() {});
                                                                    return;
                                                                  }
                                                                } else {
                                                                  if (_shouldSetState)
                                                                    setState(() {});
                                                                  return;
                                                                }
                                                                setState(() {});
                                                                _model.wishlistlikedislike = !_model.wishlistlikedislike;
                                                                setState(() {});
                                                                HapticFeedback.lightImpact();
                                                              },
                                                              child: Container(
                                                                width: 28,
                                                                height: 28,
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
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        valueOrDefault<String>(
                                          OtherProductsDetailsCall.yantraproductname(
                                            containerOtherProductsDetailsResponse?.jsonBody,
                                          ),
                                          'Name',
                                        ),
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 15,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      RichText(
                                        textScaler: MediaQuery.of(context).textScaler,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Product Code: ',
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Montserrat',
                                                fontSize: 15,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text: valueOrDefault<String>(
                                                OtherProductsDetailsCall.yantraproductcode(
                                                  containerOtherProductsDetailsResponse?.jsonBody,
                                                ),
                                                'Code',
                                              ),
                                              style: GoogleFonts.getFont(
                                                'Montserrat',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            )
                                          ],
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              _model.expandableExpandableController3.expanded=true;

                                              _scrollController.animateTo(
                                                  _YantraProductDetailsWidgetratingKey.currentContext!.findRenderObject()!.getTransformTo(null).getTranslation().y,
                                                  duration: Duration(milliseconds: 300),
                                                  curve: Curves.easeInOut);
                                            },
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                              child: RatingBarIndicator(
                                                itemBuilder: (context, index) => Icon(
                                                  Icons.star_rounded,
                                                  color: Color(0xFFF2B503),
                                                ),
                                                direction: Axis.horizontal,
                                                rating: OtherProductsDetailsCall.productrating(
                                                  containerOtherProductsDetailsResponse?.jsonBody,
                                                )!,
                                                unratedColor: FlutterFlowTheme.of(context).accent3,
                                                itemCount: 5,
                                                itemSize: 18,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            OtherProductsDetailsCall.productrating(
                                              containerOtherProductsDetailsResponse?.jsonBody,
                                            ).toString(),
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Roboto',
                                              fontSize: 13,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ].divide(SizedBox(height: 8)),
                                  ),
                                ),
                                if (OtherProductsDetailsCall.pujaenergizationlist(
                                  containerOtherProductsDetailsResponse?.jsonBody,
                                ) != null &&
                                    (OtherProductsDetailsCall.pujaenergizationlist(
                                      containerOtherProductsDetailsResponse?.jsonBody,
                                    ))!.isNotEmpty)
                                  Divider(
                                    height: 2,
                                    thickness: 1.5,
                                    color: Color(0xFFE7E7E8),
                                  ),
                                if (OtherProductsDetailsCall.yantrapujaenergizationlist(
                                  containerOtherProductsDetailsResponse?.jsonBody,
                                ) != null &&
                                    (OtherProductsDetailsCall.yantrapujaenergizationlist(
                                      containerOtherProductsDetailsResponse?.jsonBody,
                                    ))!.isNotEmpty)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          textScaler: MediaQuery.of(context).textScaler,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Energization: ',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 14,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              TextSpan(
                                                text: valueOrDefault<String>(
                                                  _model.selectedEnergization,
                                                  'Energization',
                                                ),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              )
                                            ],
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              fontSize: 15,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Builder(
                                          builder: (context) {
                                            final selectEnergization = OtherProductsDetailsCall.yantrapujaenergizationlist(
                                                  containerOtherProductsDetailsResponse?.jsonBody,
                                                )?.toList() ?? [];
                                            return SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(
                                                    selectEnergization.length, (selectEnergizationIndex) {
                                                      final selectEnergizationItem = selectEnergization[selectEnergizationIndex];
                                                      return Align(
                                                        alignment: AlignmentDirectional(0, 1),
                                                        child: InkWell(
                                                          splashColor: Colors.transparent,
                                                          focusColor: Colors.transparent,
                                                          hoverColor: Colors.transparent,
                                                          highlightColor: Colors.transparent,
                                                          onTap: () async {
                                                            _model.energizationprice = getJsonField(
                                                                  selectEnergizationItem,
                                                                  r'''$.price''',);
                                                            setState(() {});
                                                            if (_model.selecteddesign == true) {
                                                              _model.selectedEnergizationlist = selectEnergizationIndex;
                                                              setState(() {});
                                                            } else {
                                                              _model.selectedEnergizationlist = selectEnergizationIndex;
                                                              setState(() {});
                                                            }

                                                            _model.selectedEnergization = getJsonField(
                                                                  selectEnergizationItem,
                                                                  r'''$.name''',).toString();
                                                            _model.selectedEnergizationIndex = selectEnergizationIndex;
                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            // width: 224,
                                                            height: 44,
                                                            decoration: BoxDecoration(
                                                              color: _model.selectedEnergizationlist == selectEnergizationIndex
                                                                  ? Color(0x26740074)
                                                                  : FlutterFlowTheme.of(context).secondaryBackground,
                                                              borderRadius: BorderRadius.circular(5),
                                                              border: Border.all(
                                                                color: _model.selectedEnergizationlist == selectEnergizationIndex
                                                                    ? Color(0xFF740074)
                                                                    : FlutterFlowTheme.of(context).secondaryBackground,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets.only(left: 15, right: 15),
                                                              child: Center(
                                                                child: AutoSizeText(getJsonField(
                                                                    selectEnergizationItem, r'''$.name''',
                                                                  ).toString(),
                                                                  maxLines: 2,
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    fontFamily: 'Montserrat',
                                                                    fontSize: 13,
                                                                    letterSpacing: 0,
                                                                    fontWeight: FontWeight.w600,
                                                                    lineHeight: 1.5,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }).divide(SizedBox(width: 10)),
                                              ),
                                            );
                                          },
                                        ),
                                      ].divide(SizedBox(height: 10)),
                                    ),
                                  ),
                                if (OtherProductsDetailsCall.yantrapujaenergizationlist(
                                  containerOtherProductsDetailsResponse?.jsonBody,
                                ) != null && (OtherProductsDetailsCall.yantrapujaenergizationlist(
                                  containerOtherProductsDetailsResponse?.jsonBody,
                                ))!.isNotEmpty)
                                  Divider(
                                    height: 2,
                                    thickness: 1.5,
                                    color: Color(0xFFE7E7E8),
                                  ),
                                if (OtherProductsDetailsCall.yantraproductVariantStatus(
                                  containerOtherProductsDetailsResponse?.jsonBody,
                                ) == true)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          textScaler: MediaQuery.of(context).textScaler,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Select Variation: ',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 14,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              TextSpan(
                                                text: utf8.decode((selectedVariation).toString().codeUnits),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              )
                                            ],
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              fontSize: 15,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Builder(
                                          builder: (context) {
                                            final selectVariation = OtherProductsDetailsCall.productvariantdata(
                                              containerOtherProductsDetailsResponse?.jsonBody,
                                            )?.toList() ?? [];

                                            // Set the initial value of selectedVariation if not already set
                                            if (selectVariation.isNotEmpty && selectedVariation == null) {
                                              selectedVariation = getJsonField(selectVariation[0], r'''$.variant_name''').toString();
                                              _model.selectedCertificationindex = 0; // Default to first variation
                                            } else if (selectedVariation != null) {
                                              // Find the index of the selected variation if it's already set
                                              _model.selectedCertificationindex = selectVariation.indexWhere((item) =>
                                              getJsonField(item, r'''$.variant_name''').toString() == selectedVariation);
                                            }

                                            // Get the index of the currently selected variation
                                            int? selectedIndex = _model.selectedCertificationindex;

                                            return SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(
                                                    selectVariation.length, (selectVariationIndex) {
                                                  final selectVariationItem = selectVariation[selectVariationIndex];

                                                  // Decode the JSON data if necessary
                                                  final decodedDescription = utf8.decode(
                                                      getJsonField(selectVariationItem,
                                                        r'''$.variant_name''',).toString().codeUnits
                                                  );

                                                  return Align(
                                                    alignment: AlignmentDirectional(0, 1),
                                                    child: InkWell(
                                                      splashColor: Colors.transparent,
                                                      focusColor: Colors.transparent,
                                                      hoverColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      onTap: () async {
                                                        _model.expandableExpandableController1.expanded=true;
                                                        _model.selectedvariationprice = getJsonField(
                                                          selectVariationItem,
                                                          r'''$.price''',
                                                        );
                                                        /*_model.selectvariationindex = selectVariationIndex;
                                                        selectedIndex = selectVariationIndex;*/
                                                        setState(() {});
                                                        /*if (_model.selecteddesign == true) {
                                                          //_model.selectedCertificationindex = selectVariationIndex;
                                                          selectedIndex = selectVariationIndex;
                                                          setState(() {});
                                                        } else {
                                                          //_model.selectedCertificationindex = selectVariationIndex;
                                                          selectedIndex = selectVariationIndex;
                                                          setState(() {});
                                                        }*/

                                                        selectedIndex = selectVariationIndex;
                                                        //_model.selectedCertification = getJsonField(selectVariationItem, r'''$.variant_name''',).toString();
                                                        selectedVariation = getJsonField(selectVariationItem, r'''$.variant_name''',).toString();
                                                        _model.selectedCertificationindex = selectVariationIndex;
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        width: 224,
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                          color: selectedIndex == selectVariationIndex
                                                              ? Color(0x26740074)
                                                              : FlutterFlowTheme.of(context).secondaryBackground,
                                                          borderRadius: BorderRadius.circular(5),
                                                          border: Border.all(
                                                            color: selectedIndex == selectVariationIndex
                                                                ? Color(0xFF740074)
                                                                : Color(0xFFE7E7E8),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 0, right: 0),
                                                          child: Center(
                                                            child: 
                                                            HtmlWidget(
                                                            decodedDescription,
                                                             
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }).divide(SizedBox(width: 10)),
                                              ),
                                            );
                                          },
                                        ),
                                      ].divide(SizedBox(height: 10)),
                                    ),
                                  ),
                                if (OtherProductsDetailsCall.yantraproductVariantStatus(
                                  containerOtherProductsDetailsResponse?.jsonBody,
                                ) == true)
                                  Divider(
                                    height: 2,
                                    thickness: 1.5,
                                    color: Color(0xFFE7E7E8),
                                  ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (OtherProductsDetailsCall.yantraproductVariantStatus(
                                          containerOtherProductsDetailsResponse?.jsonBody,
                                        ) == true)
                                          Container(
                                            width: double.infinity,
                                            color: Colors.white,
                                            child: ExpandableNotifier(
                                              controller: _model.expandableExpandableController1,
                                              child: ExpandablePanel(
                                                header: RichText(
                                                  textScaler: MediaQuery.of(context).textScaler,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: 'Select Designs:',
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Montserrat',
                                                          letterSpacing: 0,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: ' ',
                                                        style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontSize: 14,
                                                        ),
                                                      )
                                                    ],
                                                    style:
                                                    FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      letterSpacing: 0,
                                                    ),
                                                  ),
                                                ),
                                                collapsed: Container(),
                                                expanded: Builder(
                                                  builder: (context) {
                                                    final productVariants = OtherProductsDetailsCall.yantraproductvariantdata(
                                                        containerOtherProductsDetailsResponse?.jsonBody)?.toList() ?? [];

                                                    print('Product Variants: $productVariants'); // Debug: Check all product variants
                                                    print('_model.id: ${productVariationID} (type: ${productVariationID.runtimeType})'); // Debug: Check the model ID type

                                                    // Find the product that matches _model.id
                                                    final selectedProduct = productVariants.firstWhere(
                                                          (product) => product['id'].toString() == productVariationID,
                                                      orElse: () => null, // Handle case where no product is found
                                                    );

                                                    print('Selected Product: $selectedProduct');

                                                    // If the product is found, get the designgrp
                                                    final designGroup = selectedProduct['designgrp'] ?? [];
                                                    print('Design Group: $designGroup'); // Debug: Check the design group list

                                                    // Assuming designGroupID is available in your widget
                                                    final String? designGroupID = productVariationID; // Replace with your logic to get the designGroupID

                                                    return SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal,
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        children: List.generate(designGroup.length, (index) {
                                                          final designItem = designGroup[index];
                                                          return InkWell(
                                                            splashColor: Colors.transparent,
                                                            focusColor: Colors.transparent,
                                                            hoverColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () {
                                                              // Handle onTap event as needed
                                                              setState(() {
                                                                _model.selecteddesign = !_model.selecteddesign;
                                                                _model.selectedyantratdesign = index;
                                                                _model.designprice = designItem['price']; // Update design price based on selected design
                                                                _model.selecteddesignid = designItem['id'];
                                                                preSelectedDesign = getJsonField(designItem, r'''$.name''').toString();
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 114,
                                                              decoration: BoxDecoration(
                                                                color: (designItem['id'] == index ||
                                                                    preSelectedDesign == getJsonField(designItem, r'''$.name''').toString())
                                                                    ? const Color(0x26740074)
                                                                    : FlutterFlowTheme.of(context).secondaryBackground,
                                                                borderRadius: BorderRadius.circular(5),
                                                                border: Border.all(
                                                                  color: (designItem['id'] == index ||
                                                                      preSelectedDesign == getJsonField(designItem, r'''$.name''').toString())
                                                                      ? const Color(0xFF740074)
                                                                      : FlutterFlowTheme.of(context).secondaryBackground,
                                                                ),
                                                              ),
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.max,
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(7, 4, 7, 4),
                                                                    child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(8),
                                                                      child: Image.network(
                                                                        designItem['image'],
                                                                        width: 100,
                                                                        height: 120,
                                                                        fit: BoxFit.contain,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(7, 0, 0, 0),
                                                                    child: Container(
                                                                      width: double.infinity,
                                                                      height: 42,
                                                                      child: AutoSizeText(
                                                                        designItem['name'],
                                                                        maxLines: 2,
                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                          fontFamily: 'Montserrat',
                                                                          fontSize: 13,
                                                                          fontWeight: FontWeight.w600,
                                                                          lineHeight: 1.5,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(7, 0, 0, 7),
                                                                    child: RichText(
                                                                      text: TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text: '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatNumber(
                                                                              functions.currencyConversion(FFAppState().currencyRate, designItem['price'].toString()),
                                                                              formatType: FormatType.decimal,
                                                                              decimalType: DecimalType.periodDecimal,
                                                                            )}',
                                                                            style: TextStyle(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 14,
                                                                            ),
                                                                          )
                                                                        ],
                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                          fontFamily: 'Montserrat',
                                                                          fontSize: 14,
                                                                          letterSpacing: 0,
                                                                          fontWeight: FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                      maxLines: 2,
                                                                    ),
                                                                  ),
                                                                ].divide(SizedBox(height: 12)),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                theme: ExpandableThemeData(
                                                  tapHeaderToExpand: true,
                                                  tapBodyToExpand: false,
                                                  tapBodyToCollapse: false,
                                                  headerAlignment:
                                                  ExpandablePanelHeaderAlignment
                                                      .center,
                                                  hasIcon: true,
                                                  expandIcon:
                                                  Icons.keyboard_arrow_down,
                                                  collapseIcon:
                                                  Icons.keyboard_arrow_up_sharp,
                                                  iconColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (OtherProductsDetailsCall.yantraproductVariantStatus(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                ) == true)
                                  Divider(
                                    height: 2,
                                    thickness: 1.5,
                                    color: Color(0xFFE7E7E8),
                                  ),
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 16, 0, 16),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Quantity',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 14,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius: BorderRadius.circular(8),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Colors.transparent,
                                            width: 2,
                                          ),
                                        ),
                                        child: FlutterFlowCountController(
                                          decrementIconBuilder: (enabled) => FaIcon(
                                            FontAwesomeIcons.minus,
                                            color: enabled
                                                ? FlutterFlowTheme.of(context)
                                                .primaryText
                                                : FlutterFlowTheme.of(context)
                                                .alternate,
                                            size: 15,
                                          ),
                                          incrementIconBuilder: (enabled) => FaIcon(
                                            FontAwesomeIcons.plus,
                                            color: enabled
                                                ? FlutterFlowTheme.of(context)
                                                .primaryText
                                                : FlutterFlowTheme.of(context)
                                                .alternate,
                                            size: 15,
                                          ),
                                          countBuilder: (count) => Text(
                                            count.toString(),
                                            style: FlutterFlowTheme.of(context)
                                                .titleLarge
                                                .override(
                                              fontFamily: 'Outfit',
                                              fontSize: 15,
                                              letterSpacing: 30,
                                            ),
                                          ),
                                          count: _model.countControllerValue ??= 1,
                                          updateCount: (count) => setState(() =>
                                          _model.countControllerValue = count),
                                          stepSize: 1,
                                          minimum: 1,
                                          maximum: 5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 2,
                                  thickness: 1.5,
                                  color: Color(0xFFE7E7E8),
                                ),
                                if (OtherProductsDetailsCall.out_of_stock(
                                  containerOtherProductsDetailsResponse?.jsonBody,
                                ) == false)
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(16, 10, 0, 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        // Generated code for this ConditionalBuilder Widget...
                                        Builder(
                                          builder: (context) {
                                            if (OtherProductsDetailsCall.yantraproductVariantStatus(
                                              containerOtherProductsDetailsResponse?.jsonBody,
                                            ) == true) {
                                              return Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                                child: RichText(
                                                  textScaler: MediaQuery.of(context).textScaler,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatNumber(
                                                          functions.currencyConversion(FFAppState().currencyRate, ((OtherProductsDetailsCall.yantravariantdatasellingprice(
                                                            containerOtherProductsDetailsResponse?.jsonBody,)
                                                          ![_model.selectedCertificationindex!] +
                                                              (_model.designprice!) +
                                                              (_model.energizationprice!)) *
                                                              (_model.countControllerValue!)).toString()),
                                                          formatType: FormatType.decimal,
                                                          decimalType: DecimalType.periodDecimal,
                                                        )}',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 18,
                                                        ),
                                                      )
                                                    ],
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 18,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  maxLines: 2,
                                                ),
                                              );
                                            } else {
                                              return Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                                child: RichText(
                                                  textScaler: MediaQuery.of(context).textScaler,
                                                  text: TextSpan(
                                                    children: [

                                                      TextSpan(
                                                        text: '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatNumber(
                                                          functions.currencyConversion(FFAppState().currencyRate, ((functions.stringtoIntFunction(OtherProductsDetailsCall.yantraProductsellingprice(
                                                            containerOtherProductsDetailsResponse?.jsonBody,
                                                          ))!) + (_model.energizationprice!)).toString()),
                                                          formatType: FormatType.decimal,
                                                          decimalType: DecimalType.periodDecimal,
                                                        )* (_model.countControllerValue!)}',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 18,
                                                        ),
                                                      )
                                                    ],
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 18,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  maxLines: 2,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                        Text(
                                          '(Inc all taxes)',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  /*Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(16, 10, 0, 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        // Generated code for this ConditionalBuilder Widget...
                                        Builder(
                                          builder: (context) {
                                            if (OtherProductsDetailsCall.yantraproductVariantStatus(
                                              containerOtherProductsDetailsResponse?.jsonBody,
                                            ) == true) {
                                              return Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                                child: RichText(
                                                  textScaler: MediaQuery.of(context).textScaler,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatNumber(
                                                          functions.currencyConversion(FFAppState().currencyRate, ((OtherProductsDetailsCall.yantravariantdatasellingprice(
                                                            containerOtherProductsDetailsResponse?.jsonBody,)
                                                          ![productVariationIdIndex!] +
                                                              (_model.designprice!) +
                                                              (_model.energizationprice!)) *
                                                              (_model.countControllerValue!)).toString()),
                                                          formatType: FormatType.decimal,
                                                          decimalType: DecimalType.periodDecimal,
                                                        )}',
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 18,
                                                        ),
                                                      )
                                                    ],
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 18,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  maxLines: 2,
                                                ),
                                              );
                                            } else {
                                              return Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                                child: RichText(
                                                  textScaler: MediaQuery.of(context).textScaler,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatNumber(
                                                          functions.currencyConversion(FFAppState().currencyRate, ((functions.stringtoIntFunction(OtherProductsDetailsCall.yantraProductsellingprice(
                                                            containerOtherProductsDetailsResponse?.jsonBody,
                                                          ))!) + (_model.energizationprice!)).toString()),
                                                          formatType: FormatType.decimal,
                                                          decimalType: DecimalType.periodDecimal,
                                                        )* (_model.countControllerValue!)}',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 18,
                                                        ),
                                                      )
                                                    ],
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 18,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  maxLines: 2,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                        Text(
                                          '(Inc all taxes)',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),*/
                                if (OtherProductsDetailsCall.out_of_stock(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                ) == true)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 8, 16, 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () async {
                                            final Uri phoneLaunchUri = Uri(
                                              scheme: 'tel',
                                              path: '+917021180033', // replace with your phone number
                                            );
                                            if (await canLaunchUrl(phoneLaunchUri)) {
                                              await launchUrl(phoneLaunchUri);
                                            } else {
                                              throw 'Could not launch $phoneLaunchUri';
                                            }
                                          },
                                          text: 'Call Us',
                                          options: FFButtonOptions(
                                            height: 40,
                                            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                            iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                            color: FlutterFlowTheme.of(context).primary,
                                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                              fontFamily: 'Montserrat',
                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                              fontSize: 12,
                                              letterSpacing: 0,
                                            ),
                                            elevation: 0,
                                            borderSide: BorderSide(
                                              color: Color(0xFF740074),
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        FFButtonWidget(
                                          onPressed: () async {
                                            final Uri whatsappLaunchUri = Uri(
                                              scheme: 'https',
                                              host: 'api.whatsapp.com',
                                              path: '/send',
                                              queryParameters: {
                                                'phone': '919819111150',
                                                'text': 'I am interested in ${OtherProductsDetailsCall.productname(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                )} however it is out of stock. Kindly suggest an alternative.',
                                              },
                                            );

                                            if (await canLaunchUrl(whatsappLaunchUri)) {
                                              await launchUrl(whatsappLaunchUri, mode: LaunchMode.externalApplication);
                                            } else {
                                              throw 'Could not launch $whatsappLaunchUri';
                                            }
                                          },
                                          text: 'WHATSAPP',
                                          options: FFButtonOptions(
                                            height: 40,
                                            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                            iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                            color: FlutterFlowTheme.of(context).whatsapp,
                                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                              fontFamily: 'Montserrat',
                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                              fontSize: 12,
                                              letterSpacing: 0,
                                            ),
                                            elevation: 0,
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).whatsapp,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),

                                        FFButtonWidget(
                                          onPressed: () async {
                                            final Uri mailLaunchUri = Uri(
                                              scheme: 'mailto',
                                              path: 'contact@rudracentre.com,info@rudracentre.com', // replace with your email address
                                              queryParameters: {
                                                'subject': 'Product_Inquiry',
                                                'body':"I am interested in ${OtherProductsDetailsCall.productname(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                )} however it is out of stock. Kindly suggest an alternative."
                                              },
                                            );
                                            if (await canLaunchUrl(mailLaunchUri)) {
                                              await launchUrl(mailLaunchUri);
                                            } else {
                                              throw 'Could not launch $mailLaunchUri';
                                            }
                                          },
                                          text: 'MAIL US',
                                          options: FFButtonOptions(
                                            height: 40,
                                            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                            iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                              fontFamily: 'Montserrat',
                                              color: FlutterFlowTheme.of(context).primary,
                                              fontSize: 12,
                                              letterSpacing: 0,
                                            ),
                                            elevation: 0,
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).primary,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),

                                Divider(
                                  height: 2,
                                  thickness: 1.5,
                                  color: Color(0xFFE7E7E8),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                                  child: Container(
                                    key: _YantraProductDetailsWidgetratingKey,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      color: Colors.white,
                                      child: ExpandableNotifier(
                                        controller: _model.expandableExpandableController3,
                                        child: ExpandablePanel(
                                          header: Text(
                                            'Ratings & Reviews',
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              fontSize: 14,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          collapsed: Container(),
                                          expanded: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      /*Padding(
                                                        padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0, 0, 10, 0),
                                                        child: RichText(
                                                          textScaler:
                                                          MediaQuery.of(context)
                                                              .textScaler,
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: _formattedRating(
                                                                  OtherProductsDetailsCall.productrating(containerOtherProductsDetailsResponse?.jsonBody),
                                                                ),
                                                                style: FlutterFlowTheme
                                                                    .of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                  fontFamily:
                                                                  'Montserrat',
                                                                  color: FlutterFlowTheme.of(
                                                                      context)
                                                                      .primaryText,
                                                                  fontSize: 24,
                                                                  letterSpacing:
                                                                  0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                ),
                                                              ),
                                                            ],
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Montserrat',
                                                              letterSpacing: 0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            'Overall Rating',
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
                                                          RichText(
                                                            textScaler:
                                                            MediaQuery.of(
                                                                context)
                                                                .textScaler,
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: valueOrDefault<String>(
                                                                    (OtherProductsDetailsCall.reviewdata(
                                                                      containerOtherProductsDetailsResponse?.jsonBody,
                                                                    ) as List).length.toString(),
                                                                    '0',
                                                                  ),
                                                                  style: FlutterFlowTheme
                                                                      .of(context)
                                                                      .bodyMedium
                                                                      .override(
                                                                    fontFamily:
                                                                    'Montserrat',
                                                                    fontSize:
                                                                    12,
                                                                    letterSpacing:
                                                                    0,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: ' Ratings',
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
                                                                fontSize: 12,
                                                                letterSpacing:
                                                                0,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),*/
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                                        child: (OtherProductsDetailsCall.reviewdata(containerOtherProductsDetailsResponse?.jsonBody) as List).isEmpty
                                                            ? Container(
                                                          padding: EdgeInsets.all(10.0),
                                                          decoration: BoxDecoration(
                                                            color: Colors.grey[300],
                                                            borderRadius: BorderRadius.circular(8.0),
                                                          ),
                                                          child: Container(
                                                            width: 200,
                                                            child: Center(
                                                              child: Text(
                                                                'Be the first to review this product!',
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Montserrat',
                                                                  color: Colors.black,
                                                                  fontSize: 14,
                                                                  letterSpacing: 0,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ) : RichText(
                                                          textScaler: MediaQuery.of(context).textScaler,
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: _formattedRating(
                                                                  OtherProductsDetailsCall.productrating(
                                                                    containerOtherProductsDetailsResponse?.jsonBody,
                                                                  ),
                                                                ),
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Montserrat',
                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                  fontSize: 24,
                                                                  letterSpacing: 0,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            ],
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Montserrat',
                                                              letterSpacing: 0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize: MainAxisSize.max,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          (OtherProductsDetailsCall.reviewdata(containerOtherProductsDetailsResponse?.jsonBody) as List).isEmpty
                                                              ? SizedBox.shrink() // Hide the Overall Rating text when there are no reviews
                                                              : Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Overall Rating',
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Montserrat',
                                                                  fontSize: 16,
                                                                  letterSpacing: 0,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                              RichText(
                                                                textScaler: MediaQuery.of(context).textScaler,
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: valueOrDefault<String>(
                                                                        (OtherProductsDetailsCall.reviewdata(containerOtherProductsDetailsResponse?.jsonBody) as List).length.toString(),
                                                                        '0',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Montserrat',
                                                                        fontSize: 12,
                                                                        letterSpacing: 0,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text: ' Ratings',
                                                                      style: TextStyle(),
                                                                    )
                                                                  ],
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    fontFamily: 'Montserrat',
                                                                    fontSize: 12,
                                                                    letterSpacing: 0,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  FFButtonWidget(
                                                    onPressed: () async {
                                                      print("Productid:${  OtherProductsDetailsCall
                                                          .productid(
                                                        containerOtherProductsDetailsResponse
                                                            ?.jsonBody,
                                                      )?.toString()}");
                                                      print("productMainType:${  OtherProductsDetailsCall
                                                          .productMainType(
                                                        containerOtherProductsDetailsResponse
                                                            ?.jsonBody,
                                                      )?.toString()}");

                                                      print("reviewcustomercomment:${  OtherProductsDetailsCall.reviewcustomercomment(
                                                        containerOtherProductsDetailsResponse?.jsonBody,
                                                      )}");
                                                      await showModalBottomSheet(
                                                        isScrollControlled: true,
                                                        backgroundColor: Colors.transparent,
                                                        enableDrag: false,
                                                        context: context,
                                                        builder: (context) {
                                                          return GestureDetector(
                                                            onTap: () => _model.unfocusNode.canRequestFocus
                                                                ? FocusScope.of(context)
                                                                .requestFocus(_model.unfocusNode)
                                                                : FocusScope.of(context).unfocus(),
                                                            child: Padding(
                                                              padding: MediaQuery.viewInsetsOf(context),
                                                              child: AddReviewPopUpWidget(
                                                                mainproducttype: serializeParam(
                                                                  OtherProductsDetailsCall
                                                                      .productMainType(
                                                                    containerOtherProductsDetailsResponse
                                                                        ?.jsonBody,
                                                                  )?.toString(),

                                                                  ParamType.String,
                                                                ),
                                                                productid: serializeParam(
                                                                  OtherProductsDetailsCall
                                                                      .productid(
                                                                    containerOtherProductsDetailsResponse
                                                                        ?.jsonBody,
                                                                  )?.toString(),
                                                                  ParamType.String,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ).then((value) => safeSetState(() {}));
                                                      /*   context.pushNamed(

                                                      'AddRatingDetails',
                                                      queryParameters: {
                                                        'mainproducttype': serializeParam(
                                                          OtherProductsDetailsCall
                                                              .rudrakshaMainProductType(
                                                            containerOtherProductsDetailsResponse
                                                                .jsonBody,
                                                          )?.toString(),

                                                          ParamType.String,
                                                        ),
                                                        'productid': serializeParam(
                                                          OtherProductsDetailsCall
                                                              .rudrakshaProductid(
                                                            containerOtherProductsDetailsResponse
                                                                .jsonBody,
                                                          )?.toString(),
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
                                                    },
                                                    text: 'Rate Now',
                                                    options: FFButtonOptions(
                                                      height: 40,
                                                      padding: EdgeInsetsDirectional
                                                          .fromSTEB(24, 0, 24, 0),
                                                      iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0, 0, 0, 0),
                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                        fontFamily: 'Montserrat',
                                                        color: FlutterFlowTheme.of(context).primary,
                                                        letterSpacing: 0,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                      elevation: 0,
                                                      borderSide: BorderSide(
                                                        color: Color(0xFF740074),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (OtherProductsDetailsCall.reviewdata(
                                                containerOtherProductsDetailsResponse?.jsonBody,
                                              ) != null &&
                                                  (OtherProductsDetailsCall.reviewdata(
                                                    containerOtherProductsDetailsResponse?.jsonBody,
                                                  ))!.isNotEmpty)
                                                Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [


                                                    RatingreviewWidget(
                                                      parameter1:  OtherProductsDetailsCall.Otherreviewcustomerstarrating(
                                                        containerOtherProductsDetailsResponse?.jsonBody,
                                                      )!,
                                                    ),

                                                    Text(
                                                      valueOrDefault<String>(
                                                        OtherProductsDetailsCall.Otherproductreviewcustomercomment(
                                                          containerOtherProductsDetailsResponse?.jsonBody,
                                                        ),
                                                        'x',
                                                      ),
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
                                                        color: Color(0xFF696969),
                                                        fontSize: 16,
                                                        letterSpacing: 0,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          valueOrDefault<String>(
                                                            OtherProductsDetailsCall.Otherproductreviewcustomername(
                                                              containerOtherProductsDetailsResponse?.jsonBody,
                                                            ),
                                                            'x',

                                                          ),
                                                          style: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Montserrat',
                                                            color:
                                                            Color(0xFF696969),
                                                            letterSpacing: 0,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                          ),
                                                        ),
                                                        SizedBox(width: 5),

                                                        Text(
                                                          valueOrDefault<String>(
                                                            OtherProductsDetailsCall.Otherproductreviewdate(
                                                              containerOtherProductsDetailsResponse?.jsonBody,
                                                            ) != null
                                                                ? formatDate(OtherProductsDetailsCall.Otherproductreviewdate(
                                                              containerOtherProductsDetailsResponse?.jsonBody,
                                                            )!) : 'x', 'x',
                                                          ),
                                                          style: FlutterFlowTheme.of(context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily: 'Montserrat',
                                                            color: Color(0xFF696969),
                                                            letterSpacing: 0,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: FFButtonWidget(
                                                        onPressed:(){
                                                          context.pushNamed(
                                                            'AllReviewsWidget',
                                                            queryParameters: {
                                                              'reviewlist': serializeParam(
                                                                OtherProductsDetailsCall.reviewdata(
                                                                  containerOtherProductsDetailsResponse
                                                                      ?.jsonBody,
                                                                ),
                                                                ParamType.JSON,
                                                                // isList: true,
                                                              ),
                                                              'productSlugValue': serializeParam(
                                                                widget.productSlugValue,
                                                                ParamType.String,
                                                              ),
                                                              'producttype': serializeParam(
                                                                widget.producttype,
                                                                ParamType.String,
                                                              ),

                                                            }.withoutNulls,
                                                          );
                                                        },
                                                        text: 'View All Reviews',
                                                        options: FFButtonOptions(
                                                          width: MediaQuery.sizeOf(context).width * 1,
                                                          height: 40,
                                                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                                          iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                          color: Color(0xFF740074),
                                                          textStyle: FlutterFlowTheme.of(context)
                                                              .titleSmall
                                                              .override(
                                                            fontFamily: 'Montserrat',
                                                            color: FlutterFlowTheme.of(context)
                                                                .secondaryBackground,
                                                            letterSpacing: 0,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          elevation: 0,
                                                          borderSide: BorderSide(
                                                            color: Color(0xFF740074),
                                                            width: 1,
                                                          ),
                                                          borderRadius: BorderRadius.circular(12),
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(SizedBox(height: 10)),
                                                ),
                                            ].divide(SizedBox(height: 8)),
                                          ),
                                          theme: ExpandableThemeData(
                                            tapHeaderToExpand: true,
                                            tapBodyToExpand: false,
                                            tapBodyToCollapse: false,
                                            headerAlignment:
                                            ExpandablePanelHeaderAlignment
                                                .center,
                                            hasIcon: true,
                                            expandIcon:
                                            Icons.keyboard_arrow_down_sharp,
                                            collapseIcon: Icons.keyboard_arrow_up,
                                            iconColor: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            iconPadding:
                                            EdgeInsets.fromLTRB(16, 16, 8, 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 4,
                                  thickness: 2,
                                  color: Color(0xFFE7E7E8),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 0, 30),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Related Products',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 14,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                                        child: Builder(
                                          builder: (context) {
                                            final relatedProduct = OtherProductsDetailsCall.yantraProductsimilarcategoryproduct(
                                              containerOtherProductsDetailsResponse?.jsonBody,
                                            )?.toList() ?? [];

                                            // Sort the list
                                            relatedProduct.sort((a, b) {
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

                                            return SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(relatedProduct.length, (relatedProductIndex) {
                                                  final relatedProductItem = relatedProduct[relatedProductIndex];
                                                  return InkWell(
                                                    splashColor: Colors.transparent,
                                                    focusColor: Colors.transparent,
                                                    hoverColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    onTap: () async {
                                                      if (widget.producttype == FFAppConstants.YantraMasterProductDetailsApi) {
                                                        context.pushNamed(
                                                          'YantraProductDetails',
                                                          queryParameters: {
                                                            'productSlugValue': serializeParam(
                                                              getJsonField(relatedProductItem,
                                                                r'''$.slug_value''',).toString(),
                                                              ParamType.String,
                                                            ),
                                                            'producttype': serializeParam(FFAppConstants.RudrakshaMasterProductDetailsApi,
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
                                                      } else {
                                                        context.pushNamed(
                                                          'YantraProductDetails',
                                                          queryParameters: {
                                                            'productSlugValue': serializeParam(
                                                              getJsonField(relatedProductItem,
                                                                r'''$.slug_value''',).toString(),
                                                              ParamType.String,
                                                            ),
                                                            'producttype': serializeParam(FFAppConstants.YantraMasterProductDetailsApi,
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
                                                        return;
                                                      }
                                                    },
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          width: 148,
                                                          height: 200,
                                                          decoration: BoxDecoration(
                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                          ),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius: BorderRadius.circular(10),
                                                                child: Image.network(
                                                                  getJsonField(relatedProductItem,
                                                                    r'''$.thumbnail_image''',).toString(),
                                                                  width: 152,
                                                                  height: 104,
                                                                  fit: BoxFit.contain,
                                                                ),
                                                              ),
                                                              Container(
                                                                width: double.infinity,
                                                                height: 50,
                                                                decoration: BoxDecoration(),
                                                                child: AutoSizeText(
                                                                  getJsonField(relatedProductItem,
                                                                    r'''$.product_name''',).toString(),
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    fontFamily: 'Montserrat',
                                                                    color: Color(0xFF696969),
                                                                    fontSize: 14,
                                                                    letterSpacing: 0,
                                                                    fontWeight: FontWeight.normal,
                                                                    lineHeight: 1.5,
                                                                  ),
                                                                ),
                                                              ),
                                                              RichText(
                                                                textScaler: MediaQuery.of(context).textScaler,
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(
                                                                        getJsonField(relatedProductItem,
                                                                          r'''$.selling_price''',).toString(), FFAppState().currencyRate,
                                                                      )}',
                                                                      style: TextStyle(
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 14,
                                                                      ),
                                                                    )
                                                                  ],
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    fontFamily: 'Montserrat',
                                                                    fontSize: 14,
                                                                    letterSpacing: 0,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                                maxLines: 2,
                                                              ),
                                                              Row(
                                                                mainAxisSize: MainAxisSize.max,
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius: BorderRadius.circular(0),
                                                                    child: Image.asset(
                                                                      'assets/images/Rating_Icon.png',
                                                                      width: 16,
                                                                      height: 16,
                                                                      fit: BoxFit.fill,
                                                                    ),
                                                                  ),
                                                                  RichText(
                                                                    textScaler: MediaQuery.of(context).textScaler,
                                                                    text: TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:  getJsonField(relatedProductItem,
                                                                            r'''$.product_rating''',).toString(),
                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            fontFamily: 'Montserrat',
                                                                            letterSpacing: 0,
                                                                            fontWeight: FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Montserrat',
                                                                        letterSpacing: 0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ].divide(SizedBox(width: 5)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        if (getJsonField(relatedProductItem, r'''$.out_of_stock''').toString() == 'true')
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
                                                                  child: Text("OUT OF STOCK",
                                                                    style: TextStyle(color: Colors.white),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        if (getJsonField(relatedProductItem, r'''$.reserved''').toString() == 'true')
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
                                                                  child: Text("RESERVED",
                                                                    style: TextStyle(color: Colors.white),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  );
                                                }).divide(SizedBox(width: 16)),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 12)),
                                  ),
                                ),
                                Divider(
                                  height: 10,
                                  thickness: 2,
                                  color: Color(0xFFE7E7E8),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                  color: Colors.white, // Set the background color to white
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                    children: [
                      if (OtherProductsDetailsCall.out_of_stock(
                        containerOtherProductsDetailsResponse?.jsonBody,
                      ) == false)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                          child: Container(
                            height: 60, // Adjust as needed
                            width: double.infinity,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /*FFButtonWidget(
                                    onPressed: () async {
                                      var _shouldSetState = false;
                                      if (currentAuthenticationToken != null &&
                                          currentAuthenticationToken != '') {
                                        FFAppState().buynow = false;
                                        if (OtherProductsDetailsCall
                                            .productVariantStatus(
                                          containerOtherProductsDetailsResponse
                                              ?.jsonBody,
                                        ) ==
                                            true) {
                                          _model.apiResultj7i =
                                          await AddToCartCall.call(
                                            hosturl: FFAppConstants.sanityurl,
                                            token: currentAuthenticationToken,
                                            productid: OtherProductsDetailsCall
                                                .productid(
                                              containerOtherProductsDetailsResponse
                                                  ?.jsonBody,
                                            )?.toString(),
                                            productType:
                                            OtherProductsDetailsCall
                                                .productMainType(
                                              containerOtherProductsDetailsResponse
                                                  ?.jsonBody,
                                            )?.toString(),
                                            productvariation:
                                            OtherProductsDetailsCall
                                                .productVariantStatus(
                                              containerOtherProductsDetailsResponse
                                                  ?.jsonBody,
                                            ),
                                            productvariationId:
                                            OtherProductsDetailsCall
                                                .productVariantStatus(
                                              containerOtherProductsDetailsResponse
                                                  ?.jsonBody,
                                            ) ==
                                                true
                                                ? (OtherProductsDetailsCall
                                                .otherproductvariantdataid(
                                              containerOtherProductsDetailsResponse
                                                  ?.jsonBody,
                                            )?[_model
                                                .selectedVariatoinindex!])
                                                : 0,
                                            quantity: _model
                                                .countControllerValue
                                                ?.toString(),
                                          );
                                          _shouldSetState = true;
                                          if ((_model.apiResultj7i?.succeeded ??
                                              true)) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  getJsonField(
                                                    (_model.apiResultj7i
                                                        ?.jsonBody ??
                                                        ''),
                                                    r'''$.msg''',
                                                  ).toString(),
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(context).containerFillColor,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                            );
                                            _model.otherproductid =
                                                OtherProductsDetailsCall
                                                    .productid(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                );
                                            _model.otherproductvarientstattus =
                                                OtherProductsDetailsCall
                                                    .productVariantStatus(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                );
                                            _model.otherproductmaintype =
                                                OtherProductsDetailsCall
                                                    .productMainType(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                );
                                            setState(() {});
                                            if (getJsonField(
                                              (_model.apiResultj7i
                                                  ?.jsonBody ??
                                                  ''),
                                              r'''$.status''',
                                            ).toString() !=
                                                "failed")
                                              await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                Colors.transparent,
                                                enableDrag: false,
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
                                                      padding: MediaQuery
                                                          .viewInsetsOf(
                                                          context),
                                                      child: MyCartWidget(),
                                                    ),
                                                  );
                                                },
                                              ).then((value) =>
                                                  safeSetState(() {}));
                                          } else {
                                            _model.apiResultj7i =
                                            await OtherSinglePriceAddToCartCall
                                                .call(
                                              hosturl: FFAppConstants.sanityurl,
                                              token: currentAuthenticationToken,
                                              productid:
                                              OtherProductsDetailsCall
                                                  .productid(
                                                containerOtherProductsDetailsResponse
                                                    ?.jsonBody,
                                              )?.toString(),
                                              productType:
                                              OtherProductsDetailsCall
                                                  .productMainType(
                                                containerOtherProductsDetailsResponse
                                                    ?.jsonBody,
                                              )?.toString(),
                                              quantity: _model
                                                  .countControllerValue
                                                  ?.toString(),
                                            );
                                            _shouldSetState = true;
                                            if ((_model
                                                .apiResultj7i?.succeeded ??
                                                true)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    getJsonField(
                                                      (_model.apiResultj7i
                                                          ?.jsonBody ??
                                                          ''),
                                                      r'''$.msg''',
                                                    ).toString(),
                                                    style: TextStyle(
                                                      color: FlutterFlowTheme.of(context).containerFillColor,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              );
                                              _model.otherproductid =
                                                  OtherProductsDetailsCall
                                                      .productid(
                                                    containerOtherProductsDetailsResponse
                                                        ?.jsonBody,
                                                  );
                                              _model.otherproductvarientstattus =
                                                  OtherProductsDetailsCall
                                                      .productVariantStatus(
                                                    containerOtherProductsDetailsResponse
                                                        ?.jsonBody,
                                                  );
                                              _model.otherproductmaintype =
                                                  OtherProductsDetailsCall
                                                      .productMainType(
                                                    containerOtherProductsDetailsResponse
                                                        ?.jsonBody,
                                                  );
                                              setState(() {});
                                              if (getJsonField(
                                                (_model.apiResultj7i
                                                    ?.jsonBody ??
                                                    ''),
                                                r'''$.status''',
                                              ).toString() !=
                                                  "failed")
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                  Colors.transparent,
                                                  enableDrag: false,
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
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                            context),
                                                        child: MyCartWidget(),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    safeSetState(() {}));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    (_model.apiResultj7i
                                                        ?.statusCode ??
                                                        200)
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: FlutterFlowTheme.of(context).containerFillColor,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              );
                                              if (_shouldSetState)
                                                setState(() {});
                                              return;
                                            }
                                            if (_shouldSetState)
                                              setState(() {});
                                          }
                                          if (_shouldSetState) setState(() {});
                                        } else {
                                          _model.apiResultj7i =
                                          await OtherSinglePriceAddToCartCall
                                              .call(
                                            hosturl: FFAppConstants.sanityurl,
                                            token: currentAuthenticationToken,
                                            productid: OtherProductsDetailsCall
                                                .productid(
                                              containerOtherProductsDetailsResponse
                                                  ?.jsonBody,
                                            )?.toString(),
                                            productType:
                                            OtherProductsDetailsCall
                                                .productMainType(
                                              containerOtherProductsDetailsResponse
                                                  ?.jsonBody,
                                            )?.toString(),
                                            quantity: _model
                                                .countControllerValue
                                                ?.toString(),
                                          );
                                          _shouldSetState = true;
                                          if ((_model.apiResultj7i?.succeeded ??
                                              true)) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  getJsonField(
                                                    (_model.apiResultj7i
                                                        ?.jsonBody ??
                                                        ''),
                                                    r'''$.msg''',
                                                  ).toString(),
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(context).containerFillColor,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                            );
                                            _model.otherproductid =
                                                OtherProductsDetailsCall
                                                    .productid(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                );
                                            _model.otherproductvarientstattus =
                                                OtherProductsDetailsCall
                                                    .productVariantStatus(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                );
                                            _model.otherproductmaintype =
                                                OtherProductsDetailsCall
                                                    .productMainType(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                );
                                            setState(() {});
                                            if (getJsonField(
                                              (_model.apiResultj7i
                                                  ?.jsonBody ??
                                                  ''),
                                              r'''$.status''',
                                            ).toString() !=
                                                "failed")
                                              await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                Colors.transparent,
                                                enableDrag: false,
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
                                                      child: MyCartWidget(),
                                                    ),
                                                  );
                                                },
                                              ).then(
                                                      (value) => safeSetState(() {}));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  (_model.apiResultj7i
                                                      ?.statusCode ??
                                                      200)
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(context).containerFillColor,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                            );
                                            if (_shouldSetState)
                                              setState(() {});
                                            return;
                                          }
                                          if (_shouldSetState) setState(() {});
                                        }
                                      } else {
                                        context.pushNamed(
                                          'LoginPage',
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                              PageTransitionType.fade,
                                              duration:
                                              Duration(milliseconds: 0),
                                            ),
                                          },
                                        );
                                      }
                                    },

                                    text: 'Add to Cart',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.44,
                                      height: 40,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24, 0, 24, 0),
                                      iconPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF740074),
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      elevation: 0,
                                      borderSide: BorderSide(
                                        color: Color(0xFF740074),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    showLoadingIndicator: false,
                                  ),*/
                                FFButtonWidget(
                                  onPressed: () async {
                                    if (currentAuthenticationToken != null && currentAuthenticationToken != '') {
                                      setState(() {
                                        _isLoading = true; // Set loading state to true when API call starts
                                      });

                                      // Perform API call and handle response
                                      var result;
                                      if (OtherProductsDetailsCall.productVariantStatus(
                                        containerOtherProductsDetailsResponse?.jsonBody,
                                      ) == true) {
                                        result = await AddToCartCall.call(
                                          hosturl: FFAppConstants.sanityurl,
                                          token: currentAuthenticationToken,
                                          productid: OtherProductsDetailsCall.productid(
                                            containerOtherProductsDetailsResponse?.jsonBody,
                                          )?.toString(),
                                          productType: OtherProductsDetailsCall.productMainType(
                                            containerOtherProductsDetailsResponse?.jsonBody,
                                          )?.toString(),
                                          productvariation: OtherProductsDetailsCall.productVariantStatus(
                                            containerOtherProductsDetailsResponse?.jsonBody,
                                          ),
                                          productvariationId: OtherProductsDetailsCall.productVariantStatus(
                                            containerOtherProductsDetailsResponse?.jsonBody,
                                          ) == true
                                              ? (OtherProductsDetailsCall.otherproductvariantdataid(
                                            containerOtherProductsDetailsResponse?.jsonBody,
                                          )?[_model.selectedVariatoinindex!])
                                              : 0,
                                          quantity: _model.countControllerValue?.toString(),
                                        );
                                      } else {
                                        result = await OtherSinglePriceAddToCartCall.call(
                                          hosturl: FFAppConstants.sanityurl,
                                          token: currentAuthenticationToken,
                                          productid: OtherProductsDetailsCall.productid(
                                            containerOtherProductsDetailsResponse?.jsonBody,
                                          )?.toString(),
                                          productType: OtherProductsDetailsCall.productMainType(
                                            containerOtherProductsDetailsResponse?.jsonBody,
                                          )?.toString(),
                                          quantity: _model.countControllerValue?.toString(),
                                        );
                                      }

                                      setState(() {
                                        _isLoading = false; // Set loading state to false when API call completes
                                      });

                                      if ((result?.succeeded ?? false)) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              getJsonField(result?.jsonBody ?? '', r'''$.msg''').toString(),
                                              //'Product added in Cart',
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).containerFillColor,
                                              ),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: FlutterFlowTheme.of(context).primary,
                                          ),
                                        );
                                        _model.otherproductid = OtherProductsDetailsCall.productid(
                                          containerOtherProductsDetailsResponse?.jsonBody,
                                        );
                                        _model.otherproductvarientstattus = OtherProductsDetailsCall.productVariantStatus(
                                          containerOtherProductsDetailsResponse?.jsonBody,
                                        );
                                        _model.otherproductmaintype = OtherProductsDetailsCall.productMainType(
                                          containerOtherProductsDetailsResponse?.jsonBody,
                                        );
                                        setState(() {});
                                        if (getJsonField(result?.jsonBody ?? '', r'''$.status''').toString() != "failed") {
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
                                                  child: MyCartWidget(),
                                                ),
                                              );
                                            },
                                          ).then((value) => safeSetState(() {}));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              (result?.statusCode ?? 200).toString(),
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).containerFillColor,
                                              ),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: FlutterFlowTheme.of(context).primary,
                                          ),
                                        );
                                      }
                                    } else {
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
                                    }
                                  },
                                  text: 'Add to Cart',
                                  options: FFButtonOptions(
                                    width: MediaQuery.sizeOf(context).width * 0.44,
                                    height: 40,
                                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF740074),
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    elevation: 0,
                                    borderSide: BorderSide(
                                      color: Color(0xFF740074),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  showLoadingIndicator: _isLoading, // Show loading indicator based on the state
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    if (currentAuthenticationToken != null &&
                                        currentAuthenticationToken != '') {

                                      FFAppState().productid =
                                          OtherProductsDetailsCall
                                              .productid(
                                            containerOtherProductsDetailsResponse
                                                ?.jsonBody,
                                          ).toString();
                                      FFAppState().productvariationId =OtherProductsDetailsCall
                                          .productVariantDataId(
                                        containerOtherProductsDetailsResponse
                                            ?.jsonBody,
                                      )?[_model
                                          .selectedVariatoinindex!];
                                      FFAppState().productType =
                                          OtherProductsDetailsCall
                                              .productMainType(
                                            containerOtherProductsDetailsResponse
                                                ?.jsonBody,
                                          ).toString();

                                      FFAppState().productvariation =
                                          OtherProductsDetailsCall
                                              .productVariantStatus(
                                            containerOtherProductsDetailsResponse
                                                ?.jsonBody,
                                          );
                                      print(FFAppState().productvariation);

                                      FFAppState().quantity = _model
                                          .countControllerValue!
                                          .toString();


                                      print(
                                          "FFAppState().selectedCertificationId ${FFAppState().selectedCertificationId}");


                                      FFAppState().buynow = true;
                                      print("FFAppState().buynow ${FFAppState().buynow}");
                                      print("FFAppState().quantity ${FFAppState().quantity}");
                                      print("FFAppState().productvariation ${FFAppState().productvariation}");
                                      print("FFAppState().productType ${FFAppState().productType}");
                                      print("FFAppState().productvariationId ${FFAppState().productvariationId}");
                                      print("FFAppState().productid ${FFAppState().productid}");

                                      context.pushNamed(
                                        'DeliveryAddress',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey:
                                          const TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                            PageTransitionType
                                                .bottomToTop,
                                            duration:
                                            Duration(milliseconds: 400),
                                          ),
                                        },
                                      );


                                      print('Button pressed ...');
                                    } else {
                                      context.pushNamed(
                                        'LoginPage',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                            PageTransitionType.fade,
                                            duration:
                                            Duration(milliseconds: 0),
                                          ),
                                        },
                                      );
                                    }
                                  },
                                  text: 'Buy Now',
                                  options: FFButtonOptions(
                                    width: MediaQuery.sizeOf(context).width *
                                        0.44,
                                    height: 40,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24, 0, 24, 0),
                                    iconPadding:
                                    EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    color: Color(0xFF740074),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    elevation: 0,
                                    borderSide: BorderSide(
                                      color: Color(0xFF740074),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (OtherProductsDetailsCall.out_of_stock(
                          containerOtherProductsDetailsResponse?.jsonBody) == true)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {
                                  final Uri phoneLaunchUri = Uri(
                                    scheme: 'tel',
                                    path: '+917021180033', // replace with your phone number
                                  );
                                  if (await canLaunchUrl(phoneLaunchUri)) {
                                    await launchUrl(phoneLaunchUri);
                                  } else {
                                    throw 'Could not launch $phoneLaunchUri';
                                  }
                                },
                                text: 'Call Us',
                                options: FFButtonOptions(
                                  height: 40,
                                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                    fontSize: 12,
                                    letterSpacing: 0,
                                  ),
                                  elevation: 0,
                                  borderSide: BorderSide(
                                    color: Color(0xFF740074),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  final Uri whatsappLaunchUri = Uri(
                                    scheme: 'https',
                                    host: 'api.whatsapp.com',
                                    path: '/send',
                                    queryParameters: {
                                      'phone': '919819111150',
                                      'text': 'I am interested in ${OtherProductsDetailsCall.productname(
                                        containerOtherProductsDetailsResponse
                                            ?.jsonBody,
                                      )} however it is out of stock. Kindly suggest an alternative.',
                                    },
                                  );

                                  if (await canLaunchUrl(whatsappLaunchUri)) {
                                    await launchUrl(whatsappLaunchUri, mode: LaunchMode.externalApplication);
                                  } else {
                                    throw 'Could not launch $whatsappLaunchUri';
                                  }
                                },
                                text: 'WHATSAPP',
                                options: FFButtonOptions(
                                  height: 40,
                                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  color: FlutterFlowTheme.of(context).whatsapp,
                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                    fontSize: 12,
                                    letterSpacing: 0,
                                  ),
                                  elevation: 0,
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).whatsapp,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),

                              FFButtonWidget(
                                onPressed: () async {
                                  final Uri mailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: 'contact@rudracentre.com,info@rudracentre.com', // replace with your email address
                                    queryParameters: {
                                      'subject': 'Product_Inquiry',
                                      'body':"I am interested in ${OtherProductsDetailsCall.productname(
                                        containerOtherProductsDetailsResponse
                                            ?.jsonBody,
                                      )} however it is out of stock. Kindly suggest an alternative."
                                    },
                                  );
                                  if (await canLaunchUrl(mailLaunchUri)) {
                                    await launchUrl(mailLaunchUri);
                                  } else {
                                    throw 'Could not launch $mailLaunchUri';
                                  }
                                },
                                text: 'MAIL US',
                                options: FFButtonOptions(
                                  height: 40,
                                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 12,
                                    letterSpacing: 0,
                                  ),
                                  elevation: 0,
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),


                            ],
                          ),
                        ),
                    ]
                ),
              ),
            ),
          ]
      ),
    );
  }

  Widget buildDefaultProductDetails() {
    return SafeArea(
      top: true,
      child: Stack(
          children: [
            Container(
              height: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 4),
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 20,
                            borderWidth: 1,
                            buttonSize: 40,
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: Color(0xFF272728),
                              size: 30,
                            ),
                            onPressed: () async {
                              context.safePop();
                            },
                          ),
                          /*InkWell(
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
                                bottomLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(0.0),
                                topLeft: Radius.circular(0.0),
                                topRight: Radius.circular(0.0),
                              ),
                              child: Image.asset(
                                'assets/images/Buy.png',
                                width: 30.0,
                                height: 30.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),*/
                          FutureBuilder<ApiCallResponse>(
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
                              final cartCount = functions.cartBadgeCount(badgeCartResponse.jsonBody);

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
                                      fit: BoxFit.cover,
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
                          )
                        ],
                      ),
                    ),
                  ),
                  FutureBuilder<ApiCallResponse>(
                    future: OtherProductsDetailsCall.call(
                      sanityurl: FFAppConstants.sanityurl,
                      producttype: FFAppConstants.YantraMasterProductDetailsApi,
                      productslugvalue: widget.productSlugValue,
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
                      containerOtherProductsDetailsResponse = snapshot.data!;
                      print("data: ${getJsonField(
                        containerOtherProductsDetailsResponse
                            ?.jsonBody,
                        r'''$.data''',
                      ).toString()}");
                      return Container(
                        height: MediaQuery.sizeOf(context).height * 0.85,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xFFE7E7E8),
                                      width: 2,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 16, 0),
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: Stack(
                                        alignment: AlignmentDirectional(1, 1),
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
                                                enableDrag: false,
                                                context: context,
                                                builder: (context) {
                                                  return GestureDetector(
                                                    onTap: () => _model.unfocusNode.canRequestFocus
                                                        ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                        : FocusScope.of(context).unfocus(),
                                                    child: Padding(
                                                      padding: MediaQuery.viewInsetsOf(context),
                                                      child: /*ImageZoomScreen(
                                                        imageUrl:
                                                        OtherProductsDetailsCall.yantraproductimageurlpath(
                                                          containerOtherProductsDetailsResponse?.jsonBody,
                                                        )!.first,
                                                      ),*/
                                                      imageZoomScreen(
                                                        imageUrls: widget.producttype == FFAppConstants.YantraMasterProductDetailsApi
                                                            ? OtherProductsDetailsCall.otherproductimageurlpath(
                                                          containerOtherProductsDetailsResponse?.jsonBody,
                                                        )?.toList() ?? []
                                                            : parseImageUrls(
                                                            getJsonField(
                                                                containerOtherProductsDetailsResponse?.jsonBody,
                                                                r'''$.data.image_url[*].path'''
                                                            ) ?? []
                                                        ),
                                                        initialIndex: 0,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).then((value) => safeSetState(() {}));
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(0),
                                              child: Stack(
                                                children: [
                                                  /*CachedNetworkImage(
                                                    fadeInDuration:
                                                        Duration(milliseconds: 500),
                                                    fadeOutDuration:
                                                        Duration(milliseconds: 500),
                                                    imageUrl: OtherProductsDetailsCall
                                                            .yantraproductimageurlpath(
                                                      containerOtherProductsDetailsResponse
                                                          ?.jsonBody,
                                                    )!.first,
                                                    width: double.infinity,
                                                    height: 288,
                                                    fit: BoxFit.contain,
                                                  ),*/
                                                  ProductImagesWidget(
                                                    imageUrls: OtherProductsDetailsCall.otherproductvariantdata(
                                                      containerOtherProductsDetailsResponse?.jsonBody,
                                                    ) != null &&
                                                        (OtherProductsDetailsCall.otherproductvariantdata(
                                                          containerOtherProductsDetailsResponse?.jsonBody,
                                                        ))!.isNotEmpty
                                                        ? parseImageUrls(OtherProductsDetailsCall.otherproductimageurlpath(
                                                      containerOtherProductsDetailsResponse?.jsonBody,
                                                    ) ?? [])
                                                        : parseImageUrls(
                                                        getJsonField(
                                                            containerOtherProductsDetailsResponse?.jsonBody,
                                                            r'''$.data.image_url[*].path'''
                                                        ) ?? []
                                                    ),
                                                  ),
                                                  /*ProductImagesWidget(
                                                    imageUrls: OtherProductsDetailsCall.otherproductvariantdata(
                                                      containerOtherProductsDetailsResponse?.jsonBody,
                                                    ) != null &&
                                                        (OtherProductsDetailsCall.otherproductvariantdata(
                                                          containerOtherProductsDetailsResponse?.jsonBody,
                                                        ))!.isNotEmpty
                                                        ? OtherProductsDetailsCall.otherproductimageurlpath(
                                                        containerOtherProductsDetailsResponse?.jsonBody
                                                    )?.toList() ?? []
                                                        : List<String>.from(
                                                        getJsonField(
                                                            containerOtherProductsDetailsResponse?.jsonBody,
                                                            r'''$.data.image_url[*].path'''
                                                        ) ?? []
                                                    ),
                                                  ),*/
                                                  Align(
                                                    alignment: AlignmentDirectional(1,1),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top: 10,right: 10),
                                                      child: SvgPicture.asset(
                                                        'assets/images/zoom_image.svg',
                                                        width: 25,
                                                        height: 25,
                                                        color: FlutterFlowTheme.of(context).primary,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                            AlignmentDirectional(0.99, 1),
                                            child: Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 10, 10),
                                              child:
                                              currentAuthenticationToken ==
                                                  null
                                                  ? InkWell(
                                                splashColor:
                                                Colors.transparent,
                                                focusColor:
                                                Colors.transparent,
                                                hoverColor:
                                                Colors.transparent,
                                                highlightColor:
                                                Colors.transparent,
                                                onTap: () async {
                                                  context.pushNamed(
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
                                                },
                                                child: Container(
                                                  width: 28,
                                                  height: 28,
                                                  clipBehavior:
                                                  Clip.antiAlias,
                                                  decoration:
                                                  BoxDecoration(
                                                    shape:
                                                    BoxShape.circle,
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/HeartEmpty.png',
                                                    fit: BoxFit.cover,
                                                    color: FlutterFlowTheme.of(context).primary,
                                                  ),
                                                ),
                                              )
                                                  : FutureBuilder<
                                                  ApiCallResponse>(
                                                future:
                                                WishListCall.call(
                                                  hosturl:
                                                  FFAppConstants
                                                      .sanityurl,
                                                  token:
                                                  currentAuthenticationToken,
                                                ),
                                                builder: (context,
                                                    snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot
                                                      .hasData) {
                                                    return Container(
                                                      width: 5,
                                                      height: 5,
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
                                                        final wishlistIds = WishListCall.id(containerWishlistResponse.jsonBody) ?? [];
                                                        final productId = OtherProductsDetailsCall.rudrakshaProductid(containerOtherProductsDetailsResponse?.jsonBody);

                                                        print(wishlistIds);
                                                        print("productId${productId}");
                                                        print(WishListCall.id(
                                                            containerWishlistResponse
                                                                ?.jsonBody));
                                                        print(OtherProductsDetailsCall
                                                            .rudrakshaProductid(
                                                            containerOtherProductsDetailsResponse
                                                                ?.jsonBody));
                                                        if (!wishlistIds
                                                            .contains(
                                                          OtherProductsDetailsCall
                                                              .rudrakshaProductid(
                                                            containerOtherProductsDetailsResponse
                                                                ?.jsonBody,
                                                          ),
                                                        )) {
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
                                                                    OtherProductsDetailsCall.rudrakshaProductid(
                                                                      containerOtherProductsDetailsResponse?.jsonBody,
                                                                    ),
                                                                    productType:
                                                                    OtherProductsDetailsCall.rudrakshaMainProductType(
                                                                      containerOtherProductsDetailsResponse?.jsonBody,
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
                                                                        backgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                      ),
                                                                    );
                                                                  }
                                                                  setState(
                                                                          () {});
                                                                  _model.wishlistlikedislike =
                                                                  !_model.wishlistlikedislike;
                                                                  setState(
                                                                          () {});
                                                                  HapticFeedback
                                                                      .lightImpact();
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
                                                              },
                                                              child:
                                                              Container(
                                                                width:
                                                                28,
                                                                height:
                                                                28,
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
                                                                  fit: BoxFit.cover,
                                                                  color: FlutterFlowTheme.of(context).primary,
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
                                                                  OtherProductsDetailsCall.rudrakshaProductid(
                                                                    containerOtherProductsDetailsResponse?.jsonBody,
                                                                  ),
                                                                  productType:
                                                                  OtherProductsDetailsCall.rudrakshaMainProductType(
                                                                    containerOtherProductsDetailsResponse?.jsonBody,
                                                                  ),
                                                                );

                                                                _shouldSetState =
                                                                true;
                                                                if ((_model.apiResult5ep?.succeeded ??
                                                                    true)) {
                                                                  FFAppState().statusFailed =
                                                                      getJsonField(
                                                                        (_model.apiResult5ep?.jsonBody ??
                                                                            ''),
                                                                        r'''$.status''',
                                                                      ).toString();
                                                                  setState(
                                                                          () {});
                                                                  ScaffoldMessenger.of(context)
                                                                      .clearSnackBars();
                                                                  ScaffoldMessenger.of(context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content: Text(
                                                                        getJsonField(
                                                                          (_model.apiResult5ep?.jsonBody ?? ''),
                                                                          r'''$.msg''',
                                                                        ).toString(),
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
                                                                _model.wishlistlikedislike =
                                                                !_model.wishlistlikedislike;
                                                                setState(
                                                                        () {});
                                                                HapticFeedback
                                                                    .lightImpact();
                                                              },
                                                              child:
                                                              Container(
                                                                width:
                                                                28,
                                                                height:
                                                                28,
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
                                                },
                                              ),
                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 16, 16, 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        valueOrDefault<String>(
                                          OtherProductsDetailsCall.yantraproductname(
                                            containerOtherProductsDetailsResponse
                                                ?.jsonBody,
                                          ),
                                          'Name',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 15,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      RichText(
                                        textScaler:
                                        MediaQuery.of(context).textScaler,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Product Code: ',
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Montserrat',
                                                fontSize: 15,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text: valueOrDefault<String>(
                                                OtherProductsDetailsCall.yantraproductcode(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                ),
                                                'Code',
                                              ),
                                              style: GoogleFonts.getFont(
                                                'Montserrat',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            )
                                          ],
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              _model.expandableExpandableController3.expanded=true;

                                              _scrollController.animateTo(
                                                  _YantraProductDetailsWidgetratingKey.currentContext!.findRenderObject()!.getTransformTo(null).getTranslation().y,
                                                  duration: Duration(milliseconds: 300),
                                                  curve: Curves.easeInOut);
                                            },
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 5, 0),
                                              child: RatingBarIndicator(
                                                itemBuilder: (context, index) => Icon(
                                                  Icons.star_rounded,
                                                  color: Color(0xFFF2B503),
                                                ),
                                                direction: Axis.horizontal,
                                                rating: OtherProductsDetailsCall
                                                    .productrating(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                )!,
                                                unratedColor:
                                                FlutterFlowTheme.of(context)
                                                    .accent3,
                                                itemCount: 5,
                                                itemSize: 18,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            OtherProductsDetailsCall.productrating(
                                              containerOtherProductsDetailsResponse
                                                  ?.jsonBody,
                                            ).toString(),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Roboto',
                                              fontSize: 13,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ].divide(SizedBox(height: 8)),
                                  ),
                                ),
                                if (OtherProductsDetailsCall.pujaenergizationlist(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                ) !=
                                    null &&
                                    (OtherProductsDetailsCall.pujaenergizationlist(
                                      containerOtherProductsDetailsResponse
                                          ?.jsonBody,
                                    ))!
                                        .isNotEmpty)
                                  Divider(
                                    height: 2,
                                    thickness: 1.5,
                                    color: Color(0xFFE7E7E8),
                                  ),
                                if (OtherProductsDetailsCall
                                    .yantrapujaenergizationlist(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                ) !=
                                    null &&
                                    (OtherProductsDetailsCall
                                        .yantrapujaenergizationlist(
                                      containerOtherProductsDetailsResponse
                                          ?.jsonBody,
                                    ))!
                                        .isNotEmpty)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 16, 16, 16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          textScaler:
                                          MediaQuery.of(context).textScaler,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Energization : ',
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 14,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              TextSpan(
                                                text: valueOrDefault<String>(
                                                  _model.selectedEnergization,
                                                  'Energization',
                                                ),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              )
                                            ],
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              fontSize: 15,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Builder(
                                          builder: (context) {
                                            final selectEnergization =
                                                OtherProductsDetailsCall
                                                    .yantrapujaenergizationlist(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                )?.toList() ??
                                                    [];
                                            return SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(
                                                    selectEnergization.length,
                                                        (selectEnergizationIndex) {
                                                      final selectEnergizationItem =
                                                      selectEnergization[
                                                      selectEnergizationIndex];
                                                      return Align(
                                                        alignment:
                                                        AlignmentDirectional(0, 1),
                                                        child: InkWell(
                                                          splashColor:
                                                          Colors.transparent,
                                                          focusColor:
                                                          Colors.transparent,
                                                          hoverColor:
                                                          Colors.transparent,
                                                          highlightColor:
                                                          Colors.transparent,
                                                          onTap: () async {
                                                            _model.energizationprice =
                                                                getJsonField(
                                                                  selectEnergizationItem,
                                                                  r'''$.price''',
                                                                );
                                                            setState(() {});
                                                            if (_model.selecteddesign ==
                                                                true) {
                                                              _model.selectedEnergizationlist =
                                                                  selectEnergizationIndex;
                                                              setState(() {});
                                                            } else {
                                                              _model.selectedEnergizationlist =
                                                                  selectEnergizationIndex;
                                                              setState(() {});
                                                            }

                                                            _model.selectedEnergization =
                                                                getJsonField(
                                                                  selectEnergizationItem,
                                                                  r'''$.name''',
                                                                ).toString();
                                                            _model.selectedEnergizationIndex =
                                                                selectEnergizationIndex;
                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            // width: 224,
                                                            height: 44,
                                                            decoration: BoxDecoration(
                                                              color: _model
                                                                  .selectedEnergizationlist ==
                                                                  selectEnergizationIndex
                                                                  ? Color(0x26740074)
                                                                  : FlutterFlowTheme.of(
                                                                  context)
                                                                  .secondaryBackground,
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  5),
                                                              border: Border.all(
                                                                color: _model
                                                                    .selectedEnergizationlist ==
                                                                    selectEnergizationIndex
                                                                    ? Color(0xFF740074)
                                                                    : FlutterFlowTheme
                                                                    .of(context)
                                                                    .secondaryBackground,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: 15, right: 15),
                                                              child: Center(
                                                                child: AutoSizeText(
                                                                  getJsonField(
                                                                    selectEnergizationItem,
                                                                    r'''$.name''',
                                                                  ).toString(),
                                                                  maxLines: 2,
                                                                  style: FlutterFlowTheme
                                                                      .of(context)
                                                                      .bodyMedium
                                                                      .override(
                                                                    fontFamily:
                                                                    'Montserrat',
                                                                    fontSize: 13,
                                                                    letterSpacing:
                                                                    0,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                    lineHeight: 1.5,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }).divide(SizedBox(width: 10)),
                                              ),
                                            );
                                          },
                                        ),
                                      ].divide(SizedBox(height: 10)),
                                    ),
                                  ),
                                if (OtherProductsDetailsCall
                                    .yantrapujaenergizationlist(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                ) !=
                                    null && (OtherProductsDetailsCall.yantrapujaenergizationlist(
                                  containerOtherProductsDetailsResponse?.jsonBody,
                                ))!.isNotEmpty)
                                  Divider(
                                    height: 2,
                                    thickness: 1.5,
                                    color: Color(0xFFE7E7E8),
                                  ),
                                if (OtherProductsDetailsCall.yantraproductVariantStatus(
                                  containerOtherProductsDetailsResponse?.jsonBody,
                                ) == true)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          textScaler: MediaQuery.of(context).textScaler,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Select Variation: ',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 14,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              TextSpan(
                                                text: valueOrDefault<String>(
                                                  _model.selectedCertification != null
                                                      ? utf8.decode((_model.selectedCertification, 'Variation').toString().codeUnits)
                                                      : null,
                                                  'Variation',
                                                ),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              )
                                            ],
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              fontSize: 15,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Builder(
                                          builder: (context) {
                                            final selectVariation = OtherProductsDetailsCall.productvariantdata(
                                              containerOtherProductsDetailsResponse?.jsonBody,
                                            )?.toList() ?? [];

                                            // Set the initial value of selectedCertification if needed
                                            if (selectVariation.isNotEmpty && _model.selectedCertification == null) {
                                              _model.selectedCertification = getJsonField(selectVariation[0], r'''$.variant_name''').toString();
                                              _model.selectedCertificationindex = 0; // Set the index to the first variation

                                              print('_model.selectedVariatoinindex: ${_model.selectedVariatoinindex}');
                                            }

                                            return SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(
                                                    selectVariation.length, (selectVariationIndex) {
                                                  final selectVariationItem = selectVariation[selectVariationIndex];

                                                  // Decode the JSON data if necessary
                                                  final decodedDescription = utf8.decode(
                                                      getJsonField(selectVariationItem,
                                                        r'''$.variant_name''',).toString().codeUnits
                                                  );

                                                  return Align(
                                                    alignment: AlignmentDirectional(0, 1),
                                                    child: InkWell(
                                                      splashColor: Colors.transparent,
                                                      focusColor: Colors.transparent,
                                                      hoverColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      onTap: () async {
                                                        _model.expandableExpandableController1.expanded=true;
                                                        _model.selectedvariationprice = getJsonField(
                                                          selectVariationItem,
                                                          r'''$.price''',
                                                        );
                                                        _model.selectvariationindex = selectVariationIndex;
                                                        setState(() {});
                                                        if (_model.selecteddesign == true) {
                                                          _model.selectedCertificationindex = selectVariationIndex;
                                                          setState(() {});
                                                        } else {
                                                          _model.selectedCertificationindex = selectVariationIndex;
                                                          setState(() {});
                                                        }

                                                        _model.selectedCertification = getJsonField(
                                                          selectVariationItem,
                                                          r'''$.variant_name''').toString();

                                                        _model.id = getJsonField(
                                                          selectVariationItem,
                                                          r'''$.id''').toString();
                                                        _model.selectedCertificationindex = selectVariationIndex;

                                                        //print('_model.id: ${_model.id}');

                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        width: 224,
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                          color: _model.selectedCertificationindex == selectVariationIndex
                                                              ? Color(0x26740074)
                                                              : FlutterFlowTheme.of(context).secondaryBackground,
                                                          borderRadius: BorderRadius.circular(5),
                                                          border: Border.all(
                                                              color: _model.selectedCertificationindex == selectVariationIndex
                                                                  ? Color(0xFF740074)
                                                                  : Color(0xFFE7E7E8),
                                                              width: 1
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 0, right: 0),
                                                          child: Center(
                                                            child: HtmlWidget(
                                                               decodedDescription,
                                                              
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }).divide(SizedBox(width: 10)),
                                              ),
                                            );
                                          },
                                        ),
                                      ].divide(SizedBox(height: 10)),
                                    ),
                                  ),
                                if (OtherProductsDetailsCall.yantraproductVariantStatus(
                                  containerOtherProductsDetailsResponse?.jsonBody,
                                ) == true)
                                  Divider(
                                    height: 2,
                                    thickness: 1.5,
                                    color: Color(0xFFE7E7E8),
                                  ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (OtherProductsDetailsCall.yantraproductVariantStatus(
                                          containerOtherProductsDetailsResponse?.jsonBody,
                                        ) == true)
                                          Container(
                                            width: double.infinity,
                                            color: Colors.white,
                                            child: ExpandableNotifier(
                                              controller: _model.expandableExpandableController1,
                                              child: ExpandablePanel(
                                                header: RichText(
                                                  textScaler: MediaQuery.of(context).textScaler,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: 'Select Designs',
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Montserrat',
                                                          letterSpacing: 0,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      letterSpacing: 0,
                                                    ),
                                                  ),
                                                ),
                                                collapsed: Container(),
                                                expanded: Builder(
                                                  builder: (context) {
                                                    final productVariants = OtherProductsDetailsCall.yantraproductvariantdata(containerOtherProductsDetailsResponse?.jsonBody)?.toList() ?? [];

                                                    print('Product Variants: $productVariants'); // Debug: Check all product variants
                                                    print('_model.id: ${_model.id} (type: ${_model.id.runtimeType})'); // Debug: Check the model ID type

                                                    // Check types for IDs
                                                    productVariants.forEach((product) {
                                                      print('Product ID: ${product['id']} (type: ${product['id'].runtimeType})');
                                                    });

                                                    // Find the product that matches _model.id
                                                    final selectedProduct = productVariants.firstWhere(
                                                          (product) => product['id'].toString() == _model.id.toString(),
                                                      orElse: () => null, // Handle case where no product is found
                                                    );

                                                    if (selectedProduct == null) {
                                                      print('No product found for id: ${_model.id}'); // Debug: Product not found
                                                      return Text('No product found.'); // Return an appropriate widget when product is not found
                                                    }

                                                    print('Selected Product: $selectedProduct'); // Debug: Show selected product details

                                                    // If the product is found, get the designgrp
                                                    final designGroup = selectedProduct['designgrp'] ?? [];
                                                    print('Design Group: $designGroup'); // Debug: Check the design group list

                                                    return SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal,
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        children: List.generate(designGroup.length, (index) {
                                                          final designItem = designGroup[index];
                                                          return InkWell(
                                                            splashColor: Colors.transparent,
                                                            focusColor: Colors.transparent,
                                                            hoverColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () {
                                                              // Handle onTap event as needed
                                                              _model.selecteddesign = !_model.selecteddesign;
                                                              _model.selectedyantratdesign = index;
                                                              _model.designprice = designItem['price']; // Update design price based on selected design
                                                              _model.selecteddesignid = designItem['id'];
                                                              setState(() {});
                                                            },
                                                            child: Container(
                                                              width: 114,
                                                              decoration: BoxDecoration(
                                                                color: _model.selectedyantratdesign == index ? Color(0x26740074) : FlutterFlowTheme.of(context).secondaryBackground,
                                                                borderRadius: BorderRadius.circular(5),
                                                                border: Border.all(
                                                                  color: _model.selectedyantratdesign == index ? Color(0xFF740074) : FlutterFlowTheme.of(context).secondaryBackground,
                                                                ),
                                                              ),
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.max,
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(7, 4, 7, 4),
                                                                    child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(8),
                                                                      child: Image.network(
                                                                        designItem['image'],
                                                                        width: 100,
                                                                        height: 120,
                                                                        fit: BoxFit.contain,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(7, 0, 0, 0),
                                                                    child: Container(
                                                                      width: double.infinity,
                                                                      height: 42,
                                                                      child: AutoSizeText(
                                                                        designItem['name'],
                                                                        maxLines: 2,
                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                          fontFamily: 'Montserrat',
                                                                          fontSize: 13,
                                                                          fontWeight: FontWeight.w600,
                                                                          lineHeight: 1.5,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(7, 0, 0, 7),
                                                                    child: RichText(
                                                                      text: TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text: '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatNumber(
                                                                              functions.currencyConversion(FFAppState().currencyRate, designItem['price'].toString()),
                                                                              formatType: FormatType.decimal,
                                                                              decimalType: DecimalType.periodDecimal,
                                                                            )}',
                                                                            style: TextStyle(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 14,
                                                                            ),
                                                                          )
                                                                        ],
                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                          fontFamily: 'Montserrat',
                                                                          fontSize: 14,
                                                                          letterSpacing: 0,
                                                                          fontWeight: FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                      maxLines: 2,
                                                                    ),
                                                                  ),
                                                                ].divide(SizedBox(height: 12)),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                      ),
                                                    );
                                                  },
                                                  /*builder: (context) {
                                                    if (_model.selectvariationindex == 0) {
                                                      return Builder(
                                                        builder: (context) {
                                                          final selectDesgn = OtherProductsDetailsCall.yantraproductvariantdata(
                                                            containerOtherProductsDetailsResponse?.jsonBody)?.toList() ?? [];
                                                          return SingleChildScrollView(
                                                            scrollDirection: Axis.horizontal,
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.max,
                                                              children: List.generate(
                                                                  selectDesgn.length, (selectDesgnIndex) {
                                                                    final selectDesgnItem = selectDesgn[selectDesgnIndex];
                                                                    return InkWell(
                                                                      splashColor: Colors.transparent,
                                                                      focusColor: Colors.transparent,
                                                                      hoverColor: Colors.transparent,
                                                                      highlightColor: Colors.transparent,
                                                                      onTap: () async {
                                                                        _model.selecteddesign = !_model.selecteddesign;
                                                                        setState(() {});
                                                                        _model.selectedyantratdesign = selectDesgnIndex;
                                                                        _model.designprice = OtherProductsDetailsCall.yantraproductvariantdatadesigngrpprice(
                                                                          containerOtherProductsDetailsResponse?.jsonBody)?[_model.selectedyantratdesign!];
                                                                        _model.selecteddesignid = getJsonField(selectDesgnItem, r'''$.designgrp[0].id''',);
                                                                        setState(() {});
                                                                      },
                                                                      child: Container(
                                                                        width: 114,
                                                                        //height: 222,
                                                                        decoration: BoxDecoration(
                                                                          color: _model.selectedyantratdesign == selectDesgnIndex
                                                                              ? Color(0x26740074)
                                                                              : FlutterFlowTheme.of(context).secondaryBackground,
                                                                          borderRadius: BorderRadius.circular(5),
                                                                          border: Border.all(
                                                                            color: _model.selectedyantratdesign == selectDesgnIndex
                                                                                ? Color(0xFF740074)
                                                                                : FlutterFlowTheme.of(context).secondaryBackground,
                                                                          ),
                                                                        ),
                                                                        child: Column(
                                                                          mainAxisSize: MainAxisSize.max,
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(7, 4, 7, 4),
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                child: Image.network(getJsonField(selectDesgnItem, r'''$.designgrp[0].image''').toString(),
                                                                                  width: 100,
                                                                                  height: 120,
                                                                                  fit: BoxFit.contain,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(7, 0, 0, 0),
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: 42,
                                                                                decoration: BoxDecoration(),
                                                                                child: AutoSizeText(getJsonField(selectDesgnItem, r'''$.designgrp[0].name''').toString(),
                                                                                  maxLines: 2,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Montserrat',
                                                                                    fontSize: 13,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    lineHeight: 1.5,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(7, 0, 0, 7),
                                                                              child: RichText(
                                                                                textScaler: MediaQuery.of(context).textScaler,
                                                                                text: TextSpan(
                                                                                  children: [
                                                                                    TextSpan(
                                                                                      text: '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatNumber(
                                                                                        functions.currencyConversion(FFAppState().currencyRate, getJsonField(
                                                                                          selectDesgnItem,
                                                                                          r'''$.designgrp[0].price''',
                                                                                        ).toString()),
                                                                                        formatType: FormatType.decimal,
                                                                                        decimalType: DecimalType.periodDecimal,
                                                                                      )}',
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 14,
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Montserrat',
                                                                                    fontSize: 14,
                                                                                    letterSpacing: 0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                                ),
                                                                                maxLines: 2,
                                                                              ),
                                                                            ),
                                                                          ].divide(SizedBox(height: 12)),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    } else if (_model.selectvariationindex == 1) {
                                                      return Builder(
                                                        builder: (context) {
                                                          final selectDesgn =
                                                              OtherProductsDetailsCall. yantraproductvariantdata(
                                                                containerOtherProductsDetailsResponse?.jsonBody,
                                                              )?.toList() ?? [];
                                                          return SingleChildScrollView(
                                                            scrollDirection: Axis.horizontal,
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.max,
                                                              children: List.generate(
                                                                  selectDesgn.length, (selectDesgnIndex) {
                                                                    final selectDesgnItem = selectDesgn[selectDesgnIndex];
                                                                    return InkWell(
                                                                      splashColor: Colors.transparent,
                                                                      focusColor: Colors.transparent,
                                                                      hoverColor: Colors.transparent,
                                                                      highlightColor: Colors.transparent,
                                                                      onTap: () async {
                                                                        _model.selecteddesign = !_model.selecteddesign;
                                                                        setState(() {});
                                                                        _model.selectedyantratdesign = selectDesgnIndex;
                                                                        _model.designprice = OtherProductsDetailsCall.dataproductvariantdata1designgrpprice(
                                                                          containerOtherProductsDetailsResponse?.jsonBody,
                                                                        )?[_model.selectedyantratdesign!];
                                                                        _model.selecteddesignid = getJsonField(
                                                                          selectDesgnItem, r'''$.designgrp[1].id''',
                                                                        );
                                                                        setState(() {});
                                                                      },
                                                                      child: Container(
                                                                        width: 114,
                                                                        height: 222,
                                                                        decoration: BoxDecoration(
                                                                          color: _model.selectedyantratdesign == selectDesgnIndex
                                                                              ? Color(0x26740074)
                                                                              : FlutterFlowTheme.of(context).secondaryBackground,
                                                                          borderRadius: BorderRadius.circular(5),
                                                                          border: Border.all(
                                                                            color: _model.selectedyantratdesign == selectDesgnIndex
                                                                                ? Color(0xFF740074)
                                                                                : FlutterFlowTheme.of(context).secondaryBackground,
                                                                          ),
                                                                        ),
                                                                        child: Column(
                                                                          mainAxisSize: MainAxisSize.max,
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(7, 4, 7, 4),
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                child: Image.network(
                                                                                  getJsonField(
                                                                                    selectDesgnItem,
                                                                                    r'''$.designgrp[1].image''',
                                                                                  ).toString(),
                                                                                  width: 100,
                                                                                  height: 120,
                                                                                  fit: BoxFit.contain,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(7, 0, 0, 0),
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: 42,
                                                                                decoration: BoxDecoration(),
                                                                                child: AutoSizeText(
                                                                                  getJsonField(
                                                                                    selectDesgnItem,
                                                                                    r'''$.designgrp[1].name''',
                                                                                  ).toString(),
                                                                                  maxLines: 2,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Montserrat',
                                                                                    fontSize: 13,
                                                                                    letterSpacing: 0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    lineHeight: 1.5,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(7, 0, 0, 7),
                                                                              child: RichText(
                                                                                textScaler: MediaQuery.of(context).textScaler,
                                                                                text: TextSpan(
                                                                                  children: [
                                                                                    TextSpan(
                                                                                      text: '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatNumber(
                                                                                        functions.currencyConversion(FFAppState().currencyRate, getJsonField(
                                                                                          selectDesgnItem,
                                                                                          r'''$.designgrp[1].price''',
                                                                                        ).toString()),
                                                                                        formatType: FormatType.decimal,
                                                                                        decimalType: DecimalType.periodDecimal,
                                                                                      )}',
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 14,
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Montserrat',
                                                                                    fontSize: 14,
                                                                                    letterSpacing: 0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                                ),
                                                                                maxLines: 2,
                                                                              ),
                                                                            ),
                                                                          ].divide(SizedBox(height: 12)),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    } else if (_model.selectvariationindex == 2) {
                                                      return Builder(
                                                        builder: (context) {
                                                          final selectDesgn = OtherProductsDetailsCall.yantraproductvariantdata(
                                                                containerOtherProductsDetailsResponse?.jsonBody,
                                                              )?.toList() ?? [];
                                                          return SingleChildScrollView(
                                                            scrollDirection: Axis.horizontal,
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.max,
                                                              children: List.generate(
                                                                  selectDesgn.length, (selectDesgnIndex) {
                                                                    final selectDesgnItem = selectDesgn[selectDesgnIndex];
                                                                    return InkWell(
                                                                      splashColor: Colors.transparent,
                                                                      focusColor: Colors.transparent,
                                                                      hoverColor: Colors.transparent,
                                                                      highlightColor: Colors.transparent,
                                                                      onTap: () async {
                                                                        _model.selecteddesign = !_model.selecteddesign;
                                                                        setState(() {});
                                                                        _model.selectedyantratdesign = selectDesgnIndex;
                                                                        _model.designprice = OtherProductsDetailsCall
                                                                            .dataproductvariantdata3designgrpprice(
                                                                          containerOtherProductsDetailsResponse?.jsonBody,
                                                                        )?[_model.selectedyantratdesign!];
                                                                        _model.selecteddesignid = getJsonField(
                                                                          selectDesgnItem,
                                                                          r'''$.designgrp[2].id''',
                                                                        );
                                                                        setState(() {});
                                                                      },
                                                                      child: Container(
                                                                        width: 114,
                                                                        height: 222,
                                                                        decoration: BoxDecoration(
                                                                          color: _model.selectedyantratdesign == selectDesgnIndex
                                                                              ? Color(0x26740074)
                                                                              : FlutterFlowTheme.of(context).secondaryBackground,
                                                                          borderRadius: BorderRadius.circular(5),
                                                                          border: Border.all(
                                                                            color: _model.selectedyantratdesign == selectDesgnIndex
                                                                                ? Color(0xFF740074)
                                                                                : FlutterFlowTheme.of(context).secondaryBackground,
                                                                          ),
                                                                        ),
                                                                        child: Column(
                                                                          mainAxisSize: MainAxisSize.max,
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(7, 4, 7, 4),
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                child: Image.network(
                                                                                  getJsonField(selectDesgnItem, r'''$.designgrp[2].image''',).toString(),
                                                                                  width: 100,
                                                                                  height: 120,
                                                                                  fit: BoxFit.contain,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(7, 0, 0, 0),
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: 42,
                                                                                decoration: BoxDecoration(),
                                                                                child: AutoSizeText(
                                                                                  getJsonField(
                                                                                    selectDesgnItem, r'''$.designgrp[2].name''',).toString(),
                                                                                  maxLines: 2,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Montserrat',
                                                                                    fontSize: 13,
                                                                                    letterSpacing: 0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    lineHeight: 1.5,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(7, 0, 0, 7),
                                                                              child: RichText(
                                                                                textScaler: MediaQuery.of(context).textScaler,
                                                                                text: TextSpan(
                                                                                  children: [
                                                                                    TextSpan(
                                                                                      text: '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatNumber(
                                                                                        functions.currencyConversion(FFAppState().currencyRate, getJsonField(
                                                                                          selectDesgnItem,
                                                                                          r'''$.designgrp[2].price''',
                                                                                        ).toString()),
                                                                                        formatType: FormatType.decimal,
                                                                                        decimalType: DecimalType.periodDecimal,
                                                                                      )}',
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 14,
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Montserrat',
                                                                                    fontSize: 14,
                                                                                    letterSpacing: 0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                                ),
                                                                                maxLines: 2,
                                                                              ),
                                                                            ),
                                                                          ].divide(SizedBox(height: 12)),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    } else {
                                                      return Builder(
                                                        builder: (context) {
                                                          final selectDesgn = OtherProductsDetailsCall.yantraproductvariantdata(
                                                                containerOtherProductsDetailsResponse?.jsonBody,
                                                              )?.toList() ?? [];
                                                          return SingleChildScrollView(
                                                            scrollDirection: Axis.horizontal,
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.max,
                                                              children: List.generate(
                                                                  selectDesgn.length, (selectDesgnIndex) {
                                                                    final selectDesgnItem = selectDesgn[selectDesgnIndex];
                                                                    return InkWell(
                                                                      splashColor: Colors.transparent,
                                                                      focusColor: Colors.transparent,
                                                                      hoverColor: Colors.transparent,
                                                                      highlightColor: Colors.transparent,
                                                                      onTap: () async {
                                                                        _model.selecteddesign = !_model.selecteddesign;
                                                                        setState(() {});
                                                                        _model.selectedyantratdesign = selectDesgnIndex;
                                                                        _model.designprice = OtherProductsDetailsCall.dataproductvariantdata3designgrpprice(
                                                                          containerOtherProductsDetailsResponse?.jsonBody,
                                                                        )?[_model.selectedyantratdesign!];
                                                                        _model.selecteddesignid = getJsonField(
                                                                          selectDesgnItem, r'''$.designgrp[3].id''',
                                                                        );
                                                                        setState(() {});
                                                                      },
                                                                      child: Container(
                                                                        width: 114,
                                                                        height: 222,
                                                                        decoration: BoxDecoration(
                                                                          color: _model.selectedyantratdesign == selectDesgnIndex
                                                                              ? Color(0x26740074)
                                                                              : FlutterFlowTheme.of(context).secondaryBackground,
                                                                          borderRadius: BorderRadius.circular(5),
                                                                          border: Border.all(
                                                                            color: _model.selectedyantratdesign == selectDesgnIndex
                                                                                ? Color(0xFF740074)
                                                                                : FlutterFlowTheme.of(context).secondaryBackground,
                                                                          ),
                                                                        ),
                                                                        child: Column(
                                                                          mainAxisSize: MainAxisSize.max,
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(7, 4, 7, 4),
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                child: Image.network(
                                                                                  getJsonField(selectDesgnItem,
                                                                                    r'''$.designgrp[3].image''',).toString(),
                                                                                  width: 100,
                                                                                  height: 120,
                                                                                  fit: BoxFit.contain,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(7, 0, 0, 0),
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: 42,
                                                                                decoration: BoxDecoration(),
                                                                                child: AutoSizeText(
                                                                                  getJsonField(
                                                                                    selectDesgnItem,
                                                                                    r'''$.designgrp[3].name''',).toString(),
                                                                                  maxLines: 2,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Montserrat',
                                                                                    fontSize: 13,
                                                                                    letterSpacing: 0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    lineHeight: 1.5,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(7, 0, 0, 7),
                                                                              child:
                                                                              RichText(
                                                                                textScaler: MediaQuery.of(context).textScaler,
                                                                                text: TextSpan(
                                                                                  children: [
                                                                                    TextSpan(
                                                                                      text: '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatNumber(
                                                                                        functions.currencyConversion(FFAppState().currencyRate, getJsonField(
                                                                                          selectDesgnItem,
                                                                                          r'''$.designgrp[3].price''',
                                                                                        ).toString()),
                                                                                        formatType: FormatType.decimal,
                                                                                        decimalType: DecimalType.periodDecimal,
                                                                                      )}',
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 14,
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Montserrat',
                                                                                    fontSize: 14,
                                                                                    letterSpacing: 0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                                ),
                                                                                maxLines: 2,
                                                                              ),
                                                                            ),
                                                                          ].divide(SizedBox(height: 12)),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    }
                                                  },*/
                                                ),
                                                theme: ExpandableThemeData(
                                                  tapHeaderToExpand: true,
                                                  tapBodyToExpand: false,
                                                  tapBodyToCollapse: false,
                                                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                                                  hasIcon: true,
                                                  expandIcon: Icons.keyboard_arrow_down,
                                                  collapseIcon: Icons.keyboard_arrow_up_sharp,
                                                  iconColor: FlutterFlowTheme.of(context).primaryText,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (OtherProductsDetailsCall.yantraproductVariantStatus(
                                  containerOtherProductsDetailsResponse?.jsonBody,
                                ) == true)
                                  Divider(
                                    height: 2,
                                    thickness: 1.5,
                                    color: Color(0xFFE7E7E8),
                                  ),
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 16, 0, 16),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Quantity',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 14,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius: BorderRadius.circular(8),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Colors.transparent,
                                            width: 2,
                                          ),
                                        ),
                                        child: FlutterFlowCountController(
                                          decrementIconBuilder: (enabled) => FaIcon(
                                            FontAwesomeIcons.minus,
                                            color: enabled
                                                ? FlutterFlowTheme.of(context)
                                                .primaryText
                                                : FlutterFlowTheme.of(context)
                                                .alternate,
                                            size: 15,
                                          ),
                                          incrementIconBuilder: (enabled) => FaIcon(
                                            FontAwesomeIcons.plus,
                                            color: enabled
                                                ? FlutterFlowTheme.of(context)
                                                .primaryText
                                                : FlutterFlowTheme.of(context)
                                                .alternate,
                                            size: 15,
                                          ),
                                          countBuilder: (count) => Text(
                                            count.toString(),
                                            style: FlutterFlowTheme.of(context)
                                                .titleLarge
                                                .override(
                                              fontFamily: 'Outfit',
                                              fontSize: 15,
                                              letterSpacing: 30,
                                            ),
                                          ),
                                          count: _model.countControllerValue ??= 1,
                                          updateCount: (count) => setState(() =>
                                          _model.countControllerValue = count),
                                          stepSize: 1,
                                          minimum: 1,
                                          maximum: 5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 2,
                                  thickness: 1.5,
                                  color: Color(0xFFE7E7E8),
                                ),
                                if (OtherProductsDetailsCall.out_of_stock(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                ) == false)
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(16, 10, 0, 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        // Generated code for this ConditionalBuilder Widget...
                                        Builder(
                                          builder: (context) {
                                            if (OtherProductsDetailsCall.yantraproductVariantStatus(
                                              containerOtherProductsDetailsResponse?.jsonBody,
                                            ) == true) {
                                              return Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                                child: RichText(
                                                  textScaler: MediaQuery.of(context).textScaler,
                                                  text: TextSpan(
                                                    children: [
                                                      /*TextSpan(
                                                      text: '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
                                                        fontSize: 18,
                                                        letterSpacing: 0,
                                                        fontWeight: FontWeight.w600,
                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                      ),
                                                    ),*/
                                                      TextSpan(
                                                        text: /*valueOrDefault<String>(
                                                        OtherProductsDetailsCall.productVariantStatus(containerOtherProductsDetailsResponse.jsonBody,
                                                      ) == true
                                                          ? ' ${formatNumber(
                                                        (functions.currencyConversion(
                                                          FFAppState().currencyRate,
                                                          (OtherProductsDetailsCall.productvariantdatasellingprice(
                                                            containerOtherProductsDetailsResponse.jsonBody,)
                                                          ![_model.selectvariationindex!] +
                                                              (_model.designprice!) +
                                                              (_model.energizationprice!) *
                                                                  (_model.countControllerValue!),).toString(),
                                                        )),
                                                        formatType: FormatType.decimal,
                                                        decimalType: DecimalType.automatic,
                                                      )}' : OtherProductsDetailsCall.otherProductsellingprice(containerOtherProductsDetailsResponse.jsonBody,
                                                      ), '0000',),*/

                                                        '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatNumber(
                                                          functions.currencyConversion(FFAppState().currencyRate, ((OtherProductsDetailsCall.yantravariantdatasellingprice(
                                                            containerOtherProductsDetailsResponse?.jsonBody,)
                                                          ![_model.selectvariationindex!] +
                                                              (_model.designprice!) +
                                                              (_model.energizationprice!)) *
                                                              (_model.countControllerValue!)).toString()),
                                                          formatType: FormatType.decimal,
                                                          decimalType: DecimalType.periodDecimal,
                                                        )}',

                                                        /*text: valueOrDefault<String>(
                                                        OtherProductsDetailsCall.productVariantStatus(containerOtherProductsDetailsResponse.jsonBody,
                                                             ) == true
                                                            ? formatNumber(
                                                                (OtherProductsDetailsCall.productvariantdatasellingprice(
                                                                  containerOtherProductsDetailsResponse.jsonBody,)
                                                                ![_model.selectvariationindex!] +
                                                                        (_model.designprice!) +
                                                                        (_model.energizationprice!)) *
                                                                    (_model.countControllerValue!),
                                                                formatType: FormatType.decimal,
                                                                decimalType: DecimalType.periodDecimal,
                                                              )
                                                            : OtherProductsDetailsCall.otherProductsellingprice(containerOtherProductsDetailsResponse.jsonBody,
                                                              ), '0000',
                                                      ),*/
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 18,
                                                        ),
                                                      )
                                                    ],
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 18,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  maxLines: 2,
                                                ),
                                              );
                                            } else {
                                              return Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                                child: RichText(
                                                  textScaler: MediaQuery.of(context).textScaler,
                                                  text: TextSpan(
                                                    children: [
                                                      /*TextSpan(
                                                      text: 'INR ',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
                                                        fontSize: 18,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                      ),
                                                    ),*/
                                                      TextSpan(
                                                        text: /*((functions.stringtoIntFunction(OtherProductsDetailsCall.otherProductsellingprice(
                                                                containerOtherProductsDetailsResponse.jsonBody,
                                                      ))!) + (_model.energizationprice!)).toString(),*/
                                                        '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatNumber(
                                                          functions.currencyConversion(FFAppState().currencyRate, ((functions.stringtoIntFunction(OtherProductsDetailsCall.yantraProductsellingprice(
                                                            containerOtherProductsDetailsResponse?.jsonBody,
                                                          ))!) + (_model.energizationprice!)).toString()),
                                                          formatType: FormatType.decimal,
                                                          decimalType: DecimalType.periodDecimal,
                                                        )* (_model.countControllerValue!)}',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 18,
                                                        ),
                                                      )
                                                    ],
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 18,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  maxLines: 2,
                                                ),
                                                /*RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: '${valueOrDefault<String>(FFAppState().currencyName, 'INR')}',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
                                                        fontSize: 18,
                                                        letterSpacing: 0,
                                                        fontWeight: FontWeight.w600,
                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ' ${formatNumber(
                                                        (functions.currencyConversion(
                                                          FFAppState().currencyRate,
                                                          (functions.stringtoIntFunction(
                                                            OtherProductsDetailsCall.otherProductsellingprice(
                                                              containerOtherProductsDetailsResponse.jsonBody,
                                                            ),
                                                          )! + (_model.energizationprice!)).toString(),
                                                        )),
                                                        formatType: FormatType.decimal,
                                                        decimalType: DecimalType.automatic,
                                                      )}',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
                                                        fontSize: 18,
                                                        letterSpacing: 0,
                                                        fontWeight: FontWeight.w600,
                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                maxLines: 2,
                                              ),*/
                                              );
                                            }
                                          },
                                        ),
                                        Text(
                                          '(Inc all taxes)',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (OtherProductsDetailsCall.out_of_stock(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                ) == true)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 8, 16, 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () async {
                                            final Uri phoneLaunchUri = Uri(
                                              scheme: 'tel',
                                              path: '+917021180033', // replace with your phone number
                                            );
                                            if (await canLaunchUrl(phoneLaunchUri)) {
                                              await launchUrl(phoneLaunchUri);
                                            } else {
                                              throw 'Could not launch $phoneLaunchUri';
                                            }
                                          },
                                          text: 'Call Us',
                                          options: FFButtonOptions(
                                            height: 40,
                                            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                            iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                            color: FlutterFlowTheme.of(context).primary,
                                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                              fontFamily: 'Montserrat',
                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                              fontSize: 12,
                                              letterSpacing: 0,
                                            ),
                                            elevation: 0,
                                            borderSide: BorderSide(
                                              color: Color(0xFF740074),
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        FFButtonWidget(
                                          onPressed: () async {
                                            final Uri whatsappLaunchUri = Uri(
                                              scheme: 'https',
                                              host: 'api.whatsapp.com',
                                              path: '/send',
                                              queryParameters: {
                                                'phone': '919819111150',
                                                'text': 'I am interested in ${OtherProductsDetailsCall.productname(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                )} however it is out of stock. Kindly suggest an alternative.',
                                              },
                                            );

                                            if (await canLaunchUrl(whatsappLaunchUri)) {
                                              await launchUrl(whatsappLaunchUri, mode: LaunchMode.externalApplication);
                                            } else {
                                              throw 'Could not launch $whatsappLaunchUri';
                                            }
                                          },
                                          text: 'WHATSAPP',
                                          options: FFButtonOptions(
                                            height: 40,
                                            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                            iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                            color: FlutterFlowTheme.of(context).whatsapp,
                                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                              fontFamily: 'Montserrat',
                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                              fontSize: 12,
                                              letterSpacing: 0,
                                            ),
                                            elevation: 0,
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).whatsapp,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),

                                        FFButtonWidget(
                                          onPressed: () async {
                                            final Uri mailLaunchUri = Uri(
                                              scheme: 'mailto',
                                              path: 'contact@rudracentre.com,info@rudracentre.com', // replace with your email address
                                              queryParameters: {
                                                'subject': 'Product_Inquiry',
                                                'body':"I am interested in ${OtherProductsDetailsCall.productname(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                )} however it is out of stock. Kindly suggest an alternative."
                                              },
                                            );
                                            if (await canLaunchUrl(mailLaunchUri)) {
                                              await launchUrl(mailLaunchUri);
                                            } else {
                                              throw 'Could not launch $mailLaunchUri';
                                            }
                                          },
                                          text: 'MAIL US',
                                          options: FFButtonOptions(
                                            height: 40,
                                            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                            iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                              fontFamily: 'Montserrat',
                                              color: FlutterFlowTheme.of(context).primary,
                                              fontSize: 12,
                                              letterSpacing: 0,
                                            ),
                                            elevation: 0,
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).primary,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),

                                Divider(
                                  height: 2,
                                  thickness: 1.5,
                                  color: Color(0xFFE7E7E8),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                                  child: Container(
                                    key: _YantraProductDetailsWidgetratingKey,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      color: Colors.white,
                                      child: ExpandableNotifier(
                                        controller: _model.expandableExpandableController3,
                                        child: ExpandablePanel(
                                          header: Text(
                                            'Ratings & Reviews',
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              fontSize: 14,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          collapsed: Container(),
                                          expanded: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      /*Padding(
                                                        padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0, 0, 10, 0),
                                                        child: RichText(
                                                          textScaler:
                                                          MediaQuery.of(context)
                                                              .textScaler,
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: _formattedRating(
                                                                  OtherProductsDetailsCall.productrating(containerOtherProductsDetailsResponse?.jsonBody),
                                                                ),
                                                                style: FlutterFlowTheme
                                                                    .of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                  fontFamily:
                                                                  'Montserrat',
                                                                  color: FlutterFlowTheme.of(
                                                                      context)
                                                                      .primaryText,
                                                                  fontSize: 24,
                                                                  letterSpacing:
                                                                  0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                ),
                                                              ),
                                                            ],
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Montserrat',
                                                              letterSpacing: 0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            'Overall Rating',
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
                                                          RichText(
                                                            textScaler:
                                                            MediaQuery.of(
                                                                context)
                                                                .textScaler,
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: valueOrDefault<String>(
                                                                    (OtherProductsDetailsCall.reviewdata(
                                                                      containerOtherProductsDetailsResponse?.jsonBody,
                                                                    ) as List).length.toString(),
                                                                    '0',
                                                                  ),
                                                                  style: FlutterFlowTheme
                                                                      .of(context)
                                                                      .bodyMedium
                                                                      .override(
                                                                    fontFamily:
                                                                    'Montserrat',
                                                                    fontSize:
                                                                    12,
                                                                    letterSpacing:
                                                                    0,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: ' Ratings',
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
                                                                fontSize: 12,
                                                                letterSpacing:
                                                                0,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),*/
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                                        child: (OtherProductsDetailsCall.reviewdata(containerOtherProductsDetailsResponse?.jsonBody) as List).isEmpty
                                                            ? Container(
                                                          padding: EdgeInsets.all(10.0),
                                                          decoration: BoxDecoration(
                                                            color: Colors.grey[300],
                                                            borderRadius: BorderRadius.circular(8.0),
                                                          ),
                                                          child: Container(
                                                            width: 200,
                                                            child: Center(
                                                              child: Text(
                                                                'Be the first to review this product!',
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Montserrat',
                                                                  color: Colors.black,
                                                                  fontSize: 14,
                                                                  letterSpacing: 0,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ) : RichText(
                                                          textScaler: MediaQuery.of(context).textScaler,
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: _formattedRating(
                                                                  OtherProductsDetailsCall.productrating(
                                                                    containerOtherProductsDetailsResponse?.jsonBody,
                                                                  ),
                                                                ),
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Montserrat',
                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                  fontSize: 24,
                                                                  letterSpacing: 0,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            ],
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Montserrat',
                                                              letterSpacing: 0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize: MainAxisSize.max,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          (OtherProductsDetailsCall.reviewdata(containerOtherProductsDetailsResponse?.jsonBody) as List).isEmpty
                                                              ? SizedBox.shrink() // Hide the Overall Rating text when there are no reviews
                                                              : Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Overall Rating',
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Montserrat',
                                                                  fontSize: 16,
                                                                  letterSpacing: 0,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                              RichText(
                                                                textScaler: MediaQuery.of(context).textScaler,
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: valueOrDefault<String>(
                                                                        (OtherProductsDetailsCall.reviewdata(containerOtherProductsDetailsResponse?.jsonBody) as List).length.toString(),
                                                                        '0',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Montserrat',
                                                                        fontSize: 12,
                                                                        letterSpacing: 0,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text: ' Ratings',
                                                                      style: TextStyle(),
                                                                    )
                                                                  ],
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    fontFamily: 'Montserrat',
                                                                    fontSize: 12,
                                                                    letterSpacing: 0,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  FFButtonWidget(
                                                    onPressed: () async {
                                                      print("Productid:${  OtherProductsDetailsCall
                                                          .productid(
                                                        containerOtherProductsDetailsResponse
                                                            ?.jsonBody,
                                                      )?.toString()}");
                                                      print("productMainType:${  OtherProductsDetailsCall
                                                          .productMainType(
                                                        containerOtherProductsDetailsResponse
                                                            ?.jsonBody,
                                                      )?.toString()}");

                                                      print("reviewcustomercomment:${  OtherProductsDetailsCall.reviewcustomercomment(
                                                        containerOtherProductsDetailsResponse?.jsonBody,
                                                      )}");
                                                      await showModalBottomSheet(
                                                        isScrollControlled: true,
                                                        backgroundColor: Colors.transparent,
                                                        enableDrag: false,
                                                        context: context,
                                                        builder: (context) {
                                                          return GestureDetector(
                                                            onTap: () => _model.unfocusNode.canRequestFocus
                                                                ? FocusScope.of(context)
                                                                .requestFocus(_model.unfocusNode)
                                                                : FocusScope.of(context).unfocus(),
                                                            child: Padding(
                                                              padding: MediaQuery.viewInsetsOf(context),
                                                              child: AddReviewPopUpWidget(
                                                                mainproducttype: serializeParam(
                                                                  OtherProductsDetailsCall
                                                                      .productMainType(
                                                                    containerOtherProductsDetailsResponse
                                                                        ?.jsonBody,
                                                                  )?.toString(),

                                                                  ParamType.String,
                                                                ),
                                                                productid: serializeParam(
                                                                  OtherProductsDetailsCall
                                                                      .productid(
                                                                    containerOtherProductsDetailsResponse
                                                                        ?.jsonBody,
                                                                  )?.toString(),
                                                                  ParamType.String,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ).then((value) => safeSetState(() {}));
                                                      /*   context.pushNamed(

                                                      'AddRatingDetails',
                                                      queryParameters: {
                                                        'mainproducttype': serializeParam(
                                                          OtherProductsDetailsCall
                                                              .rudrakshaMainProductType(
                                                            containerOtherProductsDetailsResponse
                                                                .jsonBody,
                                                          )?.toString(),

                                                          ParamType.String,
                                                        ),
                                                        'productid': serializeParam(
                                                          OtherProductsDetailsCall
                                                              .rudrakshaProductid(
                                                            containerOtherProductsDetailsResponse
                                                                .jsonBody,
                                                          )?.toString(),
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
                                                    },
                                                    text: 'Rate Now',
                                                    options: FFButtonOptions(
                                                      height: 40,
                                                      padding: EdgeInsetsDirectional
                                                          .fromSTEB(24, 0, 24, 0),
                                                      iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0, 0, 0, 0),
                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                        fontFamily: 'Montserrat',
                                                        color: FlutterFlowTheme.of(context).primary,
                                                        letterSpacing: 0,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                      elevation: 0,
                                                      borderSide: BorderSide(
                                                        color: Color(0xFF740074),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (OtherProductsDetailsCall.reviewdata(
                                                containerOtherProductsDetailsResponse?.jsonBody,
                                              ) != null &&
                                                  (OtherProductsDetailsCall.reviewdata(
                                                    containerOtherProductsDetailsResponse?.jsonBody,
                                                  ))!.isNotEmpty)
                                                Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [


                                                    RatingreviewWidget(
                                                      parameter1:  OtherProductsDetailsCall.Otherreviewcustomerstarrating(
                                                        containerOtherProductsDetailsResponse?.jsonBody,
                                                      )!,
                                                    ),

                                                    Text(
                                                      valueOrDefault<String>(
                                                        OtherProductsDetailsCall.Otherproductreviewcustomercomment(
                                                          containerOtherProductsDetailsResponse?.jsonBody,
                                                        ),
                                                        'x',
                                                      ),
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
                                                        color: Color(0xFF696969),
                                                        fontSize: 16,
                                                        letterSpacing: 0,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          valueOrDefault<String>(
                                                            OtherProductsDetailsCall.Otherproductreviewcustomername(
                                                              containerOtherProductsDetailsResponse?.jsonBody,
                                                            ),
                                                            'x',

                                                          ),
                                                          style: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Montserrat',
                                                            color:
                                                            Color(0xFF696969),
                                                            letterSpacing: 0,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                          ),
                                                        ),
                                                        SizedBox(width: 5),

                                                        Text(
                                                          valueOrDefault<String>(
                                                            OtherProductsDetailsCall.Otherproductreviewdate(
                                                              containerOtherProductsDetailsResponse?.jsonBody,
                                                            ) != null
                                                                ? formatDate(OtherProductsDetailsCall.Otherproductreviewdate(
                                                              containerOtherProductsDetailsResponse?.jsonBody,
                                                            )!) : 'x', 'x',
                                                          ),
                                                          style: FlutterFlowTheme.of(context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily: 'Montserrat',
                                                            color: Color(0xFF696969),
                                                            letterSpacing: 0,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: FFButtonWidget(
                                                        onPressed:(){
                                                          context.pushNamed(
                                                            'AllReviewsWidget',
                                                            queryParameters: {
                                                              'reviewlist': serializeParam(
                                                                OtherProductsDetailsCall.reviewdata(
                                                                  containerOtherProductsDetailsResponse
                                                                      ?.jsonBody,
                                                                ),
                                                                ParamType.JSON,
                                                                // isList: true,
                                                              ),
                                                              'productSlugValue': serializeParam(
                                                                widget.productSlugValue,
                                                                ParamType.String,
                                                              ),
                                                              'producttype': serializeParam(
                                                                widget.producttype,
                                                                ParamType.String,
                                                              ),

                                                            }.withoutNulls,
                                                          );
                                                        },
                                                        text: 'View All Reviews',
                                                        options: FFButtonOptions(
                                                          width: MediaQuery.sizeOf(context).width * 1,
                                                          height: 40,
                                                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                                          iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                          color: Color(0xFF740074),
                                                          textStyle: FlutterFlowTheme.of(context)
                                                              .titleSmall
                                                              .override(
                                                            fontFamily: 'Montserrat',
                                                            color: FlutterFlowTheme.of(context)
                                                                .secondaryBackground,
                                                            letterSpacing: 0,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          elevation: 0,
                                                          borderSide: BorderSide(
                                                            color: Color(0xFF740074),
                                                            width: 1,
                                                          ),
                                                          borderRadius: BorderRadius.circular(12),
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(SizedBox(height: 10)),
                                                ),
                                            ].divide(SizedBox(height: 8)),
                                          ),
                                          theme: ExpandableThemeData(
                                            tapHeaderToExpand: true,
                                            tapBodyToExpand: false,
                                            tapBodyToCollapse: false,
                                            headerAlignment:
                                            ExpandablePanelHeaderAlignment
                                                .center,
                                            hasIcon: true,
                                            expandIcon:
                                            Icons.keyboard_arrow_down_sharp,
                                            collapseIcon: Icons.keyboard_arrow_up,
                                            iconColor: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            iconPadding:
                                            EdgeInsets.fromLTRB(16, 16, 8, 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 4,
                                  thickness: 2,
                                  color: Color(0xFFE7E7E8),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 0, 30),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Related Products',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 14,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                                        child: Builder(
                                          builder: (context) {
                                            final relatedProduct = OtherProductsDetailsCall.yantraProductsimilarcategoryproduct(
                                              containerOtherProductsDetailsResponse?.jsonBody,
                                            )?.toList() ?? [];

                                            // Sort the list
                                            relatedProduct.sort((a, b) {
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

                                            return SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(relatedProduct.length, (relatedProductIndex) {
                                                  final relatedProductItem = relatedProduct[relatedProductIndex];
                                                  return InkWell(
                                                    splashColor: Colors.transparent,
                                                    focusColor: Colors.transparent,
                                                    hoverColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    onTap: () async {
                                                      if (widget.producttype == FFAppConstants.YantraMasterProductDetailsApi) {
                                                        context.pushNamed(
                                                          'YantraProductDetails',
                                                          queryParameters: {
                                                            'productSlugValue': serializeParam(
                                                              getJsonField(relatedProductItem,
                                                                r'''$.slug_value''',).toString(),
                                                              ParamType.String,
                                                            ),
                                                            'producttype': serializeParam(FFAppConstants.RudrakshaMasterProductDetailsApi,
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
                                                      } else {
                                                        context.pushNamed(
                                                          'YantraProductDetails',
                                                          queryParameters: {
                                                            'productSlugValue': serializeParam(
                                                              getJsonField(relatedProductItem,
                                                                r'''$.slug_value''',).toString(),
                                                              ParamType.String,
                                                            ),
                                                            'producttype': serializeParam(FFAppConstants.YantraMasterProductDetailsApi,
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
                                                        return;
                                                      }
                                                    },
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          width: 148,
                                                          height: 200,
                                                          decoration: BoxDecoration(
                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                          ),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius: BorderRadius.circular(10),
                                                                child: Image.network(
                                                                  getJsonField(relatedProductItem,
                                                                    r'''$.thumbnail_image''',).toString(),
                                                                  width: 152,
                                                                  height: 104,
                                                                  fit: BoxFit.contain,
                                                                ),
                                                              ),
                                                              Container(
                                                                width: double.infinity,
                                                                height: 50,
                                                                decoration: BoxDecoration(),
                                                                child: AutoSizeText(
                                                                  getJsonField(relatedProductItem,
                                                                    r'''$.product_name''',).toString(),
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    fontFamily: 'Montserrat',
                                                                    color: Color(0xFF696969),
                                                                    fontSize: 14,
                                                                    letterSpacing: 0,
                                                                    fontWeight: FontWeight.normal,
                                                                    lineHeight: 1.5,
                                                                  ),
                                                                ),
                                                              ),
                                                              RichText(
                                                                textScaler: MediaQuery.of(context).textScaler,
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(
                                                                        getJsonField(relatedProductItem,
                                                                          r'''$.selling_price''',).toString(), FFAppState().currencyRate,
                                                                      )}',
                                                                      style: TextStyle(
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 14,
                                                                      ),
                                                                    )
                                                                  ],
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    fontFamily: 'Montserrat',
                                                                    fontSize: 14,
                                                                    letterSpacing: 0,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                                maxLines: 2,
                                                              ),
                                                              Row(
                                                                mainAxisSize: MainAxisSize.max,
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius: BorderRadius.circular(0),
                                                                    child: Image.asset(
                                                                      'assets/images/Rating_Icon.png',
                                                                      width: 16,
                                                                      height: 16,
                                                                      fit: BoxFit.fill,
                                                                    ),
                                                                  ),
                                                                  RichText(
                                                                    textScaler: MediaQuery.of(context).textScaler,
                                                                    text: TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:  getJsonField(relatedProductItem,
                                                                            r'''$.product_rating''',).toString(),
                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            fontFamily: 'Montserrat',
                                                                            letterSpacing: 0,
                                                                            fontWeight: FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Montserrat',
                                                                        letterSpacing: 0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ].divide(SizedBox(width: 5)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        if (getJsonField(relatedProductItem, r'''$.out_of_stock''').toString() == 'true')
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
                                                                  child: Text("OUT OF STOCK",
                                                                    style: TextStyle(color: Colors.white),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        if (getJsonField(relatedProductItem, r'''$.reserved''').toString() == 'true')
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
                                                                  child: Text("RESERVED",
                                                                    style: TextStyle(color: Colors.white),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  );
                                                }).divide(SizedBox(width: 16)),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 12)),
                                  ),
                                ),
                                Divider(
                                  height: 10,
                                  thickness: 2,
                                  color: Color(0xFFE7E7E8),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                  color: Colors.white, // Set the background color to white
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                    children: [
                      if (OtherProductsDetailsCall.out_of_stock(
                        containerOtherProductsDetailsResponse?.jsonBody,
                      ) == false)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                          child: Container(
                            height: 60, // Adjust as needed
                            width: double.infinity,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /*FFButtonWidget(
                                    onPressed: () async {
                                      var _shouldSetState = false;
                                      if (currentAuthenticationToken != null &&
                                          currentAuthenticationToken != '') {
                                        FFAppState().buynow = false;
                                        if (OtherProductsDetailsCall
                                            .productVariantStatus(
                                          containerOtherProductsDetailsResponse
                                              ?.jsonBody,
                                        ) ==
                                            true) {
                                          _model.apiResultj7i =
                                          await AddToCartCall.call(
                                            hosturl: FFAppConstants.sanityurl,
                                            token: currentAuthenticationToken,
                                            productid: OtherProductsDetailsCall
                                                .productid(
                                              containerOtherProductsDetailsResponse
                                                  ?.jsonBody,
                                            )?.toString(),
                                            productType:
                                            OtherProductsDetailsCall
                                                .productMainType(
                                              containerOtherProductsDetailsResponse
                                                  ?.jsonBody,
                                            )?.toString(),
                                            productvariation:
                                            OtherProductsDetailsCall
                                                .productVariantStatus(
                                              containerOtherProductsDetailsResponse
                                                  ?.jsonBody,
                                            ),
                                            productvariationId:
                                            OtherProductsDetailsCall
                                                .productVariantStatus(
                                              containerOtherProductsDetailsResponse
                                                  ?.jsonBody,
                                            ) ==
                                                true
                                                ? (OtherProductsDetailsCall
                                                .otherproductvariantdataid(
                                              containerOtherProductsDetailsResponse
                                                  ?.jsonBody,
                                            )?[_model
                                                .selectedVariatoinindex!])
                                                : 0,
                                            quantity: _model
                                                .countControllerValue
                                                ?.toString(),
                                          );
                                          _shouldSetState = true;
                                          if ((_model.apiResultj7i?.succeeded ??
                                              true)) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  getJsonField(
                                                    (_model.apiResultj7i
                                                        ?.jsonBody ??
                                                        ''),
                                                    r'''$.msg''',
                                                  ).toString(),
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(context).containerFillColor,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                            );
                                            _model.otherproductid =
                                                OtherProductsDetailsCall
                                                    .productid(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                );
                                            _model.otherproductvarientstattus =
                                                OtherProductsDetailsCall
                                                    .productVariantStatus(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                );
                                            _model.otherproductmaintype =
                                                OtherProductsDetailsCall
                                                    .productMainType(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                );
                                            setState(() {});
                                            if (getJsonField(
                                              (_model.apiResultj7i
                                                  ?.jsonBody ??
                                                  ''),
                                              r'''$.status''',
                                            ).toString() !=
                                                "failed")
                                              await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                Colors.transparent,
                                                enableDrag: false,
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
                                                      padding: MediaQuery
                                                          .viewInsetsOf(
                                                          context),
                                                      child: MyCartWidget(),
                                                    ),
                                                  );
                                                },
                                              ).then((value) =>
                                                  safeSetState(() {}));
                                          } else {
                                            _model.apiResultj7i =
                                            await OtherSinglePriceAddToCartCall
                                                .call(
                                              hosturl: FFAppConstants.sanityurl,
                                              token: currentAuthenticationToken,
                                              productid:
                                              OtherProductsDetailsCall
                                                  .productid(
                                                containerOtherProductsDetailsResponse
                                                    ?.jsonBody,
                                              )?.toString(),
                                              productType:
                                              OtherProductsDetailsCall
                                                  .productMainType(
                                                containerOtherProductsDetailsResponse
                                                    ?.jsonBody,
                                              )?.toString(),
                                              quantity: _model
                                                  .countControllerValue
                                                  ?.toString(),
                                            );
                                            _shouldSetState = true;
                                            if ((_model
                                                .apiResultj7i?.succeeded ??
                                                true)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    getJsonField(
                                                      (_model.apiResultj7i
                                                          ?.jsonBody ??
                                                          ''),
                                                      r'''$.msg''',
                                                    ).toString(),
                                                    style: TextStyle(
                                                      color: FlutterFlowTheme.of(context).containerFillColor,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              );
                                              _model.otherproductid =
                                                  OtherProductsDetailsCall
                                                      .productid(
                                                    containerOtherProductsDetailsResponse
                                                        ?.jsonBody,
                                                  );
                                              _model.otherproductvarientstattus =
                                                  OtherProductsDetailsCall
                                                      .productVariantStatus(
                                                    containerOtherProductsDetailsResponse
                                                        ?.jsonBody,
                                                  );
                                              _model.otherproductmaintype =
                                                  OtherProductsDetailsCall
                                                      .productMainType(
                                                    containerOtherProductsDetailsResponse
                                                        ?.jsonBody,
                                                  );
                                              setState(() {});
                                              if (getJsonField(
                                                (_model.apiResultj7i
                                                    ?.jsonBody ??
                                                    ''),
                                                r'''$.status''',
                                              ).toString() !=
                                                  "failed")
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                  Colors.transparent,
                                                  enableDrag: false,
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
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                            context),
                                                        child: MyCartWidget(),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    safeSetState(() {}));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    (_model.apiResultj7i
                                                        ?.statusCode ??
                                                        200)
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: FlutterFlowTheme.of(context).containerFillColor,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              );
                                              if (_shouldSetState)
                                                setState(() {});
                                              return;
                                            }
                                            if (_shouldSetState)
                                              setState(() {});
                                          }
                                          if (_shouldSetState) setState(() {});
                                        } else {
                                          _model.apiResultj7i =
                                          await OtherSinglePriceAddToCartCall
                                              .call(
                                            hosturl: FFAppConstants.sanityurl,
                                            token: currentAuthenticationToken,
                                            productid: OtherProductsDetailsCall
                                                .productid(
                                              containerOtherProductsDetailsResponse
                                                  ?.jsonBody,
                                            )?.toString(),
                                            productType:
                                            OtherProductsDetailsCall
                                                .productMainType(
                                              containerOtherProductsDetailsResponse
                                                  ?.jsonBody,
                                            )?.toString(),
                                            quantity: _model
                                                .countControllerValue
                                                ?.toString(),
                                          );
                                          _shouldSetState = true;
                                          if ((_model.apiResultj7i?.succeeded ??
                                              true)) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  getJsonField(
                                                    (_model.apiResultj7i
                                                        ?.jsonBody ??
                                                        ''),
                                                    r'''$.msg''',
                                                  ).toString(),
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(context).containerFillColor,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                            );
                                            _model.otherproductid =
                                                OtherProductsDetailsCall
                                                    .productid(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                );
                                            _model.otherproductvarientstattus =
                                                OtherProductsDetailsCall
                                                    .productVariantStatus(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                );
                                            _model.otherproductmaintype =
                                                OtherProductsDetailsCall
                                                    .productMainType(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                );
                                            setState(() {});
                                            if (getJsonField(
                                              (_model.apiResultj7i
                                                  ?.jsonBody ??
                                                  ''),
                                              r'''$.status''',
                                            ).toString() !=
                                                "failed")
                                              await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                Colors.transparent,
                                                enableDrag: false,
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
                                                      child: MyCartWidget(),
                                                    ),
                                                  );
                                                },
                                              ).then(
                                                      (value) => safeSetState(() {}));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  (_model.apiResultj7i
                                                      ?.statusCode ??
                                                      200)
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(context).containerFillColor,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                            );
                                            if (_shouldSetState)
                                              setState(() {});
                                            return;
                                          }
                                          if (_shouldSetState) setState(() {});
                                        }
                                      } else {
                                        context.pushNamed(
                                          'LoginPage',
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                              PageTransitionType.fade,
                                              duration:
                                              Duration(milliseconds: 0),
                                            ),
                                          },
                                        );
                                      }
                                    },

                                    text: 'Add to Cart',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.44,
                                      height: 40,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24, 0, 24, 0),
                                      iconPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF740074),
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      elevation: 0,
                                      borderSide: BorderSide(
                                        color: Color(0xFF740074),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    showLoadingIndicator: false,
                                  ),*/
                                FFButtonWidget(
                                  onPressed: () async {
                                    if (currentAuthenticationToken != null && currentAuthenticationToken != '') {
                                      setState(() {
                                        _isLoading = true; // Set loading state to true when API call starts
                                      });

                                      // Perform API call and handle response
                                      var result;
                                      if (OtherProductsDetailsCall.productVariantStatus(
                                        containerOtherProductsDetailsResponse?.jsonBody,
                                      ) == true) {
                                        result = await AddToCartCall.call(
                                          hosturl: FFAppConstants.sanityurl,
                                          token: currentAuthenticationToken,
                                          productid: OtherProductsDetailsCall.productid(
                                            containerOtherProductsDetailsResponse?.jsonBody,
                                          )?.toString(),
                                          productType: OtherProductsDetailsCall.productMainType(
                                            containerOtherProductsDetailsResponse?.jsonBody,
                                          )?.toString(),
                                          productvariation: OtherProductsDetailsCall.productVariantStatus(
                                            containerOtherProductsDetailsResponse?.jsonBody,
                                          ),
                                          productvariationId: OtherProductsDetailsCall.productVariantStatus(
                                            containerOtherProductsDetailsResponse?.jsonBody,
                                          ) == true
                                              ? (OtherProductsDetailsCall.otherproductvariantdataid(
                                            containerOtherProductsDetailsResponse?.jsonBody,
                                          )?[_model.selectedCertificationindex!])
                                              : 0,
                                          quantity: _model.countControllerValue?.toString(),
                                          design: _model.selecteddesignid,
                                        );
                                      } else {
                                        result = await OtherSinglePriceAddToCartCall.call(
                                          hosturl: FFAppConstants.sanityurl,
                                          token: currentAuthenticationToken,
                                          productid: OtherProductsDetailsCall.productid(
                                            containerOtherProductsDetailsResponse?.jsonBody,
                                          )?.toString(),
                                          productType: OtherProductsDetailsCall.productMainType(
                                            containerOtherProductsDetailsResponse?.jsonBody,
                                          )?.toString(),
                                          quantity: _model.countControllerValue?.toString(),
                                        );
                                      }

                                      setState(() {
                                        _isLoading = false; // Set loading state to false when API call completes
                                      });

                                      if ((result?.succeeded ?? false)) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              getJsonField(result?.jsonBody ?? '', r'''$.msg''').toString(),
                                              //'Product added in Cart',
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).containerFillColor,
                                              ),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: FlutterFlowTheme.of(context).primary,
                                          ),
                                        );
                                        _model.otherproductid = OtherProductsDetailsCall.productid(
                                          containerOtherProductsDetailsResponse?.jsonBody,
                                        );
                                        _model.otherproductvarientstattus = OtherProductsDetailsCall.productVariantStatus(
                                          containerOtherProductsDetailsResponse?.jsonBody,
                                        );
                                        _model.otherproductmaintype = OtherProductsDetailsCall.productMainType(
                                          containerOtherProductsDetailsResponse?.jsonBody,
                                        );
                                        setState(() {});
                                        if (getJsonField(result?.jsonBody ?? '', r'''$.status''').toString() != "failed") {
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
                                                  child: MyCartWidget(),
                                                ),
                                              );
                                            },
                                          ).then((value) => safeSetState(() {}));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              (result?.statusCode ?? 200).toString(),
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).containerFillColor,
                                              ),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: FlutterFlowTheme.of(context).primary,
                                          ),
                                        );
                                      }
                                    } else {
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
                                    }
                                  },
                                  text: 'Add to Cart',
                                  options: FFButtonOptions(
                                    width: MediaQuery.sizeOf(context).width * 0.44,
                                    height: 40,
                                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF740074),
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    elevation: 0,
                                    borderSide: BorderSide(
                                      color: Color(0xFF740074),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  showLoadingIndicator: _isLoading, // Show loading indicator based on the state
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    if (currentAuthenticationToken != null &&
                                        currentAuthenticationToken != '') {

                                      FFAppState().productid =
                                          OtherProductsDetailsCall
                                              .productid(
                                            containerOtherProductsDetailsResponse
                                                ?.jsonBody,
                                          ).toString();
                                      FFAppState().productvariationId =OtherProductsDetailsCall
                                          .productVariantDataId(
                                        containerOtherProductsDetailsResponse
                                            ?.jsonBody,
                                      )?[_model.selectedVariatoinindex!];
                                      FFAppState().productType =
                                          OtherProductsDetailsCall
                                              .productMainType(
                                            containerOtherProductsDetailsResponse
                                                ?.jsonBody,
                                          ).toString();

                                      FFAppState().productvariation =
                                          OtherProductsDetailsCall
                                              .productVariantStatus(
                                            containerOtherProductsDetailsResponse
                                                ?.jsonBody,
                                          );
                                      print(FFAppState().productvariation);

                                      FFAppState().quantity = _model
                                          .countControllerValue!
                                          .toString();


                                      print(
                                          "FFAppState().selectedCertificationId ${FFAppState().selectedCertificationId}");


                                      FFAppState().buynow = true;
                                      print("FFAppState().buynow ${FFAppState().buynow}");
                                      print("FFAppState().quantity ${FFAppState().quantity}");
                                      print("FFAppState().productvariation ${FFAppState().productvariation}");
                                      print("FFAppState().productType ${FFAppState().productType}");
                                      print("FFAppState().productvariationId ${FFAppState().productvariationId}");
                                      print("FFAppState().productid ${FFAppState().productid}");

                                      context.pushNamed(
                                        'DeliveryAddress',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey:
                                          const TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                            PageTransitionType
                                                .bottomToTop,
                                            duration:
                                            Duration(milliseconds: 400),
                                          ),
                                        },
                                      );


                                      print('Button pressed ...');
                                    } else {
                                      context.pushNamed(
                                        'LoginPage',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                            PageTransitionType.fade,
                                            duration:
                                            Duration(milliseconds: 0),
                                          ),
                                        },
                                      );
                                    }
                                  },
                                  text: 'Buy Now',
                                  options: FFButtonOptions(
                                    width: MediaQuery.sizeOf(context).width *
                                        0.44,
                                    height: 40,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24, 0, 24, 0),
                                    iconPadding:
                                    EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    color: Color(0xFF740074),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    elevation: 0,
                                    borderSide: BorderSide(
                                      color: Color(0xFF740074),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (OtherProductsDetailsCall.out_of_stock(
                          containerOtherProductsDetailsResponse?.jsonBody) == true)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {
                                  final Uri phoneLaunchUri = Uri(
                                    scheme: 'tel',
                                    path: '+917021180033', // replace with your phone number
                                  );
                                  if (await canLaunchUrl(phoneLaunchUri)) {
                                    await launchUrl(phoneLaunchUri);
                                  } else {
                                    throw 'Could not launch $phoneLaunchUri';
                                  }
                                },
                                text: 'Call Us',
                                options: FFButtonOptions(
                                  height: 40,
                                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                    fontSize: 12,
                                    letterSpacing: 0,
                                  ),
                                  elevation: 0,
                                  borderSide: BorderSide(
                                    color: Color(0xFF740074),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  final Uri whatsappLaunchUri = Uri(
                                    scheme: 'https',
                                    host: 'api.whatsapp.com',
                                    path: '/send',
                                    queryParameters: {
                                      'phone': '919819111150',
                                      'text': 'I am interested in ${OtherProductsDetailsCall.productname(
                                        containerOtherProductsDetailsResponse
                                            ?.jsonBody,
                                      )} however it is out of stock. Kindly suggest an alternative.',
                                    },
                                  );

                                  if (await canLaunchUrl(whatsappLaunchUri)) {
                                    await launchUrl(whatsappLaunchUri, mode: LaunchMode.externalApplication);
                                  } else {
                                    throw 'Could not launch $whatsappLaunchUri';
                                  }
                                },
                                text: 'WHATSAPP',
                                options: FFButtonOptions(
                                  height: 40,
                                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  color: FlutterFlowTheme.of(context).whatsapp,
                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                    fontSize: 12,
                                    letterSpacing: 0,
                                  ),
                                  elevation: 0,
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).whatsapp,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),

                              FFButtonWidget(
                                onPressed: () async {
                                  final Uri mailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: 'contact@rudracentre.com,info@rudracentre.com', // replace with your email address
                                    queryParameters: {
                                      'subject': 'Product_Inquiry',
                                      'body':"I am interested in ${OtherProductsDetailsCall.productname(
                                        containerOtherProductsDetailsResponse
                                            ?.jsonBody,
                                      )} however it is out of stock. Kindly suggest an alternative."
                                    },
                                  );
                                  if (await canLaunchUrl(mailLaunchUri)) {
                                    await launchUrl(mailLaunchUri);
                                  } else {
                                    throw 'Could not launch $mailLaunchUri';
                                  }
                                },
                                text: 'MAIL US',
                                options: FFButtonOptions(
                                  height: 40,
                                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 12,
                                    letterSpacing: 0,
                                  ),
                                  elevation: 0,
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),


                            ],
                          ),
                        ),
                    ]
                ),
              ),
            ),
          ]
      ),
    );
  }
}
