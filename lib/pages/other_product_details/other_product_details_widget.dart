import 'package:cached_network_image/cached_network_image.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../auth/custom_auth/auth_util.dart';
import '../../components/AddReviewPopUp_Widget.dart';
import '../../components/custom_nav_bar_widget.dart';
import '../../components/ratingreview_widget.dart';
import '../../components/shimmer_widget.dart';
import '../../custom_code/image_zoom_screen.dart';
import '../../custom_code/product_images.dart';
import '../../flutter_flow/custom_functions.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/my_cart/my_cart_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'other_product_details_model.dart';
export 'other_product_details_model.dart';

class OtherProductDetailsWidget extends StatefulWidget {
  const OtherProductDetailsWidget({
    super.key,
    this.productSlugValue,
    this.outofstockValue = false,  // Default value set here
    required this.isFromPaymentScreen,
    required this.cartId,
  });

  final String? productSlugValue;
  final bool? outofstockValue;
  final bool isFromPaymentScreen;
  final int? cartId;

  @override
  State<OtherProductDetailsWidget> createState() => _OtherProductDetailsWidgetState();
}

class _OtherProductDetailsWidgetState extends State<OtherProductDetailsWidget> {
  late OtherProductDetailsModel _model;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _OtherProductDetailsWidgetratingKey = GlobalKey();
  final OtherProductDetailsWidgetscaffoldKey = GlobalKey<ScaffoldState>();
  ApiCallResponse? containerOtherProductsDetailsResponse;
  bool isLoading = true;

