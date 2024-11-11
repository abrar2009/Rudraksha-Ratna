import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../auth/custom_auth/auth_util.dart';
import '../../components/AddReviewPopUp_Widget.dart';
import '../../components/custom_nav_bar_widget.dart';
import '../../components/shimmer_widget.dart';
import '../../custom_code/image_zoom_screen.dart';
import '../../custom_code/product_images.dart';
import '../../custom_code/selected_options.dart';
import '../../custom_code/widgets/metal_dropdown.dart';
import '../../flutter_flow/custom_functions.dart';
import '../../flutter_flow/ring_size_system.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/my_cart/my_cart_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;

import 'diamond_product_details_model.dart';
export 'diamond_product_details_model.dart';

class DiamondProductDetailsWidget extends StatefulWidget {
  const DiamondProductDetailsWidget({
    super.key,
    String? productSlugValue,
    this.producttype,
    this.firstLevelName,
    required this.isFromPaymentScreen,
    required this.cartId,
  }) : this.productSlugValue =
            productSlugValue ?? 'buy/1-mukhi-from-java-indonesia-large-xviii';

  final String productSlugValue;
  final String? producttype;
  final String? firstLevelName;
  final bool isFromPaymentScreen;
  final int? cartId;

  @override
  State<DiamondProductDetailsWidget> createState() =>
      _DiamondProductDetailsWidgetState();
}

