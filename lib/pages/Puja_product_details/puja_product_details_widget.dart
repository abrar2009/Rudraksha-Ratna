import 'dart:convert';
import 'package:file_picker/file_picker.dart';
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
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/pages/my_cart/my_cart_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'puja_product_details_model.dart';
export 'puja_product_details_model.dart';
import 'package:badges/badges.dart' as badges;

class PujaProductDetailsWidget extends StatefulWidget {
  const PujaProductDetailsWidget({
    super.key,
    String? productSlugValue,
    String? producttype,
  })  : this.productSlugValue =
      productSlugValue ?? 'buy/maha-shivratri-mahapuja',
        this.producttype =
            producttype ?? 'mobileapp/puja-product-detail?slug_value';

  final String productSlugValue;
  final String producttype;

  @override
  State<PujaProductDetailsWidget> createState() =>
      _PujaProductDetailsWidgetState();
}

Widget wrapInMaterialTimePickerTheme(
    BuildContext context,
    Widget child, {
      Color? headerBackgroundColor,
      Color? headerForegroundColor,
      TextStyle? headerTextStyle,
      Color? pickerBackgroundColor,
      Color? pickerForegroundColor,
      Color? selectedDateTimeBackgroundColor,
      Color? selectedDateTimeForegroundColor,
      Color? actionButtonForegroundColor,
      double iconSize = 24.0,
    }) {
  return Theme(
    data: Theme.of(context).copyWith(
      timePickerTheme: TimePickerThemeData(
        backgroundColor: pickerBackgroundColor,
        hourMinuteTextColor: pickerForegroundColor,
        dayPeriodTextColor: pickerForegroundColor,
        dayPeriodColor: MaterialStateColor.resolveWith(
              (states) => states.contains(MaterialState.selected)
              ? selectedDateTimeBackgroundColor ?? Colors.blue
              : pickerBackgroundColor ?? Colors.white,
        ),
        dialBackgroundColor: pickerBackgroundColor,
        dialHandColor: selectedDateTimeForegroundColor,
        entryModeIconColor: pickerForegroundColor,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(),
      ),
      textTheme: TextTheme(
        headlineLarge: headerTextStyle,
      ),
    ),
    child: child,
  );
}

class _PujaProductDetailsWidgetState extends State<PujaProductDetailsWidget> {
  late PujaProductDetailsModel _model;
  late ApiCallResponse containerOtherProductsDetailsResponse;
  bool isLoading = true;

  final PujaProductDetailsWidgetscaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isFormValid = ValueNotifier<bool>(false);
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PujaProductDetailsModel());

    _fetchData();

    _model.expandableExpandableController1 =
        ExpandableController(initialExpanded: false);
    _model.enterNameTextController ??= TextEditingController();
    _model.enterNameFocusNode ??= FocusNode();

    _model.enterSankalpWishTextController ??= TextEditingController();
    _model.enterSankalpWishFocusNode ??= FocusNode();

    _model.enterDateofBirthTextController ??= TextEditingController();
    _model.enterDateofBirthFocusNode ??= FocusNode();

    _model.enterMothersNameTextController ??= TextEditingController();
    _model.enterMothersNameFocusNode ??= FocusNode();

    _model.enterFathersNameTextController ??= TextEditingController();
    _model.enterFathersNameFocusNode ??= FocusNode();

    _model.timeofBirthTextController ??= TextEditingController();
    _model.timeofBirthFocusNode ??= FocusNode();

    _model.enterPlaceofBirthTextController ??= TextEditingController();
    _model.enterPlaceofBirthFocusNode ??= FocusNode();

    _model.enterGotraClanNameTextController ??= TextEditingController();
    _model.enterGotraClanNameFocusNode ??= FocusNode();

    _model.enterSpecialInstructionsTextController ??= TextEditingController();
    _model.enterSpecialInstructionsFocusNode ??= FocusNode();

    _model.expandableExpandableController2 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController3 =
        ExpandableController(initialExpanded: false);
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
        producttype: FFAppConstants.PujaMasterProductDetailsApi,
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

  void _validateForm() {
    _isFormValid.value = _formKey.currentState?.validate() ?? false;
  }
  String formatDate(String dateTimeString) {
    final DateTime dateTime = DateTime.parse(dateTimeString);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }
  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<List<PlatformFile>?> selectFiles({required bool multiFile}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: multiFile,
    );
    return result?.files;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: PujaProductDetailsWidgetscaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Column(
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
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24,
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
                    producttype: FFAppConstants.PujaMasterProductDetailsApi,
                    productslugvalue: widget.productSlugValue,
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
                    final containerOtherProductsDetailsResponse = snapshot.data!;

                    final description = valueOrDefault<String>(
                    OtherProductsDetailsCall
                        .longdescription(
                    containerOtherProductsDetailsResponse
                        .jsonBody,
                    ),
                    'Description',
                    );

                    //final decodedDescription = utf8.decode(description.codeUnits);
                    final decodedDescription = utf8.decode(description.codeUnits, allowMalformed: true);

                    return Container(
                      height: MediaQuery.sizeOf(context).height * 0.85,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 80),
                        child: SingleChildScrollView(
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
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
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
                                                      imageUrl: OtherProductsDetailsCall.pujavariantstatus(
                                                        containerOtherProductsDetailsResponse.jsonBody,
                                                      ) == true
                                                          ? (OtherProductsDetailsCall.pujavariantpath(
                                                        containerOtherProductsDetailsResponse.jsonBody,
                                                      )![_model.selectedCertificationindex!])
                                                          : OtherProductsDetailsCall.pujaimageurlpath(
                                                        containerOtherProductsDetailsResponse.jsonBody,
                                                      )!.first,
                                                    ),*/
                                                    imageZoomScreen(
                                                      imageUrls: OtherProductsDetailsCall.pujavariantstatus(
                                                        containerOtherProductsDetailsResponse.jsonBody,
                                                      ) == true
                                                          ? [OtherProductsDetailsCall.pujavariantpath(
                                                        containerOtherProductsDetailsResponse.jsonBody,
                                                      )![_model.selectedCertificationindex!]]
                                                          : OtherProductsDetailsCall.pujaimageurlpath(
                                                        containerOtherProductsDetailsResponse.jsonBody,
                                                      ) ?? [],
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
                                                  fadeInDuration: Duration(milliseconds: 500),
                                                  fadeOutDuration: Duration(milliseconds: 500),
                                                  imageUrl: OtherProductsDetailsCall.pujavariantstatus(
                                                    containerOtherProductsDetailsResponse.jsonBody,
                                                  ) == true
                                                      ? (OtherProductsDetailsCall.pujavariantpath(
                                                    containerOtherProductsDetailsResponse.jsonBody,
                                                  )![_model.selectedCertificationindex!])
                                                      : OtherProductsDetailsCall.pujaimageurlpath(
                                                    containerOtherProductsDetailsResponse.jsonBody,
                                                  )!.first,
                                                  width: double.infinity,
                                                  height: 288,
                                                  fit: BoxFit.contain,
                                                ),*/
                                                ProductImagesWidget(
                                                  imageUrls: OtherProductsDetailsCall.pujavariantstatus(
                                                    containerOtherProductsDetailsResponse.jsonBody,
                                                  ) == true
                                                      ? [OtherProductsDetailsCall.pujavariantpath(
                                                    containerOtherProductsDetailsResponse.jsonBody,
                                                  )![_model.selectedCertificationindex!]]
                                                      : OtherProductsDetailsCall.pujaimageurlpath(
                                                    containerOtherProductsDetailsResponse.jsonBody,
                                                  ) ?? [],
                                                ),
                                                Align(
                                                  alignment:
                                                  AlignmentDirectional(1,1),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(top: 15,right: 5),
                                                    child: SvgPicture.asset(
                                                      'assets/images/zoom_image.svg',
                                                      color: FlutterFlowTheme.of(context).primary,
                                                      width: 25,
                                                      height: 25,
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
                                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 22),
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
                                                          duration: Duration(milliseconds:
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
                                                          final productId = OtherProductsDetailsCall.rudrakshaProductid(containerOtherProductsDetailsResponse.jsonBody);

                                                          print(WishListCall.id(containerWishlistResponse.jsonBody));
                                                      print(OtherProductsDetailsCall.rudrakshaProductid(containerOtherProductsDetailsResponse.jsonBody));
                                                      if (!wishlistIds.contains(
                                                        OtherProductsDetailsCall.rudrakshaProductid(
                                                          containerOtherProductsDetailsResponse.jsonBody,),
                                                      )) {
                                                        return Padding(
                                                          padding: EdgeInsets.all(5),
                                                          child: InkWell(
                                                            splashColor: Colors.transparent,
                                                            focusColor: Colors.transparent,
                                                            hoverColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () async {
                                                              if (currentAuthenticationToken != null && currentAuthenticationToken != '') {
                                                                _model.addtoWishlist = await AddToWishlistCall.call(
                                                                  hosturl: FFAppConstants.sanityurl,
                                                                  token: currentAuthenticationToken,
                                                                  productid: OtherProductsDetailsCall.rudrakshaProductid(
                                                                    containerOtherProductsDetailsResponse.jsonBody,
                                                                  ),
                                                                  productType: OtherProductsDetailsCall.rudrakshaMainProductType(
                                                                    containerOtherProductsDetailsResponse.jsonBody,
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
                                                                _model.wishlistlikedislike =
                                                                !_model.wishlistlikedislike;
                                                                setState(() {});
                                                                HapticFeedback
                                                                    .lightImpact();
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
                                                                fit: BoxFit
                                                                    .cover,
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
                                                                  containerOtherProductsDetailsResponse.jsonBody,
                                                                ),
                                                                productType: OtherProductsDetailsCall.rudrakshaMainProductType(
                                                                  containerOtherProductsDetailsResponse.jsonBody,
                                                                ),
                                                              );

                                                              _shouldSetState = true;
                                                              if ((_model.apiResult5ep?.succeeded ?? true)) {
                                                                FFAppState().statusFailed = getJsonField(
                                                                  (_model.apiResult5ep?.jsonBody ?? ''), r'''$.status''',).toString();
                                                                setState(() {});
                                                                ScaffoldMessenger.of(context).clearSnackBars();
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                  SnackBar(
                                                                    content: Text(
                                                                      getJsonField((_model.apiResult5ep?.jsonBody ?? ''),
                                                                        r'''$.msg''',).toString(),
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
                                                              _model.wishlistlikedislike =
                                                              !_model.wishlistlikedislike;
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
                                                              child: Image.asset('assets/images/HeartFilled.png',
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
                                    Text(valueOrDefault<String>(
                                        getJsonField(
                                          containerOtherProductsDetailsResponse.jsonBody,
                                          r'''$.data.product_name''',
                                        )?.toString(),
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
                                            text: 'Product Code : ',
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              fontSize: 15,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextSpan(
                                            text: valueOrDefault<String>(
                                              getJsonField(
                                                containerOtherProductsDetailsResponse.jsonBody,
                                                r'''$.data.product_code''',
                                              )?.toString(),
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
                                  ].divide(SizedBox(height: 8)),
                                ),
                              ),
                              Divider(
                                height: 5,
                                thickness: 3,
                                color: Color(0xFFE7E7E8),
                              ),
                              if (OtherProductsDetailsCall.pujavariantstatus(
                                containerOtherProductsDetailsResponse.jsonBody,
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
                                              text: 'Select Variation : ',
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Montserrat',
                                                fontSize: 14,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text: valueOrDefault<String>(
                                                OtherProductsDetailsCall.pujavariantname(
                                                  containerOtherProductsDetailsResponse.jsonBody,
                                                )?[_model.selectedCertificationindex!],
                                                '0',
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
                                          final selectVariation = OtherProductsDetailsCall.pujavariantdata(
                                                containerOtherProductsDetailsResponse.jsonBody,
                                              )?.toList() ?? [];

                                          return SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  selectVariation.length, (selectVariationIndex) {
                                                    final selectVariationItem = selectVariation[selectVariationIndex];
                                                    return Align(
                                                      alignment: AlignmentDirectional(0, 1),
                                                      child: InkWell(
                                                        splashColor: Colors.transparent,
                                                        focusColor: Colors.transparent,
                                                        hoverColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        onTap: () async {
                                                          _model.selectedvariationprice = getJsonField(
                                                                selectVariationItem,
                                                                r'''$.price''',);
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
                                                                r'''$.variant_name''',).toString();
                                                          _model.selectedCertificationindex = selectVariationIndex;
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
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.all(5),
                                                            child: AutoSizeText(
                                                              getJsonField(selectVariationItem,
                                                                r'''$.variant_name''',).toString(),
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
                              if (OtherProductsDetailsCall.pujavariantstatus(
                                containerOtherProductsDetailsResponse.jsonBody,
                              ) == true)
                                Divider(
                                  height: 5,
                                  thickness: 2,
                                  color: Color(0xFFE7E7E8),
                                ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(16, 10, 0, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    // Generated code for this Row Widget...
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          // Generated code for this ConditionalBuilder Widget...
                                          Builder(
                                            builder: (context) {
                                              if (OtherProductsDetailsCall.pujavariantstatus(
                                                containerOtherProductsDetailsResponse.jsonBody,
                                              ) == true) {
                                                return Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                                  child: RichText(
                                                    textScaler: MediaQuery.of(context).textScaler,
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: '${valueOrDefault<String>(
                                                              FFAppState().currencyName, 'INR'
                                                          )} ${formatNumber(
                                                            functions.currencyConversion(
                                                              FFAppState().currencyRate,
                                                              (OtherProductsDetailsCall.pujadataproductvariantdatasellingprice(
                                                                  containerOtherProductsDetailsResponse.jsonBody
                                                              )?[_model.selectedCertificationindex!])?.toString() ?? '0000',
                                                            ),
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
                                                          text: '${valueOrDefault<String>(FFAppState().currencyName, 'INR'
                                                          )} ${formatNumber(
                                                            functions.currencyConversion(
                                                                FFAppState().currencyRate,
                                                                functions.stringtoIntFunction(
                                                                    valueOrDefault<String>(
                                                                      OtherProductsDetailsCall.Stringproductsellingprice(
                                                                        containerOtherProductsDetailsResponse.jsonBody,
                                                                      ).toString(),
                                                                      '0000',
                                                                    )
                                                                ).toString()
                                                            ),
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
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              letterSpacing: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                child: Container(
                                  decoration: BoxDecoration(),
                                ),
                              ),
                              Divider(
                                height: 4,
                                thickness: 2,
                                color: Color(0xFFE7E7E8),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.white,
                                    child: ExpandableNotifier(
                                      controller: _model.expandableExpandableController1,
                                      child: ExpandablePanel(
                                        header: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(6, 0, 0, 0),
                                          child: Text(
                                            'Enter Details',
                                            style: FlutterFlowTheme.of(context).displaySmall.override(
                                              fontFamily: 'Outfit',
                                              color: Colors.black,
                                              fontSize: 16,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        collapsed: Container(),
                                        expanded: Form(
                                          key:  _formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(6, 0, 6, 0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('First Name',
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Montserrat',
                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                      Form(
                                                        key: _model.formKey3,
                                                        autovalidateMode: AutovalidateMode.always,
                                                        child: TextFormField(
                                                          controller: _model.enterNameTextController,
                                                          focusNode: _model.enterNameFocusNode,
                                                          autofocus: false,
                                                          obscureText: false,
                                                          decoration: InputDecoration(
                                                            labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                              fontFamily: 'Montserrat',
                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                              fontSize: 16,
                                                              letterSpacing: 0,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                            hintText: 'Enter Name',
                                                            hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Montserrat',
                                                              letterSpacing: 1,
                                                            ),
                                                            enabledBorder: UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: Color(0xFF868687),
                                                                width: 1,
                                                              ),
                                                              borderRadius: BorderRadius.circular(0),
                                                            ),
                                                            focusedBorder: UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                width: 1,
                                                              ),
                                                              borderRadius: BorderRadius.circular(0),
                                                            ),
                                                            errorBorder: UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: FlutterFlowTheme.of(context).error,
                                                                width: 1,
                                                              ),
                                                              borderRadius: BorderRadius.circular(0),
                                                            ),
                                                            focusedErrorBorder: UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: FlutterFlowTheme.of(context).error,
                                                                width: 1,
                                                              ),
                                                              borderRadius: BorderRadius.circular(0),
                                                            ),
                                                          ),
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Montserrat',
                                                            letterSpacing: 0,
                                                          ),
                                                          keyboardType: TextInputType.name,
                                                          validator: _model.enterNameTextControllerValidator.asValidator(context),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Form(
                                                key: _model.formKey2,
                                                autovalidateMode: AutovalidateMode.always,
                                                child: Container(
                                                  decoration: BoxDecoration(),
                                                  child: Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(6, 0, 6, 0),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Sankalp/Wish',
                                                          style: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Montserrat',
                                                            color: FlutterFlowTheme
                                                                .of(context)
                                                                .secondaryText,
                                                            letterSpacing: 0,
                                                          ),
                                                        ),
                                                        TextFormField(
                                                          controller: _model
                                                              .enterSankalpWishTextController,
                                                          focusNode: _model
                                                              .enterSankalpWishFocusNode,
                                                          autofocus: true,
                                                          obscureText: false,
                                                          decoration: InputDecoration(
                                                            labelStyle:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .labelMedium
                                                                .override(
                                                              fontFamily:
                                                              'Montserrat',
                                                              color: FlutterFlowTheme.of(
                                                                  context)
                                                                  .primaryText,
                                                              fontSize: 16,
                                                              letterSpacing:
                                                              0,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                            ),
                                                            hintText:
                                                            'Enter Sankalp/Wish',
                                                            hintStyle:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Montserrat',
                                                              letterSpacing:
                                                              1,
                                                            ),
                                                            enabledBorder:
                                                            UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color:
                                                                Color(0xFF868687),
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(0),
                                                            ),
                                                            focusedBorder:
                                                            UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: FlutterFlowTheme
                                                                    .of(context)
                                                                    .primaryText,
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(0),
                                                            ),
                                                            errorBorder:
                                                            UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: FlutterFlowTheme
                                                                    .of(context)
                                                                    .error,
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(0),
                                                            ),
                                                            focusedErrorBorder:
                                                            UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: FlutterFlowTheme
                                                                    .of(context)
                                                                    .error,
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(0),
                                                            ),
                                                          ),
                                                          style: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Montserrat',
                                                            letterSpacing: 0,
                                                          ),
                                                          validator: _model
                                                              .enterSankalpWishTextControllerValidator
                                                              .asValidator(context),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(6, 0, 0, 0),
                                                child: Text(
                                                  'Birth Details (optional)',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 16,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(6, 0, 6, 0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Date of Birth',
                                                        style: FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium
                                                            .override(
                                                          fontFamily:
                                                          'Montserrat',
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0, 12, 0, 12),
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
                                                            // DatePickerDOB
                                                            await showModalBottomSheet<
                                                                bool>(
                                                                context: context,
                                                                builder: (context) {
                                                                  final _datePicked1CupertinoTheme =
                                                                  CupertinoTheme
                                                                      .of(context);
                                                                  return Container(
                                                                    height: MediaQuery.of(
                                                                        context)
                                                                        .size
                                                                        .height /
                                                                        3,
                                                                    width: MediaQuery.of(
                                                                        context)
                                                                        .size
                                                                        .width,
                                                                    color: FlutterFlowTheme.of(
                                                                        context)
                                                                        .secondaryBackground,
                                                                    child:
                                                                    CupertinoTheme(
                                                                      data: _datePicked1CupertinoTheme
                                                                          .copyWith(
                                                                        textTheme: _datePicked1CupertinoTheme
                                                                            .textTheme
                                                                            .copyWith(
                                                                          dateTimePickerTextStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                              .headlineMedium
                                                                              .override(
                                                                            fontFamily:
                                                                            'Outfit',
                                                                            color:
                                                                            FlutterFlowTheme.of(context).primaryText,
                                                                            letterSpacing:
                                                                            0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                      CupertinoDatePicker(
                                                                        mode: CupertinoDatePickerMode
                                                                            .date,
                                                                        minimumDate:
                                                                        DateTime(
                                                                            1900),
                                                                        initialDateTime:
                                                                        getCurrentTimestamp,
                                                                        maximumDate:
                                                                        getCurrentTimestamp,
                                                                        backgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        use24hFormat:
                                                                        false,
                                                                        onDateTimeChanged:
                                                                            (newDateTime) =>
                                                                            safeSetState(() {
                                                                              _model.datePicked1 =
                                                                                  newDateTime;
                                                                            }),
                                                                      ),
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                          child: Container(
                                                            decoration:
                                                            BoxDecoration(),
                                                            child: Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                dateTimeFormat(
                                                                    'yMd',
                                                                    _model
                                                                        .datePicked1),
                                                                'Enter Date of Birth',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                fontFamily:
                                                                'Montserrat',
                                                                letterSpacing:
                                                                1,
                                                                fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Divider(
                                                        height: 1,
                                                        thickness: 1,
                                                        color: Color(0xFF868687),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Form(
                                                key: _model.formKey4,
                                                autovalidateMode: AutovalidateMode.always,
                                                child: Container(
                                                  decoration: BoxDecoration(),
                                                  child: Padding(
                                                    padding: EdgeInsetsDirectional
                                                        .fromSTEB(6, 0, 6, 0),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Mother’s Name (optional)',
                                                          style: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Montserrat',
                                                            color: FlutterFlowTheme
                                                                .of(context)
                                                                .secondaryText,
                                                            letterSpacing: 0,
                                                          ),
                                                        ),
                                                        TextFormField(
                                                          controller: _model
                                                              .enterMothersNameTextController,
                                                          focusNode: _model
                                                              .enterMothersNameFocusNode,
                                                          autofocus: true,
                                                          obscureText: false,
                                                          decoration: InputDecoration(
                                                            labelStyle:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .labelMedium
                                                                .override(
                                                              fontFamily:
                                                              'Montserrat',
                                                              color: FlutterFlowTheme.of(
                                                                  context)
                                                                  .primaryText,
                                                              fontSize: 16,
                                                              letterSpacing:
                                                              0,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                            ),
                                                            hintText:
                                                            'Enter Mother’s Name',
                                                            hintStyle:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Montserrat',
                                                              letterSpacing:
                                                              1,
                                                            ),
                                                            enabledBorder:
                                                            UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color:
                                                                Color(0xFF868687),
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(0),
                                                            ),
                                                            focusedBorder:
                                                            UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: FlutterFlowTheme
                                                                    .of(context)
                                                                    .primaryText,
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(0),
                                                            ),
                                                            errorBorder:
                                                            UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: FlutterFlowTheme
                                                                    .of(context)
                                                                    .error,
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(0),
                                                            ),
                                                            focusedErrorBorder:
                                                            UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: FlutterFlowTheme
                                                                    .of(context)
                                                                    .error,
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(0),
                                                            ),
                                                          ),
                                                          style: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Montserrat',
                                                            letterSpacing: 0,
                                                          ),
                                                          validator: _model
                                                              .enterMothersNameTextControllerValidator
                                                              .asValidator(context),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Form(
                                                  key: _model.formKey5,
                                                autovalidateMode: AutovalidateMode.always,
                                                child: Container(
                                                  decoration: BoxDecoration(),
                                                  child: Padding(
                                                    padding: EdgeInsetsDirectional
                                                        .fromSTEB(6, 0, 6, 0),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Father’s Name',
                                                          style: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Montserrat',
                                                            color: FlutterFlowTheme
                                                                .of(context)
                                                                .secondaryText,
                                                            letterSpacing: 0,
                                                          ),
                                                        ),
                                                        TextFormField(
                                                          controller: _model
                                                              .enterFathersNameTextController,
                                                          focusNode: _model
                                                              .enterFathersNameFocusNode,
                                                          autofocus: true,
                                                          obscureText: false,
                                                          decoration: InputDecoration(
                                                            labelStyle:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .labelMedium
                                                                .override(
                                                              fontFamily:
                                                              'Montserrat',
                                                              color: FlutterFlowTheme.of(
                                                                  context)
                                                                  .primaryText,
                                                              fontSize: 16,
                                                              letterSpacing:
                                                              0,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                            ),
                                                            hintText:
                                                            'Enter Father’s Name',
                                                            hintStyle:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Montserrat',
                                                              letterSpacing:
                                                              1,
                                                            ),
                                                            enabledBorder:
                                                            UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color:
                                                                Color(0xFF868687),
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(0),
                                                            ),
                                                            focusedBorder:
                                                            UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: FlutterFlowTheme
                                                                    .of(context)
                                                                    .primaryText,
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(0),
                                                            ),
                                                            errorBorder:
                                                            UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: FlutterFlowTheme
                                                                    .of(context)
                                                                    .error,
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(0),
                                                            ),
                                                            focusedErrorBorder:
                                                            UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: FlutterFlowTheme
                                                                    .of(context)
                                                                    .error,
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(0),
                                                            ),
                                                          ),
                                                          style: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Montserrat',
                                                            letterSpacing: 0,
                                                          ),
                                                          validator: _model
                                                              .enterFathersNameTextControllerValidator
                                                              .asValidator(context),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(6, 0, 6, 0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Time of Birth',
                                                        style: FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium
                                                            .override(
                                                          fontFamily:
                                                          'Montserrat',
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0, 12, 0, 12),
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
                                                            await showModalBottomSheet<
                                                                bool>(
                                                                context: context,
                                                                builder: (context) {
                                                                  final _datePicked2CupertinoTheme =
                                                                  CupertinoTheme
                                                                      .of(context);
                                                                  return Container(
                                                                    height: MediaQuery.of(
                                                                        context)
                                                                        .size
                                                                        .height /
                                                                        3,
                                                                    width: MediaQuery.of(
                                                                        context)
                                                                        .size
                                                                        .width,
                                                                    color: FlutterFlowTheme.of(
                                                                        context)
                                                                        .secondaryBackground,
                                                                    child:
                                                                    CupertinoTheme(
                                                                      data: _datePicked2CupertinoTheme
                                                                          .copyWith(
                                                                        textTheme: _datePicked2CupertinoTheme
                                                                            .textTheme
                                                                            .copyWith(
                                                                          dateTimePickerTextStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                              .headlineMedium
                                                                              .override(
                                                                            fontFamily:
                                                                            'Outfit',
                                                                            color:
                                                                            FlutterFlowTheme.of(context).primaryText,
                                                                            letterSpacing:
                                                                            0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                      CupertinoDatePicker(
                                                                        mode: CupertinoDatePickerMode
                                                                            .time,
                                                                        minimumDate:
                                                                        DateTime(
                                                                            1900),
                                                                        initialDateTime:
                                                                        getCurrentTimestamp,
                                                                        maximumDate:
                                                                        DateTime(
                                                                            2050),
                                                                        backgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        use24hFormat:
                                                                        false,
                                                                        onDateTimeChanged:
                                                                            (newDateTime) =>
                                                                            safeSetState(() {
                                                                              _model.datePicked2 =
                                                                                  newDateTime;
                                                                            }),
                                                                      ),
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                          child: Container(
                                                            decoration:
                                                            BoxDecoration(),
                                                            child: Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                dateTimeFormat(
                                                                    'jm',
                                                                    _model
                                                                        .datePicked2),
                                                                '--:-- --',
                                                              ),
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
                                                        ),
                                                      ),
                                                      Divider(
                                                        height: 1,
                                                        thickness: 1,
                                                        color: Color(0xFF868687),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(6, 0, 6, 0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Place of Birth',
                                                        style: FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium
                                                            .override(
                                                          fontFamily:
                                                          'Montserrat',
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                      TextFormField(
                                                        controller: _model
                                                            .enterPlaceofBirthTextController,
                                                        focusNode: _model
                                                            .enterPlaceofBirthFocusNode,
                                                        autofocus: true,
                                                        obscureText: false,
                                                        decoration: InputDecoration(
                                                          labelStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .labelMedium
                                                              .override(
                                                            fontFamily:
                                                            'Montserrat',
                                                            color: FlutterFlowTheme.of(
                                                                context)
                                                                .primaryText,
                                                            fontSize: 16,
                                                            letterSpacing:
                                                            0,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500,
                                                          ),
                                                          hintText:
                                                          'Enter Place of Birth',
                                                          hintStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Montserrat',
                                                            letterSpacing:
                                                            1,
                                                          ),
                                                          enabledBorder:
                                                          UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color:
                                                              Color(0xFF868687),
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(0),
                                                          ),
                                                          focusedBorder:
                                                          UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .primaryText,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(0),
                                                          ),
                                                          errorBorder:
                                                          UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .error,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(0),
                                                          ),
                                                          focusedErrorBorder:
                                                          UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .error,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(0),
                                                          ),
                                                        ),
                                                        style: FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium
                                                            .override(
                                                          fontFamily:
                                                          'Montserrat',
                                                          letterSpacing: 0,
                                                        ),
                                                        validator: _model
                                                            .enterPlaceofBirthTextControllerValidator
                                                            .asValidator(context),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(6, 0, 6, 0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Gotra/Clan Name (optional)',
                                                        style: FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium
                                                            .override(
                                                          fontFamily:
                                                          'Montserrat',
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                      TextFormField(
                                                        controller: _model
                                                            .enterGotraClanNameTextController,
                                                        focusNode: _model
                                                            .enterGotraClanNameFocusNode,
                                                        autofocus: true,
                                                        obscureText: false,
                                                        decoration: InputDecoration(
                                                          labelStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .labelMedium
                                                              .override(
                                                            fontFamily:
                                                            'Montserrat',
                                                            color: FlutterFlowTheme.of(
                                                                context)
                                                                .primaryText,
                                                            fontSize: 16,
                                                            letterSpacing:
                                                            0,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500,
                                                          ),
                                                          hintText:
                                                          'Enter Gotra/Clan Name',
                                                          hintStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Montserrat',
                                                            letterSpacing:
                                                            1,
                                                          ),
                                                          enabledBorder:
                                                          UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color:
                                                              Color(0xFF868687),
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(0),
                                                          ),
                                                          focusedBorder:
                                                          UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .primaryText,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(0),
                                                          ),
                                                          errorBorder:
                                                          UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .error,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(0),
                                                          ),
                                                          focusedErrorBorder:
                                                          UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .error,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(0),
                                                          ),
                                                        ),
                                                        style: FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium
                                                            .override(
                                                          fontFamily:
                                                          'Montserrat',
                                                          letterSpacing: 0,
                                                        ),
                                                        validator: _model
                                                            .enterGotraClanNameTextControllerValidator
                                                            .asValidator(context),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(6, 0, 6, 0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Upload Image (optional)',
                                                        style: FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium
                                                            .override(
                                                          fontFamily:
                                                          'Montserrat',
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0, 6, 0, 0),
                                                        child: Row(
                                                          mainAxisSize:
                                                          MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                  0, 11, 0),
                                                              child: FFButtonWidget(
                                                                onPressed:
                                                                    () async {
                                                                  // UploadedFile

                                                                  final selectedFiles =
                                                                  await selectFiles(
                                                                    multiFile:
                                                                    false,
                                                                  );

                                                                  if (selectedFiles !=
                                                                      null) {
                                                                    setState(() =>
                                                                    _model.isDataUploading =
                                                                    true);
                                                                    var selectedUploadedFiles =
                                                                    <FFUploadedFile>[];

                                                                    try {
                                                                      selectedUploadedFiles =
                                                                          selectedFiles
                                                                              .map((m) =>
                                                                              FFUploadedFile(
                                                                                name: m.name.split('/').last,
                                                                                bytes: m.bytes,
                                                                              ))
                                                                              .toList();
                                                                    } finally {
                                                                      _model.isDataUploading =
                                                                      false;
                                                                    }
                                                                    if (selectedUploadedFiles
                                                                        .length ==
                                                                        selectedFiles
                                                                            .length) {
                                                                      setState(() {
                                                                        _model.uploadedLocalFile =
                                                                            selectedUploadedFiles
                                                                                .first;
                                                                        selectedUploadedFiles = selectedFiles
                                                                            .map((m) => FFUploadedFile(
                                                                          name: m.name, // Use name directly
                                                                          bytes: m.bytes,
                                                                        ))
                                                                            .toList();

                                                                        // Convert to base64
                                                                        _model
                                                                            .selectedFileBase64 = base64Encode(selectedUploadedFiles
                                                                            .first
                                                                            .bytes
                                                                        as List<
                                                                            int>);
                                                                        _model.selectedFileName =
                                                                            selectedUploadedFiles
                                                                                .first
                                                                                .name;
                                                                        _model.selectedFileName =
                                                                            selectedUploadedFiles
                                                                                .first
                                                                                .name;
                                                                      });
                                                                    } else {
                                                                      setState(
                                                                              () {});
                                                                      return;
                                                                    }
                                                                  }
                                                                },
                                                                text: 'Choose File',
                                                                options:
                                                                FFButtonOptions(
                                                                  height: 40,
                                                                  padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      24,
                                                                      0,
                                                                      24,
                                                                      0),
                                                                  iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      0),
                                                                  color: Color(
                                                                      0xFFDCDCDC),
                                                                  textStyle:
                                                                  FlutterFlowTheme.of(
                                                                      context)
                                                                      .titleSmall
                                                                      .override(
                                                                    fontFamily:
                                                                    'Montserrat',
                                                                    color: FlutterFlowTheme.of(context)
                                                                        .primaryText,
                                                                    letterSpacing:
                                                                    0,
                                                                  ),
                                                                  elevation: 0,
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: Colors
                                                                        .transparent,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 180,
                                                              child: Text(
                                                                _model.selectedFileName ??
                                                                    'No File Chosen',
                                                                style: FlutterFlowTheme
                                                                    .of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                  fontFamily:
                                                                  'Montserrat',
                                                                  fontSize: 16,
                                                                  letterSpacing:
                                                                  0,
                                                                ),
                                                                maxLines: 2,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(6, 0, 6, 0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Special Instructions (optional)',
                                                        style: FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium
                                                            .override(
                                                          fontFamily:
                                                          'Montserrat',
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                      TextFormField(
                                                        controller: _model
                                                            .enterSpecialInstructionsTextController,
                                                        focusNode: _model
                                                            .enterSpecialInstructionsFocusNode,
                                                        autofocus: true,
                                                        obscureText: false,
                                                        decoration: InputDecoration(
                                                          labelStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .labelMedium
                                                              .override(
                                                            fontFamily:
                                                            'Montserrat',
                                                            color: FlutterFlowTheme.of(
                                                                context)
                                                                .primaryText,
                                                            fontSize: 16,
                                                            letterSpacing:
                                                            0,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500,
                                                          ),
                                                          hintText:
                                                          'Enter Special Instructions',
                                                          hintStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Montserrat',
                                                            letterSpacing:
                                                            1,
                                                          ),
                                                          enabledBorder:
                                                          UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color:
                                                              Color(0xFF868687),
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(0),
                                                          ),
                                                          focusedBorder:
                                                          UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .primaryText,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(0),
                                                          ),
                                                          errorBorder:
                                                          UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .error,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(0),
                                                          ),
                                                          focusedErrorBorder:
                                                          UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .error,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(0),
                                                          ),
                                                        ),
                                                        style: FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium
                                                            .override(
                                                          fontFamily:
                                                          'Montserrat',
                                                          letterSpacing: 0,
                                                        ),
                                                        validator: _model
                                                            .enterSpecialInstructionsTextControllerValidator
                                                            .asValidator(context),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 16)),
                                          ),
                                        ),
                                        theme: ExpandableThemeData(
                                          tapHeaderToExpand: true,
                                          tapBodyToExpand: false,
                                          tapBodyToCollapse: false,
                                          headerAlignment:
                                          ExpandablePanelHeaderAlignment.center,
                                          hasIcon: true,
                                          expandIcon: Icons.keyboard_arrow_down,
                                          collapseIcon: Icons.keyboard_arrow_up,
                                          iconColor: FlutterFlowTheme.of(context).primaryText,
                                          iconPadding:
                                          EdgeInsets.fromLTRB(16, 16, 14, 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (OtherProductsDetailsCall.pujavariantstatus(
                                containerOtherProductsDetailsResponse.jsonBody,) == true)
                                Divider(
                                  height: 5,
                                  thickness: 2,
                                  color: Color(0xFFE7E7E8),
                                ),
                              if (OtherProductsDetailsCall.pujavariantstatus(
                                containerOtherProductsDetailsResponse.jsonBody,) == false)
                              Divider(
                                height: 5,
                                thickness: 2,
                                color: Color(0xFFE7E7E8),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.white,
                                    child: ExpandableNotifier(
                                      controller:
                                      _model.expandableExpandableController2,
                                      child: ExpandablePanel(
                                        header: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(6, 0, 0, 0),
                                          child: Text(
                                            'Description',
                                            style: FlutterFlowTheme.of(context).displaySmall.override(
                                              fontFamily: 'Outfit',
                                              color: Colors.black,
                                              fontSize: 16,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        collapsed: Container(),
                                        expanded: HtmlWidget(
                                          decodedDescription,
                                        
                                        ),
                                        theme: ExpandableThemeData(
                                          tapHeaderToExpand: true,
                                          tapBodyToExpand: false,
                                          tapBodyToCollapse: false,
                                          headerAlignment: ExpandablePanelHeaderAlignment.center,
                                          hasIcon: true,
                                          expandIcon: Icons.keyboard_arrow_down,
                                          collapseIcon: Icons.keyboard_arrow_up,
                                          iconColor: FlutterFlowTheme.of(context).primaryText,
                                          iconPadding: EdgeInsets.fromLTRB(16, 16, 14, 16),
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
                                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 10),
                                child: Container(
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
                                          style: FlutterFlowTheme.of(context).displaySmall.override(
                                            fontFamily: 'Outfit',
                                            color: Colors.black,
                                            fontSize: 16,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.normal,
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
                                                    print("Productid:${  OtherProductsDetailsCall.rudrakshaProductid(
                                                      containerOtherProductsDetailsResponse.jsonBody,)?.toString()}");
                                                    print("productMainType:${  OtherProductsDetailsCall.rudrakshaMainProductType(
                                                      containerOtherProductsDetailsResponse.jsonBody,)?.toString()}");

                                                    print("reviewcustomercomment:${  OtherProductsDetailsCall.reviewcustomercomment(
                                                      containerOtherProductsDetailsResponse.jsonBody,)}");
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
                                                            child: AddReviewPopUpWidget(
                                                              mainproducttype: serializeParam(
                                                                OtherProductsDetailsCall.rudrakshaMainProductType(
                                                                  containerOtherProductsDetailsResponse.jsonBody,
                                                                )?.toString(),
                                                                ParamType.String,
                                                              ),
                                                              productid: serializeParam(
                                                                OtherProductsDetailsCall.rudrakshaProductid(
                                                                  containerOtherProductsDetailsResponse.jsonBody,
                                                                )?.toString(),
                                                                ParamType.String,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ).then((value) => safeSetState(() {}));
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
                                            if (OtherProductsDetailsCall.reviewData(
                                              containerOtherProductsDetailsResponse.jsonBody,
                                            ) != null &&
                                                (OtherProductsDetailsCall.reviewData(
                                                  containerOtherProductsDetailsResponse.jsonBody,
                                                ))!.isNotEmpty)
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  RatingreviewWidget(
                                                    parameter1:  OtherProductsDetailsCall.reviewcustomerstarrating(
                                                      containerOtherProductsDetailsResponse.jsonBody,
                                                    )!,
                                                  ),

                                                  Text(
                                                    valueOrDefault<String>(
                                                      OtherProductsDetailsCall.reviewcustomercomment(
                                                        containerOtherProductsDetailsResponse.jsonBody,
                                                      ), 'x',
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
                                                      Text(valueOrDefault<String>(
                                                          OtherProductsDetailsCall.reviewcustomername(
                                                            containerOtherProductsDetailsResponse.jsonBody,
                                                          ), 'x',

                                                        ),
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Montserrat',
                                                          color: Color(0xFF696969),
                                                          letterSpacing: 0,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),

                                                      Text(
                                                        valueOrDefault<String>(
                                                          OtherProductsDetailsCall.reviewdate(
                                                            containerOtherProductsDetailsResponse.jsonBody,
                                                          ) != null ? formatDate(OtherProductsDetailsCall.reviewdate(
                                                            containerOtherProductsDetailsResponse.jsonBody,
                                                          )!) : 'x',
                                                          'x',
                                                        ),
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                                                                containerOtherProductsDetailsResponse.jsonBody,
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
                                                ].divide(SizedBox(height: 10)),
                                              ),
                                          ].divide(SizedBox(height: 8)),
                                        ),
                                        theme: ExpandableThemeData(
                                          tapHeaderToExpand: true,
                                          tapBodyToExpand: false,
                                          tapBodyToCollapse: false,
                                          headerAlignment: ExpandablePanelHeaderAlignment.center,
                                          hasIcon: true,
                                          expandIcon: Icons.keyboard_arrow_down_sharp,
                                          collapseIcon: Icons.keyboard_arrow_up,
                                          iconColor: FlutterFlowTheme.of(context).primaryText,
                                          iconPadding: EdgeInsets.fromLTRB(16, 16, 8, 16),
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
                                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Related Products',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                      child: Builder(
                                        builder: (context) {
                                          final relatedProduct = OtherProductsDetailsCall.relatedproduct(
                                                containerOtherProductsDetailsResponse.jsonBody,
                                              )?.toList() ?? [];

                                          return SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  relatedProduct.length, (relatedProductIndex) {
                                                    final relatedProductItem = relatedProduct[relatedProductIndex];
                                                    return InkWell(
                                                      splashColor: Colors.transparent,
                                                      focusColor: Colors.transparent,
                                                      hoverColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      onTap: () async {
                                                        if (widget!.producttype == FFAppConstants.RudrakshaMasterProductDetailsApi) {
                                                          context.pushNamed(
                                                            'PujaProductDetails',
                                                            queryParameters: {
                                                              'productSlugValue': serializeParam(
                                                                getJsonField(
                                                                  relatedProductItem,
                                                                  r'''$.slug_value''',
                                                                ).toString(),
                                                                ParamType.String,
                                                              ),
                                                              'producttype': serializeParam(
                                                                FFAppConstants.RudrakshaMasterProductDetailsApi,
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
                                                            'PujaProductDetails',
                                                            queryParameters: {
                                                              'productSlugValue': serializeParam(getJsonField(
                                                                  relatedProductItem,
                                                                  r'''$.slug_value''',).toString(),
                                                                ParamType.String,
                                                              ),
                                                              'producttype': serializeParam(
                                                                FFAppConstants.GemstoneMasterProductDetailsApi,
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
                                                      child: Container(
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
                                                            ClipRRect(
                                                              borderRadius: BorderRadius.circular(10),
                                                              child: Image.network(getJsonField(
                                                                  relatedProductItem,
                                                                  r'''$.thumbnail_image''',).toString(),
                                                                width: 152,
                                                                height: 104,
                                                                fit: BoxFit.fitWidth,
                                                              ),
                                                            ),
                                                            Container(
                                                              width: double.infinity,
                                                              height: 50,
                                                              decoration: BoxDecoration(),
                                                              child: AutoSizeText(getJsonField(
                                                                  relatedProductItem,
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
                                                          ],
                                                        ),
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
                                  print(
                                      "currentAuthenticationToken:${currentAuthenticationToken}");
                                  print(
                                      "_model.productid:${OtherProductsDetailsCall.rudrakshaProductid(
                                        containerOtherProductsDetailsResponse
                                            ?.jsonBody,
                                      )?.toString()}");
                                  print(
                                      "_model.productmaintypee:${OtherProductsDetailsCall.rudrakshaMainProductType(
                                        containerOtherProductsDetailsResponse
                                            ?.jsonBody,
                                      )?.toString()}");
                                  print(
                                      "_model.productvarient:${OtherProductsDetailsCall.pujavariantstatus(
                                        containerOtherProductsDetailsResponse
                                            ?.jsonBody,
                                      )}");

                                  print(
                                      "_model.pujadataproductvariantdataproductid:${(OtherProductsDetailsCall.pujadataproductvariantdataproductid(
                                        containerOtherProductsDetailsResponse
                                            ?.jsonBody,
                                      )?[_model.selectedCertificationindex!])}");
                                  if (currentAuthenticationToken != null &&
                                      currentAuthenticationToken != '') {
                                    FFAppState().buynow = false;
                                    if (OtherProductsDetailsCall
                                        .pujavariantstatus(
                                      containerOtherProductsDetailsResponse
                                          ?.jsonBody,
                                    ) ==
                                        true) {
                                      var _shouldSetState = false;
                                      _model.apiResultj7i =
                                      await PujaproductAddToCartCall
                                          .call(
                                        hosturl: FFAppConstants.sanityurl,
                                        token: currentAuthenticationToken,
                                        productid: OtherProductsDetailsCall
                                            .rudrakshaProductid(
                                          containerOtherProductsDetailsResponse
                                              ?.jsonBody,
                                        )?.toString(),
                                        productType:
                                        OtherProductsDetailsCall
                                            .rudrakshaMainProductType(
                                          containerOtherProductsDetailsResponse
                                              ?.jsonBody,
                                        )?.toString(),
                                        productvariation:
                                        OtherProductsDetailsCall
                                            .pujavariantstatus(
                                          containerOtherProductsDetailsResponse
                                              ?.jsonBody,
                                        ),
                                        productvariationId:
                                        (OtherProductsDetailsCall
                                            .pujadataproductvariantdataproductid(
                                          containerOtherProductsDetailsResponse
                                              ?.jsonBody,
                                        )?[_model
                                            .selectedCertificationindex!]),
                                        personName: _model
                                            .enterNameTextController.text,
                                        sankalp: _model
                                            .enterSankalpWishTextController
                                            .text,
                                        specialInstructions: _model
                                            .enterSpecialInstructionsTextController
                                            .text,
                                        fatherName: _model
                                            .enterFathersNameTextController
                                            .text,
                                        motherName: _model
                                            .enterMothersNameTextController
                                            .text,
                                        /*  dob: dateTimeFormat(
                                                  'yMd', _model.datePicked1),
                                              tob: dateTimeFormat(
                                                  'jm', _model.datePicked2),
                                              pob: _model
                                                  .enterPlaceofBirthTextController
                                                  .text,*/
                                        gotra: _model
                                            .enterGotraClanNameTextController
                                            .text,
                                        photo: _model.selectedFileBase64,
                                      );
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
                                        if (getJsonField(
                                          (_model.apiResultj7i
                                              ?.jsonBody ??
                                              ''),
                                          r'''$.status''',
                                        ).toString() ==
                                            "success")
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
                                        if (_shouldSetState)
                                          setState(() {});
                                        return;
                                      }
                                      _model.productid =
                                          OtherProductsDetailsCall
                                              .rudrakshaProductid(
                                            containerOtherProductsDetailsResponse
                                                ?.jsonBody,
                                          );
                                      _model.productmaintypee =
                                          OtherProductsDetailsCall
                                              .rudrakshaMainProductType(
                                            containerOtherProductsDetailsResponse
                                                ?.jsonBody,
                                          );
                                      _model.productvarient =
                                      OtherProductsDetailsCall
                                          .productVariantStatus(
                                        containerOtherProductsDetailsResponse
                                            ?.jsonBody,
                                      )!;
                                      setState(() {
                                        print(
                                            "_model.productid:${_model.productid}");
                                        print(
                                            "_model.productmaintypee:${_model.productmaintypee}");
                                        print(
                                            "_model.productvarient:${_model.productvarient}");
                                      });
                                      if (_shouldSetState) setState(() {});
                                    } else {
                                      var _shouldSetState = false;
                                      _model.apiResultj7i = await PujaproductAddToCartCall
                                          .call(
                                          hosturl:
                                          FFAppConstants.sanityurl,
                                          token:
                                          currentAuthenticationToken,
                                          productid:
                                          OtherProductsDetailsCall
                                              .rudrakshaProductid(
                                            containerOtherProductsDetailsResponse
                                                ?.jsonBody,
                                          )?.toString(),
                                          productType:
                                          OtherProductsDetailsCall
                                              .rudrakshaMainProductType(
                                            containerOtherProductsDetailsResponse
                                                ?.jsonBody,
                                          )?.toString(),
                                          personName: _model
                                              .enterNameTextController
                                              .text,
                                          sankalp: _model
                                              .enterSankalpWishTextController
                                              .text,
                                          specialInstructions: _model
                                              .enterSpecialInstructionsTextController
                                              .text,
                                          fatherName: _model
                                              .enterFathersNameTextController
                                              .text,
                                          motherName: _model
                                              .enterMothersNameTextController
                                              .text
                                        /*   certification:
                                                (OtherProductsDetailsCall
                                                        .certificationlistid(
                                              containerOtherProductsDetailsResponse
                                                  .jsonBody,
                                            )?[_model.selectedCertificationindex!])
                                                    ?.toString(),*/

                                      );
                                      _shouldSetState = true;
                                      if ((_model.apiResultj7i?.succeeded ??
                                          true)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              getJsonField(
                                                (_model.apiResultj7i?.jsonBody ?? ''), r'''$.msg''',).toString(),
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).containerFillColor,
                                              ),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: FlutterFlowTheme.of(context).primary,
                                          ),
                                        );
                                        if (getJsonField((_model.apiResultj7i?.jsonBody ?? ''),
                                          r'''$.status''',).toString() == "success")
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
                                            FlutterFlowTheme.of(context).primary,
                                          ),
                                        );
                                        if (_shouldSetState)
                                          setState(() {});
                                        return;
                                      }
                                      _model.productid =
                                          OtherProductsDetailsCall
                                              .rudrakshaProductid(
                                            containerOtherProductsDetailsResponse
                                                ?.jsonBody,
                                          );
                                      _model.productmaintypee =
                                          OtherProductsDetailsCall
                                              .rudrakshaMainProductType(
                                            containerOtherProductsDetailsResponse
                                                ?.jsonBody,
                                          );
                                      _model.productvarient =
                                      OtherProductsDetailsCall
                                          .productVariantStatus(
                                        containerOtherProductsDetailsResponse
                                            ?.jsonBody,
                                      )!;
                                      setState(() {});
                                      if (_shouldSetState) setState(() {});
                                    }
                                    ;
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
                                showLoadingIndicator: false,
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  print("producttype:${widget.producttype}");
                                  if (currentAuthenticationToken != null &&
                                      currentAuthenticationToken != '') {
                                    if (widget.producttype ==
                                        FFAppConstants
                                            .PujaMasterProductDetailsApi) {
                                      FFAppState().productid =
                                          OtherProductsDetailsCall
                                              .rudrakshaProductid(
                                            containerOtherProductsDetailsResponse
                                                ?.jsonBody,
                                          )!
                                              .toString();

                                      FFAppState().productvariationId =
                                      (OtherProductsDetailsCall
                                          .pujadataproductvariantdataproductid(
                                        containerOtherProductsDetailsResponse
                                            ?.jsonBody,
                                      )?[_model
                                          .selectedCertificationindex!]);
                                      FFAppState().productType =
                                          OtherProductsDetailsCall
                                              .rudrakshaMainProductType(
                                            containerOtherProductsDetailsResponse
                                                ?.jsonBody,
                                          )!
                                              .toString();
                                      if (OtherProductsDetailsCall
                                          .pujavariantstatus(
                                        containerOtherProductsDetailsResponse
                                            ?.jsonBody,
                                      ) ==
                                          false) {
                                        FFAppState()
                                            .productvariation = false;
                                      }
                                      else
                                        FFAppState().productvariation =
                                            OtherProductsDetailsCall
                                                .pujavariantstatus(
                                              containerOtherProductsDetailsResponse
                                                  ?.jsonBody,
                                            );
                                      FFAppState().personName = _model
                                          .enterNameTextController.text;
                                      FFAppState().sankalp = _model
                                          .enterSankalpWishTextController
                                          .text;
                                      FFAppState().specialInstructions = _model
                                          .enterSpecialInstructionsTextController
                                          .text;
                                      FFAppState().fatherName = _model
                                          .enterFathersNameTextController
                                          .text;
                                      FFAppState().motherName = _model
                                          .enterMothersNameTextController
                                          .text;
                                      print(FFAppState().productvariation);

                                      print(
                                          "_model.selecteddesignid ${_model.selecteddesignid}");
                                      print(
                                          "FFAppState().energizationId ${FFAppState().energizationId}");

                                      print(
                                          "FFAppState().selectedCertificationId ${FFAppState().selectedCertificationId}");

                                      FFAppState().buynow = true;
                                      print(
                                          "FFAppState().buynow: ${FFAppState().buynow}");
                                      print(
                                          "FFAppState().quantity: ${FFAppState().quantity}");
                                      print(
                                          "FFAppState().productvariation: ${FFAppState().productvariation}");
                                      print(
                                          "FFAppState().productType: ${FFAppState().productType}");
                                      print(
                                          "FFAppState().productvariationId: ${FFAppState().productvariationId}");
                                      print(
                                          "FFAppState().productid: ${FFAppState().productid}");
                                      print(
                                          "FFAppState().personName: ${FFAppState().personName}");
                                      print(
                                          "FFAppState().sankalp: ${FFAppState().sankalp}");
                                      print(
                                          "FFAppState().specialInstructions: ${FFAppState().specialInstructions}");
                                      print(
                                          "FFAppState().fatherName: ${FFAppState().fatherName}");
                                      print(
                                          "FFAppState()._motherName: ${FFAppState().motherName}");

                                      print(
                                          "FFAppState().productvariationString: ${FFAppState().productvariationString}");

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
                                    }

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
                      ]
                  ),
                ),
              ),
              /*Align(
                alignment: AlignmentDirectional(0, 1),
                child: wrapWithModel(
                  model: _model.customNavBarModel,
                  updateCallback: () => setState(() {}),
                  child: const CustomNavBarWidget(),
                ),
              ),*/
            ]
          ),
        ),
        bottomNavigationBar: const CustomNavBarWidget(),
      ),
    );
  }
}