  //For preselected values when navigate from payment screen after clicking "View Details"
  bool isLoadingForPreselection = false;
  ApiCallResponse? cartDataResponse;
  String? preSelectedVariation;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OtherProductDetailsModel());
    print("outofstockValue  ${widget.outofstockValue}");
    _model.expandableExpandableController1 = ExpandableController(initialExpanded: false);
    _model.expandableExpandableController2 = ExpandableController(initialExpanded: false);
    _fetchData();
    fetchCartData();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> fetchCartData() async {
    setState(() {
      isLoadingForPreselection = true;

      // Reset the variables to null or initial values before making a new API call
      preSelectedVariation = null;
      print('printing for checking...');
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
        String? newPreSelectedVariation = getJsonField(cartItem, r'''$.product_variation_name''').toString();

        setState(() {
          isLoadingForPreselection = false;
          // Update the state variables with the values from the matching cart item
          preSelectedVariation = newPreSelectedVariation;
          print('printing for checking...');
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

  Future<void> _fetchData() async {
    try {
      final response = await OtherProductsDetailsCall.call(
        sanityurl: FFAppConstants.sanityurl,
        producttype: FFAppConstants.OtherMasterProductDetailsApi,
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: OtherProductDetailsWidgetscaffoldKey,
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
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 5),
                  child: Container(
                    width: double.infinity,
                    //height: 48,
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
                    producttype: FFAppConstants.OtherMasterProductDetailsApi,
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

                    print("otherproductvariantdata: ${OtherProductsDetailsCall
                        .productvariantdataimageurlpath(
                      containerOtherProductsDetailsResponse
                          ?.jsonBody,
                    ) }");
                    print("otherproductimageurlpath: ${OtherProductsDetailsCall
                        .otherproductimageurlpath(
                      containerOtherProductsDetailsResponse
                          ?.jsonBody,
                    ) }");
                    print("otherproductname: ${OtherProductsDetailsCall
                        .otherproductname(
                      containerOtherProductsDetailsResponse
                          ?.jsonBody,
                    ) }");
                    print("otherproductnamecotherproductcode: ${OtherProductsDetailsCall
                        .cotherproductcode(
                      containerOtherProductsDetailsResponse
                          ?.jsonBody,
                    ) }");

                    /*   final otherSinglePrice = ((functions.stringtoIntFunction(
                        OtherProductsDetailsCall.otherProductsellingprice(
                          containerOtherProductsDetailsResponse.jsonBody,
                        ))!) * (_model .countControllerValue!));
                    print('Single Price: $otherSinglePrice');*//**/
                    /*print('otherProductsellingprice Price: ${OtherProductsDetailsCall.otherProductsellingprice(
                      containerOtherProductsDetailsResponse.jsonBody,
                    )}');*/
                    return Expanded(
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.85,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
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
                                        0, 0, 0, 0),
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
                                                            valueOrDefault<String>(
                                                              OtherProductsDetailsCall.otherproductvariantdata(
                                                                containerOtherProductsDetailsResponse?.jsonBody,
                                                              ) != null &&
                                                                  (OtherProductsDetailsCall.otherproductvariantdata(
                                                                    containerOtherProductsDetailsResponse?.jsonBody,
                                                                  ))!.isNotEmpty
                                                                  ? (OtherProductsDetailsCall.productvariantdataimageurlpath(
                                                                containerOtherProductsDetailsResponse?.jsonBody,
                                                              )?[_model.selectedVariatoinindex!])
                                                                  : OtherProductsDetailsCall.otherproductimageurlpath(
                                                                containerOtherProductsDetailsResponse?.jsonBody,
                                                              )?.first,
                                                              'xxxx',
                                                            ),
                                                          ),*/
                                                      imageZoomScreen(
                                                        imageUrls: OtherProductsDetailsCall.otherproductvariantdata(
                                                          containerOtherProductsDetailsResponse?.jsonBody,
                                                        ) != null &&
                                                            (OtherProductsDetailsCall.otherproductvariantdata(
                                                              containerOtherProductsDetailsResponse?.jsonBody,
                                                            ))!.isNotEmpty
                                                            ? OtherProductsDetailsCall.otherproductimageurlpath(
                                                            containerOtherProductsDetailsResponse?.jsonBody
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
                                                        fadeInDuration: Duration(milliseconds: 100),
                                                        fadeOutDuration: Duration(milliseconds: 100),
                                                        imageUrl: utf8.decode(
                                                          valueOrDefault<String>(
                                                            OtherProductsDetailsCall.otherproductvariantdata(
                                                              containerOtherProductsDetailsResponse?.jsonBody,
                                                            ) != null &&
                                                                (OtherProductsDetailsCall.otherproductvariantdata(
                                                                  containerOtherProductsDetailsResponse?.jsonBody,
                                                                ))!.isNotEmpty
                                                                ? (OtherProductsDetailsCall.productvariantdataimageurlpath(
                                                              containerOtherProductsDetailsResponse?.jsonBody,
                                                            )?[_model.selectedVariatoinindex!])
                                                                : OtherProductsDetailsCall.otherproductimageurlpath(
                                                              containerOtherProductsDetailsResponse?.jsonBody,
                                                            )?.first,
                                                            'xxxx',
                                                          ).codeUnits,
                                                          allowMalformed: true,
                                                        ),
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
                                                        ? OtherProductsDetailsCall.otherproductimageurlpath(
                                                        containerOtherProductsDetailsResponse?.jsonBody
                                                    )?.toList() ?? []
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
                                                        final productId = OtherProductsDetailsCall.productid(containerOtherProductsDetailsResponse?.jsonBody);

                                                        print(WishListCall.id(
                                                            containerWishlistResponse
                                                                .jsonBody));

                                                        print ("wishlistid");
                                                        print(OtherProductsDetailsCall
                                                            .productid(
                                                            containerOtherProductsDetailsResponse
                                                                ?.jsonBody));
                                                        if (!wishlistIds
                                                            .contains(
                                                          OtherProductsDetailsCall
                                                              .productid(
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
                                                                    OtherProductsDetailsCall.productid(
                                                                      containerOtherProductsDetailsResponse?.jsonBody,
                                                                    ),
                                                                    productType:
                                                                    OtherProductsDetailsCall.productMainType(
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
                                                                        backgroundColor: FlutterFlowTheme.of(context).primary,
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
                                                                  OtherProductsDetailsCall.productid(
                                                                    containerOtherProductsDetailsResponse?.jsonBody,
                                                                  ),
                                                                  productType:
                                                                  OtherProductsDetailsCall.productMainType(
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 16, 16, 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        valueOrDefault<String>(
                                          OtherProductsDetailsCall.otherproductname(
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
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                fontSize: 15,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text: valueOrDefault<String>(
                                                OtherProductsDetailsCall
                                                    .cotherproductcode(
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
                                              _model.expandableExpandableController2.expanded=true;
                                              _scrollController.animateTo(
                                                _OtherProductDetailsWidgetratingKey.currentContext!.findRenderObject()!.getTransformTo(null).getTranslation().y,
                                                duration: Duration(milliseconds: 300),
                                                curve: Curves.easeInOut,
                                              );
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
                                if (OtherProductsDetailsCall.otherproductvariantdata(
                                  containerOtherProductsDetailsResponse?.jsonBody,
                                ) != null &&
                                    (OtherProductsDetailsCall.otherproductvariantdata(
                                      containerOtherProductsDetailsResponse?.jsonBody,
                                    ))!.isNotEmpty)
                                  Divider(
                                    height: 5,
                                    thickness: 3,
                                    color: Color(0xFFE7E7E8),
                                  ),
                                if (OtherProductsDetailsCall.otherproductvariantdata(
                                  containerOtherProductsDetailsResponse?.jsonBody,
                                ) != null &&
                                    (OtherProductsDetailsCall.otherproductvariantdata(
                                      containerOtherProductsDetailsResponse?.jsonBody,))!.isNotEmpty)
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
                                                text: _model.selectedvariation ?? preSelectedVariation,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
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
                                            final selectVariation = OtherProductsDetailsCall.otherproductvariantdata(
                                              containerOtherProductsDetailsResponse?.jsonBody,
                                            )?.toList() ?? [];

                                            // Ensure preSelectedVariation is correctly handled on first render
                                            if (_model.selectedvariation == null && preSelectedVariation != null) {
                                              _model.selectedvariation = preSelectedVariation;
                                              _model.selectedVariatoinindex = selectVariation.indexWhere(
                                                    (item) => getJsonField(item, r'''$.variant_name''').toString() == preSelectedVariation,
                                              );
                                            }

                                            return SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(selectVariation.length, (selectVariationIndex) {
                                                  final selectVariationItem = selectVariation[selectVariationIndex];
                                                  final variantName = getJsonField(selectVariationItem, r'''$.variant_name''').toString();

                                                  final isSelected = variantName == (_model.selectedvariation ?? preSelectedVariation);

                                                  return InkWell(
                                                    splashColor: Colors.transparent,
                                                    focusColor: Colors.transparent,
                                                    hoverColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    onTap: () async {
                                                      setState(() {
                                                        // Update the selected variation when the user taps on a new variant
                                                        _model.selectedvariation = variantName;
                                                        _model.selectedVariatoinindex = selectVariationIndex;
                                                        preSelectedVariation = variantName; // Update the preSelectedVariation to the newly selected value
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 224,
                                                      height: 44,
                                                      decoration: BoxDecoration(
                                                        color: isSelected ? Color(0x26740074) : FlutterFlowTheme.of(context).secondaryBackground,
                                                        borderRadius: BorderRadius.circular(5),
                                                        border: Border.all(
                                                          color: isSelected ? Color(0xFF740074) : Color(0xFFE7E7E8),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.only(left: 15, right: 15),
                                                        child: Center(
                                                          child: AutoSizeText(
                                                            variantName,
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
                                                  );
                                                }).divide(SizedBox(width: 10)),
                                              ),
                                            );
                                          },
                                        ),
                                      ].divide(SizedBox(height: 10)),
                                    ),
                                  ),
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                  child: Container(
                                    decoration: BoxDecoration(),
                                  ),
                                ),
                                Divider(
                                  height: 5,
                                  thickness: 2,
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
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
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
                                  height: 4,
                                  thickness: 2,
                                  color: Color(0xFFE7E7E8),
                                ),

                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 10, 0, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Builder(
                                        builder: (context) {
                                          if (OtherProductsDetailsCall
                                              .otherproductvariantdata(
                                            containerOtherProductsDetailsResponse
                                                ?.jsonBody,
                                          ) !=
                                              null &&
                                              (OtherProductsDetailsCall
                                                  .otherproductvariantdata(
                                                containerOtherProductsDetailsResponse
                                                    ?.jsonBody,
                                              ))!
                                                  .isNotEmpty) {
                                            return Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 10, 0),
                                              child: RichText(
                                                textScaler: MediaQuery.of(context)
                                                    .textScaler,
                                                text: TextSpan(
                                                  children: [


                                                    TextSpan(
                                                      text:
                                                      '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatNumber(
                                                        functions.currencyConversion(FFAppState().currencyRate, ((valueOrDefault<int>(
                                                          OtherProductsDetailsCall.productvariantdatasellingprice(
                                                            containerOtherProductsDetailsResponse?.jsonBody,)?[_model.selectedVariatoinindex!], 00000,)) *
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
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
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
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 10, 0),
                                              child: RichText(
                                                textScaler: MediaQuery.of(context)
                                                    .textScaler,
                                                text: TextSpan(
                                                  children: [

                                                    TextSpan(
                                                      text:
                                                      '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatNumber(
                                                        functions.currencyConversion(
                                                            FFAppState().currencyRate,((functions.stringtoIntFunction(
                                                            OtherProductsDetailsCall.otherProductsellingprice(
                                                              containerOtherProductsDetailsResponse?.jsonBody,
                                                            ))!) * (_model .countControllerValue!)).toString()),
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

                                Divider(
                                  height: 4,
                                  thickness: 2,
                                  color: Color(0xFFE7E7E8),
                                ),
                                /*if (OtherProductsDetailsCall.out_of_stock(
                                  containerOtherProductsDetailsResponse.jsonBody,
                                ) == false)
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () async {
                                            var _shouldSetState = false;
                                            if (currentAuthenticationToken != null &&
                                                currentAuthenticationToken != '') {
                                              FFAppState().buynow = false;
                                              if (OtherProductsDetailsCall
                                                  .productVariantStatus(
                                                containerOtherProductsDetailsResponse
                                                    .jsonBody,
                                              ) ==
                                                  true) {
                                                _model.apiResultj7i =
                                                await AddToCartCall.call(
                                                  hosturl: FFAppConstants.sanityurl,
                                                  token: currentAuthenticationToken,
                                                  productid: OtherProductsDetailsCall
                                                      .productid(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
                                                  )?.toString(),
                                                  productType:
                                                  OtherProductsDetailsCall
                                                      .productMainType(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
                                                  )?.toString(),
                                                  productvariation:
                                                  OtherProductsDetailsCall
                                                      .productVariantStatus(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
                                                  ),
                                                  productvariationId:
                                                  OtherProductsDetailsCall
                                                      .productVariantStatus(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
                                                  ) ==
                                                      true
                                                      ? (OtherProductsDetailsCall
                                                      .otherproductvariantdataid(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
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
                                                            .jsonBody,
                                                      );
                                                  _model.otherproductvarientstattus =
                                                      OtherProductsDetailsCall
                                                          .productVariantStatus(
                                                        containerOtherProductsDetailsResponse
                                                            .jsonBody,
                                                      );
                                                  _model.otherproductmaintype =
                                                      OtherProductsDetailsCall
                                                          .productMainType(
                                                        containerOtherProductsDetailsResponse
                                                            .jsonBody,
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
                                                          .jsonBody,
                                                    )?.toString(),
                                                    productType:
                                                    OtherProductsDetailsCall
                                                        .productMainType(
                                                      containerOtherProductsDetailsResponse
                                                          .jsonBody,
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
                                                              .jsonBody,
                                                        );
                                                    _model.otherproductvarientstattus =
                                                        OtherProductsDetailsCall
                                                            .productVariantStatus(
                                                          containerOtherProductsDetailsResponse
                                                              .jsonBody,
                                                        );
                                                    _model.otherproductmaintype =
                                                        OtherProductsDetailsCall
                                                            .productMainType(
                                                          containerOtherProductsDetailsResponse
                                                              .jsonBody,
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
                                                        .jsonBody,
                                                  )?.toString(),
                                                  productType:
                                                  OtherProductsDetailsCall
                                                      .productMainType(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
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
                                                            .jsonBody,
                                                      );
                                                  _model.otherproductvarientstattus =
                                                      OtherProductsDetailsCall
                                                          .productVariantStatus(
                                                        containerOtherProductsDetailsResponse
                                                            .jsonBody,
                                                      );
                                                  _model.otherproductmaintype =
                                                      OtherProductsDetailsCall
                                                          .productMainType(
                                                        containerOtherProductsDetailsResponse
                                                            .jsonBody,
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
                                        ),
                                        FFButtonWidget(
                                          onPressed: () async {
                                            if (currentAuthenticationToken != null &&
                                                currentAuthenticationToken != '') {

                                              FFAppState().productid =
                                                  OtherProductsDetailsCall
                                                      .productid(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
                                                  ).toString();
                                              FFAppState().productvariationId =OtherProductsDetailsCall
                                                  .productVariantDataId(
                                                containerOtherProductsDetailsResponse
                                                    .jsonBody,
                                              )?[_model
                                                  .selectedVariatoinindex!];
                                              FFAppState().productType =
                                                  OtherProductsDetailsCall
                                                      .productMainType(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
                                                  ).toString();

                                              FFAppState().productvariation =
                                                  OtherProductsDetailsCall
                                                      .productVariantStatus(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
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
                                if (OtherProductsDetailsCall.out_of_stock(
                                  containerOtherProductsDetailsResponse.jsonBody) == true)
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
                                                      .jsonBody,
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
                                                      .jsonBody,
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
                                  height: 4,
                                  thickness: 2,
                                  color: Color(0xFFE7E7E8),
                                ),*/
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      color: Colors.white,
                                      child: ExpandableNotifier(
                                        controller:
                                        _model.expandableExpandableController1,
                                        child: ExpandablePanel(
                                          header: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                6, 0, 0, 0),
                                            child: Text(
                                              'Description',
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Montserrat',
                                                fontSize: 14,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          collapsed: Container(),
                                          expanded: Html(
                                            data: valueOrDefault<String>(
                                              OtherProductsDetailsCall
                                                  .otherproductvariantdata(
                                                containerOtherProductsDetailsResponse
                                                    ?.jsonBody,
                                              ) !=
                                                  null &&
                                                  (OtherProductsDetailsCall
                                                      .otherproductvariantdata(
                                                    containerOtherProductsDetailsResponse
                                                        ?.jsonBody,
                                                  ))!
                                                      .isNotEmpty
                                                  ? valueOrDefault<String>(
                                                OtherProductsDetailsCall
                                                    .productvariantdatadescription(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                )?[_model
                                                    .selectedVariatoinindex!],
                                                '0',
                                              )
                                                  : OtherProductsDetailsCall
                                                  .otherProductlongDescription(
                                                containerOtherProductsDetailsResponse
                                                    ?.jsonBody,
                                              ),
                                              'xxxx',
                                            ),
                                            /*  onLinkTap: (url, _, __) =>
                                                launchURL(url!),*/
                                          ),
                                          theme: ExpandableThemeData(
                                            tapHeaderToExpand: true,
                                            tapBodyToExpand: false,
                                            tapBodyToCollapse: false,
                                            headerAlignment:
                                            ExpandablePanelHeaderAlignment
                                                .center,
                                            hasIcon: true,
                                            expandIcon: Icons.keyboard_arrow_down,
                                            collapseIcon: Icons.keyboard_arrow_up,
                                            iconColor: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            iconPadding:
                                            EdgeInsets.fromLTRB(16, 16, 14, 16),
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
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                                  child: Container(
                                    key: _OtherProductDetailsWidgetratingKey,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      color: Colors.white,
                                      child: ExpandableNotifier(
                                        controller:
                                        _model.expandableExpandableController2,
                                        child: ExpandablePanel(
                                          key: _OtherProductDetailsWidgetratingKey,
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
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                      print("Productid:${
                                                          OtherProductsDetailsCall
                                                              .productid(
                                                            containerOtherProductsDetailsResponse
                                                                ?.jsonBody,
                                                          )?.toString()
                                                      /* OtherProductsDetailsCall
                                                        .rudrakshaProductid(
                                                      containerOtherProductsDetailsResponse
                                                          .jsonBody,
                                                    )?.toString()*/}");
                                                      print("productMainType:${  OtherProductsDetailsCall
                                                          .productMainType(
                                                        containerOtherProductsDetailsResponse
                                                            ?.jsonBody,
                                                      )?.toString()}");
                                                      print("productSlugValue:${ widget.productSlugValue }");

                                                      print("Otherreviewcustomerstarrating:${  OtherProductsDetailsCall.Otherreviewcustomerstarrating(
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
                                                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
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
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (OtherProductsDetailsCall
                                                  .reviewdata(
                                                containerOtherProductsDetailsResponse
                                                    ?.jsonBody,
                                              ) !=
                                                  null &&
                                                  (OtherProductsDetailsCall
                                                      .reviewdata(
                                                    containerOtherProductsDetailsResponse
                                                        ?.jsonBody,
                                                  ))!
                                                      .isNotEmpty)
                                                Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    RatingreviewWidget(

                                                      parameter1:  OtherProductsDetailsCall
                                                          .Otherreviewcustomerstarrating(
                                                        containerOtherProductsDetailsResponse
                                                            ?.jsonBody,
                                                      )!,
                                                    ),


                                                    Text(

                                                      valueOrDefault<String>(
                                                        OtherProductsDetailsCall.Otherproductreviewcustomercomment(
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
                                                        fontSize: 16,
                                                        letterSpacing: 0,
                                                      ),
                                                    ),
                                                    /*Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                        child: Image.asset(
                                                          'assets/images/Image_(2).png',
                                                          width: 70,
                                                          height: 70,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                        child: Image.asset(
                                                          'assets/images/Image.png',
                                                          width: 70,
                                                          height: 70,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                        child: Image.asset(
                                                          'assets/images/Image_(1).png',
                                                          width: 70,
                                                          height: 70,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ].divide(SizedBox(width: 8)),
                                                  ),*/
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
                                                            )!)
                                                                : 'x',
                                                            'x',
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
                                                              'producttype': FFAppConstants.OtherMasterProductDetailsApi,

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
                                                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                            fontFamily: 'Montserrat',
                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
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
                                                    /*InkWell(
                                                      onTap:(){
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
                                                            'producttype': FFAppConstants.OtherMasterProductDetailsApi,

                                                          }.withoutNulls,
                                                        );
                                                      },

                                                      child: Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          RichText(
                                                            textScaler:
                                                            MediaQuery.of(context)
                                                                .textScaler,
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: 'View All ',
                                                                  style: FlutterFlowTheme
                                                                      .of(context)
                                                                      .bodyMedium
                                                                      .override(
                                                                    fontFamily:
                                                                    'Montserrat',
                                                                    letterSpacing:
                                                                    0,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  ),
                                                                ),
                                                              *//*  TextSpan(
                                                                  text: valueOrDefault<String>(
                                                                    (OtherProductsDetailsCall.reviewdata(
                                                                      containerOtherProductsDetailsResponse.jsonBody,
                                                                    ) as List).length.toString(),
                                                                    '0',
                                                                  ),
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),*//*

                                                                TextSpan(
                                                                  text: ' Reviews',
                                                                  style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  ),
                                                                )
                                                              ],
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                fontFamily:
                                                                'Montserrat',
                                                                letterSpacing: 0,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          *//*FlutterFlowIconButton(
                                                            borderColor:
                                                            Colors.transparent,
                                                            borderRadius: 30,
                                                            borderWidth: 1,
                                                            buttonSize:
                                                            MediaQuery.sizeOf(
                                                                context)
                                                                .width *
                                                                0.1,
                                                            icon: Icon(
                                                              Icons.navigate_next,
                                                              color:
                                                              FlutterFlowTheme.of(
                                                                  context)
                                                                  .primaryText,
                                                              size: 25,
                                                            ),
                                                            onPressed: () {
                                                              print(
                                                                  'IconButton pressed ...');
                                                            },
                                                          ),*//*
                                                        ],
                                                      ),
                                                    ),*/

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
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 16, 0, 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Related Products',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 30),
                                        child: Builder(
                                          builder: (context) {
                                            final relatedProduct =
                                                OtherProductsDetailsCall
                                                    .otherProductsimilarcategoryproduct(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                )?.toList() ??
                                                    [];
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
                                                children: List.generate(
                                                    relatedProduct.length,
                                                        (relatedProductIndex) {
                                                      final relatedProductItem =
                                                      relatedProduct[
                                                      relatedProductIndex];
                                                      return InkWell(
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
                                                                  relatedProductItem,
                                                                  r'''$.slug_value''',
                                                                ).toString(),
                                                                ParamType.String,
                                                              ),
                                                              'outofstockValue':
                                                              serializeParam(
                                                                getJsonField(
                                                                  relatedProductItem,
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
                                                          );
                                                        },
                                                        child:
                                                        Stack(
                                                          children: [
                                                            Container(
                                                              width: 148,
                                                              height: 220,
                                                              decoration: BoxDecoration(
                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                              ),
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.max,
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Center(
                                                                    child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      child:
                                                                      CachedNetworkImage(
                                                                        fadeInDuration: Duration(milliseconds: 100),
                                                                        fadeOutDuration: Duration(milliseconds: 100),
                                                                        imageUrl: getJsonField(
                                                                          relatedProductItem,
                                                                          r'''$.thumbnail_image''',).toString(),
                                                                        //width: 152,
                                                                        height: 104,
                                                                        fit: BoxFit.contain,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: double.infinity,
                                                                    height: 50,
                                                                    decoration:
                                                                    BoxDecoration(),
                                                                    child: AutoSizeText(
                                                                      getJsonField(
                                                                        relatedProductItem,
                                                                        r'''$.product_name''',
                                                                      ).toString(),
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
                                                                            getJsonField(relatedProductItem, r'''$.selling_price''').toString(),
                                                                            FFAppState().currencyRate,
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
                                                                    mainAxisSize:
                                                                    MainAxisSize.max,
                                                                    children: [
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            0),
                                                                        child: Image.asset(
                                                                          'assets/images/Rating_Icon.png',
                                                                          width: 16,
                                                                          height: 16,
                                                                          fit: BoxFit.fill,
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
                                                                              text: '4.4',
                                                                              style: FlutterFlowTheme.of(
                                                                                  context)
                                                                                  .bodyMedium
                                                                                  .override(
                                                                                fontFamily:
                                                                                'Montserrat',
                                                                                letterSpacing:
                                                                                0,
                                                                                fontWeight:
                                                                                FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                            /*  TextSpan(
                                                                          text:
                                                                              ' (412)',
                                                                          style:
                                                                              TextStyle(
                                                                            color: FlutterFlowTheme.of(
                                                                                    context)
                                                                                .secondaryText,
                                                                          ),
                                                                        )*/
                                                                          ],
                                                                          style: FlutterFlowTheme
                                                                              .of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                            fontFamily:
                                                                            'Montserrat',
                                                                            letterSpacing:
                                                                            0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ].divide(
                                                                        SizedBox(width: 5)),
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
                                                                      child: Text(
                                                                        "OUT OF STOCK",
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
                                                                      child: Text(
                                                                        "RESERVED",
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
                      ),
                    );
                  },
                ),
              ],
            ),
            /* Align(
                alignment: AlignmentDirectional(0, 0.9),
                child: Column(
                  children: [
                    if (OtherProductsDetailsCall.out_of_stock(
                      containerOtherProductsDetailsResponse?.jsonBody,
                    ) == false)
                      Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            FFButtonWidget(
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
                    if (OtherProductsDetailsCall.out_of_stock(
                        containerOtherProductsDetailsResponse?.jsonBody) == true)
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
                  ],
                ),
              ),*/
            /*Align(
                alignment: AlignmentDirectional(0, 1),
                child: wrapWithModel(
                  model: _model.customNavBarModel,
                  updateCallback: () => setState(() {}),
                  child: Container(
                    height: 112,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white, // Set the background color to white
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              if (OtherProductsDetailsCall.out_of_stock(
                                containerOtherProductsDetailsResponse?.jsonBody,) == false)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      FFButtonWidget(
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
                        const CustomNavBarWidget(),
                      ],
                    ),
                  ),
                ),
              ),*/
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
                        containerOtherProductsDetailsResponse?.jsonBody,) == false)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              FFButtonWidget(
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
                                              /*getJsonField(
                                                  (_model.apiResultj7i
                                                      ?.jsonBody ??
                                                      ''),
                                                  r'''$.msg''',
                                                ).toString(),*/
                                              'Product added in Cart',
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).containerFillColor,
                                              ),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: FlutterFlowTheme.of(context).primary,
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
                                                (_model.apiResultj7i?.jsonBody ?? ''), r'''$.msg''',
                                              ).toString(),
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).containerFillColor,
                                              ),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: FlutterFlowTheme.of(context).primary,
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
                                          (_model.apiResultj7i?.jsonBody ?? ''), r'''$.status''',).toString() != "failed")
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
                                              (_model.apiResultj7i?.statusCode ?? 200).toString(),
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
            )
          ]
      ),
    );
  }

  Widget buildDefaultProductDetails() {
    return SafeArea(
      top: true,
      child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 5),
                  child: Container(
                    width: double.infinity,
                    //height: 48,
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
                    producttype: FFAppConstants.OtherMasterProductDetailsApi,
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

                    print("otherproductvariantdata: ${OtherProductsDetailsCall
                        .productvariantdataimageurlpath(
                      containerOtherProductsDetailsResponse
                          ?.jsonBody,
                    ) }");
                    print("otherproductimageurlpath: ${OtherProductsDetailsCall
                        .otherproductimageurlpath(
                      containerOtherProductsDetailsResponse
                          ?.jsonBody,
                    ) }");
                    print("otherproductname: ${OtherProductsDetailsCall
                        .otherproductname(
                      containerOtherProductsDetailsResponse
                          ?.jsonBody,
                    ) }");
                    print("otherproductnamecotherproductcode: ${OtherProductsDetailsCall
                        .cotherproductcode(
                      containerOtherProductsDetailsResponse
                          ?.jsonBody,
                    ) }");

                    /*   final otherSinglePrice = ((functions.stringtoIntFunction(
                        OtherProductsDetailsCall.otherProductsellingprice(
                          containerOtherProductsDetailsResponse.jsonBody,
                        ))!) * (_model .countControllerValue!));
                    print('Single Price: $otherSinglePrice');*//**/
                    /*print('otherProductsellingprice Price: ${OtherProductsDetailsCall.otherProductsellingprice(
                      containerOtherProductsDetailsResponse.jsonBody,
                    )}');*/
                    return Expanded(
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.85,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
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
                                        0, 0, 0, 0),
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
                                                            valueOrDefault<String>(
                                                              OtherProductsDetailsCall.otherproductvariantdata(
                                                                containerOtherProductsDetailsResponse?.jsonBody,
                                                              ) != null &&
                                                                  (OtherProductsDetailsCall.otherproductvariantdata(
                                                                    containerOtherProductsDetailsResponse?.jsonBody,
                                                                  ))!.isNotEmpty
                                                                  ? (OtherProductsDetailsCall.productvariantdataimageurlpath(
                                                                containerOtherProductsDetailsResponse?.jsonBody,
                                                              )?[_model.selectedVariatoinindex!])
                                                                  : OtherProductsDetailsCall.otherproductimageurlpath(
                                                                containerOtherProductsDetailsResponse?.jsonBody,
                                                              )?.first,
                                                              'xxxx',
                                                            ),
                                                          ),*/
                                                      imageZoomScreen(
                                                        imageUrls: OtherProductsDetailsCall.otherproductvariantdata(
                                                          containerOtherProductsDetailsResponse?.jsonBody,
                                                        ) != null &&
                                                            (OtherProductsDetailsCall.otherproductvariantdata(
                                                              containerOtherProductsDetailsResponse?.jsonBody,
                                                            ))!.isNotEmpty
                                                            ? OtherProductsDetailsCall.otherproductimageurlpath(
                                                            containerOtherProductsDetailsResponse?.jsonBody
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
                                                        fadeInDuration: Duration(milliseconds: 100),
                                                        fadeOutDuration: Duration(milliseconds: 100),
                                                        imageUrl: utf8.decode(
                                                          valueOrDefault<String>(
                                                            OtherProductsDetailsCall.otherproductvariantdata(
                                                              containerOtherProductsDetailsResponse?.jsonBody,
                                                            ) != null &&
                                                                (OtherProductsDetailsCall.otherproductvariantdata(
                                                                  containerOtherProductsDetailsResponse?.jsonBody,
                                                                ))!.isNotEmpty
                                                                ? (OtherProductsDetailsCall.productvariantdataimageurlpath(
                                                              containerOtherProductsDetailsResponse?.jsonBody,
                                                            )?[_model.selectedVariatoinindex!])
                                                                : OtherProductsDetailsCall.otherproductimageurlpath(
                                                              containerOtherProductsDetailsResponse?.jsonBody,
                                                            )?.first,
                                                            'xxxx',
                                                          ).codeUnits,
                                                          allowMalformed: true,
                                                        ),
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
                                                        ? OtherProductsDetailsCall.otherproductimageurlpath(
                                                        containerOtherProductsDetailsResponse?.jsonBody
                                                    )?.toList() ?? []
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
                                                        final productId = OtherProductsDetailsCall.productid(containerOtherProductsDetailsResponse?.jsonBody);

                                                        print(WishListCall.id(
                                                            containerWishlistResponse
                                                                .jsonBody));

                                                        print ("wishlistid");
                                                        print(OtherProductsDetailsCall
                                                            .productid(
                                                            containerOtherProductsDetailsResponse
                                                                ?.jsonBody));
                                                        if (!wishlistIds
                                                            .contains(
                                                          OtherProductsDetailsCall
                                                              .productid(
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
                                                                    OtherProductsDetailsCall.productid(
                                                                      containerOtherProductsDetailsResponse?.jsonBody,
                                                                    ),
                                                                    productType:
                                                                    OtherProductsDetailsCall.productMainType(
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
                                                                        backgroundColor: FlutterFlowTheme.of(context).primary,
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
                                                                  OtherProductsDetailsCall.productid(
                                                                    containerOtherProductsDetailsResponse?.jsonBody,
                                                                  ),
                                                                  productType:
                                                                  OtherProductsDetailsCall.productMainType(
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 16, 16, 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        valueOrDefault<String>(
                                          OtherProductsDetailsCall.otherproductname(
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
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                fontSize: 15,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text: valueOrDefault<String>(
                                                OtherProductsDetailsCall
                                                    .cotherproductcode(
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
                                              _model.expandableExpandableController2.expanded=true;
                                              _scrollController.animateTo(
                                                _OtherProductDetailsWidgetratingKey.currentContext!.findRenderObject()!.getTransformTo(null).getTranslation().y,
                                                duration: Duration(milliseconds: 300),
                                                curve: Curves.easeInOut,
                                              );
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
                                if (OtherProductsDetailsCall.otherproductvariantdata(
                                  containerOtherProductsDetailsResponse?.jsonBody,
                                ) != null &&
                                    (OtherProductsDetailsCall.otherproductvariantdata(
                                      containerOtherProductsDetailsResponse?.jsonBody,
                                    ))!.isNotEmpty)
                                  Divider(
                                    height: 5,
                                    thickness: 3,
                                    color: Color(0xFFE7E7E8),
                                  ),
                                if (OtherProductsDetailsCall.otherproductvariantdata(
                                  containerOtherProductsDetailsResponse?.jsonBody,
                                ) != null &&
                                    (OtherProductsDetailsCall.otherproductvariantdata(
                                      containerOtherProductsDetailsResponse?.jsonBody,))!.isNotEmpty)
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
                                                  _model.selectedvariation ?? 'Variation',
                                                  'Variation',
                                                ),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
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
                                            // Define selectVariation within the builder context
                                            final selectVariation = OtherProductsDetailsCall.otherproductvariantdata(
                                              containerOtherProductsDetailsResponse?.jsonBody,
                                            )?.toList() ?? [];

                                            // Set default selected variation if not already set
                                            if (_model.selectedvariation == null && selectVariation.isNotEmpty) {
                                              _model.selectedvariation = getJsonField(selectVariation[0], r'''$.variant_name''').toString();
                                              _model.selectedVariatoinindex = 0; // Set index for the first variation
                                            }

                                            return SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(selectVariation.length, (selectVariationIndex) {
                                                  final selectVariationItem = selectVariation[selectVariationIndex];

                                                  return InkWell(
                                                    splashColor: Colors.transparent,
                                                    focusColor: Colors.transparent,
                                                    hoverColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    onTap: () async {
                                                      // Update selected design and variation on tap
                                                      _model.selecteddesign = !_model.selecteddesign;
                                                      setState(() {});
                                                      _model.updateSelectedDesingAtIndex(0, (_) => selectVariationIndex);
                                                      _model.selectedvariation = getJsonField(
                                                        selectVariationItem,
                                                        r'''$.variant_name''',
                                                      ).toString();
                                                      _model.selectedVariatoinindex = selectVariationIndex;
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      width: 224,
                                                      height: 44,
                                                      decoration: BoxDecoration(
                                                        color: _model.selectedDesing.contains(selectVariationIndex)
                                                            ? Color(0x26740074)
                                                            : FlutterFlowTheme.of(context).secondaryBackground,
                                                        borderRadius: BorderRadius.circular(5),
                                                        border: Border.all(
                                                          color: _model.selectedDesing.contains(selectVariationIndex)
                                                              ? Color(0xFF740074)
                                                              : Color(0xFFE7E7E8),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.only(left: 15, right: 15),
                                                        child: Center(
                                                          child: AutoSizeText(
                                                            getJsonField(
                                                              selectVariationItem,
                                                              r'''$.variant_name''',
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
                                                  );
                                                }).divide(SizedBox(width: 10)),
                                              ),
                                            );
                                          },
                                        ),
                                      ].divide(SizedBox(height: 10)),
                                    ),
                                  ),
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                  child: Container(
                                    decoration: BoxDecoration(),
                                  ),
                                ),
                                Divider(
                                  height: 5,
                                  thickness: 2,
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
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
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
                                  height: 4,
                                  thickness: 2,
                                  color: Color(0xFFE7E7E8),
                                ),

                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 10, 0, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Builder(
                                        builder: (context) {
                                          if (OtherProductsDetailsCall
                                              .otherproductvariantdata(
                                            containerOtherProductsDetailsResponse
                                                ?.jsonBody,
                                          ) !=
                                              null &&
                                              (OtherProductsDetailsCall
                                                  .otherproductvariantdata(
                                                containerOtherProductsDetailsResponse
                                                    ?.jsonBody,
                                              ))!
                                                  .isNotEmpty) {
                                            return Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 10, 0),
                                              child: RichText(
                                                textScaler: MediaQuery.of(context)
                                                    .textScaler,
                                                text: TextSpan(
                                                  children: [


                                                    TextSpan(
                                                      text:
                                                      '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatNumber(
                                                        functions.currencyConversion(FFAppState().currencyRate, ((valueOrDefault<int>(
                                                          OtherProductsDetailsCall.productvariantdatasellingprice(
                                                            containerOtherProductsDetailsResponse?.jsonBody,)?[_model.selectedVariatoinindex!], 00000,)) *
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
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
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
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 10, 0),
                                              child: RichText(
                                                textScaler: MediaQuery.of(context)
                                                    .textScaler,
                                                text: TextSpan(
                                                  children: [

                                                    TextSpan(
                                                      text:
                                                      '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatNumber(
                                                        functions.currencyConversion(
                                                            FFAppState().currencyRate,((functions.stringtoIntFunction(
                                                            OtherProductsDetailsCall.otherProductsellingprice(
                                                              containerOtherProductsDetailsResponse?.jsonBody,
                                                            ))!) * (_model .countControllerValue!)).toString()),
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

                                Divider(
                                  height: 4,
                                  thickness: 2,
                                  color: Color(0xFFE7E7E8),
                                ),
                                /*if (OtherProductsDetailsCall.out_of_stock(
                                  containerOtherProductsDetailsResponse.jsonBody,
                                ) == false)
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () async {
                                            var _shouldSetState = false;
                                            if (currentAuthenticationToken != null &&
                                                currentAuthenticationToken != '') {
                                              FFAppState().buynow = false;
                                              if (OtherProductsDetailsCall
                                                  .productVariantStatus(
                                                containerOtherProductsDetailsResponse
                                                    .jsonBody,
                                              ) ==
                                                  true) {
                                                _model.apiResultj7i =
                                                await AddToCartCall.call(
                                                  hosturl: FFAppConstants.sanityurl,
                                                  token: currentAuthenticationToken,
                                                  productid: OtherProductsDetailsCall
                                                      .productid(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
                                                  )?.toString(),
                                                  productType:
                                                  OtherProductsDetailsCall
                                                      .productMainType(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
                                                  )?.toString(),
                                                  productvariation:
                                                  OtherProductsDetailsCall
                                                      .productVariantStatus(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
                                                  ),
                                                  productvariationId:
                                                  OtherProductsDetailsCall
                                                      .productVariantStatus(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
                                                  ) ==
                                                      true
                                                      ? (OtherProductsDetailsCall
                                                      .otherproductvariantdataid(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
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
                                                            .jsonBody,
                                                      );
                                                  _model.otherproductvarientstattus =
                                                      OtherProductsDetailsCall
                                                          .productVariantStatus(
                                                        containerOtherProductsDetailsResponse
                                                            .jsonBody,
                                                      );
                                                  _model.otherproductmaintype =
                                                      OtherProductsDetailsCall
                                                          .productMainType(
                                                        containerOtherProductsDetailsResponse
                                                            .jsonBody,
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
                                                          .jsonBody,
                                                    )?.toString(),
                                                    productType:
                                                    OtherProductsDetailsCall
                                                        .productMainType(
                                                      containerOtherProductsDetailsResponse
                                                          .jsonBody,
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
                                                              .jsonBody,
                                                        );
                                                    _model.otherproductvarientstattus =
                                                        OtherProductsDetailsCall
                                                            .productVariantStatus(
                                                          containerOtherProductsDetailsResponse
                                                              .jsonBody,
                                                        );
                                                    _model.otherproductmaintype =
                                                        OtherProductsDetailsCall
                                                            .productMainType(
                                                          containerOtherProductsDetailsResponse
                                                              .jsonBody,
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
                                                        .jsonBody,
                                                  )?.toString(),
                                                  productType:
                                                  OtherProductsDetailsCall
                                                      .productMainType(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
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
                                                            .jsonBody,
                                                      );
                                                  _model.otherproductvarientstattus =
                                                      OtherProductsDetailsCall
                                                          .productVariantStatus(
                                                        containerOtherProductsDetailsResponse
                                                            .jsonBody,
                                                      );
                                                  _model.otherproductmaintype =
                                                      OtherProductsDetailsCall
                                                          .productMainType(
                                                        containerOtherProductsDetailsResponse
                                                            .jsonBody,
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
                                        ),
                                        FFButtonWidget(
                                          onPressed: () async {
                                            if (currentAuthenticationToken != null &&
                                                currentAuthenticationToken != '') {

                                              FFAppState().productid =
                                                  OtherProductsDetailsCall
                                                      .productid(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
                                                  ).toString();
                                              FFAppState().productvariationId =OtherProductsDetailsCall
                                                  .productVariantDataId(
                                                containerOtherProductsDetailsResponse
                                                    .jsonBody,
                                              )?[_model
                                                  .selectedVariatoinindex!];
                                              FFAppState().productType =
                                                  OtherProductsDetailsCall
                                                      .productMainType(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
                                                  ).toString();

                                              FFAppState().productvariation =
                                                  OtherProductsDetailsCall
                                                      .productVariantStatus(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
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
                                if (OtherProductsDetailsCall.out_of_stock(
                                  containerOtherProductsDetailsResponse.jsonBody) == true)
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
                                                      .jsonBody,
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
                                                      .jsonBody,
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
                                  height: 4,
                                  thickness: 2,
                                  color: Color(0xFFE7E7E8),
                                ),*/
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      color: Colors.white,
                                      child: ExpandableNotifier(
                                        controller:
                                        _model.expandableExpandableController1,
                                        child: ExpandablePanel(
                                          header: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                6, 0, 0, 0),
                                            child: Text(
                                              'Description',
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Montserrat',
                                                fontSize: 14,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          collapsed: Container(),
                                          expanded: Html(
                                            data: valueOrDefault<String>(
                                              OtherProductsDetailsCall
                                                  .otherproductvariantdata(
                                                containerOtherProductsDetailsResponse
                                                    ?.jsonBody,
                                              ) !=
                                                  null &&
                                                  (OtherProductsDetailsCall
                                                      .otherproductvariantdata(
                                                    containerOtherProductsDetailsResponse
                                                        ?.jsonBody,
                                                  ))!
                                                      .isNotEmpty
                                                  ? valueOrDefault<String>(
                                                OtherProductsDetailsCall
                                                    .productvariantdatadescription(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                )?[_model
                                                    .selectedVariatoinindex!],
                                                '0',
                                              )
                                                  : OtherProductsDetailsCall
                                                  .otherProductlongDescription(
                                                containerOtherProductsDetailsResponse
                                                    ?.jsonBody,
                                              ),
                                              'xxxx',
                                            ),
                                            /*  onLinkTap: (url, _, __) =>
                                                launchURL(url!),*/
                                          ),
                                          theme: ExpandableThemeData(
                                            tapHeaderToExpand: true,
                                            tapBodyToExpand: false,
                                            tapBodyToCollapse: false,
                                            headerAlignment:
                                            ExpandablePanelHeaderAlignment
                                                .center,
                                            hasIcon: true,
                                            expandIcon: Icons.keyboard_arrow_down,
                                            collapseIcon: Icons.keyboard_arrow_up,
                                            iconColor: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            iconPadding:
                                            EdgeInsets.fromLTRB(16, 16, 14, 16),
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
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                                  child: Container(
                                    key: _OtherProductDetailsWidgetratingKey,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      color: Colors.white,
                                      child: ExpandableNotifier(
                                        controller:
                                        _model.expandableExpandableController2,
                                        child: ExpandablePanel(
                                          key: _OtherProductDetailsWidgetratingKey,
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
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                      print("Productid:${
                                                          OtherProductsDetailsCall
                                                              .productid(
                                                            containerOtherProductsDetailsResponse
                                                                ?.jsonBody,
                                                          )?.toString()
                                                      /* OtherProductsDetailsCall
                                                        .rudrakshaProductid(
                                                      containerOtherProductsDetailsResponse
                                                          .jsonBody,
                                                    )?.toString()*/}");
                                                      print("productMainType:${  OtherProductsDetailsCall
                                                          .productMainType(
                                                        containerOtherProductsDetailsResponse
                                                            ?.jsonBody,
                                                      )?.toString()}");
                                                      print("productSlugValue:${ widget.productSlugValue }");

                                                      print("Otherreviewcustomerstarrating:${  OtherProductsDetailsCall.Otherreviewcustomerstarrating(
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
                                                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
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
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (OtherProductsDetailsCall
                                                  .reviewdata(
                                                containerOtherProductsDetailsResponse
                                                    ?.jsonBody,
                                              ) !=
                                                  null &&
                                                  (OtherProductsDetailsCall
                                                      .reviewdata(
                                                    containerOtherProductsDetailsResponse
                                                        ?.jsonBody,
                                                  ))!
                                                      .isNotEmpty)
                                                Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    RatingreviewWidget(

                                                      parameter1:  OtherProductsDetailsCall
                                                          .Otherreviewcustomerstarrating(
                                                        containerOtherProductsDetailsResponse
                                                            ?.jsonBody,
                                                      )!,
                                                    ),


                                                    Text(

                                                      valueOrDefault<String>(
                                                        OtherProductsDetailsCall.Otherproductreviewcustomercomment(
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
                                                        fontSize: 16,
                                                        letterSpacing: 0,
                                                      ),
                                                    ),
                                                    /*Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                        child: Image.asset(
                                                          'assets/images/Image_(2).png',
                                                          width: 70,
                                                          height: 70,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                        child: Image.asset(
                                                          'assets/images/Image.png',
                                                          width: 70,
                                                          height: 70,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                        child: Image.asset(
                                                          'assets/images/Image_(1).png',
                                                          width: 70,
                                                          height: 70,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ].divide(SizedBox(width: 8)),
                                                  ),*/
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
                                                            )!)
                                                                : 'x',
                                                            'x',
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
                                                              'producttype': FFAppConstants.OtherMasterProductDetailsApi,

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
                                                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                            fontFamily: 'Montserrat',
                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
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
                                                    /*InkWell(
                                                      onTap:(){
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
                                                            'producttype': FFAppConstants.OtherMasterProductDetailsApi,

                                                          }.withoutNulls,
                                                        );
                                                      },

                                                      child: Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          RichText(
                                                            textScaler:
                                                            MediaQuery.of(context)
                                                                .textScaler,
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: 'View All ',
                                                                  style: FlutterFlowTheme
                                                                      .of(context)
                                                                      .bodyMedium
                                                                      .override(
                                                                    fontFamily:
                                                                    'Montserrat',
                                                                    letterSpacing:
                                                                    0,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  ),
                                                                ),
                                                              *//*  TextSpan(
                                                                  text: valueOrDefault<String>(
                                                                    (OtherProductsDetailsCall.reviewdata(
                                                                      containerOtherProductsDetailsResponse.jsonBody,
                                                                    ) as List).length.toString(),
                                                                    '0',
                                                                  ),
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),*//*

                                                                TextSpan(
                                                                  text: ' Reviews',
                                                                  style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  ),
                                                                )
                                                              ],
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                fontFamily:
                                                                'Montserrat',
                                                                letterSpacing: 0,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          *//*FlutterFlowIconButton(
                                                            borderColor:
                                                            Colors.transparent,
                                                            borderRadius: 30,
                                                            borderWidth: 1,
                                                            buttonSize:
                                                            MediaQuery.sizeOf(
                                                                context)
                                                                .width *
                                                                0.1,
                                                            icon: Icon(
                                                              Icons.navigate_next,
                                                              color:
                                                              FlutterFlowTheme.of(
                                                                  context)
                                                                  .primaryText,
                                                              size: 25,
                                                            ),
                                                            onPressed: () {
                                                              print(
                                                                  'IconButton pressed ...');
                                                            },
                                                          ),*//*
                                                        ],
                                                      ),
                                                    ),*/

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
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 16, 0, 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Related Products',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 30),
                                        child: Builder(
                                          builder: (context) {
                                            final relatedProduct =
                                                OtherProductsDetailsCall
                                                    .otherProductsimilarcategoryproduct(
                                                  containerOtherProductsDetailsResponse
                                                      ?.jsonBody,
                                                )?.toList() ??
                                                    [];
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
                                                children: List.generate(
                                                    relatedProduct.length,
                                                        (relatedProductIndex) {
                                                      final relatedProductItem =
                                                      relatedProduct[
                                                      relatedProductIndex];
                                                      return InkWell(
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
                                                                  relatedProductItem,
                                                                  r'''$.slug_value''',
                                                                ).toString(),
                                                                ParamType.String,
                                                              ),
                                                              'outofstockValue':
                                                              serializeParam(
                                                                getJsonField(
                                                                  relatedProductItem,
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
                                                          );
                                                        },
                                                        child:
                                                        Stack(
                                                          children: [
                                                            Container(
                                                              width: 148,
                                                              height: 220,
                                                              decoration: BoxDecoration(
                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                              ),
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.max,
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Center(
                                                                    child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      child:
                                                                      CachedNetworkImage(
                                                                        fadeInDuration: Duration(milliseconds: 100),
                                                                        fadeOutDuration: Duration(milliseconds: 100),
                                                                        imageUrl: getJsonField(
                                                                          relatedProductItem,
                                                                          r'''$.thumbnail_image''',).toString(),
                                                                        //width: 152,
                                                                        height: 104,
                                                                        fit: BoxFit.contain,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: double.infinity,
                                                                    height: 50,
                                                                    decoration:
                                                                    BoxDecoration(),
                                                                    child: AutoSizeText(
                                                                      getJsonField(
                                                                        relatedProductItem,
                                                                        r'''$.product_name''',
                                                                      ).toString(),
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
                                                                            getJsonField(relatedProductItem, r'''$.selling_price''').toString(),
                                                                            FFAppState().currencyRate,
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
                                                                    mainAxisSize:
                                                                    MainAxisSize.max,
                                                                    children: [
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            0),
                                                                        child: Image.asset(
                                                                          'assets/images/Rating_Icon.png',
                                                                          width: 16,
                                                                          height: 16,
                                                                          fit: BoxFit.fill,
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
                                                                              text: '4.4',
                                                                              style: FlutterFlowTheme.of(
                                                                                  context)
                                                                                  .bodyMedium
                                                                                  .override(
                                                                                fontFamily:
                                                                                'Montserrat',
                                                                                letterSpacing:
                                                                                0,
                                                                                fontWeight:
                                                                                FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                            /*  TextSpan(
                                                                          text:
                                                                              ' (412)',
                                                                          style:
                                                                              TextStyle(
                                                                            color: FlutterFlowTheme.of(
                                                                                    context)
                                                                                .secondaryText,
                                                                          ),
                                                                        )*/
                                                                          ],
                                                                          style: FlutterFlowTheme
                                                                              .of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                            fontFamily:
                                                                            'Montserrat',
                                                                            letterSpacing:
                                                                            0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ].divide(
                                                                        SizedBox(width: 5)),
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
                                                                      child: Text(
                                                                        "OUT OF STOCK",
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
                                                                      child: Text(
                                                                        "RESERVED",
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
                      ),
                    );
                  },
                ),
              ],
            ),
            /* Align(
                alignment: AlignmentDirectional(0, 0.9),
                child: Column(
                  children: [
                    if (OtherProductsDetailsCall.out_of_stock(
                      containerOtherProductsDetailsResponse?.jsonBody,
                    ) == false)
                      Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            FFButtonWidget(
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
                    if (OtherProductsDetailsCall.out_of_stock(
                        containerOtherProductsDetailsResponse?.jsonBody) == true)
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
                  ],
                ),
              ),*/
            /*Align(
                alignment: AlignmentDirectional(0, 1),
                child: wrapWithModel(
                  model: _model.customNavBarModel,
                  updateCallback: () => setState(() {}),
                  child: Container(
                    height: 112,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white, // Set the background color to white
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              if (OtherProductsDetailsCall.out_of_stock(
                                containerOtherProductsDetailsResponse?.jsonBody,) == false)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      FFButtonWidget(
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
                        const CustomNavBarWidget(),
                      ],
                    ),
                  ),
                ),
              ),*/
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
                        containerOtherProductsDetailsResponse?.jsonBody,) == false)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              FFButtonWidget(
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
                                              /*getJsonField(
                                                  (_model.apiResultj7i
                                                      ?.jsonBody ??
                                                      ''),
                                                  r'''$.msg''',
                                                ).toString(),*/
                                              'Product added in Cart',
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).containerFillColor,
                                              ),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: FlutterFlowTheme.of(context).primary,
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
                                                (_model.apiResultj7i?.jsonBody ?? ''), r'''$.msg''',
                                              ).toString(),
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).containerFillColor,
                                              ),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: FlutterFlowTheme.of(context).primary,
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
                                          (_model.apiResultj7i?.jsonBody ?? ''), r'''$.status''',).toString() != "failed")
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
                                              (_model.apiResultj7i?.statusCode ?? 200).toString(),
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
            )
          ]
      ),
    );
  }
}