class _DiamondProductDetailsWidgetState
    extends State<DiamondProductDetailsWidget> {
  late DiamondProductDetailsModel _model;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _DiamondProductDetailsWidgetratingKey = GlobalKey();
  final DeliveryAddressWidgetscaffoldKeyscaffoldKey =
      GlobalKey<ScaffoldState>();
  ApiCallResponse? containerOtherProductsDetailsResponse;
  //bool isLoading = true;
  SelectedOptions? selectedOptions;
  String? _selectedMetalId;
  String initialMetalVal = 'Select Metal';
  int? group;
  bool _showNewExpandable = false;
  int? _selectedDesignIndex;
  int? _selectedChainIndex;
  bool _isDesignSelected = false;
  String? noDesignsAvailable;

  //For preselected values when navigate from payment screen after clicking "View Details"
  ApiCallResponse? cartDataResponse;
  bool isLoading = false;
  String? energizationName;
  String? certificationName;
  String? selectDesignType;
  String? metalType;
  String? metalId;
  String? selectDesignsMetalDep;
  String? selectDesignsChainDep;
  String? selectedWristSize;
  String? selectedRingSizeSystem;
  String? selectedRingSize;
  int? selectedDesignPrice;
  int? selectedChainPrice;
  int? selectedEnergizationPrice;
  int? selectedCertificationPrice;
  int? productType;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DiamondProductDetailsModel());

    _model.expandableExpandableController1 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController2 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController3 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController4 =
        ExpandableController(initialExpanded: false);
    //_fetchData();

    fetchSlugData();

    /*if (widget.isFromPaymentScreen) {
      fetchCartData();
    };
    debugPrint('Cart id passed on diamond product detail screen: ${widget.cartId}');*/
    // Log the cartId being passed
    debugPrint(
        'Cart id passed on diamond product detail screen: ${widget.cartId}');

    // Check if the cartId is valid before calling fetchCartData
    if (widget.isFromPaymentScreen && widget.cartId != -1) {
      fetchCartData();
    } else {
      debugPrint('Invalid cartId: ${widget.cartId}, skipping fetchCartData.');
    }

    debugPrint('metalType etyythdghd: ${metalType}');
  }

  Future<void> fetchCartData() async {
    setState(() {
      isLoading = true;

      // Reset the variables to null or initial values before making a new API call
      energizationName = null;
      certificationName = null;
      selectDesignType = null;
      metalType = null;
      metalId = null;
      selectDesignsMetalDep = null;
      selectDesignsChainDep = null;
      selectedWristSize = null;
      selectedRingSizeSystem = null;
      selectedRingSize = null;
      selectedDesignPrice = null;
      selectedChainPrice = null;
      selectedEnergizationPrice = null;
      selectedCertificationPrice = null;
    });

    try {
      // Call the Cart API
      cartDataResponse = await CartCall.call(
        hosturl: FFAppConstants.hosturl,
        token: currentAuthenticationToken,
      );

      // Store the JSON response from the API call
      final cartJsonData =
          getJsonField(cartDataResponse!.jsonBody, r'''$.data''');

      // Find the cart item with the matching cartId
      final cartItem = (cartJsonData as List).firstWhere(
        (item) => getJsonField(item, r'''$.cart_id''') == widget.cartId,
        orElse: () => null,
      );

      // Check if a matching cart item was found
      if (cartItem != null) {
        String? newEnergizationName =
            getJsonField(cartItem, r'''$.energization_name''').toString();
        String? newCertificationName =
            getJsonField(cartItem, r'''$.certification_name''').toString();
        String? newSelectDesignType =
            getJsonField(cartItem, r'''$.design_type''').toString();
        String? newMetalType =
            getJsonField(cartItem, r'''$.metal_id''').toString();
        String? newSelectDesignsMetalDep =
            getJsonField(cartItem, r'''$.design_name''').toString();
        String? newSelectDesignsChainDep =
            getJsonField(cartItem, r'''$.chain_name''').toString();
        String? newSelectedWristSize =
            getJsonField(cartItem, r'''$.wrist_size''').toString();
        String? newSelectedRingSizeSystem =
            getJsonField(cartItem, r'''$.ring_size_system''').toString();
        String? newSelectedRingSize =
            getJsonField(cartItem, r'''$.ring_size''').toString();
        int? newSelectedDesignPrice =
            getJsonField(cartItem, r'''$.design_price''').toInt();
        int? newSelectedChainPrice =
            getJsonField(cartItem, r'''$.chain_price''').toInt();
        int? newSelectedEnergizationPrice =
            getJsonField(cartItem, r'''$.energization_price''').toInt();
        int? newSelectedCertificationPrice =
            getJsonField(cartItem, r'''$.certification_price''').toInt();
        print('Metal Type: $newMetalType');
        print('Metal Type2: $metalType');

        setState(() {
          isLoading = false;
          // Update the state variables with the values from the matching cart item
          energizationName = newEnergizationName;
          certificationName = newCertificationName;
          selectDesignType = newSelectDesignType;
          metalType = newMetalType;
          metalId = newMetalType;
          selectDesignsMetalDep = newSelectDesignsMetalDep;
          selectDesignsChainDep = newSelectDesignsChainDep;
          selectedWristSize = newSelectedWristSize;
          selectedRingSizeSystem = newSelectedRingSizeSystem;
          selectedRingSize = newSelectedRingSize;
          selectedDesignPrice = newSelectedDesignPrice;
          selectedChainPrice = newSelectedChainPrice;
          selectedEnergizationPrice = newSelectedEnergizationPrice;
          selectedCertificationPrice = newSelectedCertificationPrice;

          print('Metal Type3: $metalType');
          print('selectedWristSize: $selectedWristSize');
          print('selectDesignsMetalDep: $selectDesignsMetalDep');
          print('selectDesignType: $selectDesignType');
          // Now that metalType is updated, trigger the metalDependantDesign API call
          if (metalType != null && selectDesignType != null) {
            _triggerMetalDependentDesignApi();
          }
        });
      } else {
        // Handle case where the cart item with the given cartId is not found
        setState(() {
          isLoading = false;
        });
        print('No cart item found with cartId: ${widget.cartId}');
      }
    } catch (e) {
      // Handle API error
      setState(() {
        isLoading = false;
      });
      print('Error fetching cart data: $e');
    }
  }

  Future<void> fetchSlugData() async {
    try {
      // Call the SlugSearch API using the host URL and slug value
      final response = await SlugSearchCall.call(
        hosturl: FFAppConstants.hosturl,
        slugValue: widget.productSlugValue,
      );

      // Parse the response data
      int? mainProdType = SlugSearchCall.datamainprodtype(response.jsonBody);
      int? level = SlugSearchCall.datalevel(response.jsonBody);
      bool? productList = SlugSearchCall.dataproductlist(response.jsonBody);

      // Debugging output
      print('Main Product Type: $mainProdType');
      print('Level: $level');
      print('Product List Exists: $productList');

      // Handle the data according to your app's logic
      if (mainProdType != null && level != null) {
        // Do something with the retrieved data
        productType = mainProdType;
        print('Product Type: $productType');
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      print('Error fetching slug data: $e');
    }
  }

  void _triggerMetalDependentDesignApi() {
    // Call the API with the current metal type
    metalDependantDesign
        .call(
      hosturl: FFAppConstants.sanityurl,
      slugValue: widget.productSlugValue,
      designType: _model.selectedDesignType.toString(),
      metal: metalType,
      group: _model.selectedGroupId.toString(),
    )
        .then((response) {
      // Handle the API response as you did in the FutureBuilder
      final metalData =
          getJsonField(response.jsonBody, r'''$.data''', true) ?? [];
      print('metalData: $metalData');
      // Process metalData and update the state as needed
    }).catchError((error) {
      // Handle error
      print('Error fetching metal dependent data: $error');
    });

    final requestBody = {
      'hosturl': FFAppConstants.sanityurl,
      'slugValue': widget.productSlugValue,
      'designType': _model.selectedDesignType.toString(),
      'metal': metalType,
      'group': _model.selectedGroupId.toString(),
    };

    print('Metal Request Body1: ${jsonEncode(requestBody)}');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Retrieve preselected options from the arguments, safely inside didChangeDependencies
    selectedOptions =
        ModalRoute.of(context)?.settings.arguments as SelectedOptions?;

    if (selectedOptions != null) {
      // Initialize the model with the preselected options
      _model.selectedEnergization = selectedOptions!.energizationName;
      _model.selectedCertification = selectedOptions!.certificationName;
      //_model.selectedDesignName = selectedOptions!.designName;
      _model.selecteddesignid = selectedOptions!.designType;

      // Initialize indices based on the options (if necessary)
      _initializeSelectedIndices();
    }
  }

  void _initializeSelectedIndices() {
    // Set the initial index values based on the preselected options
    final List<dynamic> energizationList =
        OtherProductsDetailsCall.pujaenergizationlist(
              containerOtherProductsDetailsResponse?.jsonBody,
            )?.toList() ??
            [];

    _model.selectedEnergizationIndex = energizationList.indexWhere((item) =>
        getJsonField(item, r'''$.name''').toString() ==
        _model.selectedEnergization);

    // Similarly, you can set indices for certification, design name, and type
    setState(() {});
  }

  @override
  void dispose() {
    _model.dispose();

    _scrollController.dispose();
    super.dispose();
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
        key: DeliveryAddressWidgetscaffoldKeyscaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: FlutterFlowTheme.of(context).primary,
              ))
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
      child: Stack(children: [
        Container(
          height: double.infinity,
          //width: double.infinity,
          child: Column(
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
                          final cartCount = functions
                              .cartBadgeCount(badgeCartResponse.jsonBody);

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
                                      transitionType:
                                          PageTransitionType.rightToLeft,
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
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 2, 10, 2),
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
                                      transitionType:
                                          PageTransitionType.rightToLeft,
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
                  producttype: widget.producttype,
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

                  final description = valueOrDefault<String>(
                    OtherProductsDetailsCall.longdescription(
                      containerOtherProductsDetailsResponse?.jsonBody,
                    ),
                    'Description',
                  );

                  int? groupId;
                  int? designType;

                  final jsonResponse =
                      containerOtherProductsDetailsResponse?.jsonBody;

                  // Determine group id based on choice chip selection
                  if (_model.choiceChipsValue1 == 'Pendant' ||
                      _model.choiceChipsValue2 == 'Pendant' ||
                      selectDesignType == 'Pendant') {
                    groupId =
                        getJsonField(jsonResponse, r'''$.data.pendent[0]''')
                                as int? ??
                            0;
                    designType = 2;
                  } else if (_model.choiceChipsValue1 == 'Bracelet' ||
                      _model.choiceChipsValue2 == 'Bracelet' ||
                      selectDesignType == 'Bracelet') {
                    groupId =
                        getJsonField(jsonResponse, r'''$.data.bracelet[0]''')
                                as int? ??
                            0;
                    designType = 1;
                  } else if (_model.choiceChipsValue1 == 'Ring' ||
                      _model.choiceChipsValue2 == 'Ring' ||
                      selectDesignType == 'Ring') {
                    groupId = getJsonField(jsonResponse, r'''$.data.ring[0]''')
                            as int? ??
                        0;
                    designType = 3;
                  }

                  _model.selectedGroupId = groupId;
                  _model.selectedDesignType = designType;

                  print(
                      '_model.selectedGroupId = groupId; ${_model.selectedGroupId}');
                  print(
                      '_model.selectedDesignType = designType; ${_model.selectedDesignType}');

                  final decodedDescription = utf8.decode(description.codeUnits);

                  if (kDebugMode) {
                    print(
                        "data87: ${getJsonField(containerOtherProductsDetailsResponse?.jsonBody, r'''$.data''').toString()}");
                  }

                  return Expanded(
                    child: Container(
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
                                      0, 0, 0, 0),
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    child: Stack(
                                      alignment: AlignmentDirectional(1, 1),
                                      children: [
                                        // Generated code for this Image Widget...
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
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
                                                    child: imageZoomScreen(
                                                      imageUrls: widget
                                                                  .producttype ==
                                                              FFAppConstants
                                                                  .YantraMasterProductDetailsApi
                                                          ? OtherProductsDetailsCall
                                                                  .otherproductimageurlpath(
                                                                containerOtherProductsDetailsResponse
                                                                    ?.jsonBody,
                                                              )?.toList() ??
                                                              []
                                                          : parseImageUrls(getJsonField(
                                                                  containerOtherProductsDetailsResponse
                                                                      ?.jsonBody,
                                                                  r'''$.data.image_url[*].path''') ??
                                                              []),
                                                      initialIndex: 0,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then(
                                                (value) => safeSetState(() {}));
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            child: Stack(
                                              children: [
                                                ProductImagesWidget(
                                                  imageUrls: widget
                                                              .producttype ==
                                                          FFAppConstants
                                                              .YantraMasterProductDetailsApi
                                                      ? OtherProductsDetailsCall
                                                                  .otherproductimageurlpath(
                                                                      containerOtherProductsDetailsResponse
                                                                          ?.jsonBody)
                                                              ?.toList() ??
                                                          []
                                                      : parseImageUrls(getJsonField(
                                                              containerOtherProductsDetailsResponse
                                                                  ?.jsonBody,
                                                              r'''$.data.image_url[*].path''') ??
                                                          []),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          1, 1),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10, right: 10),
                                                    child: SvgPicture.asset(
                                                      'assets/images/zoom_image.svg',
                                                      width: 25,
                                                      height: 25,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
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
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
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
                                                                final wishlistIds =
                                                                    WishListCall.id(
                                                                            containerWishlistResponse.jsonBody) ??
                                                                        [];
                                                                final productId =
                                                                    OtherProductsDetailsCall.rudrakshaProductid(
                                                                        containerOtherProductsDetailsResponse
                                                                            ?.jsonBody);

                                                                print(
                                                                    wishlistIds);
                                                                print(
                                                                    productId);
                                                                print(WishListCall.id(
                                                                    containerWishlistResponse
                                                                        .jsonBody));
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
                                        OtherProductsDetailsCall.productname(
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
                                                  .productcode(
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
                                    if (OtherProductsDetailsCall.reviewdata(
                                            containerOtherProductsDetailsResponse
                                                ?.jsonBody) !=
                                        null)
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              _model
                                                  .expandableExpandableController3
                                                  .expanded = true;
                                              _scrollController.animateTo(
                                                _DiamondProductDetailsWidgetratingKey
                                                    .currentContext!
                                                    .findRenderObject()!
                                                    .getTransformTo(null)
                                                    .getTranslation()
                                                    .y,
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves.easeInOut,
                                              );
                                            },
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 5, 0),
                                              child: RatingBarIndicator(
                                                itemBuilder: (context, index) =>
                                                    Icon(
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
                                            OtherProductsDetailsCall
                                                .productrating(
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
                              Divider(
                                height: 2,
                                thickness: 1.5,
                                color: Color(0xFFE7E7E8),
                              ),
                              if (OtherProductsDetailsCall.pujaenergizationlist(
                                        containerOtherProductsDetailsResponse
                                            ?.jsonBody,
                                      ) !=
                                      null &&
                                  (OtherProductsDetailsCall
                                          .pujaenergizationlist(
                                    containerOtherProductsDetailsResponse
                                        ?.jsonBody,
                                  ))!
                                      .isNotEmpty)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 16, 16, 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        textScaler:
                                            MediaQuery.of(context).textScaler,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Energization: ',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 14,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            TextSpan(
                                              text: energizationName,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
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
                                          final selectVariation =
                                              OtherProductsDetailsCall
                                                      .pujaenergizationlist(
                                                    containerOtherProductsDetailsResponse
                                                        ?.jsonBody,
                                                  )?.toList() ??
                                                  [];

                                          // Set default selected energization if not already set
                                          if (_model.selectedEnergization ==
                                                  null &&
                                              selectVariation.isNotEmpty) {
                                            _model.selectedEnergization =
                                                getJsonField(selectVariation[0],
                                                        r'''$.name''')
                                                    .toString();
                                            _model.selectedEnergizationIndex =
                                                0; // Set index for the first energization
                                            _model.energizationprice =
                                                getJsonField(selectVariation[0],
                                                    r'''$.price''');
                                          }

                                          // Get the selected index based on the current selected energization
                                          int selectedIndex = getIndexByName(
                                              selectVariation,
                                              energizationName ?? '');

                                          return SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  selectVariation.length,
                                                  (selectVariationIndex) {
                                                final selectVariationItem =
                                                    selectVariation[
                                                        selectVariationIndex];
                                                return Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 1),
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
                                                              selectVariationItem,
                                                              r'''$.price''');
                                                      setState(() {});
                                                      print(
                                                          'Energization List: $selectVariation');
                                                      print(
                                                          'selectedEnergizationIndex: ${_model.selectedEnergizationIndex}');
                                                      print(
                                                          'Energization List: $selectVariation');

                                                      selectedIndex =
                                                          selectVariationIndex;
                                                      energizationName =
                                                          getJsonField(
                                                                  selectVariationItem,
                                                                  r'''$.name''')
                                                              .toString();
                                                      _model.selectedEnergizationIndex =
                                                          selectVariationIndex;
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      height: 44,
                                                      decoration: BoxDecoration(
                                                        color: selectedIndex ==
                                                                selectVariationIndex
                                                            ? Color(0x26740074)
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                          color: selectedIndex ==
                                                                  selectVariationIndex
                                                              ? Color(
                                                                  0xFF740074)
                                                              : Color(
                                                                  0xFFE7E7E8),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15,
                                                                right: 15),
                                                        child: Center(
                                                          child: AutoSizeText(
                                                            getJsonField(
                                                                    selectVariationItem,
                                                                    r'''$.name''')
                                                                .toString(),
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
                                                                  lineHeight:
                                                                      1.5,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).divide(SizedBox(width: 16)),
                                            ),
                                          );
                                        },
                                      ),
                                    ].divide(SizedBox(height: 10)),
                                  ),
                                ),
                              if (OtherProductsDetailsCall.pujaenergizationlist(
                                        containerOtherProductsDetailsResponse
                                            ?.jsonBody,
                                      ) !=
                                      null &&
                                  (OtherProductsDetailsCall
                                          .pujaenergizationlist(
                                    containerOtherProductsDetailsResponse
                                        ?.jsonBody,
                                  ))!
                                      .isNotEmpty)
                                Divider(
                                  height: 2,
                                  thickness: 1.5,
                                  color: Color(0xFFE7E7E8),
                                ),
                              if (OtherProductsDetailsCall.certificationlist(
                                        containerOtherProductsDetailsResponse
                                            ?.jsonBody,
                                      ) !=
                                      null &&
                                  (OtherProductsDetailsCall.certificationlist(
                                    containerOtherProductsDetailsResponse
                                        ?.jsonBody,
                                  ))!
                                      .isNotEmpty)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 16, 16, 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        textScaler:
                                            MediaQuery.of(context).textScaler,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Certificate: ',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 14,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            TextSpan(
                                              text: certificationName,
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
                                          final selectVariation =
                                              OtherProductsDetailsCall
                                                      .certificationlist(
                                                    containerOtherProductsDetailsResponse
                                                        ?.jsonBody,
                                                  )?.toList() ??
                                                  [];

                                          // Set default selected energization if not already set
                                          if (_model.selecteddesign == null &&
                                              selectVariation.isNotEmpty) {
                                            _model.selectedEnergization =
                                                getJsonField(selectVariation[0],
                                                        r'''$.name''')
                                                    .toString();
                                            _model.selectedCertificationindex =
                                                0; // Set index for the first energization
                                            //_model.energizationprice = getJsonField(selectVariation[0], r'''$.price''');
                                          }

                                          // Get the selected index based on the current selected energization
                                          int selectedIndex = getIndexByName(
                                              selectVariation,
                                              certificationName ?? '');

                                          return SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  selectVariation.length,
                                                  (selectVariationIndex) {
                                                final selectVariationItem =
                                                    selectVariation[
                                                        selectVariationIndex];
                                                return Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 1),
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
                                                      _model.selectedcertificateprice =
                                                          getJsonField(
                                                        selectVariationItem,
                                                        r'''$.price''',
                                                      );
                                                      setState(() {});
                                                      /*if (_model.selecteddesign == true) {
                                                            _model.selectedCertificationindex = selectVariationIndex;
                                                            setState(() {});
                                                          } else {
                                                            _model.selectedCertificationindex = selectVariationIndex;
                                                            setState(() {});
                                                          }

                                                          _model.selectedCertification = getJsonField(
                                                            selectVariationItem,
                                                            r'''$.name''',
                                                          ).toString();
                                                          _model.selectedCertificationindex = selectVariationIndex;*/

                                                      selectedIndex =
                                                          selectVariationIndex;
                                                      certificationName =
                                                          getJsonField(
                                                                  selectVariationItem,
                                                                  r'''$.name''')
                                                              .toString();
                                                      _model.selectedCertificationindex =
                                                          selectVariationIndex;
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      // width: 224,
                                                      height: 44,
                                                      decoration: BoxDecoration(
                                                        color: selectedIndex ==
                                                                selectVariationIndex
                                                            ? Color(0x26740074)
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                          color: selectedIndex ==
                                                                  selectVariationIndex
                                                              ? Color(
                                                                  0xFF740074)
                                                              : Color(
                                                                  0xFFE7E7E8),
                                                        ),
                                                      ),
                                                      /*decoration: BoxDecoration(
                                                            color: _model.selectedCertificationindex == selectVariationIndex
                                                                ? Color(0x26740074)
                                                                : FlutterFlowTheme.of(context).secondaryBackground,
                                                            borderRadius: BorderRadius.circular(5),
                                                            border: Border.all(
                                                              color: _model.selectedCertificationindex == selectVariationIndex
                                                                  ? Color(0xFF740074)
                                                                  : Color(0xFFE7E7E8),
                                                            ),
                                                          ),*/
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15,
                                                                right: 15),
                                                        child: Center(
                                                          child: AutoSizeText(
                                                            getJsonField(
                                                              selectVariationItem,
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
                                                                  lineHeight:
                                                                      1.5,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).divide(SizedBox(width: 16)),
                                            ),
                                          );
                                        },
                                      ),
                                    ].divide(SizedBox(height: 10)),
                                  ),
                                ),
                              if (OtherProductsDetailsCall.certificationlist(
                                        containerOtherProductsDetailsResponse
                                            ?.jsonBody,
                                      ) !=
                                      null &&
                                  (OtherProductsDetailsCall.certificationlist(
                                    containerOtherProductsDetailsResponse
                                        ?.jsonBody,
                                  ))!
                                      .isNotEmpty)
                                Divider(
                                  height: 2,
                                  thickness: 1.5,
                                  color: Color(0xFFE7E7E8),
                                ),

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
                                            text:
                                                'Select Pendant / Bracelet Design: ',
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
                                            text: selectDesignType,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
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
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              _model
                                                  .expandableExpandableController1
                                                  .expanded = true;
                                              _model.designprice = 0;

                                              setState(() {});
                                            },
                                            child: Builder(
                                              builder: (context) {
                                                // Ensure the correct choice chips are used based on your condition
                                                List<ChipData> chipOptions =
                                                    !(OtherProductsDetailsCall
                                                                    .productRingData(
                                                                  containerOtherProductsDetailsResponse
                                                                      ?.jsonBody,
                                                                ) !=
                                                                null &&
                                                            (OtherProductsDetailsCall
                                                                    .productRingData(
                                                              containerOtherProductsDetailsResponse
                                                                  ?.jsonBody,
                                                            ))!
                                                                .isNotEmpty)
                                                        ? [
                                                            ChipData(
                                                                'Loose Bead'),
                                                            ChipData('Pendant'),
                                                            ChipData('Bracelet')
                                                          ]
                                                        : [
                                                            ChipData(
                                                                'Loose Bead'),
                                                            ChipData('Pendant'),
                                                            ChipData(
                                                                'Bracelet'),
                                                            ChipData('Ring')
                                                          ];

                                                return SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      FlutterFlowChoiceChips(
                                                        options: chipOptions,
                                                        onChanged: (val) async {
                                                          setState(() {
                                                            selectDesignType = val
                                                                ?.firstOrNull; // Update selectDesignType
                                                            _model
                                                                .expandableExpandableController1
                                                                .expanded = true;
                                                            metalType = null;
                                                            _model.designprice =
                                                                0;
                                                            _model.selecteddesigncolor =
                                                                null;
                                                            _model.selectedchaindesign =
                                                                null;
                                                          });
                                                        },
                                                        selectedChipStyle:
                                                            ChipStyle(
                                                                backgroundColor:
                                                                    Color(
                                                                        0x1A740074),
                                                                textStyle: FlutterFlowTheme.of(
                                                                        context)
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
                                                                iconColor:
                                                                    FlutterFlowTheme
                                                                            .of(
                                                                                context)
                                                                        .primaryText,
                                                                iconSize: 18,
                                                                labelPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            5,
                                                                            10,
                                                                            5),
                                                                elevation: 0,
                                                                borderColor: Color(
                                                                    0xFF740074),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                borderWidth:
                                                                    0.8),
                                                        unselectedChipStyle:
                                                            ChipStyle(
                                                                backgroundColor:
                                                                    FlutterFlowTheme
                                                                            .of(
                                                                                context)
                                                                        .secondaryBackground,
                                                                textStyle: FlutterFlowTheme
                                                                        .of(
                                                                            context)
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
                                                                              .w500,
                                                                    ),
                                                                iconColor: Color(
                                                                    0x00000000),
                                                                iconSize: 18,
                                                                labelPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            5,
                                                                            10,
                                                                            5),
                                                                elevation: 0,
                                                                borderColor: Color(
                                                                    0xFFE7E7E8),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                borderWidth: 1),
                                                        chipSpacing: 16,
                                                        rowSpacing: 12,
                                                        multiselect: false,
                                                        initialized: _model
                                                                .choiceChipsValue1 !=
                                                            null,
                                                        alignment:
                                                            WrapAlignment.start,
                                                        controller: _model
                                                                .choiceChipsValueController1 ??=
                                                            FormFieldController<
                                                                List<String>>([
                                                          selectDesignType!
                                                        ]),
                                                        wrapped: true,
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ].divide(SizedBox(height: 10)),
                                ),
                              ),

                              if (((_model.choiceChipsValue2 == 'Pendant') ||
                                      (_model.choiceChipsValue1 == 'Pendant') ||
                                      (_model.choiceChipsValue2 ==
                                          'Bracelet') ||
                                      (_model.choiceChipsValue1 ==
                                          'Bracelet') ||
                                      (_model.choiceChipsValue2 == 'Ring') ||
                                      (_model.choiceChipsValue1 == 'Ring')) &&
                                  widget.firstLevelName != 'Rudraksha' &&
                                  productType != 3)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 16),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Select Metal: ',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              fontSize: 14,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: KeyedSubtree(
                                          key: ValueKey(_model
                                              .choiceChipsValue2), // Key changes when choice chip value changes
                                          child: FutureBuilder<ApiCallResponse>(
                                            future: metalDetail.call(
                                              sanityurl:
                                                  FFAppConstants.sanityurl,
                                            ),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child: SizedBox(
                                                    height: 25.0,
                                                    child: ShimmerWidget(),
                                                  ),
                                                );
                                              }

                                              // Fetch the API response and payload
                                              print(
                                                  'API Response: ${snapshot.data}');
                                              final metalDetailDropdownResponse =
                                                  snapshot.data!;
                                              print(
                                                  'API Response JSON Body: ${metalDetailDropdownResponse.jsonBody}');

                                              // Parse the metal data
                                              final metalData = (getJsonField(
                                                metalDetailDropdownResponse
                                                    .jsonBody,
                                                r'''$.data''',
                                                true,
                                              ) as List<dynamic>)
                                                  .map((item) => {
                                                        'id': item['id']
                                                            .toString(),
                                                        'name': item['name']
                                                            .toString(),
                                                      })
                                                  .toList();

                                              // Find the initial value for the dropdown based on metalType
                                              String? initialMetalVal =
                                                  metalData.isNotEmpty
                                                      ? (metalData.firstWhere(
                                                              (metal) =>
                                                                  metal['id'] ==
                                                                  metalId,
                                                              orElse: () =>
                                                                  metalData[0])[
                                                          'name'])
                                                      : '';

                                              // Debugging output
                                              print(
                                                  'Parsed Metal Data: $metalData');

                                              return MetalDropdown(
                                                items: metalData
                                                    .map((e) => e['name'])
                                                    .toList(),
                                                initialValue:
                                                    initialMetalVal!, // Set the initial value from metalType
                                                onChanged: (val) async {
                                                  // Find the ID for the selected metal
                                                  final selectedMetal =
                                                      metalData.firstWhere(
                                                          (metal) =>
                                                              metal['name'] ==
                                                              val);
                                                  metalType =
                                                      selectedMetal['id'];

                                                  print(
                                                      'metalType: $metalType');

                                                  // Fetch dependant designs based on selected metal
                                                  if (metalType != null) {
                                                    final response =
                                                        await metalDependantDesign
                                                            .call(
                                                      hosturl: FFAppConstants
                                                          .sanityurl,
                                                      slugValue: widget
                                                          .productSlugValue,
                                                      designType: _model
                                                          .selectedDesignType
                                                          .toString(),
                                                      metal: metalType,
                                                      group: _model
                                                          .selectedGroupId
                                                          .toString(),
                                                    );

                                                    final requestBody = {
                                                      'hosturl': FFAppConstants
                                                          .sanityurl,
                                                      'slugValue': widget
                                                          .productSlugValue,
                                                      'designType': _model
                                                          .selectedDesignType
                                                          .toString(),
                                                      'metal': metalType,
                                                      'group': _model
                                                          .selectedGroupId
                                                          .toString(),
                                                    };

                                                    print(
                                                        'Metal Request Body: ${jsonEncode(requestBody)}');

                                                    print(
                                                        'Dependant Design API Response: ${response.jsonBody}');
                                                    setState(() {
                                                      // Update any state based on the API response
                                                    });
                                                    _model.chainPrice = 0;
                                                    _model.designprice = 0;
                                                    _model.selecteddesigncolor =
                                                        null;
                                                    _model.selectedchaindesign =
                                                        null;
                                                    FFAppState()
                                                            .selectedSizeSystem =
                                                        null;
                                                    FFAppState()
                                                            .selectedRingSize =
                                                        null;
                                                  }

                                                  setState(() {
                                                    FFAppState().selectedMetal =
                                                        val; // Update selected metal
                                                  });
                                                  print(
                                                      'Selected Metal: ${FFAppState().selectedMetal}');
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              if (widget.firstLevelName == 'Rudraksha' ||
                                  productType == 3)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 0),
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        // Generated code for this Expandable Widget...
                                        Container(
                                          width: double.infinity,
                                          color: Colors.white,
                                          child: ExpandableNotifier(
                                            controller: _model
                                                .expandableExpandableController1,
                                            child: ExpandablePanel(
                                              header: RichText(
                                                textScaler:
                                                    MediaQuery.of(context)
                                                        .textScaler,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Select Designs: ',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            letterSpacing: 0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                    TextSpan(
                                                      text: selectDesignType,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                    )
                                                  ],
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        letterSpacing: 0,
                                                      ),
                                                ),
                                              ),
                                              collapsed: Container(),
                                              expanded: Builder(
                                                builder: (context) {
                                                  if ((_model.choiceChipsValue2 ==
                                                          'Pendant') ||
                                                      (_model.choiceChipsValue1 ==
                                                          'Pendant')) {
                                                    return Builder(
                                                      builder: (context) {
                                                        final selectDesgn =
                                                            OtherProductsDetailsCall
                                                                    .pendentgroup(
                                                                  containerOtherProductsDetailsResponse
                                                                      ?.jsonBody,
                                                                )?.toList() ??
                                                                [];
                                                        return SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: List.generate(
                                                                selectDesgn
                                                                    .length,
                                                                (selectDesgnIndex) {
                                                              final selectDesgnItem =
                                                                  selectDesgn[
                                                                      selectDesgnIndex];
                                                              return InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  _model.selecteddesign =
                                                                      !_model
                                                                          .selecteddesign;
                                                                  /*setState(() {});
                                                                          _model.selectedpendentdesign = selectDesgnIndex;
                                                                          _model.designprice = getJsonField(
                                                                            selectDesgnItem, r'''$.price''',
                                                                          );
                                                                          _model.selecteddesignid = getJsonField(
                                                                            selectDesgnItem,
                                                                            r'''$.id''',
                                                                          );
                                                                          setState(() {});*/
                                                                  setState(() {
                                                                    _model.selectedpendentdesign =
                                                                        selectDesgnIndex;
                                                                    _model.designprice =
                                                                        getJsonField(
                                                                      selectDesgnItem,
                                                                      r'''$.price''',
                                                                    );
                                                                    _model.selecteddesignid =
                                                                        getJsonField(
                                                                      selectDesgnItem,
                                                                      r'''$.id''',
                                                                    );

                                                                    // After selecting, update the default selected value to the current selection
                                                                    selectDesignsMetalDep = getJsonField(
                                                                            selectDesgnItem,
                                                                            r'''$.name''')
                                                                        .toString();
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 114,
                                                                  height: 222,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: (_model.selecteddesigncolor ==
                                                                                selectDesgnIndex ||
                                                                            selectDesignsMetalDep ==
                                                                                getJsonField(selectDesgnItem, r'''$.name''')
                                                                                    .toString())
                                                                        ? const Color(
                                                                            0x26740074)
                                                                        : FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: (_model.selecteddesigncolor == selectDesgnIndex || selectDesignsMetalDep == getJsonField(selectDesgnItem, r'''$.name''').toString())
                                                                          ? const Color(
                                                                              0xFF740074)
                                                                          : FlutterFlowTheme.of(context)
                                                                              .secondaryBackground,
                                                                    ),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            4,
                                                                            7,
                                                                            4),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(16),
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            fadeInDuration:
                                                                                Duration(milliseconds: 100),
                                                                            fadeOutDuration:
                                                                                Duration(milliseconds: 100),
                                                                            imageUrl:
                                                                                getJsonField(
                                                                              selectDesgnItem,
                                                                              r'''$.image''',
                                                                            ).toString(),
                                                                            width:
                                                                                93,
                                                                            //height: 120,
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              42,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              AutoSizeText(
                                                                            getJsonField(
                                                                              selectDesgnItem,
                                                                              r'''$.name''',
                                                                            ).toString(),
                                                                            maxLines:
                                                                                2,
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
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            7),
                                                                        child:
                                                                            RichText(
                                                                          textScaler:
                                                                              MediaQuery.of(context).textScaler,
                                                                          text:
                                                                              TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: '+${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(
                                                                                  getJsonField(selectDesgnItem, r'''$.price''').toString(),
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
                                                                          maxLines:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            12)),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } else if ((_model
                                                              .choiceChipsValue2 ==
                                                          'Bracelet') ||
                                                      (_model.choiceChipsValue1 ==
                                                          'Bracelet')) {
                                                    return Builder(
                                                      builder: (context) {
                                                        final selectBraceletDesign =
                                                            OtherProductsDetailsCall
                                                                    .braceletgroup(
                                                                  containerOtherProductsDetailsResponse
                                                                      ?.jsonBody,
                                                                )?.toList() ??
                                                                [];
                                                        return SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: List.generate(
                                                                selectBraceletDesign
                                                                    .length,
                                                                (selectBraceletDesignIndex) {
                                                              final selectBraceletDesignItem =
                                                                  selectBraceletDesign[
                                                                      selectBraceletDesignIndex];
                                                              return InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  print(
                                                                      "Braclet : ${selectBraceletDesignItem}");
                                                                  _model.selecteddesign =
                                                                      !_model
                                                                          .selecteddesign;
                                                                  setState(
                                                                      () {});
                                                                  _model.selectedbraceletdesign =
                                                                      selectBraceletDesignIndex;
                                                                  _model.designprice =
                                                                      getJsonField(
                                                                    selectBraceletDesignItem,
                                                                    r'''$.price''',
                                                                  );
                                                                  _model.selecteddesignid =
                                                                      getJsonField(
                                                                    selectBraceletDesignItem,
                                                                    r'''$.id''',
                                                                  );
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 114,
                                                                  height: 222,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: _model.selectedbraceletdesign ==
                                                                            selectBraceletDesignIndex
                                                                        ? Color(
                                                                            0x26740074)
                                                                        : FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: _model.selectedbraceletdesign ==
                                                                              selectBraceletDesignIndex
                                                                          ? Color(
                                                                              0xFF740074)
                                                                          : FlutterFlowTheme.of(context)
                                                                              .secondaryBackground,
                                                                    ),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            4,
                                                                            7,
                                                                            4),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            fadeInDuration:
                                                                                Duration(milliseconds: 100),
                                                                            fadeOutDuration:
                                                                                Duration(milliseconds: 100),
                                                                            imageUrl:
                                                                                getJsonField(
                                                                              selectBraceletDesignItem,
                                                                              r'''$.image''',
                                                                            ).toString(),
                                                                            width:
                                                                                100,
                                                                            height:
                                                                                120,
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              42,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              AutoSizeText(
                                                                            getJsonField(
                                                                              selectBraceletDesignItem,
                                                                              r'''$.name''',
                                                                            ).toString(),
                                                                            maxLines:
                                                                                2,
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
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            7),
                                                                        child:
                                                                            RichText(
                                                                          textScaler:
                                                                              MediaQuery.of(context).textScaler,
                                                                          text:
                                                                              TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: '+${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(
                                                                                  getJsonField(selectBraceletDesignItem, r'''$.price''').toString(),
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
                                                                          maxLines:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            12)),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } else if (_model
                                                          .choiceChipsValue2 ==
                                                      'Ring') {
                                                    return Builder(
                                                      builder: (context) {
                                                        final ringDesign =
                                                            OtherProductsDetailsCall
                                                                    .productRingData(
                                                                  containerOtherProductsDetailsResponse
                                                                      ?.jsonBody,
                                                                )?.toList() ??
                                                                [];
                                                        return SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: List.generate(
                                                                ringDesign
                                                                    .length,
                                                                (ringDesignIndex) {
                                                              final ringDesignItem =
                                                                  ringDesign[
                                                                      ringDesignIndex];
                                                              return InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  print(
                                                                      "ringDesign : ${ringDesignItem}");
                                                                  _model.selectedringdesign =
                                                                      ringDesignIndex;
                                                                  _model.designprice =
                                                                      getJsonField(
                                                                    ringDesignItem,
                                                                    r'''$.price''',
                                                                  );
                                                                  _model.selecteddesignid =
                                                                      getJsonField(
                                                                    ringDesignItem,
                                                                    r'''$.id''',
                                                                  );
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 114,
                                                                  height: 222,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: _model.selectedringdesign ==
                                                                            ringDesignIndex
                                                                        ? Color(
                                                                            0x26740074)
                                                                        : FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: _model.selectedringdesign ==
                                                                              ringDesignIndex
                                                                          ? Color(
                                                                              0xFF740074)
                                                                          : FlutterFlowTheme.of(context)
                                                                              .secondaryBackground,
                                                                    ),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            4,
                                                                            7,
                                                                            4),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            fadeInDuration:
                                                                                Duration(milliseconds: 100),
                                                                            fadeOutDuration:
                                                                                Duration(milliseconds: 100),
                                                                            imageUrl:
                                                                                getJsonField(
                                                                              ringDesignItem,
                                                                              r'''$.image''',
                                                                            ).toString(),
                                                                            width:
                                                                                100,
                                                                            height:
                                                                                120,
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              42,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              AutoSizeText(
                                                                            getJsonField(
                                                                              ringDesignItem,
                                                                              r'''$.name''',
                                                                            ).toString(),
                                                                            maxLines:
                                                                                2,
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
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            7),
                                                                        child:
                                                                            RichText(
                                                                          textScaler:
                                                                              MediaQuery.of(context).textScaler,
                                                                          text:
                                                                              TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: '+${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(
                                                                                  getJsonField(ringDesignItem, r'''$.price''').toString(),
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
                                                                          maxLines:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            12)),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    return Container(
                                                      width: 405,
                                                      height: 1,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                    );
                                                  }
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
                                                collapseIcon: Icons
                                                    .keyboard_arrow_up_sharp,
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

                              //if (metalType != null && metalType!.isNotEmpty && widget.firstLevelName != 'Rudraksha')
                              Divider(
                                height: 5,
                                thickness: 1.5,
                                color: Color(0xFFE7E7E8),
                              ),
                              //if (selectDesignsMetalDep != null)
                              //if (FFAppState().selectedMetal != null  || FFAppState().selectedMetal!.isNotEmpty)
                              if (((_model.choiceChipsValue2 == 'Pendant') ||
                                      (_model.choiceChipsValue1 == 'Pendant') ||
                                      (_model.choiceChipsValue2 ==
                                          'Bracelet') ||
                                      (_model.choiceChipsValue1 ==
                                          'Bracelet') ||
                                      (_model.choiceChipsValue2 == 'Ring') ||
                                      (_model.choiceChipsValue1 == 'Ring')) &&
                                  widget.firstLevelName != 'Rudraksha' &&
                                  productType != 3)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 8),
                                  child: Container(
                                    //decoration: BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          color: Colors.white,
                                          child: ExpandableNotifier(
                                            controller: _model
                                                .expandableExpandableController1,
                                            child: ExpandablePanel(
                                              header: RichText(
                                                textScaler:
                                                    MediaQuery.of(context)
                                                        .textScaler,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Select Designs: ',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            letterSpacing: 0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                    TextSpan(
                                                      text: selectDesignType,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                    )
                                                  ],
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        letterSpacing: 0,
                                                      ),
                                                ),
                                              ),
                                              collapsed: Container(),
                                              expanded: Builder(
                                                builder: (context) {
                                                  if ((_model.choiceChipsValue2 == 'Bracelet') ||
                                                      (_model.choiceChipsValue1 ==
                                                          'Bracelet') ||
                                                      (_model.choiceChipsValue2 ==
                                                          'Pendant') ||
                                                      (_model.choiceChipsValue1 ==
                                                          'Pendant') ||
                                                      (_model.choiceChipsValue2 ==
                                                          'Ring') ||
                                                      (selectDesignType ==
                                                          'Ring') ||
                                                      (selectDesignType ==
                                                          'Bracelet') ||
                                                      (selectDesignType ==
                                                          'Pendant')) {
                                                    return FutureBuilder<
                                                        ApiCallResponse>(
                                                      future:
                                                          metalDependantDesign
                                                              .call(
                                                        hosturl: FFAppConstants
                                                            .sanityurl,
                                                        slugValue: widget
                                                            .productSlugValue,
                                                        designType: _model
                                                            .selectedDesignType
                                                            .toString(),
                                                        metal: metalId,
                                                        group: _model
                                                            .selectedGroupId
                                                            .toString(),
                                                      ),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (!snapshot.hasData) {
                                                          return SizedBox(
                                                            height: 250,
                                                            child:
                                                                ShimmerWidget(),
                                                          );
                                                        }

                                                        final metalDependentResponse =
                                                            snapshot.data!;
                                                        print(
                                                            'Full API response: ${metalDependentResponse.jsonBody}');
                                                        print(
                                                            'Calling API with:');
                                                        print(
                                                            'Slug: ${widget.productSlugValue}');
                                                        print(
                                                            'Design Type: ${_model.selectedDesignType}');
                                                        print(
                                                            'Metal: $metalType');
                                                        print(
                                                            'Metal: $metalId');
                                                        print(
                                                            'Group: ${_model.selectedGroupId}');

                                                        final metalData = getJsonField(
                                                                metalDependentResponse
                                                                    .jsonBody,
                                                                r'''$.data''',
                                                                true) ??
                                                            [];

                                                        print(
                                                            'Metal dependent data: $metalData');

                                                        return SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: List.generate(
                                                                metalData
                                                                    .length,
                                                                (selectDesgnIndex) {
                                                              final metalItem =
                                                                  metalData[
                                                                      selectDesgnIndex];
                                                              return InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  setState(() {
                                                                    // Update the selected design color index
                                                                    _model.selecteddesigncolor =
                                                                        selectDesgnIndex;

                                                                    // Update the design price and id
                                                                    _model.designprice =
                                                                        getJsonField(
                                                                      metalItem,
                                                                      r'''$.price''',
                                                                    ).toInt();
                                                                    _model.selecteddesignid =
                                                                        getJsonField(
                                                                      metalItem,
                                                                      r'''$.id''',
                                                                    );

                                                                    // After selecting, update the default selected value to the current selection
                                                                    selectDesignsMetalDep = getJsonField(
                                                                            metalItem,
                                                                            r'''$.name''')
                                                                        .toString();
                                                                  });

                                                                  /*setState(() {});
                                                                      _model.selecteddesign = !_model.selecteddesign;
                                                                      _model.selecteddesigncolor = selectDesgnIndex;
                                                                      _model.designprice = getJsonField(
                                                                        metalItem,
                                                                        r'''$.price''',
                                                                      ).toInt();
                                                                      _model.selecteddesignid = getJsonField(
                                                                        metalItem,
                                                                        r'''$.id''',
                                                                      );
                                                                      setState(() {});*/
                                                                  print(
                                                                      '_.selecteddesignid: ${_model.selecteddesignid}');
                                                                  print(
                                                                      'selectedpendentdesign: ${_model.selecteddesigncolor}');
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 114,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: (_model.selecteddesigncolor ==
                                                                                selectDesgnIndex ||
                                                                            selectDesignsMetalDep ==
                                                                                getJsonField(metalItem, r'''$.name''')
                                                                                    .toString())
                                                                        ? const Color(
                                                                            0x26740074)
                                                                        : FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: (_model.selecteddesigncolor == selectDesgnIndex || selectDesignsMetalDep == getJsonField(metalItem, r'''$.name''').toString())
                                                                          ? const Color(
                                                                              0xFF740074)
                                                                          : FlutterFlowTheme.of(context)
                                                                              .secondaryBackground,
                                                                    ),
                                                                    /*color: _model.selecteddesigncolor == selectDesgnIndex
                                                                            ? const Color(0x26740074)
                                                                            : FlutterFlowTheme.of(context).secondaryBackground,
                                                                        borderRadius: BorderRadius.circular(5),
                                                                        border: Border.all(
                                                                          color: _model.selecteddesigncolor == selectDesgnIndex
                                                                              ? const Color(0xFF740074)
                                                                              : FlutterFlowTheme.of(context).secondaryBackground,
                                                                        ),*/
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            4,
                                                                            7,
                                                                            4),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(16),
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            fadeInDuration:
                                                                                Duration(milliseconds: 100),
                                                                            fadeOutDuration:
                                                                                Duration(milliseconds: 100),
                                                                            imageUrl:
                                                                                getJsonField(metalItem, r'''$.image''').toString(),
                                                                            width:
                                                                                93,
                                                                            height:
                                                                                120,
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              42,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              AutoSizeText(
                                                                            getJsonField(metalItem, r'''$.name''').toString(),
                                                                            maxLines:
                                                                                2,
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
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            7),
                                                                        child:
                                                                            RichText(
                                                                          textScaler:
                                                                              MediaQuery.of(context).textScaler,
                                                                          text:
                                                                              TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: '+',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Montserrat',
                                                                                      fontSize: 14,
                                                                                      letterSpacing: 0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                    ),
                                                                              ),
                                                                              TextSpan(
                                                                                text: '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(
                                                                                  getJsonField(metalItem, r'''$.price''').toString(),
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
                                                                          maxLines:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            12)),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    return Container(
                                                      width: 405,
                                                      height: 1,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                    );
                                                  }
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
                                                collapseIcon: Icons
                                                    .keyboard_arrow_up_sharp,
                                                iconColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        //if (_model.selecteddesigncolor != null && _model.choiceChipsValue2 != 'Ring')
                                        if (selectDesignsMetalDep != null &&
                                            _model.choiceChipsValue2 != 'Ring')
                                          Divider(
                                            height: 2,
                                            thickness: 1,
                                            color: Color(0xFFE7E7E8),
                                          ),
                                        //if (_model.selecteddesigncolor != null && _model.choiceChipsValue2 != 'Ring')
                                        if (selectDesignsMetalDep != null &&
                                            _model.choiceChipsValue2 !=
                                                'Ring' &&
                                            selectDesignType != 'Ring')
                                          Container(
                                            decoration: BoxDecoration(),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  color: Colors.white,
                                                  child: ExpandableNotifier(
                                                    controller: _model
                                                        .expandableExpandableController4,
                                                    child: ExpandablePanel(
                                                      header: RichText(
                                                        textScaler:
                                                            MediaQuery.of(
                                                                    context)
                                                                .textScaler,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  'Select Chain / Thread (Optional)',
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
                                                      collapsed: Container(),
                                                      expanded: Builder(
                                                        builder: (context) {
                                                          return FutureBuilder<
                                                              ApiCallResponse>(
                                                            future: metalDependantDesign.call(
                                                                hosturl:
                                                                    FFAppConstants
                                                                        .sanityurl,
                                                                slugValue: widget
                                                                    .productSlugValue,
                                                                designType: _model
                                                                    .selectedDesignType
                                                                    .toString(),
                                                                metal: 2
                                                                    .toString(),
                                                                group: _model
                                                                    .selectedGroupId
                                                                    .toString()),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    //height: 25.0,
                                                                    child:
                                                                        ShimmerWidget(),
                                                                  ),
                                                                );
                                                              }

                                                              final metalDependentResponse =
                                                                  snapshot
                                                                      .data!;
                                                              final metalData = getJsonField(
                                                                      metalDependentResponse
                                                                          .jsonBody,
                                                                      r'''$.chain''',
                                                                      true) ??
                                                                  [];

                                                              if (kDebugMode) {
                                                                print(
                                                                    'Metal dependent data: $metalData');
                                                              }

                                                              return SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: List.generate(
                                                                      metalData
                                                                          .length,
                                                                      (index) {
                                                                    final metalItem =
                                                                        metalData[
                                                                            index];
                                                                    return InkWell(
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
                                                                        setState(
                                                                            () {
                                                                          _model.selectedchain =
                                                                              !_model.selectedchain;
                                                                          _model.chainPrice =
                                                                              getJsonField(
                                                                            metalItem,
                                                                            r'''$.price''',
                                                                          ).toInt();
                                                                          _model.selectedchainid =
                                                                              getJsonField(
                                                                            metalItem,
                                                                            r'''$.id''',
                                                                          );
                                                                          _model.selectedchaindesign =
                                                                              index;

                                                                          // After selecting, update the default selected value to the current selection
                                                                          selectDesignsChainDep =
                                                                              getJsonField(metalItem, r'''$.name''').toString();
                                                                        });

                                                                        print(
                                                                            '_model.selectedchainid: ${_model.selectedchainid}');
                                                                        print(
                                                                            '_model.selectedchaindesign: ${_model.selectedchaindesign}');
                                                                        print(
                                                                            '_model.chainPrice: ${_model.chainPrice}');
                                                                        print(
                                                                            '_model.selectedchaindesign: ${_model.selectedchaindesign}');
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            114,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: (_model.selectedchaindesign == index || selectDesignsChainDep == getJsonField(metalItem, r'''$.name''').toString())
                                                                              ? const Color(0x26740074)
                                                                              : FlutterFlowTheme.of(context).secondaryBackground,
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                          border:
                                                                              Border.all(
                                                                            color: (_model.selectedchaindesign == index || selectDesignsChainDep == getJsonField(metalItem, r'''$.name''').toString())
                                                                                ? const Color(0xFF740074)
                                                                                : FlutterFlowTheme.of(context).secondaryBackground,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children:
                                                                              [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(7, 4, 7, 4),
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(16),
                                                                                child: CachedNetworkImage(
                                                                                  fadeInDuration: Duration(milliseconds: 100),
                                                                                  fadeOutDuration: Duration(milliseconds: 100),
                                                                                  imageUrl: getJsonField(metalItem, r'''$.image''').toString(),
                                                                                  width: 93,
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
                                                                                  getJsonField(metalItem, r'''$.name''').toString(),
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
                                                                                      text: '+',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Montserrat',
                                                                                            fontSize: 14,
                                                                                            letterSpacing: 0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
                                                                                    ),
                                                                                    TextSpan(
                                                                                      text: '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(
                                                                                        getJsonField(metalItem, r'''$.price''').toString(),
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
                                                        },
                                                      ),
                                                      theme:
                                                          ExpandableThemeData(
                                                        tapHeaderToExpand: true,
                                                        tapBodyToExpand: false,
                                                        tapBodyToCollapse:
                                                            false,
                                                        headerAlignment:
                                                            ExpandablePanelHeaderAlignment
                                                                .center,
                                                        hasIcon: true,
                                                        expandIcon: Icons
                                                            .keyboard_arrow_down,
                                                        collapseIcon: Icons
                                                            .keyboard_arrow_up_sharp,
                                                        iconColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        if (selectDesignsMetalDep != null &&
                                            _model.choiceChipsValue2 !=
                                                'Ring' &&
                                            selectDesignType != 'Ring')
                                          SizedBox(height: 4),
                                        if (selectDesignsMetalDep != null &&
                                            _model.choiceChipsValue2 !=
                                                'Pendant' &&
                                            selectDesignType != 'Ring' &&
                                            selectDesignType != 'Pendant')
                                          Divider(
                                            height: 2,
                                            thickness: 1,
                                            color: Color(0xFFE7E7E8),
                                          ),
                                        if (selectDesignsMetalDep != null)
                                          Builder(
                                            builder: (context) {
                                              if (_model.choiceChipsValue2 !=
                                                      'Pendant' &&
                                                  selectDesignType !=
                                                      'Pendant') {
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 8, 0, 0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            (_model.choiceChipsValue2 ==
                                                                        'Ring' ||
                                                                    selectDesignType ==
                                                                        'Ring')
                                                                ? 'Ring Size System:'
                                                                : 'Wrist / Upper Arm Size:',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                          SizedBox(
                                                              width:
                                                                  _model.choiceChipsValue2 ==
                                                                          'Ring'
                                                                      ? 16
                                                                      : 10),
                                                          Expanded(
                                                            child:
                                                                MetalDropdown(
                                                              items: (_model.choiceChipsValue2 ==
                                                                          'Ring' ||
                                                                      selectDesignType ==
                                                                          'Ring')
                                                                  ? ringsizesystem
                                                                  : wristsize,
                                                              //initialValue: _model.choiceChipsValue2 == 'Ring' ? 'Select Ring Size System' : 'Select Wrist Size',
                                                              initialValue: (_model
                                                                              .choiceChipsValue2 ==
                                                                          'Ring' ||
                                                                      selectDesignType ==
                                                                          'Ring')
                                                                  ? selectedRingSizeSystem ??
                                                                      'Select Ring Size System'
                                                                  : (selectDesignType ==
                                                                              'Bracelet' &&
                                                                          selectedWristSize !=
                                                                              null)
                                                                      ? selectedWristSize // Display selected wrist size if available
                                                                      : 'Select Wrist Size',
                                                              selectedValue: FFAppState()
                                                                              .selectedSizeSystem !=
                                                                          null &&
                                                                      ringsizesystem
                                                                          .contains(FFAppState()
                                                                              .selectedSizeSystem)
                                                                  ? FFAppState()
                                                                      .selectedSizeSystem // Ensure selected value is valid
                                                                  : null, // Reset if invalid
                                                              onChanged: (val) {
                                                                setState(() {
                                                                  FFAppState()
                                                                          .selectedRingSize =
                                                                      null; // Reset ring size
                                                                  FFAppState()
                                                                          .selectedSizeSystem =
                                                                      val;
                                                                  print(
                                                                      'Selected Size System: ${FFAppState().selectedSizeSystem}');
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      // Conditionally display ring size based on selected system
                                                      if ((FFAppState()
                                                                      .selectedSizeSystem !=
                                                                  null ||
                                                              selectedRingSizeSystem !=
                                                                  null) &&
                                                          FFAppState()
                                                                  .selectedSizeSystem !=
                                                              'Later / Don\'t Know' &&
                                                          selectDesignType !=
                                                              'Bracelet')
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      8, 0, 0),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Ring Size:',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                              ),
                                                              SizedBox(
                                                                  width: 10),
                                                              if (FFAppState()
                                                                          .selectedSizeSystem ==
                                                                      'Indian Ring Size System' ||
                                                                  selectedRingSizeSystem ==
                                                                      'Indian Ring Size System')
                                                                Expanded(
                                                                  child:
                                                                      MetalDropdown(
                                                                    items: List.generate(
                                                                        indianarray
                                                                            .length,
                                                                        (index) =>
                                                                            indianarray[index].toString()),
                                                                    initialValue:
                                                                        selectedRingSize ??
                                                                            'Select Ring Size',
                                                                    selectedValue:
                                                                        FFAppState()
                                                                            .selectedRingSize, // Pass the current selected ring size
                                                                    onChanged:
                                                                        (val) {
                                                                      setState(
                                                                          () {
                                                                        FFAppState().selectedRingSize =
                                                                            val;
                                                                      });
                                                                      print(
                                                                          'Selected Ring Size: ${FFAppState().selectedRingSize}');
                                                                    },
                                                                  ),
                                                                ),
                                                              if (FFAppState()
                                                                      .selectedSizeSystem ==
                                                                  'US Ring Size System')
                                                                Expanded(
                                                                  child:
                                                                      MetalDropdown(
                                                                    items:
                                                                        usarray,
                                                                    initialValue:
                                                                        'Select Ring Size',
                                                                    selectedValue:
                                                                        FFAppState()
                                                                            .selectedRingSize, // Pass the current selected ring size
                                                                    onChanged:
                                                                        (val) {
                                                                      setState(
                                                                          () {
                                                                        FFAppState().selectedRingSize =
                                                                            val;
                                                                      });
                                                                      print(
                                                                          'Selected Ring Size: ${FFAppState().selectedRingSize}');
                                                                    },
                                                                  ),
                                                                ),
                                                              if (FFAppState()
                                                                      .selectedSizeSystem ==
                                                                  'Inner Circumference')
                                                                Expanded(
                                                                  child:
                                                                      TextFormField(
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintText:
                                                                          'Ring size in mm',
                                                                      filled:
                                                                          true,
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                      enabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.grey,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(4),
                                                                      ),
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(4),
                                                                      ),
                                                                      errorBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.red,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(4),
                                                                      ),
                                                                      focusedErrorBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.red,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(4),
                                                                      ),
                                                                      contentPadding: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              8,
                                                                          horizontal:
                                                                              12),
                                                                    ),
                                                                    cursorColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    inputFormatters: [
                                                                      LengthLimitingTextInputFormatter(
                                                                          2),
                                                                      FilteringTextInputFormatter
                                                                          .digitsOnly,
                                                                    ],
                                                                    onChanged:
                                                                        (val) {
                                                                      setState(
                                                                          () {
                                                                        FFAppState().selectedRingSize =
                                                                            val;
                                                                      });
                                                                      print(
                                                                          'Entered Ring Size (mm): ${FFAppState().selectedRingSize}');
                                                                    },
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                );
                                              } else {
                                                return Container();
                                              }
                                            },
                                          )
                                      ],
                                    ),
                                  ),
                                ),

                              if (((_model.choiceChipsValue2 == 'Pendent') ||
                                      (_model.choiceChipsValue1 == 'Pendent') ||
                                      (_model.choiceChipsValue2 ==
                                          'Bracelet') ||
                                      (_model.choiceChipsValue1 ==
                                          'Bracelet') ||
                                      (_model.choiceChipsValue2 == 'Ring') ||
                                      (_model.choiceChipsValue1 == 'Ring')) &&
                                  widget.firstLevelName != 'Rudraksha')
                                Divider(
                                  height: 2,
                                  thickness: 1.5,
                                  color: Color(0xFFE7E7E8),
                                ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 0, 16),
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
                                        decrementIconBuilder: (enabled) =>
                                            FaIcon(
                                          FontAwesomeIcons.minus,
                                          color: enabled
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : FlutterFlowTheme.of(context)
                                                  .alternate,
                                          size: 15,
                                        ),
                                        incrementIconBuilder: (enabled) =>
                                            FaIcon(
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
                                        count: _model.countControllerValue ??=
                                            1,
                                        updateCount: (count) => setState(() =>
                                            _model.countControllerValue =
                                                count),
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

                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 10, 0, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 10, 0),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatNumber(
                                                functions.currencyConversion(
                                                    FFAppState().currencyRate,
                                                    ((valueOrDefault<int>(
                                                                  OtherProductsDetailsCall
                                                                      .productsellingprice(
                                                                    containerOtherProductsDetailsResponse
                                                                        ?.jsonBody,
                                                                  ),
                                                                  00000,
                                                                ) +
                                                                (selectedDesignPrice!) +
                                                                (selectedEnergizationPrice!) +
                                                                (selectedChainPrice!) +
                                                                (selectedCertificationPrice!)) *
                                                            (_model
                                                                .countControllerValue!))
                                                        .toString()),
                                                formatType: FormatType.decimal,
                                                decimalType:
                                                    DecimalType.periodDecimal,
                                              )}',
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                          ],
                                        ),
                                        maxLines: 2,
                                      ),
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
                                height: 2,
                                thickness: 1.5,
                                color: Color(0xFFE7E7E8),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 0),
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
                                      controller: _model
                                          .expandableExpandableController2,
                                      child: ExpandablePanel(
                                        header: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  6, 0, 0, 0),
                                          child: Text(
                                            'Description',
                                            /*style: FlutterFlowTheme.of(context)
                                                    .displaySmall
                                                    .override(
                                                      fontFamily: 'Outfit',
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.normal,
                                                    ),*/
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 14,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ),
                                        collapsed: Container(),
                                        expanded: /*Html(
                                              data: valueOrDefault<String>(
                                                OtherProductsDetailsCall.longdescription(
                                                  containerOtherProductsDetailsResponse?.jsonBody,),
                                                'Description',
                                              ),
                                            ),*/
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8,
                                                    right: 8,
                                                    bottom: 8),
                                                child: HtmlWidget(
                                                    decodedDescription)

                                                //  Html(
                                                //   data: decodedDescription,
                                                //   style: {
                                                //     "html": Style(
                                                //       fontFamily: GoogleFonts.montserrat(
                                                //         fontSize: 16,
                                                //         fontWeight: FontWeight.w500,
                                                //         color: Color(0xFF212529),
                                                //       ).fontFamily,
                                                //       color: Color(0xFF212529),
                                                //       lineHeight: LineHeight(1.5),
                                                //       margin: EdgeInsets.zero,
                                                //       padding: EdgeInsets.zero,
                                                //       textAlign: TextAlign.justify,
                                                //     ),
                                                //     "body": Style(
                                                //       margin: EdgeInsets.zero,
                                                //       padding: EdgeInsets.zero,
                                                //     ),
                                                //     "p": Style(
                                                //       margin: EdgeInsets.zero,
                                                //       padding: EdgeInsets.zero,
                                                //     ),
                                                //     "div": Style(
                                                //       margin: EdgeInsets.zero,
                                                //       padding: EdgeInsets.zero,
                                                //     ),
                                                //   },
                                                //   onLinkTap: (url, _, __, ___) async {
                                                //     if (url != null) {
                                                //       final uri = Uri.parse(url); // Convert the URL string to a Uri object

                                                //       // Launch the URL if it is valid
                                                //       if (await canLaunchUrl(uri)) {
                                                //         await launchUrl(uri, mode: LaunchMode.externalApplication);
                                                //       } else {
                                                //         // Handle cases where the URL cannot be launched
                                                //         print('Could not launch $uri');
                                                //       }
                                                //     }
                                                //   },
                                                // ),

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
                                          iconColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          iconPadding:
                                              const EdgeInsets.fromLTRB(
                                                  16, 16, 14, 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 2,
                                thickness: 1.5,
                                color: Color(0xFFE7E7E8),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 8),
                                child: Container(
                                  key: _DiamondProductDetailsWidgetratingKey,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.white,
                                    child: ExpandableNotifier(
                                      controller: _model
                                          .expandableExpandableController3,
                                      child: ExpandablePanel(
                                        header: Text(
                                          'Ratings & Reviews',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    /* Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0, 0, 10, 0),
                                                          child: RichText(
                                                            textScaler:
                                                                MediaQuery.of(
                                                                        context)
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
                                                                        fontSize:
                                                                            24,
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
                                                                    letterSpacing:
                                                                        0,
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
                                                                    letterSpacing:
                                                                        0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ),
                                                            RichText(
                                                              textScaler: MediaQuery.of(context).textScaler,
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text: valueOrDefault<String>(
                                                                      (OtherProductsDetailsCall.reviewdata(
                                                                        containerOtherProductsDetailsResponse?.jsonBody,
                                                                      ) as List).length.toString(), '0',
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
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 10, 0),
                                                      child: (OtherProductsDetailsCall
                                                                  .reviewdata(
                                                                      containerOtherProductsDetailsResponse
                                                                          ?.jsonBody) as List)
                                                              .isEmpty
                                                          ? Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .grey[300],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              child: Container(
                                                                width: 200,
                                                                child: Center(
                                                                  child: Text(
                                                                    'Be the first to review this product!',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              14,
                                                                          letterSpacing:
                                                                              0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : RichText(
                                                              textScaler:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        _formattedRating(
                                                                      OtherProductsDetailsCall
                                                                          .productrating(
                                                                        containerOtherProductsDetailsResponse
                                                                            ?.jsonBody,
                                                                      ),
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          fontSize:
                                                                              24,
                                                                          letterSpacing:
                                                                              0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                  ),
                                                                ],
                                                                style: FlutterFlowTheme.of(
                                                                        context)
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
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        (OtherProductsDetailsCall.reviewdata(
                                                                        containerOtherProductsDetailsResponse
                                                                            ?.jsonBody)
                                                                    as List)
                                                                .isEmpty
                                                            ? SizedBox
                                                                .shrink() // Hide the Overall Rating text when there are no reviews
                                                            : Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    'Overall Rating',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          fontSize:
                                                                              16,
                                                                          letterSpacing:
                                                                              0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                  ),
                                                                  RichText(
                                                                    textScaler:
                                                                        MediaQuery.of(context)
                                                                            .textScaler,
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              valueOrDefault<String>(
                                                                            (OtherProductsDetailsCall.reviewdata(containerOtherProductsDetailsResponse?.jsonBody) as List).length.toString(),
                                                                            '0',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Montserrat',
                                                                                fontSize: 12,
                                                                                letterSpacing: 0,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              ' Ratings',
                                                                          style:
                                                                              TextStyle(),
                                                                        )
                                                                      ],
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Montserrat',
                                                                            fontSize:
                                                                                12,
                                                                            letterSpacing:
                                                                                0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
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
                                                    print(
                                                        "Productid:${OtherProductsDetailsCall.rudrakshaProductid(
                                                      containerOtherProductsDetailsResponse
                                                          ?.jsonBody,
                                                    )?.toString()}");
                                                    print(
                                                        "productMainType:${OtherProductsDetailsCall.rudrakshaMainProductType(
                                                      containerOtherProductsDetailsResponse
                                                          ?.jsonBody,
                                                    )?.toString()}");

                                                    print(
                                                        "reviewcustomercomment:${OtherProductsDetailsCall.reviewcustomercomment(
                                                      containerOtherProductsDetailsResponse
                                                          ?.jsonBody,
                                                    )}");
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
                                                              ? FocusScope.of(
                                                                      context)
                                                                  .requestFocus(
                                                                      _model
                                                                          .unfocusNode)
                                                              : FocusScope.of(
                                                                      context)
                                                                  .unfocus(),
                                                          child: Padding(
                                                            padding: MediaQuery
                                                                .viewInsetsOf(
                                                                    context),
                                                            child:
                                                                AddReviewPopUpWidget(
                                                              mainproducttype:
                                                                  serializeParam(
                                                                OtherProductsDetailsCall
                                                                    .rudrakshaMainProductType(
                                                                  containerOtherProductsDetailsResponse
                                                                      ?.jsonBody,
                                                                )?.toString(),
                                                                ParamType
                                                                    .String,
                                                              ),
                                                              productid:
                                                                  serializeParam(
                                                                OtherProductsDetailsCall
                                                                    .rudrakshaProductid(
                                                                  containerOtherProductsDetailsResponse
                                                                      ?.jsonBody,
                                                                )?.toString(),
                                                                ParamType
                                                                    .String,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ).then((value) =>
                                                        safeSetState(() {}));
                                                  },
                                                  text: 'Rate Now',
                                                  options: FFButtonOptions(
                                                    height: 40,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                24, 0, 24, 0),
                                                    iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 0, 0),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          letterSpacing: 0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                    elevation: 0,
                                                    borderSide: BorderSide(
                                                      color: Color(0xFF740074),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
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
                                                  RatingBarIndicator(
                                                    itemBuilder:
                                                        (context, index) =>
                                                            Icon(
                                                      Icons.star_rounded,
                                                      color: Color(0xFFF59E0B),
                                                    ),
                                                    direction: Axis.horizontal,
                                                    rating:
                                                        OtherProductsDetailsCall
                                                            .productrating(
                                                      containerOtherProductsDetailsResponse
                                                          ?.jsonBody,
                                                    )!,
                                                    unratedColor:
                                                        Color(0x69F59E0B),
                                                    itemCount: 5,
                                                    itemSize: 20,
                                                  ),
                                                  Text(
                                                    valueOrDefault<String>(
                                                      OtherProductsDetailsCall
                                                          .reviewcustomercomment(
                                                        containerOtherProductsDetailsResponse
                                                            ?.jsonBody,
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
                                                          OtherProductsDetailsCall
                                                              .reviewcustomername(
                                                            containerOtherProductsDetailsResponse
                                                                ?.jsonBody,
                                                          ),
                                                          'x',
                                                        ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color(
                                                                  0xFF696969),
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        valueOrDefault<String>(
                                                          OtherProductsDetailsCall
                                                                      .reviewdate(
                                                                    containerOtherProductsDetailsResponse
                                                                        ?.jsonBody,
                                                                  ) !=
                                                                  null
                                                              ? formatDate(
                                                                  OtherProductsDetailsCall
                                                                      .reviewdate(
                                                                  containerOtherProductsDetailsResponse
                                                                      ?.jsonBody,
                                                                )!)
                                                              : 'x',
                                                          'x',
                                                        ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color(
                                                                  0xFF696969),
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: FFButtonWidget(
                                                      onPressed: () {
                                                        context.pushNamed(
                                                          'AllReviewsWidget',
                                                          queryParameters: {
                                                            'reviewlist':
                                                                serializeParam(
                                                              OtherProductsDetailsCall
                                                                  .reviewdata(
                                                                containerOtherProductsDetailsResponse
                                                                    ?.jsonBody,
                                                              ),
                                                              ParamType.JSON,
                                                              // isList: true,
                                                            ),
                                                            'productSlugValue':
                                                                serializeParam(
                                                              widget
                                                                  .productSlugValue,
                                                              ParamType.String,
                                                            ),
                                                            'producttype':
                                                                serializeParam(
                                                              widget
                                                                  .producttype,
                                                              ParamType.String,
                                                            ),
                                                          }.withoutNulls,
                                                        );
                                                      },
                                                      text: 'View All Reviews',
                                                      options: FFButtonOptions(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                1,
                                                        height: 40,
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(24, 0,
                                                                    24, 0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 0),
                                                        color:
                                                            Color(0xFF740074),
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  letterSpacing:
                                                                      0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                        elevation: 0,
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFF740074),
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                    ),
                                                  ),
                                                  /*InkWell(
                                                        onTap: () {
                                                          context.pushNamed(
                                                            'AllReviewsWidget',
                                                            queryParameters: {
                                                              'reviewlist':
                                                                  serializeParam(
                                                                OtherProductsDetailsCall
                                                                    .reviewdata(
                                                                  containerOtherProductsDetailsResponse
                                                                      ?.jsonBody,
                                                                ),
                                                                ParamType.JSON,
                                                                // isList: true,
                                                              ),
                                                              'productSlugValue':
                                                                  serializeParam(
                                                                widget
                                                                    .productSlugValue,
                                                                ParamType.String,
                                                              ),
                                                              'producttype':
                                                                  serializeParam(
                                                                widget.producttype,
                                                                ParamType.String,
                                                              ),
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
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        'View All ',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
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
                                                                  */ /*    TextSpan(
                                                          text: valueOrDefault<String>(
                                                          (OtherProductsDetailsCall.reviewdata(
                                                          containerOtherProductsDetailsResponse.jsonBody,
                                                          ) as List).length.toString(),
                                                          '0',
                                                          ),

                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),*/ /*
                                                                  TextSpan(
                                                                    text:
                                                                        'Reviews',
                                                                    style:
                                                                        TextStyle(
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
                                                                      letterSpacing:
                                                                          0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                              ),
                                                            ),
                                                         */ /*   FlutterFlowIconButton(
                                                              borderColor: Colors
                                                                  .transparent,
                                                              borderRadius: 30,
                                                              borderWidth: 1,
                                                              buttonSize:
                                                                  MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.1,
                                                              icon: Icon(
                                                                Icons.navigate_next,
                                                                color: FlutterFlowTheme
                                                                        .of(context)
                                                                    .primaryText,
                                                                size: 25,
                                                              ),
                                                              onPressed: () {
                                                                print(
                                                                    'IconButton pressed ...');
                                                              },
                                                            ),*/ /*
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
                                          iconColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          iconPadding: EdgeInsets.fromLTRB(
                                              16, 16, 8, 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 2,
                                thickness: 1.5,
                                color: Color(0xFFE7E7E8),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 0, 20),
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
                                          0, 0, 0, 16),
                                      child: Builder(
                                        builder: (context) {
                                          final relatedProduct =
                                              OtherProductsDetailsCall
                                                      .relatedproduct(
                                                    containerOtherProductsDetailsResponse
                                                        ?.jsonBody,
                                                  )?.toList() ??
                                                  [];
                                          // Sort the list
                                          relatedProduct.sort((a, b) {
                                            // Check for reserved field first
                                            if (getJsonField(a,
                                                            r'''$.reserved''')
                                                        .toString() ==
                                                    'true' &&
                                                getJsonField(b,
                                                            r'''$.reserved''')
                                                        .toString() ==
                                                    'false') {
                                              return -1;
                                            } else if (getJsonField(a,
                                                            r'''$.reserved''')
                                                        .toString() ==
                                                    'false' &&
                                                getJsonField(b,
                                                            r'''$.reserved''')
                                                        .toString() ==
                                                    'true') {
                                              return 1;
                                            }

                                            // If both have the same reserved status, check the out_of_stock field
                                            if (getJsonField(a,
                                                            r'''$.out_of_stock''')
                                                        .toString() ==
                                                    'true' &&
                                                getJsonField(b,
                                                            r'''$.out_of_stock''')
                                                        .toString() ==
                                                    'false') {
                                              return 1;
                                            } else if (getJsonField(a,
                                                            r'''$.out_of_stock''')
                                                        .toString() ==
                                                    'false' &&
                                                getJsonField(b,
                                                            r'''$.out_of_stock''')
                                                        .toString() ==
                                                    'true') {
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
                                                print(
                                                    "out_of_stock :${getJsonField(
                                                  relatedProductItem,
                                                  r'''$.out_of_stock''',
                                                ).toString()}");
                                                return InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    if (widget.producttype ==
                                                        FFAppConstants
                                                            .RudrakshaMasterProductDetailsApi) {
                                                      context.pushNamed(
                                                        'DiamondProductDetails',
                                                        queryParameters: {
                                                          'productSlugValue':
                                                              serializeParam(
                                                            getJsonField(
                                                              relatedProductItem,
                                                              r'''$.slug_value''',
                                                            ).toString(),
                                                            ParamType.String,
                                                          ),
                                                          'producttype':
                                                              serializeParam(
                                                            FFAppConstants
                                                                .RudrakshaMasterProductDetailsApi,
                                                            ParamType.String,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String,
                                                            dynamic>{
                                                          kTransitionInfoKey:
                                                              TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType:
                                                                PageTransitionType
                                                                    .bottomToTop,
                                                          ),
                                                        },
                                                      );
                                                    } else {
                                                      context.pushNamed(
                                                        'DiamondProductDetails',
                                                        queryParameters: {
                                                          'productSlugValue':
                                                              serializeParam(
                                                            getJsonField(
                                                              relatedProductItem,
                                                              r'''$.slug_value''',
                                                            ).toString(),
                                                            ParamType.String,
                                                          ),
                                                          'producttype':
                                                              serializeParam(
                                                            FFAppConstants
                                                                .GemstoneMasterProductDetailsApi,
                                                            ParamType.String,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String,
                                                            dynamic>{
                                                          kTransitionInfoKey:
                                                              TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType:
                                                                PageTransitionType
                                                                    .bottomToTop,
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
                                                        height: 220,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
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
                                                                  relatedProductItem,
                                                                  r'''$.thumbnail_image''',
                                                                ).toString(),
                                                                width: 152,
                                                                height: 104,
                                                                fit: BoxFit
                                                                    .fitWidth,
                                                              ),
                                                            ),
                                                            Container(
                                                              width: double
                                                                  .infinity,
                                                              height: 50,
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child:
                                                                  AutoSizeText(
                                                                getJsonField(
                                                                  relatedProductItem,
                                                                  r'''$.product_name''',
                                                                ).toString(),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      color: Color(
                                                                          0xFF696969),
                                                                      fontSize:
                                                                          14,
                                                                      letterSpacing:
                                                                          0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      lineHeight:
                                                                          1.5,
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
                                                                    text: /*getJsonField(
                                                                          relatedProductItem,
                                                                          r'''$.selling_price''',
                                                                        ).toString(),*/
                                                                        '${valueOrDefault<String>(
                                                                      FFAppState()
                                                                          .currencyName,
                                                                      'INR',
                                                                    )} ${formatNumber(
                                                                      functions.currencyConversion(
                                                                          FFAppState().currencyRate,
                                                                          getJsonField(
                                                                            relatedProductItem,
                                                                            r'''$.selling_price''',
                                                                          ).toString()),
                                                                      formatType:
                                                                          FormatType
                                                                              .decimal,
                                                                      decimalType:
                                                                          DecimalType
                                                                              .automatic,
                                                                    )}',
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                                  )
                                                                ],
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      fontSize:
                                                                          14,
                                                                      letterSpacing:
                                                                          0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                              ),
                                                              maxLines: 2,
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              0),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/Rating_Icon.png',
                                                                    width: 16,
                                                                    height: 16,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                                RichText(
                                                                  textScaler: MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text:
                                                                            getJsonField(
                                                                          relatedProductItem,
                                                                          r'''$.product_rating''',
                                                                        ).toString(),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Montserrat',
                                                                              letterSpacing: 0,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                      ),
                                                                      /*TextSpan(
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
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          letterSpacing:
                                                                              0,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 5)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      if (getJsonField(
                                                                  relatedProductItem,
                                                                  r'''$.out_of_stock''')
                                                              .toString() ==
                                                          'true')
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1, -1),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        5,
                                                                        5,
                                                                        0),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          12),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          12),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        5.0),
                                                                child: Text(
                                                                  "OUT OF STOCK",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      if (getJsonField(
                                                                  relatedProductItem,
                                                                  r'''$.reserved''')
                                                              .toString() ==
                                                          'true')
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1, -1),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        5,
                                                                        5,
                                                                        0),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          12),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          12),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        5.0),
                                                                child: Text(
                                                                  "RESERVED",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
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
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              color: Colors.white, // Set the background color to white
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(children: [
              if ((OtherProductsDetailsCall.out_of_stock(
                        containerOtherProductsDetailsResponse?.jsonBody,
                      ) ==
                      false) &&
                  (OtherProductsDetailsCall.reserved(
                        containerOtherProductsDetailsResponse?.jsonBody,
                      ) ==
                      false))
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          print(
                              "data88: ${getJsonField(containerOtherProductsDetailsResponse?.jsonBody, r'''$.data''').toString()}");
                          if (currentAuthenticationToken != null &&
                              currentAuthenticationToken != '') {
                            FFAppState().buynow = false;
                            if (widget.producttype ==
                                FFAppConstants
                                    .RudrakshaMasterProductDetailsApi) {
                              var _shouldSetState = false;
                              _model.apiResultj7i = await AddToCartCall.call(
                                hosturl: FFAppConstants.sanityurl,
                                token: currentAuthenticationToken,
                                productid:
                                    OtherProductsDetailsCall.rudrakshaProductid(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                )?.toString(),
                                productType: OtherProductsDetailsCall
                                    .rudrakshaMainProductType(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                )?.toString(),
                                productvariation: OtherProductsDetailsCall
                                    .productVariantStatus(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                ),
                                productvariationId: 2,
                                quantity:
                                    _model.countControllerValue?.toString(),
                                energization: OtherProductsDetailsCall
                                    .pujaenergizationlistid(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                )?[_model.selectedEnergizationIndex!],
                                certification: (OtherProductsDetailsCall
                                        .certificationlistid(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                )?[_model.selectedCertificationindex!])
                                    ?.toString(),
                                design: _model.selecteddesignid,
                                chain: _model.selectedchainid,
                                //ringSize: FFAppState().selectedRingSize,
                                ringSize: FFAppState().selectedRingSize != null
                                    ? FFAppState().selectedRingSize
                                    : '',
                                ringSizeSystem:
                                    _model.choiceChipsValue2 == 'Ring'
                                        ? FFAppState().selectedSizeSystem
                                        : '',
                                wristSize:
                                    _model.choiceChipsValue2 == 'Bracelet'
                                        ? FFAppState().selectedSizeSystem
                                        : '',
                              );
                              _shouldSetState = true;
                              if ((_model.apiResultj7i?.succeeded ?? true)) {
                                if (getJsonField(
                                      (_model.apiResultj7i?.jsonBody ?? ''),
                                      r'''$.status''',
                                    ).toString() !=
                                    'failed')
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        getJsonField(
                                          (_model.apiResultj7i?.jsonBody ?? ''),
                                          r'''$.msg''',
                                        ).toString(),
                                        //'Product added in Cart',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .containerFillColor,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context).primary,
                                    ),
                                  );
                                /*ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                getJsonField(
                                                  (_model.apiResultj7i?.jsonBody ?? ''),
                                                  r'''$.msg''',
                                                ).toString(),
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(context).containerFillColor,
                                                ),
                                              ),
                                              duration: Duration(milliseconds: 4000),
                                              backgroundColor: FlutterFlowTheme.of(context).primary,
                                            ),
                                          );*/
                                if (getJsonField(
                                      (_model.apiResultj7i?.jsonBody ?? ''),
                                      r'''$.status''',
                                    ).toString() !=
                                    "failed")
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () => _model
                                                .unfocusNode.canRequestFocus
                                            ? FocusScope.of(context)
                                                .requestFocus(
                                                    _model.unfocusNode)
                                            : FocusScope.of(context).unfocus(),
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: MyCartWidget(),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      getJsonField(
                                        (_model.apiResultj7i?.jsonBody ?? ''),
                                        r'''$.msg''',
                                      ).toString(),
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .containerFillColor,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                  ),
                                );
                                if (_shouldSetState) setState(() {});
                                return;
                              }
                              _model.productid =
                                  OtherProductsDetailsCall.rudrakshaProductid(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              );
                              _model.productmaintypee = OtherProductsDetailsCall
                                  .rudrakshaMainProductType(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              );
                              _model.productvarient =
                                  OtherProductsDetailsCall.productVariantStatus(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              )!;
                              setState(() {});
                              if (_shouldSetState) setState(() {});
                            } else {
                              var _shouldSetState = false;
                              _model.apiResult5ep = await AddToCartCall.call(
                                hosturl: FFAppConstants.sanityurl,
                                token: currentAuthenticationToken,
                                productid:
                                    OtherProductsDetailsCall.rudrakshaProductid(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                )?.toString(),
                                productType: OtherProductsDetailsCall
                                    .rudrakshaMainProductType(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                )?.toString(),
                                productvariation: OtherProductsDetailsCall
                                    .productVariantStatus(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                ),
                                productvariationId: 2,
                                quantity:
                                    _model.countControllerValue?.toString(),
                                energization: OtherProductsDetailsCall
                                    .pujaenergizationlistid(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                )?[_model.selectedEnergizationIndex!],
                                design: _model.selecteddesignid,
                                chain: _model.selectedchainid,
                                //ringSize: FFAppState().selectedRingSize,
                                ringSize: FFAppState().selectedRingSize != null
                                    ? FFAppState().selectedRingSize
                                    : '',
                                ringSizeSystem:
                                    _model.choiceChipsValue2 == 'Ring'
                                        ? FFAppState().selectedSizeSystem
                                        : '',
                                wristSize:
                                    _model.choiceChipsValue2 == 'Bracelet'
                                        ? FFAppState().selectedSizeSystem
                                        : '',
                              );

                              final requestData = {
                                'hosturl': FFAppConstants.sanityurl,
                                'token': currentAuthenticationToken,
                                'productid':
                                    OtherProductsDetailsCall.rudrakshaProductid(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                )?.toString(),
                                'productType': OtherProductsDetailsCall
                                    .rudrakshaMainProductType(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                )?.toString(),
                                'productvariation': OtherProductsDetailsCall
                                    .productVariantStatus(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                ),
                                'productvariationId': 2,
                                'quantity':
                                    _model.countControllerValue?.toString(),
                                'energization': OtherProductsDetailsCall
                                    .pujaenergizationlistid(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                )?[_model.selectedEnergizationIndex!],
                                'design': _model.selecteddesignid,
                                'chain': _model.selectedchainid,
                                'ringSize': FFAppState().selectedRingSize,
                                'ringSizeSystem':
                                    _model.choiceChipsValue2 == 'Ring'
                                        ? FFAppState().selectedSizeSystem
                                        : null,
                                'wristSize':
                                    _model.choiceChipsValue2 == 'Bracelet'
                                        ? FFAppState().selectedSizeSystem
                                        : null,
                              };
                              _shouldSetState = true;
                              print(
                                  'Request Data JSON: ${jsonEncode(requestData)}');
                              print('API Request Data: $requestData');
                              print(
                                  'FFAppState().selectedRingSize: ${FFAppState().selectedRingSize}');
                              print(
                                  'FFAppState().selectedSizeSystem: ${FFAppState().selectedSizeSystem}');
                              print(
                                  'FFAppState().selectedSize: ${FFAppState().selectedSize}');
                              print(
                                  '_model.selecteddesignid: ${_model.selecteddesignid}');
                              print(
                                  '_model.selectedchainidapi: ${_model.selectedchainid}');
                              print(
                                  '_model.apiResult5ep?.succeeded: ${_model.apiResult5ep?.succeeded}');
                              print(
                                  '_model.apiResult5ep?.response: ${_model.apiResult5ep?.response}');
                              print(
                                  'API Error: ${_model.apiResult5ep?.jsonBody}');
                              print(
                                  'statusCode: ${_model.apiResult5ep?.statusCode}');
                              print(
                                  'exception: ${_model.apiResult5ep?.exception}');
                              print(
                                  'exceptionMessage: ${_model.apiResult5ep?.exceptionMessage}');
                              print(
                                  'exceptionMessage: ${_model.apiResult5ep?.bodyText}');
                              if ((_model.apiResult5ep?.succeeded ?? true)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      getJsonField(
                                        (_model.apiResult5ep?.jsonBody ?? ''),
                                        r'''$.msg''',
                                      ).toString(),
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .containerFillColor,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                  ),
                                );
                                if (getJsonField(
                                      (_model.apiResult5ep?.jsonBody ?? ''),
                                      r'''$.status''',
                                    ).toString() !=
                                    "failed")
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () => _model
                                                .unfocusNode.canRequestFocus
                                            ? FocusScope.of(context)
                                                .requestFocus(
                                                    _model.unfocusNode)
                                            : FocusScope.of(context).unfocus(),
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: MyCartWidget(),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      getJsonField(
                                        (_model.apiResult5ep?.jsonBody ?? ''),
                                        r'''$.msg''',
                                      ).toString(),
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .containerFillColor,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                  ),
                                );
                                if (_shouldSetState) setState(() {});
                                return;
                              }
                              _model.productid =
                                  OtherProductsDetailsCall.rudrakshaProductid(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              );
                              _model.productmaintypee = OtherProductsDetailsCall
                                  .rudrakshaMainProductType(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              );
                              _model.productvarient =
                                  OtherProductsDetailsCall.productVariantStatus(
                                containerOtherProductsDetailsResponse?.jsonBody,
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
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
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
                            if (widget.producttype ==
                                    FFAppConstants
                                        .RudrakshaMasterProductDetailsApi ||
                                widget.producttype ==
                                    FFAppConstants
                                        .GemstoneMasterProductDetailsApi) {
                              FFAppState().productid =
                                  OtherProductsDetailsCall.rudrakshaProductid(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              )!
                                      .toString();
                              FFAppState().productvariationId = 2;
                              FFAppState().productType =
                                  OtherProductsDetailsCall
                                          .rudrakshaMainProductType(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              )!
                                      .toString();

                              FFAppState().productvariation =
                                  OtherProductsDetailsCall.productVariantStatus(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              );
                              print(FFAppState().productvariation);

                              FFAppState().quantity =
                                  _model.countControllerValue!.toString();
                              FFAppState().energizationId =
                                  OtherProductsDetailsCall
                                      .pujaenergizationlistid(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              )?[_model.selectedEnergizationIndex!];
                              print(
                                  "_model.selecteddesignid ${_model.selecteddesignid}");
                              print(
                                  "FFAppState().energizationId ${FFAppState().energizationId}");

                              FFAppState().desingId = _model.selecteddesignid;
                              FFAppState().selectedCertificationId =
                                  (OtherProductsDetailsCall.certificationlistid(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              )?[_model.selectedCertificationindex!]);

                              print(
                                  "FFAppState().selectedCertificationId ${FFAppState().selectedCertificationId}");

                              FFAppState().buynow = true;
                              print(FFAppState().buynow);
                              print(FFAppState().quantity);
                              print(FFAppState().productvariation);
                              print(FFAppState().productType);
                              print(FFAppState().productvariationId);
                              print(FFAppState().productid);
                              print(FFAppState().productid);
                              context.pushNamed(
                                'DeliveryAddress',
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: const TransitionInfo(
                                    hasTransition: true,
                                    transitionType:
                                        PageTransitionType.bottomToTop,
                                    duration: Duration(milliseconds: 400),
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
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                ),
                              },
                            );
                          }
                        },
                        text: 'Buy Now',
                        options: FFButtonOptions(
                          width: MediaQuery.sizeOf(context).width * 0.44,
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: Color(0xFF740074),
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
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
                    containerOtherProductsDetailsResponse?.jsonBody,
                  ) ==
                  true)
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          final Uri phoneLaunchUri = Uri(
                            scheme: 'tel',
                            path:
                                '+917021180033', // replace with your phone number
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
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
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
                              'text':
                                  'I am interested in ${OtherProductsDetailsCall.productname(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              )} however it is out of stock. Kindly suggest an alternative.',
                            },
                          );

                          if (await canLaunchUrl(whatsappLaunchUri)) {
                            await launchUrl(whatsappLaunchUri,
                                mode: LaunchMode.externalApplication);
                          } else {
                            throw 'Could not launch $whatsappLaunchUri';
                          }
                        },
                        text: 'WHATSAPP',
                        options: FFButtonOptions(
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: FlutterFlowTheme.of(context).whatsapp,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
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
                            path:
                                'contact@rudracentre.com,info@rudracentre.com', // replace with your email address
                            queryParameters: {
                              'subject': 'Product_Inquiry',
                              'body':
                                  "I am interested in ${OtherProductsDetailsCall.productname(
                                containerOtherProductsDetailsResponse?.jsonBody,
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
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
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
              if (OtherProductsDetailsCall.reserved(
                    containerOtherProductsDetailsResponse?.jsonBody,
                  ) ==
                  true)
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          final Uri phoneLaunchUri = Uri(
                            scheme: 'tel',
                            path:
                                '+917021180033', // replace with your phone number
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
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
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
                              'text':
                                  'I am interested in ${OtherProductsDetailsCall.productname(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              )} however it is out of stock. Kindly suggest an alternative.',
                            },
                          );

                          if (await canLaunchUrl(whatsappLaunchUri)) {
                            await launchUrl(whatsappLaunchUri,
                                mode: LaunchMode.externalApplication);
                          } else {
                            throw 'Could not launch $whatsappLaunchUri';
                          }
                        },
                        text: 'WHATSAPP',
                        options: FFButtonOptions(
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: FlutterFlowTheme.of(context).whatsapp,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
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
                            path:
                                'contact@rudracentre.com,info@rudracentre.com', // replace with your email address
                            queryParameters: {
                              'subject': 'Product_Inquiry',
                              'body':
                                  "I am interested in ${OtherProductsDetailsCall.productname(
                                containerOtherProductsDetailsResponse?.jsonBody,
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
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
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
            ]),
          ),
        ),
      ]),
    );
  }

  Widget buildDefaultProductDetails() {
    return SafeArea(
      top: true,
      child: Stack(children: [
        Container(
          height: double.infinity,
          //width: double.infinity,
          child: Column(
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
                          final cartCount = functions
                              .cartBadgeCount(badgeCartResponse.jsonBody);

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
                                      transitionType:
                                          PageTransitionType.rightToLeft,
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
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 2, 10, 2),
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
                                      transitionType:
                                          PageTransitionType.rightToLeft,
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
                  producttype: widget.producttype,
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

                  final description = valueOrDefault<String>(
                    OtherProductsDetailsCall.longdescription(
                      containerOtherProductsDetailsResponse?.jsonBody,
                    ),
                    'Description',
                  );

                  int? groupId;
                  int? designType;

                  final jsonResponse =
                      containerOtherProductsDetailsResponse?.jsonBody;

                  // Determine group id based on choice chip selection
                  if (_model.choiceChipsValue1 == 'Pendent' ||
                      _model.choiceChipsValue2 == 'Pendent') {
                    groupId =
                        getJsonField(jsonResponse, r'''$.data.pendent[0]''')
                                as int? ??
                            0;
                    designType = 2;
                  } else if (_model.choiceChipsValue1 == 'Bracelet' ||
                      _model.choiceChipsValue2 == 'Bracelet') {
                    groupId =
                        getJsonField(jsonResponse, r'''$.data.bracelet[0]''')
                                as int? ??
                            0;
                    designType = 1;
                  } else if (_model.choiceChipsValue1 == 'Ring' ||
                      _model.choiceChipsValue2 == 'Ring') {
                    groupId = getJsonField(jsonResponse, r'''$.data.ring[0]''')
                            as int? ??
                        0;
                    designType = 3;
                  }

                  _model.selectedGroupId = groupId;
                  _model.selectedDesignType = designType;

                  print(
                      '_model.selectedGroupId = groupId; ${_model.selectedGroupId}');
                  print(
                      '_model.selectedDesignType = designType; ${_model.selectedDesignType}');

                  final decodedDescription = utf8.decode(description.codeUnits);

                  if (kDebugMode) {
                    print(
                        "data87: ${getJsonField(containerOtherProductsDetailsResponse?.jsonBody, r'''$.data''').toString()}");
                  }

                  return Expanded(
                    child: Container(
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
                                      0, 0, 0, 0),
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    child: Stack(
                                      alignment: AlignmentDirectional(1, 1),
                                      children: [
                                        // Generated code for this Image Widget...
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
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
                                                    child: imageZoomScreen(
                                                      imageUrls: widget
                                                                  .producttype ==
                                                              FFAppConstants
                                                                  .YantraMasterProductDetailsApi
                                                          ? OtherProductsDetailsCall
                                                                  .otherproductimageurlpath(
                                                                containerOtherProductsDetailsResponse
                                                                    ?.jsonBody,
                                                              )?.toList() ??
                                                              []
                                                          : parseImageUrls(getJsonField(
                                                                  containerOtherProductsDetailsResponse
                                                                      ?.jsonBody,
                                                                  r'''$.data.image_url[*].path''') ??
                                                              []),
                                                      initialIndex: 0,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then(
                                                (value) => safeSetState(() {}));
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            child: Stack(
                                              children: [
                                                ProductImagesWidget(
                                                  imageUrls: widget
                                                              .producttype ==
                                                          FFAppConstants
                                                              .YantraMasterProductDetailsApi
                                                      ? OtherProductsDetailsCall
                                                                  .otherproductimageurlpath(
                                                                      containerOtherProductsDetailsResponse
                                                                          ?.jsonBody)
                                                              ?.toList() ??
                                                          []
                                                      : parseImageUrls(getJsonField(
                                                              containerOtherProductsDetailsResponse
                                                                  ?.jsonBody,
                                                              r'''$.data.image_url[*].path''') ??
                                                          []),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          1, 1),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10, right: 10),
                                                    child: SvgPicture.asset(
                                                      'assets/images/zoom_image.svg',
                                                      width: 25,
                                                      height: 25,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
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
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
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
                                                                final wishlistIds =
                                                                    WishListCall.id(
                                                                            containerWishlistResponse.jsonBody) ??
                                                                        [];
                                                                final productId =
                                                                    OtherProductsDetailsCall.rudrakshaProductid(
                                                                        containerOtherProductsDetailsResponse
                                                                            ?.jsonBody);

                                                                print(
                                                                    wishlistIds);
                                                                print(
                                                                    productId);
                                                                print(WishListCall.id(
                                                                    containerWishlistResponse
                                                                        .jsonBody));
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
                                        OtherProductsDetailsCall.productname(
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
                                                  .productcode(
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
                                    if (OtherProductsDetailsCall.reviewdata(
                                            containerOtherProductsDetailsResponse
                                                ?.jsonBody) !=
                                        null)
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              _model
                                                  .expandableExpandableController3
                                                  .expanded = true;
                                              _scrollController.animateTo(
                                                _DiamondProductDetailsWidgetratingKey
                                                    .currentContext!
                                                    .findRenderObject()!
                                                    .getTransformTo(null)
                                                    .getTranslation()
                                                    .y,
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves.easeInOut,
                                              );
                                            },
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 5, 0),
                                              child: RatingBarIndicator(
                                                itemBuilder: (context, index) =>
                                                    Icon(
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
                                            OtherProductsDetailsCall
                                                .productrating(
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
                              Divider(
                                height: 2,
                                thickness: 1.5,
                                color: Color(0xFFE7E7E8),
                              ),
                              if (OtherProductsDetailsCall.pujaenergizationlist(
                                        containerOtherProductsDetailsResponse
                                            ?.jsonBody,
                                      ) !=
                                      null &&
                                  (OtherProductsDetailsCall
                                          .pujaenergizationlist(
                                    containerOtherProductsDetailsResponse
                                        ?.jsonBody,
                                  ))!
                                      .isNotEmpty)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 16, 16, 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        textScaler:
                                            MediaQuery.of(context).textScaler,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Energization: ',
                                              style: FlutterFlowTheme.of(
                                                      context)
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
                                            ),
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
                                          final selectVariation =
                                              OtherProductsDetailsCall
                                                      .pujaenergizationlist(
                                                    containerOtherProductsDetailsResponse
                                                        ?.jsonBody,
                                                  )?.toList() ??
                                                  [];

                                          // Set default selected energization if not already set
                                          if (_model.selectedEnergization ==
                                                  null &&
                                              selectVariation.isNotEmpty) {
                                            _model.selectedEnergization =
                                                getJsonField(selectVariation[0],
                                                        r'''$.name''')
                                                    .toString();
                                            _model.selectedEnergizationIndex =
                                                0; // Set index for the first energization
                                            _model.energizationprice =
                                                getJsonField(selectVariation[0],
                                                    r'''$.price''');
                                          }

                                          return SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  selectVariation.length,
                                                  (selectVariationIndex) {
                                                final selectVariationItem =
                                                    selectVariation[
                                                        selectVariationIndex];
                                                return Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 1),
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
                                                              selectVariationItem,
                                                              r'''$.price''');
                                                      setState(() {});

                                                      _model.selectedEnergizationlist =
                                                          selectVariationIndex;
                                                      _model.selectedEnergization =
                                                          getJsonField(
                                                                  selectVariationItem,
                                                                  r'''$.name''')
                                                              .toString();
                                                      _model.selectedEnergizationIndex =
                                                          selectVariationIndex;
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      height: 44,
                                                      decoration: BoxDecoration(
                                                        color: _model
                                                                    .selectedEnergizationlist ==
                                                                selectVariationIndex
                                                            ? Color(0x26740074)
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                          color: _model
                                                                      .selectedEnergizationlist ==
                                                                  selectVariationIndex
                                                              ? Color(
                                                                  0xFF740074)
                                                              : Color(
                                                                  0xFFE7E7E8),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15,
                                                                right: 15),
                                                        child: Center(
                                                          child: AutoSizeText(
                                                            getJsonField(
                                                                    selectVariationItem,
                                                                    r'''$.name''')
                                                                .toString(),
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
                                                                  lineHeight:
                                                                      1.5,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).divide(SizedBox(width: 16)),
                                            ),
                                          );
                                        },
                                      ),
                                    ].divide(SizedBox(height: 10)),
                                  ),
                                ),
                              if (OtherProductsDetailsCall.pujaenergizationlist(
                                        containerOtherProductsDetailsResponse
                                            ?.jsonBody,
                                      ) !=
                                      null &&
                                  (OtherProductsDetailsCall
                                          .pujaenergizationlist(
                                    containerOtherProductsDetailsResponse
                                        ?.jsonBody,
                                  ))!
                                      .isNotEmpty)
                                Divider(
                                  height: 2,
                                  thickness: 1.5,
                                  color: Color(0xFFE7E7E8),
                                ),
                              if (OtherProductsDetailsCall.certificationlist(
                                        containerOtherProductsDetailsResponse
                                            ?.jsonBody,
                                      ) !=
                                      null &&
                                  (OtherProductsDetailsCall.certificationlist(
                                    containerOtherProductsDetailsResponse
                                        ?.jsonBody,
                                  ))!
                                      .isNotEmpty)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 16, 16, 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        textScaler:
                                            MediaQuery.of(context).textScaler,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Certificate: ',
                                              style: FlutterFlowTheme.of(
                                                      context)
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
                                                _model.selectedCertification,
                                                'Certificate',
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
                                          final selectVariation =
                                              OtherProductsDetailsCall
                                                      .certificationlist(
                                                    containerOtherProductsDetailsResponse
                                                        ?.jsonBody,
                                                  )?.toList() ??
                                                  [];
                                          return SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  selectVariation.length,
                                                  (selectVariationIndex) {
                                                final selectVariationItem =
                                                    selectVariation[
                                                        selectVariationIndex];
                                                return Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 1),
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
                                                      _model.selectedcertificateprice =
                                                          getJsonField(
                                                        selectVariationItem,
                                                        r'''$.price''',
                                                      );
                                                      setState(() {});
                                                      if (_model
                                                              .selecteddesign ==
                                                          true) {
                                                        _model.selectedCertificationindex =
                                                            selectVariationIndex;
                                                        setState(() {});
                                                      } else {
                                                        _model.selectedCertificationindex =
                                                            selectVariationIndex;
                                                        setState(() {});
                                                      }

                                                      _model.selectedCertification =
                                                          getJsonField(
                                                        selectVariationItem,
                                                        r'''$.name''',
                                                      ).toString();
                                                      _model.selectedCertificationindex =
                                                          selectVariationIndex;
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      // width: 224,
                                                      height: 44,
                                                      decoration: BoxDecoration(
                                                        color: _model
                                                                    .selectedCertificationindex ==
                                                                selectVariationIndex
                                                            ? Color(0x26740074)
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                          color: _model
                                                                      .selectedCertificationindex ==
                                                                  selectVariationIndex
                                                              ? Color(
                                                                  0xFF740074)
                                                              : Color(
                                                                  0xFFE7E7E8),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15,
                                                                right: 15),
                                                        child: Center(
                                                          child: AutoSizeText(
                                                            getJsonField(
                                                              selectVariationItem,
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
                                                                  lineHeight:
                                                                      1.5,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).divide(SizedBox(width: 16)),
                                            ),
                                          );
                                        },
                                      ),
                                    ].divide(SizedBox(height: 10)),
                                  ),
                                ),
                              if (OtherProductsDetailsCall.certificationlist(
                                        containerOtherProductsDetailsResponse
                                            ?.jsonBody,
                                      ) !=
                                      null &&
                                  (OtherProductsDetailsCall.certificationlist(
                                    containerOtherProductsDetailsResponse
                                        ?.jsonBody,
                                  ))!
                                      .isNotEmpty)
                                Divider(
                                  height: 2,
                                  thickness: 1.5,
                                  color: Color(0xFFE7E7E8),
                                ),
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
                                            text:
                                                'Select Pendant / Bracelet Design: ',
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
                                              !(OtherProductsDetailsCall
                                                              .productRingData(
                                                            containerOtherProductsDetailsResponse
                                                                ?.jsonBody,
                                                          ) !=
                                                          null &&
                                                      (OtherProductsDetailsCall
                                                              .productRingData(
                                                        containerOtherProductsDetailsResponse
                                                            ?.jsonBody,
                                                      ))!
                                                          .isNotEmpty)
                                                  ? _model.choiceChipsValue1
                                                  : _model.choiceChipsValue2,
                                              'Design',
                                            ),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
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
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              _model
                                                  .expandableExpandableController1
                                                  .expanded = true;
                                              _model.designprice = 0;

                                              setState(() {});
                                            },
                                            child: Builder(
                                              builder: (context) {
                                                if (!(OtherProductsDetailsCall
                                                            .productRingData(
                                                          containerOtherProductsDetailsResponse
                                                              ?.jsonBody,
                                                        ) !=
                                                        null &&
                                                    (OtherProductsDetailsCall
                                                            .productRingData(
                                                      containerOtherProductsDetailsResponse
                                                          ?.jsonBody,
                                                    ))!
                                                        .isNotEmpty)) {
                                                  return FlutterFlowChoiceChips(
                                                    options: [
                                                      ChipData('Loose Bead'),
                                                      ChipData('Pendent'),
                                                      ChipData('Bracelet')
                                                    ],
                                                    onChanged: (val) async {
                                                      _model
                                                          .expandableExpandableController1
                                                          .expanded = true;
                                                      setState(() {
                                                        _model.choiceChipsValue1 =
                                                            val?.firstOrNull;
                                                        _selectedMetalId =
                                                            null; // Clear the selected metal ID
                                                        _model.designprice = 0;
                                                        _model.selecteddesigncolor =
                                                            null;
                                                        _model.selectedchaindesign =
                                                            null;
                                                      });
                                                    },
                                                    selectedChipStyle:
                                                        ChipStyle(
                                                      backgroundColor:
                                                          Color(0x1A740074),
                                                      textStyle: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: FlutterFlowTheme
                                                                      .of(
                                                                          context)
                                                                  .primaryText,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14),
                                                      iconColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      iconSize: 18,
                                                      labelPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10, 5, 10, 5),
                                                      elevation: 0,
                                                      borderColor:
                                                          Color(0xFF740074),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    unselectedChipStyle:
                                                        ChipStyle(
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryBackground,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
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
                                                                        .w500,
                                                              ),
                                                      iconColor:
                                                          Color(0x00000000),
                                                      iconSize: 18,
                                                      labelPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10, 5, 10, 5),
                                                      elevation: 0,
                                                      borderColor:
                                                          Color(0xFFE7E7E8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    chipSpacing: 16,
                                                    rowSpacing: 12,
                                                    multiselect: false,
                                                    initialized: _model
                                                            .choiceChipsValue1 !=
                                                        null,
                                                    alignment:
                                                        WrapAlignment.start,
                                                    controller: _model
                                                            .choiceChipsValueController1 ??=
                                                        FormFieldController<
                                                                List<String>>(
                                                            ['Pendent']),
                                                    wrapped: true,
                                                  );
                                                } else {
                                                  return SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        FlutterFlowChoiceChips(
                                                          options: [
                                                            ChipData(
                                                                'Loose Bead'),
                                                            ChipData('Pendent'),
                                                            ChipData(
                                                                'Bracelet'),
                                                            ChipData('Ring')
                                                          ],
                                                          onChanged:
                                                              (val) async {
                                                            setState(() {
                                                              _model.choiceChipsValue2 =
                                                                  val?.firstOrNull;
                                                              _selectedMetalId =
                                                                  null;
                                                              _model.designprice =
                                                                  0;
                                                              _model
                                                                  .expandableExpandableController1
                                                                  .expanded = true;
                                                              _model.selecteddesigncolor =
                                                                  null;
                                                              _model.selectedchaindesign =
                                                                  null;
                                                              initialMetalVal =
                                                                  'Select Metal';
                                                              FFAppState()
                                                                      .selectedSizeSystem =
                                                                  null;
                                                              FFAppState()
                                                                      .selectedRingSize =
                                                                  null;
                                                              print(
                                                                  '_model.choiceChipsValue1: ${_model.choiceChipsValue1}');
                                                              print(
                                                                  '_model.choiceChipsValue2: ${_model.choiceChipsValue2}');
                                                            });
                                                          },
                                                          selectedChipStyle:
                                                              ChipStyle(
                                                                  backgroundColor: Color(
                                                                      0x1A740074),
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        letterSpacing:
                                                                            0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                  iconColor: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  iconSize: 18,
                                                                  labelPadding:
                                                                      EdgeInsetsDirectional.fromSTEB(
                                                                          10,
                                                                          5,
                                                                          10,
                                                                          5),
                                                                  elevation: 0,
                                                                  borderColor:
                                                                      Color(
                                                                          0xFF740074),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  borderWidth:
                                                                      0.8),
                                                          unselectedChipStyle:
                                                              ChipStyle(
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(context)
                                                                          .secondaryBackground,
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        letterSpacing:
                                                                            0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                  iconColor: Color(
                                                                      0x00000000),
                                                                  iconSize: 18,
                                                                  labelPadding:
                                                                      EdgeInsetsDirectional.fromSTEB(
                                                                          10,
                                                                          5,
                                                                          10,
                                                                          5),
                                                                  elevation: 0,
                                                                  borderColor:
                                                                      Color(
                                                                          0xFFE7E7E8),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  borderWidth:
                                                                      1),
                                                          chipSpacing: 16,
                                                          rowSpacing: 12,
                                                          multiselect: false,
                                                          initialized: _model
                                                                  .choiceChipsValue2 !=
                                                              null,
                                                          alignment:
                                                              WrapAlignment
                                                                  .spaceBetween,
                                                          controller: _model
                                                                  .choiceChipsValueController2 ??=
                                                              FormFieldController<
                                                                  List<
                                                                      String>>([
                                                            'Pendent'
                                                          ]),
                                                          wrapped: true,
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ].divide(SizedBox(height: 10)),
                                ),
                              ),
                              if (((_model.choiceChipsValue2 == 'Pendent') ||
                                      (_model.choiceChipsValue1 == 'Pendent') ||
                                      (_model.choiceChipsValue2 ==
                                          'Bracelet') ||
                                      (_model.choiceChipsValue1 ==
                                          'Bracelet') ||
                                      (_model.choiceChipsValue2 == 'Ring') ||
                                      (_model.choiceChipsValue1 == 'Ring')) &&
                                  widget.firstLevelName != 'Rudraksha' &&
                                  productType != 3)
                                //if (widget.firstLevelName != 'Rudraksha' && _model.choiceChipsValue2 != 'Loose Bead')
                                Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 16, 16),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Select Metal: ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Montserrat',
                                                fontSize: 14,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Expanded(
                                          child: KeyedSubtree(
                                            key: ValueKey(_model
                                                .choiceChipsValue2), // Key changes when choice chip value changes
                                            child:
                                                FutureBuilder<ApiCallResponse>(
                                              future: metalDetail.call(
                                                sanityurl:
                                                    FFAppConstants.sanityurl,
                                              ),
                                              builder: (context, snapshot) {
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      height: 25.0,
                                                      child: ShimmerWidget(),
                                                    ),
                                                  );
                                                }

                                                // Fetch the API response and payload
                                                print(
                                                    'API Response: ${snapshot.data}');
                                                final metalDetailDropdownResponse =
                                                    snapshot.data!;
                                                print(
                                                    'API Response JSON Body: ${metalDetailDropdownResponse.jsonBody}');

                                                // Parse the metal data
                                                final metalData = (getJsonField(
                                                  metalDetailDropdownResponse
                                                      .jsonBody,
                                                  r'''$.data''',
                                                  true,
                                                ) as List<dynamic>)
                                                    .map((item) => {
                                                          'id': item['id']
                                                              .toString(),
                                                          'name': item['name']
                                                              .toString(),
                                                        })
                                                    .toList();

                                                // Debugging output
                                                print(
                                                    'Parsed Metal Data: $metalData');

                                                return MetalDropdown(
                                                  items: metalData
                                                      .map((e) => e['name'])
                                                      .toList(),
                                                  initialValue: initialMetalVal,
                                                  onChanged: (val) async {
                                                    // Find the ID for the selected metal
                                                    final selectedMetal =
                                                        metalData.firstWhere(
                                                            (metal) =>
                                                                metal['name'] ==
                                                                val);
                                                    _selectedMetalId =
                                                        selectedMetal['id'];

                                                    // Fetch dependant designs based on selected metal
                                                    if (_selectedMetalId !=
                                                        null) {
                                                      final response =
                                                          await metalDependantDesign
                                                              .call(
                                                        hosturl: FFAppConstants
                                                            .sanityurl,
                                                        slugValue: widget
                                                            .productSlugValue,
                                                        designType: _model
                                                            .selectedDesignType
                                                            .toString(),
                                                        metal: _selectedMetalId,
                                                        group: _model
                                                            .selectedGroupId
                                                            .toString(),
                                                      );

                                                      final metalResponse =
                                                          getJsonField(
                                                                  response,
                                                                  r'''$.data''',
                                                                  true) ??
                                                              [];

                                                      noDesignsAvailable =
                                                          metalResponse;

                                                      final requestBody = {
                                                        'hosturl':
                                                            FFAppConstants
                                                                .sanityurl,
                                                        'slugValue': widget
                                                            .productSlugValue,
                                                        'designType': _model
                                                            .selectedDesignType
                                                            .toString(),
                                                        'metal':
                                                            _selectedMetalId,
                                                        'group': _model
                                                            .selectedGroupId
                                                            .toString(),
                                                      };

                                                      print(
                                                          'Metal Request Body 23: ${jsonEncode(requestBody)}');

                                                      print(
                                                          'Dependant Design API Response: ${response.jsonBody}');
                                                      setState(() {
                                                        // Update any state based on the API response
                                                      });
                                                      _model.chainPrice = 0;
                                                      _model.designprice = 0;
                                                      _model.selecteddesigncolor =
                                                          null;
                                                      _model.selectedchaindesign =
                                                          null;
                                                      FFAppState()
                                                              .selectedSizeSystem =
                                                          null;
                                                      FFAppState()
                                                              .selectedRingSize =
                                                          null;
                                                    }

                                                    setState(() {
                                                      FFAppState()
                                                              .selectedMetal =
                                                          val; // Update selected metal
                                                    });
                                                    print(
                                                        'Selected Metal: ${FFAppState().selectedMetal}');
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              if (widget.firstLevelName == 'Rudraksha' ||
                                  productType == 3)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 0),
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        // Generated code for this Expandable Widget...
                                        Container(
                                          width: double.infinity,
                                          color: Colors.white,
                                          child: ExpandableNotifier(
                                            controller: _model
                                                .expandableExpandableController1,
                                            child: ExpandablePanel(
                                              header: RichText(
                                                textScaler:
                                                    MediaQuery.of(context)
                                                        .textScaler,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Select Designs: ',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            letterSpacing: 0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                    TextSpan(
                                                      text: valueOrDefault<
                                                          String>(
                                                        !(OtherProductsDetailsCall
                                                                        .productRingData(
                                                                      containerOtherProductsDetailsResponse
                                                                          ?.jsonBody,
                                                                    ) !=
                                                                    null &&
                                                                (OtherProductsDetailsCall
                                                                        .productRingData(
                                                                  containerOtherProductsDetailsResponse
                                                                      ?.jsonBody,
                                                                ))!
                                                                    .isNotEmpty)
                                                            ? _model
                                                                .choiceChipsValue1
                                                            : _model
                                                                .choiceChipsValue2,
                                                        'Design',
                                                      ),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                    )
                                                  ],
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        letterSpacing: 0,
                                                      ),
                                                ),
                                              ),
                                              collapsed: Container(),
                                              expanded: Builder(
                                                builder: (context) {
                                                  if ((_model.choiceChipsValue2 ==
                                                          'Pendent') ||
                                                      (_model.choiceChipsValue1 ==
                                                          'Pendent')) {
                                                    return Builder(
                                                      builder: (context) {
                                                        final selectDesgn =
                                                            OtherProductsDetailsCall
                                                                    .pendentgroup(
                                                                  containerOtherProductsDetailsResponse
                                                                      ?.jsonBody,
                                                                )?.toList() ??
                                                                [];

                                                        return SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: List.generate(
                                                                selectDesgn
                                                                    .length,
                                                                (selectDesgnIndex) {
                                                              final selectDesgnItem =
                                                                  selectDesgn[
                                                                      selectDesgnIndex];
                                                              return InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  _model.selecteddesign =
                                                                      !_model
                                                                          .selecteddesign;
                                                                  setState(
                                                                      () {});
                                                                  _model.selectedpendentdesign =
                                                                      selectDesgnIndex;
                                                                  _model.designprice =
                                                                      getJsonField(
                                                                    selectDesgnItem,
                                                                    r'''$.price''',
                                                                  );
                                                                  _model.selecteddesignid =
                                                                      getJsonField(
                                                                    selectDesgnItem,
                                                                    r'''$.id''',
                                                                  );
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 114,
                                                                  height: 222,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: _model.selectedpendentdesign ==
                                                                            selectDesgnIndex
                                                                        ? Color(
                                                                            0x26740074)
                                                                        : FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: _model.selectedpendentdesign ==
                                                                              selectDesgnIndex
                                                                          ? Color(
                                                                              0xFF740074)
                                                                          : FlutterFlowTheme.of(context)
                                                                              .secondaryBackground,
                                                                    ),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            4,
                                                                            7,
                                                                            4),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(16),
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            fadeInDuration:
                                                                                Duration(milliseconds: 100),
                                                                            fadeOutDuration:
                                                                                Duration(milliseconds: 100),
                                                                            imageUrl:
                                                                                getJsonField(
                                                                              selectDesgnItem,
                                                                              r'''$.image''',
                                                                            ).toString(),
                                                                            width:
                                                                                93,
                                                                            //height: 120,
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              42,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              AutoSizeText(
                                                                            getJsonField(
                                                                              selectDesgnItem,
                                                                              r'''$.name''',
                                                                            ).toString(),
                                                                            maxLines:
                                                                                2,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Montserrat',
                                                                                  fontSize: 14,
                                                                                  letterSpacing: 0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  lineHeight: 1.5,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            7),
                                                                        child:
                                                                            RichText(
                                                                          textScaler:
                                                                              MediaQuery.of(context).textScaler,
                                                                          text:
                                                                              TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: '+${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(
                                                                                  getJsonField(selectDesgnItem, r'''$.price''').toString(),
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
                                                                          maxLines:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            12)),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } else if ((_model
                                                              .choiceChipsValue2 ==
                                                          'Bracelet') ||
                                                      (_model.choiceChipsValue1 ==
                                                          'Bracelet')) {
                                                    return Builder(
                                                      builder: (context) {
                                                        final selectBraceletDesign =
                                                            OtherProductsDetailsCall
                                                                    .braceletgroup(
                                                                  containerOtherProductsDetailsResponse
                                                                      ?.jsonBody,
                                                                )?.toList() ??
                                                                [];

                                                        // Check if the list is empty
                                                        if (selectBraceletDesign
                                                            .isEmpty) {
                                                          return Center(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          16.0),
                                                              child: Text(
                                                                'No designs available',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                              ),
                                                            ),
                                                          );
                                                        }

                                                        return SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: List.generate(
                                                                selectBraceletDesign
                                                                    .length,
                                                                (selectBraceletDesignIndex) {
                                                              final selectBraceletDesignItem =
                                                                  selectBraceletDesign[
                                                                      selectBraceletDesignIndex];
                                                              return InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  print(
                                                                      "Braclet : ${selectBraceletDesignItem}");
                                                                  _model.selecteddesign =
                                                                      !_model
                                                                          .selecteddesign;
                                                                  setState(
                                                                      () {});
                                                                  _model.selectedbraceletdesign =
                                                                      selectBraceletDesignIndex;
                                                                  _model.designprice =
                                                                      getJsonField(
                                                                    selectBraceletDesignItem,
                                                                    r'''$.price''',
                                                                  );
                                                                  _model.selecteddesignid =
                                                                      getJsonField(
                                                                    selectBraceletDesignItem,
                                                                    r'''$.id''',
                                                                  );
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 114,
                                                                  height: 222,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: _model.selectedbraceletdesign ==
                                                                            selectBraceletDesignIndex
                                                                        ? Color(
                                                                            0x26740074)
                                                                        : FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: _model.selectedbraceletdesign ==
                                                                              selectBraceletDesignIndex
                                                                          ? Color(
                                                                              0xFF740074)
                                                                          : FlutterFlowTheme.of(context)
                                                                              .secondaryBackground,
                                                                    ),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            4,
                                                                            7,
                                                                            4),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            fadeInDuration:
                                                                                Duration(milliseconds: 100),
                                                                            fadeOutDuration:
                                                                                Duration(milliseconds: 100),
                                                                            imageUrl:
                                                                                getJsonField(
                                                                              selectBraceletDesignItem,
                                                                              r'''$.image''',
                                                                            ).toString(),
                                                                            width:
                                                                                100,
                                                                            height:
                                                                                120,
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              42,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              AutoSizeText(
                                                                            getJsonField(
                                                                              selectBraceletDesignItem,
                                                                              r'''$.name''',
                                                                            ).toString(),
                                                                            maxLines:
                                                                                2,
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
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            7),
                                                                        child:
                                                                            RichText(
                                                                          textScaler:
                                                                              MediaQuery.of(context).textScaler,
                                                                          text:
                                                                              TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: '+${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(
                                                                                  getJsonField(selectBraceletDesignItem, r'''$.price''').toString(),
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
                                                                          maxLines:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            12)),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } else if (_model
                                                          .choiceChipsValue2 ==
                                                      'Ring') {
                                                    return Builder(
                                                      builder: (context) {
                                                        final ringDesign =
                                                            OtherProductsDetailsCall
                                                                    .productRingData(
                                                                  containerOtherProductsDetailsResponse
                                                                      ?.jsonBody,
                                                                )?.toList() ??
                                                                [];
                                                        return SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: List.generate(
                                                                ringDesign
                                                                    .length,
                                                                (ringDesignIndex) {
                                                              final ringDesignItem =
                                                                  ringDesign[
                                                                      ringDesignIndex];

                                                              return InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  print(
                                                                      "ringDesign : ${ringDesignItem}");
                                                                  _model.selectedringdesign =
                                                                      ringDesignIndex;
                                                                  _model.designprice =
                                                                      getJsonField(
                                                                    ringDesignItem,
                                                                    r'''$.price''',
                                                                  );
                                                                  _model.selecteddesignid =
                                                                      getJsonField(
                                                                    ringDesignItem,
                                                                    r'''$.id''',
                                                                  );
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 114,
                                                                  height: 222,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: _model.selectedringdesign ==
                                                                            ringDesignIndex
                                                                        ? Color(
                                                                            0x26740074)
                                                                        : FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: _model.selectedringdesign ==
                                                                              ringDesignIndex
                                                                          ? Color(
                                                                              0xFF740074)
                                                                          : FlutterFlowTheme.of(context)
                                                                              .secondaryBackground,
                                                                    ),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            4,
                                                                            7,
                                                                            4),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            fadeInDuration:
                                                                                Duration(milliseconds: 100),
                                                                            fadeOutDuration:
                                                                                Duration(milliseconds: 100),
                                                                            imageUrl:
                                                                                getJsonField(
                                                                              ringDesignItem,
                                                                              r'''$.image''',
                                                                            ).toString(),
                                                                            width:
                                                                                100,
                                                                            height:
                                                                                120,
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              42,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              AutoSizeText(
                                                                            getJsonField(
                                                                              ringDesignItem,
                                                                              r'''$.name''',
                                                                            ).toString(),
                                                                            maxLines:
                                                                                2,
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
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            7),
                                                                        child:
                                                                            RichText(
                                                                          textScaler:
                                                                              MediaQuery.of(context).textScaler,
                                                                          text:
                                                                              TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: '+ INR ',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Montserrat',
                                                                                      fontSize: 14,
                                                                                      letterSpacing: 0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                    ),
                                                                              ),
                                                                              TextSpan(
                                                                                text: getJsonField(
                                                                                  ringDesignItem,
                                                                                  r'''$.price''',
                                                                                ).toString(),
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
                                                                          maxLines:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            12)),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    return Container(
                                                      width: 405,
                                                      height: 1,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                    );
                                                  }
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
                                                collapseIcon: Icons
                                                    .keyboard_arrow_up_sharp,
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
                              if (_selectedMetalId != null &&
                                  _selectedMetalId!.isNotEmpty &&
                                  widget.firstLevelName != 'Rudraksha')
                                Divider(
                                  height: 5,
                                  thickness: 1.5,
                                  color: Color(0xFFE7E7E8),
                                ),

                              /*if(noDesignsAvailable == null)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                                      child:Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Text(
                                            'No designs available',
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      )
                                  ),*/

                              if (_selectedMetalId != null &&
                                  _selectedMetalId!.isNotEmpty &&
                                  noDesignsAvailable == null)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 8),
                                  child: Container(
                                    //decoration: BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          color: Colors.white,
                                          child: ExpandableNotifier(
                                            controller: _model
                                                .expandableExpandableController1,
                                            child: ExpandablePanel(
                                              header: RichText(
                                                textScaler:
                                                    MediaQuery.of(context)
                                                        .textScaler,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Select Designs: ',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            letterSpacing: 0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                    TextSpan(
                                                      text: valueOrDefault<
                                                          String>(
                                                        !(OtherProductsDetailsCall
                                                                        .productRingData(
                                                                      containerOtherProductsDetailsResponse
                                                                          ?.jsonBody,
                                                                    ) !=
                                                                    null &&
                                                                (OtherProductsDetailsCall
                                                                        .productRingData(
                                                                  containerOtherProductsDetailsResponse
                                                                      ?.jsonBody,
                                                                ))!
                                                                    .isNotEmpty)
                                                            ? _model
                                                                .choiceChipsValue1
                                                            : _model
                                                                .choiceChipsValue2,
                                                        'Design',
                                                      ),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                    )
                                                  ],
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        letterSpacing: 0,
                                                      ),
                                                ),
                                              ),
                                              collapsed: Container(),
                                              expanded: Builder(
                                                builder: (context) {
                                                  if ((_model.choiceChipsValue2 == 'Bracelet') ||
                                                      (_model.choiceChipsValue1 ==
                                                          'Bracelet') ||
                                                      (_model.choiceChipsValue2 ==
                                                          'Pendent') ||
                                                      (_model.choiceChipsValue1 ==
                                                          'Pendent') ||
                                                      (_model.choiceChipsValue2 ==
                                                          'Ring')) {
                                                    return FutureBuilder<
                                                        ApiCallResponse>(
                                                      future: metalDependantDesign.call(
                                                          hosturl:
                                                              FFAppConstants
                                                                  .sanityurl,
                                                          slugValue: widget
                                                              .productSlugValue,
                                                          designType: _model
                                                              .selectedDesignType
                                                              .toString(),
                                                          metal:
                                                              _selectedMetalId,
                                                          group: _model
                                                              .selectedGroupId
                                                              .toString()),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (!snapshot.hasData) {
                                                          return SizedBox(
                                                            height: 250,
                                                            child:
                                                                ShimmerWidget(),
                                                          );
                                                        }

                                                        final metalDependentResponse =
                                                            snapshot.data!;
                                                        final metalData = getJsonField(
                                                                metalDependentResponse
                                                                    .jsonBody,
                                                                r'''$.data''',
                                                                true) ??
                                                            [];

                                                        print(
                                                            'Metal dependent data: $metalData');

                                                        // Check if the list is empty
                                                        if (metalData.isEmpty) {
                                                          return Center(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          16.0),
                                                              child: Text(
                                                                'No designs available',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                              ),
                                                            ),
                                                          );
                                                        }

                                                        return SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: List.generate(
                                                                metalData
                                                                    .length,
                                                                (selectDesgnIndex) {
                                                              final metalItem =
                                                                  metalData[
                                                                      selectDesgnIndex];
                                                              return InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  setState(
                                                                      () {});
                                                                  _model.selecteddesign =
                                                                      !_model
                                                                          .selecteddesign;
                                                                  _model.selecteddesigncolor =
                                                                      selectDesgnIndex;
                                                                  _model.designprice =
                                                                      getJsonField(
                                                                    metalItem,
                                                                    r'''$.price''',
                                                                  ).toInt();
                                                                  _model.selecteddesignid =
                                                                      getJsonField(
                                                                    metalItem,
                                                                    r'''$.id''',
                                                                  );
                                                                  setState(
                                                                      () {});

                                                                  /*_model.selecteddesign = !_model.selecteddesign;
                                                                      print('Design ID selected: ${getJsonField(metalItem, r'''$.id''',)}');

                                                                      setState(() {});
                                                                      _model.selectedpendentdesign = index;
                                                                      _model.designprice = getJsonField(
                                                                        metalItem,
                                                                        r'''$.price''',
                                                                      );
                                                                      _model.selecteddesignid = getJsonField(
                                                                        metalItem,
                                                                        r'''$.id''',
                                                                      );
                                                                      _selectedDesignIndex = index;
                                                                      setState(() {});*/
                                                                  print(
                                                                      '_.selecteddesignid: ${_model.selecteddesignid}');
                                                                  print(
                                                                      'selectedpendentdesign: ${_model.selecteddesigncolor}');
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 114,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: _model.selecteddesigncolor ==
                                                                            selectDesgnIndex
                                                                        ? Color(
                                                                            0x26740074)
                                                                        : FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: _model.selecteddesigncolor ==
                                                                              selectDesgnIndex
                                                                          ? Color(
                                                                              0xFF740074)
                                                                          : FlutterFlowTheme.of(context)
                                                                              .secondaryBackground,
                                                                    ),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            4,
                                                                            7,
                                                                            4),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(16),
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            fadeInDuration:
                                                                                Duration(milliseconds: 100),
                                                                            fadeOutDuration:
                                                                                Duration(milliseconds: 100),
                                                                            imageUrl:
                                                                                getJsonField(metalItem, r'''$.image''').toString(),
                                                                            width:
                                                                                93,
                                                                            height:
                                                                                120,
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              42,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              AutoSizeText(
                                                                            getJsonField(metalItem, r'''$.name''').toString(),
                                                                            maxLines:
                                                                                2,
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
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            7),
                                                                        child:
                                                                            RichText(
                                                                          textScaler:
                                                                              MediaQuery.of(context).textScaler,
                                                                          text:
                                                                              TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: '+',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Montserrat',
                                                                                      fontSize: 14,
                                                                                      letterSpacing: 0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                    ),
                                                                              ),
                                                                              TextSpan(
                                                                                text: '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(
                                                                                  getJsonField(metalItem, r'''$.price''').toString(),
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
                                                                          maxLines:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            12)),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    return Container(
                                                      width: 405,
                                                      height: 1,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                    );
                                                  }
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
                                                collapseIcon: Icons
                                                    .keyboard_arrow_up_sharp,
                                                iconColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        if (_model.selecteddesigncolor !=
                                                null &&
                                            _model.choiceChipsValue2 != 'Ring')
                                          Divider(
                                            height: 2,
                                            thickness: 1,
                                            color: Color(0xFFE7E7E8),
                                          ),
                                        if (_model.selecteddesigncolor !=
                                                null &&
                                            _model.choiceChipsValue2 != 'Ring')
                                          Container(
                                            decoration: BoxDecoration(),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  color: Colors.white,
                                                  child: ExpandableNotifier(
                                                    controller: _model
                                                        .expandableExpandableController4,
                                                    child: ExpandablePanel(
                                                      header: RichText(
                                                        textScaler:
                                                            MediaQuery.of(
                                                                    context)
                                                                .textScaler,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  'Select Chain / Thread (Optional)',
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
                                                      collapsed: Container(),
                                                      expanded: Builder(
                                                        builder: (context) {
                                                          return FutureBuilder<
                                                              ApiCallResponse>(
                                                            future: metalDependantDesign.call(
                                                                hosturl:
                                                                    FFAppConstants
                                                                        .sanityurl,
                                                                slugValue: widget
                                                                    .productSlugValue,
                                                                designType: _model
                                                                    .selectedDesignType
                                                                    .toString(),
                                                                metal:
                                                                    _selectedMetalId,
                                                                group: _model
                                                                    .selectedGroupId
                                                                    .toString()),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    //height: 25.0,
                                                                    child:
                                                                        ShimmerWidget(),
                                                                  ),
                                                                );
                                                              }

                                                              final metalDependentResponse =
                                                                  snapshot
                                                                      .data!;
                                                              final metalData = getJsonField(
                                                                      metalDependentResponse
                                                                          .jsonBody,
                                                                      r'''$.chain''',
                                                                      true) ??
                                                                  [];

                                                              if (kDebugMode) {
                                                                print(
                                                                    'Metal dependent data: $metalData');
                                                              }

                                                              return SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: List.generate(
                                                                      metalData
                                                                          .length,
                                                                      (index) {
                                                                    final metalItem =
                                                                        metalData[
                                                                            index];
                                                                    return InkWell(
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
                                                                        setState(
                                                                            () {});
                                                                        _model.selectedchain =
                                                                            !_model.selectedchain;
                                                                        _model.chainPrice =
                                                                            getJsonField(
                                                                          metalItem,
                                                                          r'''$.price''',
                                                                        ).toInt();
                                                                        _model.selectedchainid =
                                                                            getJsonField(
                                                                          metalItem,
                                                                          r'''$.id''',
                                                                        );
                                                                        _model.selectedchaindesign =
                                                                            index;
                                                                        setState(
                                                                            () {});

                                                                        print(
                                                                            '_model.selectedchainid: ${_model.selectedchainid}');
                                                                        print(
                                                                            '_model.selectedchaindesign: ${_model.selectedchaindesign}');
                                                                        print(
                                                                            '_model.chainPrice: ${_model.chainPrice}');
                                                                        print(
                                                                            '_model.selectedchaindesign: ${_model.selectedchaindesign}');
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            114,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: _model.selectedchaindesign == index
                                                                              ? Color(0x26740074)
                                                                              : FlutterFlowTheme.of(context).secondaryBackground,
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                          border:
                                                                              Border.all(
                                                                            color: _model.selectedchaindesign == index
                                                                                ? Color(0xFF740074)
                                                                                : FlutterFlowTheme.of(context).secondaryBackground,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children:
                                                                              [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(7, 4, 7, 4),
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(16),
                                                                                child: CachedNetworkImage(
                                                                                  fadeInDuration: Duration(milliseconds: 100),
                                                                                  fadeOutDuration: Duration(milliseconds: 100),
                                                                                  imageUrl: getJsonField(metalItem, r'''$.image''').toString(),
                                                                                  width: 93,
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
                                                                                  getJsonField(metalItem, r'''$.name''').toString(),
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
                                                                                      text: '+',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Montserrat',
                                                                                            fontSize: 14,
                                                                                            letterSpacing: 0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
                                                                                    ),
                                                                                    TextSpan(
                                                                                      text: '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(
                                                                                        getJsonField(metalItem, r'''$.price''').toString(),
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
                                                        },
                                                      ),
                                                      theme:
                                                          ExpandableThemeData(
                                                        tapHeaderToExpand: true,
                                                        tapBodyToExpand: false,
                                                        tapBodyToCollapse:
                                                            false,
                                                        headerAlignment:
                                                            ExpandablePanelHeaderAlignment
                                                                .center,
                                                        hasIcon: true,
                                                        expandIcon: Icons
                                                            .keyboard_arrow_down,
                                                        collapseIcon: Icons
                                                            .keyboard_arrow_up_sharp,
                                                        iconColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        SizedBox(height: 4),
                                        if (_model.selecteddesigncolor !=
                                                null &&
                                            _model.choiceChipsValue2 !=
                                                'Pendent')
                                          Divider(
                                            height: 2,
                                            thickness: 1,
                                            color: Color(0xFFE7E7E8),
                                          ),
                                        if (_model.selecteddesigncolor != null)
                                          Builder(
                                            builder: (context) {
                                              if (_model.choiceChipsValue2 !=
                                                  'Pendent') {
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 8, 0, 0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            _model.choiceChipsValue2 ==
                                                                    'Ring'
                                                                ? 'Ring Size System:'
                                                                : 'Wrist / Upper Arm Size:',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                          SizedBox(
                                                              width:
                                                                  _model.choiceChipsValue2 ==
                                                                          'Ring'
                                                                      ? 16
                                                                      : 10),
                                                          Expanded(
                                                            child:
                                                                MetalDropdown(
                                                              items: _model
                                                                          .choiceChipsValue2 ==
                                                                      'Ring'
                                                                  ? ringsizesystem
                                                                  : wristsize,
                                                              //initialValue: 'Select Ring Size System',
                                                              initialValue: _model
                                                                          .choiceChipsValue2 ==
                                                                      'Ring'
                                                                  ? 'Select Ring Size System'
                                                                  : 'Select Wrist Size',
                                                              selectedValue: FFAppState()
                                                                              .selectedSizeSystem !=
                                                                          null &&
                                                                      ringsizesystem
                                                                          .contains(FFAppState()
                                                                              .selectedSizeSystem)
                                                                  ? FFAppState()
                                                                      .selectedSizeSystem // Ensure selected value is valid
                                                                  : null, // Reset if invalid
                                                              onChanged: (val) {
                                                                setState(() {
                                                                  FFAppState()
                                                                          .selectedRingSize =
                                                                      null; // Reset ring size
                                                                  FFAppState()
                                                                          .selectedSizeSystem =
                                                                      val;
                                                                  print(
                                                                      'Selected Size System: ${FFAppState().selectedSizeSystem}');
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      // Conditionally display ring size based on selected system
                                                      if (FFAppState()
                                                                  .selectedSizeSystem !=
                                                              null &&
                                                          FFAppState()
                                                                  .selectedSizeSystem !=
                                                              'Later / Don\'t Know' &&
                                                          _model.choiceChipsValue2 !=
                                                              'Bracelet')
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      8, 0, 0),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Ring Size:',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                              ),
                                                              SizedBox(
                                                                  width: 10),
                                                              if (FFAppState()
                                                                      .selectedSizeSystem ==
                                                                  'Indian Ring Size System')
                                                                Expanded(
                                                                  child:
                                                                      KeyedSubtree(
                                                                    key: ValueKey(
                                                                        FFAppState()
                                                                            .selectedSizeSystem),
                                                                    child:
                                                                        MetalDropdown(
                                                                      items: List.generate(
                                                                          indianarray
                                                                              .length,
                                                                          (index) =>
                                                                              indianarray[index].toString()),
                                                                      initialValue:
                                                                          'Select Ring Size',
                                                                      selectedValue:
                                                                          FFAppState()
                                                                              .selectedRingSize, // Pass the current selected ring size
                                                                      onChanged:
                                                                          (val) {
                                                                        setState(
                                                                            () {
                                                                          FFAppState().selectedRingSize =
                                                                              val;
                                                                        });
                                                                        print(
                                                                            'Selected Ring Size: ${FFAppState().selectedRingSize}');
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (FFAppState()
                                                                      .selectedSizeSystem ==
                                                                  'US Ring Size System')
                                                                Expanded(
                                                                  child:
                                                                      MetalDropdown(
                                                                    items:
                                                                        usarray,
                                                                    initialValue:
                                                                        'Select Ring Size',
                                                                    selectedValue:
                                                                        FFAppState()
                                                                            .selectedRingSize, // Pass the current selected ring size
                                                                    onChanged:
                                                                        (val) {
                                                                      setState(
                                                                          () {
                                                                        FFAppState().selectedRingSize =
                                                                            val;
                                                                      });
                                                                      print(
                                                                          'Selected Ring Size: ${FFAppState().selectedRingSize}');
                                                                    },
                                                                  ),
                                                                ),
                                                              if (FFAppState()
                                                                      .selectedSizeSystem ==
                                                                  'Inner Circumference')
                                                                Expanded(
                                                                  child:
                                                                      TextFormField(
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintText:
                                                                          'Ring size in mm',
                                                                      filled:
                                                                          true,
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                      enabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.grey,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(4),
                                                                      ),
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(4),
                                                                      ),
                                                                      errorBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.red,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(4),
                                                                      ),
                                                                      focusedErrorBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.red,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(4),
                                                                      ),
                                                                      contentPadding: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              8,
                                                                          horizontal:
                                                                              12),
                                                                    ),
                                                                    cursorColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    inputFormatters: [
                                                                      LengthLimitingTextInputFormatter(
                                                                          2),
                                                                      FilteringTextInputFormatter
                                                                          .digitsOnly,
                                                                    ],
                                                                    onChanged:
                                                                        (val) {
                                                                      setState(
                                                                          () {
                                                                        FFAppState().selectedRingSize =
                                                                            val;
                                                                      });
                                                                      print(
                                                                          'Entered Ring Size (mm): ${FFAppState().selectedRingSize}');
                                                                    },
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                );
                                              } else {
                                                return Container();
                                              }
                                            },
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                              Divider(
                                height: 2,
                                thickness: 1.5,
                                color: Color(0xFFE7E7E8),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 0, 16),
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
                                        decrementIconBuilder: (enabled) =>
                                            FaIcon(
                                          FontAwesomeIcons.minus,
                                          color: enabled
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : FlutterFlowTheme.of(context)
                                                  .alternate,
                                          size: 15,
                                        ),
                                        incrementIconBuilder: (enabled) =>
                                            FaIcon(
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
                                        count: _model.countControllerValue ??=
                                            1,
                                        updateCount: (count) => setState(() =>
                                            _model.countControllerValue =
                                                count),
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
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 10, 0, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 10, 0),
                                      child: /*RichText(
                                            textScaler: MediaQuery.of(context).textScaler,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'INR ',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
                                                        fontSize: 18,
                                                        letterSpacing: 0,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                ),
                                                TextSpan(
                                                  text: formatNumber(
                                                    (valueOrDefault<int>(OtherProductsDetailsCall.productsellingprice(
                                                      containerOtherProductsDetailsResponse.jsonBody,
                                                    ), 00000,) +
                                                        (_model.designprice!) +
                                                        (_model.energizationprice!) + (_model.selectedcertificateprice!)) *
                                                        (_model.countControllerValue!),
                                                    formatType: FormatType.decimal,
                                                    decimalType:
                                                        DecimalType.periodDecimal,
                                                  ),
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
                                          ),*/
                                          RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatNumber(
                                                functions.currencyConversion(
                                                    FFAppState().currencyRate,
                                                    ((valueOrDefault<int>(
                                                                  OtherProductsDetailsCall
                                                                      .productsellingprice(
                                                                    containerOtherProductsDetailsResponse
                                                                        ?.jsonBody,
                                                                  ),
                                                                  00000,
                                                                ) +
                                                                (_model
                                                                    .designprice!) +
                                                                (_model
                                                                    .energizationprice!) +
                                                                (_model
                                                                    .chainPrice!) +
                                                                (_model
                                                                    .selectedcertificateprice!)) *
                                                            (_model
                                                                .countControllerValue!))
                                                        .toString()),
                                                formatType: FormatType.decimal,
                                                decimalType:
                                                    DecimalType.periodDecimal,
                                              )}',
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                          ],
                                        ),
                                        maxLines: 2,
                                      ),
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
                                height: 2,
                                thickness: 1.5,
                                color: Color(0xFFE7E7E8),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 0),
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
                                      controller: _model
                                          .expandableExpandableController2,
                                      child: ExpandablePanel(
                                        header: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  6, 0, 0, 0),
                                          child: Text(
                                            'Description',
                                            /*style: FlutterFlowTheme.of(context)
                                                    .displaySmall
                                                    .override(
                                                      fontFamily: 'Outfit',
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.normal,
                                                    ),*/
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 14,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ),
                                        collapsed: Container(),
                                        expanded: /*Html(
                                              data: valueOrDefault<String>(
                                                OtherProductsDetailsCall.longdescription(
                                                  containerOtherProductsDetailsResponse?.jsonBody,),
                                                'Description',
                                              ),
                                            ),*/
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8,
                                                    right: 8,
                                                    bottom: 8),
                                                child: HtmlWidget(
                                                    decodedDescription)
                                                // Html(
                                                //   data: decodedDescription,
                                                //   style: {
                                                //     "html": Style(
                                                //       fontFamily: GoogleFonts.montserrat(
                                                //         fontSize: 16,
                                                //         fontWeight: FontWeight.w500,
                                                //         color: Color(0xFF212529),
                                                //       ).fontFamily,
                                                //       color: Color(0xFF212529),
                                                //       lineHeight: LineHeight(1.5),
                                                //       margin: EdgeInsets.zero,
                                                //       padding: EdgeInsets.zero,
                                                //       textAlign: TextAlign.justify,
                                                //     ),
                                                //     "body": Style(
                                                //       margin: EdgeInsets.zero,
                                                //       padding: EdgeInsets.zero,
                                                //     ),
                                                //     "p": Style(
                                                //       margin: EdgeInsets.zero,
                                                //       padding: EdgeInsets.zero,
                                                //     ),
                                                //     "div": Style(
                                                //       margin: EdgeInsets.zero,
                                                //       padding: EdgeInsets.zero,
                                                //     ),
                                                //   },
                                                //   onLinkTap: (url, _, __, ___) async {
                                                //     if (url != null) {
                                                //       final uri = Uri.parse(url); // Convert the URL string to a Uri object

                                                //       // Launch the URL if it is valid
                                                //       if (await canLaunchUrl(uri)) {
                                                //         await launchUrl(uri, mode: LaunchMode.externalApplication);
                                                //       } else {
                                                //         // Handle cases where the URL cannot be launched
                                                //         print('Could not launch $uri');
                                                //       }
                                                //     }
                                                //   },
                                                // ),

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
                                          iconColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          iconPadding:
                                              const EdgeInsets.fromLTRB(
                                                  16, 16, 14, 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 2,
                                thickness: 1.5,
                                color: Color(0xFFE7E7E8),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 8),
                                child: Container(
                                  key: _DiamondProductDetailsWidgetratingKey,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.white,
                                    child: ExpandableNotifier(
                                      controller: _model
                                          .expandableExpandableController3,
                                      child: ExpandablePanel(
                                        header: Text(
                                          'Ratings & Reviews',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    /* Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0, 0, 10, 0),
                                                          child: RichText(
                                                            textScaler:
                                                                MediaQuery.of(
                                                                        context)
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
                                                                        fontSize:
                                                                            24,
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
                                                                    letterSpacing:
                                                                        0,
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
                                                                    letterSpacing:
                                                                        0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ),
                                                            RichText(
                                                              textScaler: MediaQuery.of(context).textScaler,
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text: valueOrDefault<String>(
                                                                      (OtherProductsDetailsCall.reviewdata(
                                                                        containerOtherProductsDetailsResponse?.jsonBody,
                                                                      ) as List).length.toString(), '0',
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
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 10, 0),
                                                      child: (OtherProductsDetailsCall
                                                                  .reviewdata(
                                                                      containerOtherProductsDetailsResponse
                                                                          ?.jsonBody) as List)
                                                              .isEmpty
                                                          ? Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .grey[300],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              child: Container(
                                                                width: 200,
                                                                child: Center(
                                                                  child: Text(
                                                                    'Be the first to review this product!',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              14,
                                                                          letterSpacing:
                                                                              0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : RichText(
                                                              textScaler:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        _formattedRating(
                                                                      OtherProductsDetailsCall
                                                                          .productrating(
                                                                        containerOtherProductsDetailsResponse
                                                                            ?.jsonBody,
                                                                      ),
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          fontSize:
                                                                              24,
                                                                          letterSpacing:
                                                                              0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                  ),
                                                                ],
                                                                style: FlutterFlowTheme.of(
                                                                        context)
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
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        (OtherProductsDetailsCall.reviewdata(
                                                                        containerOtherProductsDetailsResponse
                                                                            ?.jsonBody)
                                                                    as List)
                                                                .isEmpty
                                                            ? SizedBox
                                                                .shrink() // Hide the Overall Rating text when there are no reviews
                                                            : Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    'Overall Rating',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          fontSize:
                                                                              16,
                                                                          letterSpacing:
                                                                              0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                  ),
                                                                  RichText(
                                                                    textScaler:
                                                                        MediaQuery.of(context)
                                                                            .textScaler,
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              valueOrDefault<String>(
                                                                            (OtherProductsDetailsCall.reviewdata(containerOtherProductsDetailsResponse?.jsonBody) as List).length.toString(),
                                                                            '0',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Montserrat',
                                                                                fontSize: 12,
                                                                                letterSpacing: 0,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              ' Ratings',
                                                                          style:
                                                                              TextStyle(),
                                                                        )
                                                                      ],
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Montserrat',
                                                                            fontSize:
                                                                                12,
                                                                            letterSpacing:
                                                                                0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
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
                                                    print(
                                                        "Productid:${OtherProductsDetailsCall.rudrakshaProductid(
                                                      containerOtherProductsDetailsResponse
                                                          ?.jsonBody,
                                                    )?.toString()}");
                                                    print(
                                                        "productMainType:${OtherProductsDetailsCall.rudrakshaMainProductType(
                                                      containerOtherProductsDetailsResponse
                                                          ?.jsonBody,
                                                    )?.toString()}");

                                                    print(
                                                        "reviewcustomercomment:${OtherProductsDetailsCall.reviewcustomercomment(
                                                      containerOtherProductsDetailsResponse
                                                          ?.jsonBody,
                                                    )}");
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
                                                              ? FocusScope.of(
                                                                      context)
                                                                  .requestFocus(
                                                                      _model
                                                                          .unfocusNode)
                                                              : FocusScope.of(
                                                                      context)
                                                                  .unfocus(),
                                                          child: Padding(
                                                            padding: MediaQuery
                                                                .viewInsetsOf(
                                                                    context),
                                                            child:
                                                                AddReviewPopUpWidget(
                                                              mainproducttype:
                                                                  serializeParam(
                                                                OtherProductsDetailsCall
                                                                    .rudrakshaMainProductType(
                                                                  containerOtherProductsDetailsResponse
                                                                      ?.jsonBody,
                                                                )?.toString(),
                                                                ParamType
                                                                    .String,
                                                              ),
                                                              productid:
                                                                  serializeParam(
                                                                OtherProductsDetailsCall
                                                                    .rudrakshaProductid(
                                                                  containerOtherProductsDetailsResponse
                                                                      ?.jsonBody,
                                                                )?.toString(),
                                                                ParamType
                                                                    .String,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ).then((value) =>
                                                        safeSetState(() {}));
                                                  },
                                                  text: 'Rate Now',
                                                  options: FFButtonOptions(
                                                    height: 40,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                24, 0, 24, 0),
                                                    iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 0, 0),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          letterSpacing: 0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                    elevation: 0,
                                                    borderSide: BorderSide(
                                                      color: Color(0xFF740074),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
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
                                                  RatingBarIndicator(
                                                    itemBuilder:
                                                        (context, index) =>
                                                            Icon(
                                                      Icons.star_rounded,
                                                      color: Color(0xFFF59E0B),
                                                    ),
                                                    direction: Axis.horizontal,
                                                    rating:
                                                        OtherProductsDetailsCall
                                                            .productrating(
                                                      containerOtherProductsDetailsResponse
                                                          ?.jsonBody,
                                                    )!,
                                                    unratedColor:
                                                        Color(0x69F59E0B),
                                                    itemCount: 5,
                                                    itemSize: 20,
                                                  ),
                                                  Text(
                                                    valueOrDefault<String>(
                                                      OtherProductsDetailsCall
                                                          .reviewcustomercomment(
                                                        containerOtherProductsDetailsResponse
                                                            ?.jsonBody,
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
                                                          OtherProductsDetailsCall
                                                              .reviewcustomername(
                                                            containerOtherProductsDetailsResponse
                                                                ?.jsonBody,
                                                          ),
                                                          'x',
                                                        ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color(
                                                                  0xFF696969),
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        valueOrDefault<String>(
                                                          OtherProductsDetailsCall
                                                                      .reviewdate(
                                                                    containerOtherProductsDetailsResponse
                                                                        ?.jsonBody,
                                                                  ) !=
                                                                  null
                                                              ? formatDate(
                                                                  OtherProductsDetailsCall
                                                                      .reviewdate(
                                                                  containerOtherProductsDetailsResponse
                                                                      ?.jsonBody,
                                                                )!)
                                                              : 'x',
                                                          'x',
                                                        ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color(
                                                                  0xFF696969),
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: FFButtonWidget(
                                                      onPressed: () {
                                                        context.pushNamed(
                                                          'AllReviewsWidget',
                                                          queryParameters: {
                                                            'reviewlist':
                                                                serializeParam(
                                                              OtherProductsDetailsCall
                                                                  .reviewdata(
                                                                containerOtherProductsDetailsResponse
                                                                    ?.jsonBody,
                                                              ),
                                                              ParamType.JSON,
                                                              // isList: true,
                                                            ),
                                                            'productSlugValue':
                                                                serializeParam(
                                                              widget
                                                                  .productSlugValue,
                                                              ParamType.String,
                                                            ),
                                                            'producttype':
                                                                serializeParam(
                                                              widget
                                                                  .producttype,
                                                              ParamType.String,
                                                            ),
                                                          }.withoutNulls,
                                                        );
                                                      },
                                                      text: 'View All Reviews',
                                                      options: FFButtonOptions(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                1,
                                                        height: 40,
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(24, 0,
                                                                    24, 0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 0),
                                                        color:
                                                            Color(0xFF740074),
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  letterSpacing:
                                                                      0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                        elevation: 0,
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFF740074),
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                    ),
                                                  ),
                                                  /*InkWell(
                                                        onTap: () {
                                                          context.pushNamed(
                                                            'AllReviewsWidget',
                                                            queryParameters: {
                                                              'reviewlist':
                                                                  serializeParam(
                                                                OtherProductsDetailsCall
                                                                    .reviewdata(
                                                                  containerOtherProductsDetailsResponse
                                                                      ?.jsonBody,
                                                                ),
                                                                ParamType.JSON,
                                                                // isList: true,
                                                              ),
                                                              'productSlugValue':
                                                                  serializeParam(
                                                                widget
                                                                    .productSlugValue,
                                                                ParamType.String,
                                                              ),
                                                              'producttype':
                                                                  serializeParam(
                                                                widget.producttype,
                                                                ParamType.String,
                                                              ),
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
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        'View All ',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
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
                                                                  */ /*    TextSpan(
                                                          text: valueOrDefault<String>(
                                                          (OtherProductsDetailsCall.reviewdata(
                                                          containerOtherProductsDetailsResponse.jsonBody,
                                                          ) as List).length.toString(),
                                                          '0',
                                                          ),

                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),*/ /*
                                                                  TextSpan(
                                                                    text:
                                                                        'Reviews',
                                                                    style:
                                                                        TextStyle(
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
                                                                      letterSpacing:
                                                                          0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                              ),
                                                            ),
                                                         */ /*   FlutterFlowIconButton(
                                                              borderColor: Colors
                                                                  .transparent,
                                                              borderRadius: 30,
                                                              borderWidth: 1,
                                                              buttonSize:
                                                                  MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.1,
                                                              icon: Icon(
                                                                Icons.navigate_next,
                                                                color: FlutterFlowTheme
                                                                        .of(context)
                                                                    .primaryText,
                                                                size: 25,
                                                              ),
                                                              onPressed: () {
                                                                print(
                                                                    'IconButton pressed ...');
                                                              },
                                                            ),*/ /*
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
                                          iconColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          iconPadding: EdgeInsets.fromLTRB(
                                              16, 16, 8, 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 2,
                                thickness: 1.5,
                                color: Color(0xFFE7E7E8),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 0, 20),
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
                                          0, 0, 0, 16),
                                      child: Builder(
                                        builder: (context) {
                                          final relatedProduct =
                                              OtherProductsDetailsCall
                                                      .relatedproduct(
                                                    containerOtherProductsDetailsResponse
                                                        ?.jsonBody,
                                                  )?.toList() ??
                                                  [];
                                          // Sort the list
                                          relatedProduct.sort((a, b) {
                                            // Check for reserved field first
                                            if (getJsonField(a,
                                                            r'''$.reserved''')
                                                        .toString() ==
                                                    'true' &&
                                                getJsonField(b,
                                                            r'''$.reserved''')
                                                        .toString() ==
                                                    'false') {
                                              return -1;
                                            } else if (getJsonField(a,
                                                            r'''$.reserved''')
                                                        .toString() ==
                                                    'false' &&
                                                getJsonField(b,
                                                            r'''$.reserved''')
                                                        .toString() ==
                                                    'true') {
                                              return 1;
                                            }

                                            // If both have the same reserved status, check the out_of_stock field
                                            if (getJsonField(a,
                                                            r'''$.out_of_stock''')
                                                        .toString() ==
                                                    'true' &&
                                                getJsonField(b,
                                                            r'''$.out_of_stock''')
                                                        .toString() ==
                                                    'false') {
                                              return 1;
                                            } else if (getJsonField(a,
                                                            r'''$.out_of_stock''')
                                                        .toString() ==
                                                    'false' &&
                                                getJsonField(b,
                                                            r'''$.out_of_stock''')
                                                        .toString() ==
                                                    'true') {
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
                                                print(
                                                    "out_of_stock :${getJsonField(
                                                  relatedProductItem,
                                                  r'''$.out_of_stock''',
                                                ).toString()}");
                                                return InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    if (widget.producttype ==
                                                        FFAppConstants
                                                            .RudrakshaMasterProductDetailsApi) {
                                                      context.pushNamed(
                                                        'DiamondProductDetails',
                                                        queryParameters: {
                                                          'productSlugValue':
                                                              serializeParam(
                                                            getJsonField(
                                                              relatedProductItem,
                                                              r'''$.slug_value''',
                                                            ).toString(),
                                                            ParamType.String,
                                                          ),
                                                          'producttype':
                                                              serializeParam(
                                                            FFAppConstants
                                                                .RudrakshaMasterProductDetailsApi,
                                                            ParamType.String,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String,
                                                            dynamic>{
                                                          kTransitionInfoKey:
                                                              TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType:
                                                                PageTransitionType
                                                                    .bottomToTop,
                                                          ),
                                                        },
                                                      );
                                                    } else {
                                                      context.pushNamed(
                                                        'DiamondProductDetails',
                                                        queryParameters: {
                                                          'productSlugValue':
                                                              serializeParam(
                                                            getJsonField(
                                                              relatedProductItem,
                                                              r'''$.slug_value''',
                                                            ).toString(),
                                                            ParamType.String,
                                                          ),
                                                          'producttype':
                                                              serializeParam(
                                                            FFAppConstants
                                                                .GemstoneMasterProductDetailsApi,
                                                            ParamType.String,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String,
                                                            dynamic>{
                                                          kTransitionInfoKey:
                                                              TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType:
                                                                PageTransitionType
                                                                    .bottomToTop,
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
                                                        height: 220,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
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
                                                                  relatedProductItem,
                                                                  r'''$.thumbnail_image''',
                                                                ).toString(),
                                                                width: 152,
                                                                height: 104,
                                                                fit: BoxFit
                                                                    .fitWidth,
                                                              ),
                                                            ),
                                                            Container(
                                                              width: double
                                                                  .infinity,
                                                              height: 50,
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child:
                                                                  AutoSizeText(
                                                                getJsonField(
                                                                  relatedProductItem,
                                                                  r'''$.product_name''',
                                                                ).toString(),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      color: Color(
                                                                          0xFF696969),
                                                                      fontSize:
                                                                          14,
                                                                      letterSpacing:
                                                                          0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      lineHeight:
                                                                          1.5,
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
                                                                    text: /*getJsonField(
                                                                          relatedProductItem,
                                                                          r'''$.selling_price''',
                                                                        ).toString(),*/
                                                                        '${valueOrDefault<String>(
                                                                      FFAppState()
                                                                          .currencyName,
                                                                      'INR',
                                                                    )} ${formatNumber(
                                                                      functions.currencyConversion(
                                                                          FFAppState().currencyRate,
                                                                          getJsonField(
                                                                            relatedProductItem,
                                                                            r'''$.selling_price''',
                                                                          ).toString()),
                                                                      formatType:
                                                                          FormatType
                                                                              .decimal,
                                                                      decimalType:
                                                                          DecimalType
                                                                              .automatic,
                                                                    )}',
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                                  )
                                                                ],
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      fontSize:
                                                                          14,
                                                                      letterSpacing:
                                                                          0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                              ),
                                                              maxLines: 2,
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              0),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/Rating_Icon.png',
                                                                    width: 16,
                                                                    height: 16,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                                RichText(
                                                                  textScaler: MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text:
                                                                            getJsonField(
                                                                          relatedProductItem,
                                                                          r'''$.product_rating''',
                                                                        ).toString(),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Montserrat',
                                                                              letterSpacing: 0,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                      ),
                                                                      /*TextSpan(
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
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          letterSpacing:
                                                                              0,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 5)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      if (getJsonField(
                                                                  relatedProductItem,
                                                                  r'''$.out_of_stock''')
                                                              .toString() ==
                                                          'true')
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1, -1),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        5,
                                                                        5,
                                                                        0),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          12),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          12),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        5.0),
                                                                child: Text(
                                                                  "OUT OF STOCK",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      if (getJsonField(
                                                                  relatedProductItem,
                                                                  r'''$.reserved''')
                                                              .toString() ==
                                                          'true')
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1, -1),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        5,
                                                                        5,
                                                                        0),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          12),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          12),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        5.0),
                                                                child: Text(
                                                                  "RESERVED",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
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
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              color: Colors.white, // Set the background color to white
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(children: [
              if ((OtherProductsDetailsCall.out_of_stock(
                        containerOtherProductsDetailsResponse?.jsonBody,
                      ) ==
                      false) &&
                  (OtherProductsDetailsCall.reserved(
                        containerOtherProductsDetailsResponse?.jsonBody,
                      ) ==
                      false))
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          print(
                              "data88: ${getJsonField(containerOtherProductsDetailsResponse?.jsonBody, r'''$.data''').toString()}");
                          if (currentAuthenticationToken != null &&
                              currentAuthenticationToken != '') {
                            FFAppState().buynow = false;
                            if (widget.producttype ==
                                FFAppConstants
                                    .RudrakshaMasterProductDetailsApi) {
                              var _shouldSetState = false;
                              _model.apiResultj7i = await AddToCartCall.call(
                                hosturl: FFAppConstants.sanityurl,
                                token: currentAuthenticationToken,
                                productid:
                                    OtherProductsDetailsCall.rudrakshaProductid(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                )?.toString(),
                                productType: OtherProductsDetailsCall
                                    .rudrakshaMainProductType(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                )?.toString(),
                                productvariation: OtherProductsDetailsCall
                                    .productVariantStatus(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                ),
                                productvariationId: 2,
                                quantity:
                                    _model.countControllerValue?.toString(),
                                energization: OtherProductsDetailsCall
                                    .pujaenergizationlistid(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                )?[_model.selectedEnergizationIndex!],
                                certification: (OtherProductsDetailsCall
                                        .certificationlistid(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                )?[_model.selectedCertificationindex!])
                                    ?.toString(),
                                design: _model.selecteddesignid,
                                chain: _model.selectedchainid,
                                //ringSize: FFAppState().selectedRingSize,
                                ringSize: FFAppState().selectedRingSize != null
                                    ? FFAppState().selectedRingSize
                                    : '',
                                ringSizeSystem:
                                    _model.choiceChipsValue2 == 'Ring'
                                        ? FFAppState().selectedSizeSystem
                                        : '',
                                wristSize:
                                    _model.choiceChipsValue2 == 'Bracelet'
                                        ? FFAppState().selectedSizeSystem
                                        : '',
                              );
                              _shouldSetState = true;
                              if ((_model.apiResultj7i?.succeeded ?? true)) {
                                if (getJsonField(
                                      (_model.apiResultj7i?.jsonBody ?? ''),
                                      r'''$.status''',
                                    ).toString() !=
                                    'failed')
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        getJsonField(
                                          (_model.apiResultj7i?.jsonBody ?? ''),
                                          r'''$.msg''',
                                        ).toString(),
                                        //'Product added in Cart',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .containerFillColor,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context).primary,
                                    ),
                                  );
                                /*ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                getJsonField(
                                                  (_model.apiResultj7i?.jsonBody ?? ''),
                                                  r'''$.msg''',
                                                ).toString(),
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(context).containerFillColor,
                                                ),
                                              ),
                                              duration: Duration(milliseconds: 4000),
                                              backgroundColor: FlutterFlowTheme.of(context).primary,
                                            ),
                                          );*/
                                if (getJsonField(
                                      (_model.apiResultj7i?.jsonBody ?? ''),
                                      r'''$.status''',
                                    ).toString() !=
                                    "failed")
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () => _model
                                                .unfocusNode.canRequestFocus
                                            ? FocusScope.of(context)
                                                .requestFocus(
                                                    _model.unfocusNode)
                                            : FocusScope.of(context).unfocus(),
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: MyCartWidget(),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      getJsonField(
                                        (_model.apiResultj7i?.jsonBody ?? ''),
                                        r'''$.msg''',
                                      ).toString(),
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .containerFillColor,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                  ),
                                );
                                if (_shouldSetState) setState(() {});
                                return;
                              }
                              _model.productid =
                                  OtherProductsDetailsCall.rudrakshaProductid(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              );
                              _model.productmaintypee = OtherProductsDetailsCall
                                  .rudrakshaMainProductType(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              );
                              _model.productvarient =
                                  OtherProductsDetailsCall.productVariantStatus(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              )!;
                              setState(() {});
                              if (_shouldSetState) setState(() {});
                            } else {
                              var _shouldSetState = false;
                              _model.apiResult5ep = await AddToCartCall.call(
                                hosturl: FFAppConstants.sanityurl,
                                token: currentAuthenticationToken,
                                productid:
                                    OtherProductsDetailsCall.rudrakshaProductid(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                )?.toString(),
                                productType: OtherProductsDetailsCall
                                    .rudrakshaMainProductType(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                )?.toString(),
                                productvariation: OtherProductsDetailsCall
                                    .productVariantStatus(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                ),
                                productvariationId: 2,
                                quantity:
                                    _model.countControllerValue?.toString(),
                                energization: OtherProductsDetailsCall
                                    .pujaenergizationlistid(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                )?[_model.selectedEnergizationIndex!],
                                design: _model.selecteddesignid,
                                chain: _model.selectedchainid,
                                //ringSize: FFAppState().selectedRingSize,
                                ringSize: FFAppState().selectedRingSize != null
                                    ? FFAppState().selectedRingSize
                                    : '',
                                ringSizeSystem:
                                    _model.choiceChipsValue2 == 'Ring'
                                        ? FFAppState().selectedSizeSystem
                                        : '',
                                wristSize:
                                    _model.choiceChipsValue2 == 'Bracelet'
                                        ? FFAppState().selectedSizeSystem
                                        : '',
                              );

                              final requestData = {
                                'hosturl': FFAppConstants.sanityurl,
                                'token': currentAuthenticationToken,
                                'productid':
                                    OtherProductsDetailsCall.rudrakshaProductid(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                )?.toString(),
                                'productType': OtherProductsDetailsCall
                                    .rudrakshaMainProductType(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                )?.toString(),
                                'productvariation': OtherProductsDetailsCall
                                    .productVariantStatus(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                ),
                                'productvariationId': 2,
                                'quantity':
                                    _model.countControllerValue?.toString(),
                                'energization': OtherProductsDetailsCall
                                    .pujaenergizationlistid(
                                  containerOtherProductsDetailsResponse
                                      ?.jsonBody,
                                )?[_model.selectedEnergizationIndex!],
                                'design': _model.selecteddesignid,
                                'chain': _model.selectedchainid,
                                'ringSize': FFAppState().selectedRingSize,
                                'ringSizeSystem':
                                    _model.choiceChipsValue2 == 'Ring'
                                        ? FFAppState().selectedSizeSystem
                                        : null,
                                'wristSize':
                                    _model.choiceChipsValue2 == 'Bracelet'
                                        ? FFAppState().selectedSizeSystem
                                        : null,
                              };
                              _shouldSetState = true;
                              print(
                                  'Request Data JSON: ${jsonEncode(requestData)}');
                              print('API Request Data: $requestData');
                              print(
                                  'FFAppState().selectedRingSize: ${FFAppState().selectedRingSize}');
                              print(
                                  'FFAppState().selectedSizeSystem: ${FFAppState().selectedSizeSystem}');
                              print(
                                  'FFAppState().selectedSize: ${FFAppState().selectedSize}');
                              print(
                                  '_model.selecteddesignid: ${_model.selecteddesignid}');
                              print(
                                  '_model.selectedchainidapi: ${_model.selectedchainid}');
                              print(
                                  '_model.apiResult5ep?.succeeded: ${_model.apiResult5ep?.succeeded}');
                              print(
                                  '_model.apiResult5ep?.response: ${_model.apiResult5ep?.response}');
                              print(
                                  'API Error: ${_model.apiResult5ep?.jsonBody}');
                              print(
                                  'statusCode: ${_model.apiResult5ep?.statusCode}');
                              print(
                                  'exception: ${_model.apiResult5ep?.exception}');
                              print(
                                  'exceptionMessage: ${_model.apiResult5ep?.exceptionMessage}');
                              print(
                                  'exceptionMessage: ${_model.apiResult5ep?.bodyText}');
                              if ((_model.apiResult5ep?.succeeded ?? true)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      getJsonField(
                                        (_model.apiResult5ep?.jsonBody ?? ''),
                                        r'''$.msg''',
                                      ).toString(),
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .containerFillColor,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                  ),
                                );
                                if (getJsonField(
                                      (_model.apiResult5ep?.jsonBody ?? ''),
                                      r'''$.status''',
                                    ).toString() !=
                                    "failed")
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () => _model
                                                .unfocusNode.canRequestFocus
                                            ? FocusScope.of(context)
                                                .requestFocus(
                                                    _model.unfocusNode)
                                            : FocusScope.of(context).unfocus(),
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: MyCartWidget(),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      getJsonField(
                                        (_model.apiResult5ep?.jsonBody ?? ''),
                                        r'''$.msg''',
                                      ).toString(),
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .containerFillColor,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                  ),
                                );
                                if (_shouldSetState) setState(() {});
                                return;
                              }
                              _model.productid =
                                  OtherProductsDetailsCall.rudrakshaProductid(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              );
                              _model.productmaintypee = OtherProductsDetailsCall
                                  .rudrakshaMainProductType(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              );
                              _model.productvarient =
                                  OtherProductsDetailsCall.productVariantStatus(
                                containerOtherProductsDetailsResponse?.jsonBody,
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
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
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
                            if (widget.producttype ==
                                    FFAppConstants
                                        .RudrakshaMasterProductDetailsApi ||
                                widget.producttype ==
                                    FFAppConstants
                                        .GemstoneMasterProductDetailsApi) {
                              FFAppState().productid =
                                  OtherProductsDetailsCall.rudrakshaProductid(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              )!
                                      .toString();
                              FFAppState().productvariationId = 2;
                              FFAppState().productType =
                                  OtherProductsDetailsCall
                                          .rudrakshaMainProductType(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              )!
                                      .toString();

                              FFAppState().productvariation =
                                  OtherProductsDetailsCall.productVariantStatus(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              );
                              print(FFAppState().productvariation);

                              FFAppState().quantity =
                                  _model.countControllerValue!.toString();
                              FFAppState().energizationId =
                                  OtherProductsDetailsCall
                                      .pujaenergizationlistid(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              )?[_model.selectedEnergizationIndex!];
                              print(
                                  "_model.selecteddesignid ${_model.selecteddesignid}");
                              print(
                                  "FFAppState().energizationId ${FFAppState().energizationId}");

                              FFAppState().desingId = _model.selecteddesignid;
                              FFAppState().selectedCertificationId =
                                  (OtherProductsDetailsCall.certificationlistid(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              )?[_model.selectedCertificationindex!]);

                              print(
                                  "FFAppState().selectedCertificationId ${FFAppState().selectedCertificationId}");

                              FFAppState().buynow = true;
                              print(FFAppState().buynow);
                              print(FFAppState().quantity);
                              print(FFAppState().productvariation);
                              print(FFAppState().productType);
                              print(FFAppState().productvariationId);
                              print(FFAppState().productid);
                              print(FFAppState().productid);
                              context.pushNamed(
                                'DeliveryAddress',
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: const TransitionInfo(
                                    hasTransition: true,
                                    transitionType:
                                        PageTransitionType.bottomToTop,
                                    duration: Duration(milliseconds: 400),
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
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                ),
                              },
                            );
                          }
                        },
                        text: 'Buy Now',
                        options: FFButtonOptions(
                          width: MediaQuery.sizeOf(context).width * 0.44,
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: Color(0xFF740074),
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
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
                    containerOtherProductsDetailsResponse?.jsonBody,
                  ) ==
                  true)
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          final Uri phoneLaunchUri = Uri(
                            scheme: 'tel',
                            path:
                                '+917021180033', // replace with your phone number
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
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
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
                              'text':
                                  'I am interested in ${OtherProductsDetailsCall.productname(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              )} however it is out of stock. Kindly suggest an alternative.',
                            },
                          );

                          if (await canLaunchUrl(whatsappLaunchUri)) {
                            await launchUrl(whatsappLaunchUri,
                                mode: LaunchMode.externalApplication);
                          } else {
                            throw 'Could not launch $whatsappLaunchUri';
                          }
                        },
                        text: 'WHATSAPP',
                        options: FFButtonOptions(
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: FlutterFlowTheme.of(context).whatsapp,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
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
                            path:
                                'contact@rudracentre.com,info@rudracentre.com', // replace with your email address
                            queryParameters: {
                              'subject': 'Product_Inquiry',
                              'body':
                                  "I am interested in ${OtherProductsDetailsCall.productname(
                                containerOtherProductsDetailsResponse?.jsonBody,
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
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
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
              if (OtherProductsDetailsCall.reserved(
                    containerOtherProductsDetailsResponse?.jsonBody,
                  ) ==
                  true)
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          final Uri phoneLaunchUri = Uri(
                            scheme: 'tel',
                            path:
                                '+917021180033', // replace with your phone number
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
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
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
                              'text':
                                  'I am interested in ${OtherProductsDetailsCall.productname(
                                containerOtherProductsDetailsResponse?.jsonBody,
                              )} however it is out of stock. Kindly suggest an alternative.',
                            },
                          );

                          if (await canLaunchUrl(whatsappLaunchUri)) {
                            await launchUrl(whatsappLaunchUri,
                                mode: LaunchMode.externalApplication);
                          } else {
                            throw 'Could not launch $whatsappLaunchUri';
                          }
                        },
                        text: 'WHATSAPP',
                        options: FFButtonOptions(
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: FlutterFlowTheme.of(context).whatsapp,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
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
                            path:
                                'contact@rudracentre.com,info@rudracentre.com', // replace with your email address
                            queryParameters: {
                              'subject': 'Product_Inquiry',
                              'body':
                                  "I am interested in ${OtherProductsDetailsCall.productname(
                                containerOtherProductsDetailsResponse?.jsonBody,
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
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
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
            ]),
          ),
        ),
      ]),
    );
  }
}
