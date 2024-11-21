import '../../auth/custom_auth/auth_util.dart';
import '../../components/custom_nav_bar_widget.dart';
import '../../components/shimmer_widget.dart';
import '../../flutter_flow/custom_functions.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/free_gift_component/free_gift_component_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '/flutter_flow/custom_functions.dart' as functions;
import 'categories_list_view_choose_chip_model.dart';
export 'categories_list_view_choose_chip_model.dart';

class CategoriesListViewChooseChipWidget extends StatefulWidget {
  bool isSelected;
  final String defaultcategories;
  final String subproductslugvalue;
 // Add this to your state


  CategoriesListViewChooseChipWidget({
    Key? key,
    this.isSelected = false,
    this.defaultcategories = 'Rudraksha',
    this.subproductslugvalue = 'p/chakra-vastu-pyramids',
  }) : super(key: key);

  @override
  State<CategoriesListViewChooseChipWidget> createState() =>
      _CategoriesListViewChooseChipWidgetState();
}

class _CategoriesListViewChooseChipWidgetState
    extends State<CategoriesListViewChooseChipWidget> {
  late CategoriesListViewChooseChipModel _model;

  final CategoriesListViewChooseChipWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    print("widget.subproductslugvalue : ${widget.subproductslugvalue}");
    _model = createModel(context, () => CategoriesListViewChooseChipModel());

  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }


  Widget _getImageWidget(subProductsItem) {
    String imageUrl = getJsonField(subProductsItem, r'''$.image''').toString();
    if (imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    } else {
      // If no image URL is available, show error or placeholder image
      return Image.asset(
        'assets/images/noimageavailable.jpg', // Replace with your error image asset path
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    }
  }

  String? mobilemenurefername(
      String? productname,
      dynamic jsondata,
      ) {
    /// MODIFY CODE ONLY BELOW THIS LINE

    // Ensure productname is not null
    if (productname == null || jsondata == null) {
      return null;
    }

    // Access the data list from jsondata
    var dataList = jsondata['data'];

    // Iterate over the data list to find the refer_name
    for (var item in dataList) {
      if (item['name'] == productname) {
        return item['refer_name'];
      }
    }

    return null;

    /// MODIFY CODE ONLY ABOVE THIS LINE
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: CategoriesListViewChooseChipWidgetscaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar:

        // Generated code for this AppBar Widget...
        PreferredSize(
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
              backgroundColor: Colors.transparent, // Set to transparent as the color is in the container
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
                  if (_model.selectedproduct == false) {
                    setState(() {});
                    _model.selectedproduct = true;
                    widget.isSelected = false;
                    setState(() {});
                  } else {
                    context.safePop();
                  }
                },
              ),
              title: Text(
                'All Categories',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 16,
                  letterSpacing: 0,
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
                      if (!snapshot.hasData) {
                        return const Center(
                          child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: ShimmerWidget(),
                          ),
                        );
                      }
                      final badgeCartResponse = snapshot.data!;
                      final cartCount = cartBadgeCount(badgeCartResponse.jsonBody);

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
                            borderRadius: BorderRadius.zero,
                            child: Image.asset(
                              'assets/images/Buy.png',
                              width: 30,
                              height: 30,
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
                            borderRadius: BorderRadius.zero,
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
                ),
              ],
              centerTitle: true,
              elevation: 0, // Elevation is not needed since we're using BoxShadow
            ),
          ),
        ),
        body: Stack(
          children: [
            SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [


                    FutureBuilder<ApiCallResponse>(
                      future: ProductHeirarchyCall.call(
                        sanityurl: FFAppConstants.sanityurl,
                        referName: _model.refername,
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: ShimmerWidget(),
                              )
                            ),
                          );
                        }
                        final containerProductHeirarchyResponse = snapshot.data!;
                        return Container(
                          //height: MediaQuery.sizeOf(context).height * 1,
                          decoration: BoxDecoration(),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Builder(
                                  builder: (context) {
                                    if (_model.selectedproduct) {
                                      return Container(
                                        decoration: BoxDecoration(),
                                        child: Builder(
                                          builder: (context) {
                                            final productDetails =
                                                ProductHeirarchyCall
                                                    .productDataList(
                                                  containerProductHeirarchyResponse
                                                      .jsonBody,
                                                )?.toList() ??
                                                    [];
                                            return
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(
                                                    productDetails.length,
                                                        (productDetailsIndex) {
                                                      final productDetailsItem =
                                                      productDetails[
                                                      productDetailsIndex];
                                                      return // Generated code for this Container Widget...
                                                        // Generated code for this Container Widget...
                                                        /* onTap: () async {
                                                        _model.selectedproduct = false;
                                                        setState(() {});
                                                        _model.selectedproductslugvale =
                                                            getJsonField(
                                                              productDetailsItem,
                                                              r'''$.slug_value''',
                                                            ).toString();
                                                        setState(() {});
                                                        productDetailsItem
                                                      },*/
                                                        InkWell(
                                                          splashColor: Colors.transparent,
                                                          focusColor: Colors.transparent,
                                                          hoverColor: Colors.transparent,
                                                          highlightColor: Colors.transparent,
                                                          onTap: () async {

                                                            _model.apiResulth6o = await SlugSearchCall.call(
                                                              hosturl: FFAppConstants.hosturl,
                                                              slugValue: getJsonField(
                                                                productDetailsItem,
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
                                                            setState(() {});
                                                            if (SlugSearchCall.datamainprodtype(
                                                              (_model.apiResulth6o?.jsonBody ?? ''),
                                                            ) ==
                                                                1) {
                                                              if (SlugSearchCall.datalevel(
                                                                (_model.apiResulth6o?.jsonBody ?? ''),
                                                              ) ==
                                                                  2) {
                                                                if (SlugSearchCall.dataproductlist(
                                                                  (_model.apiResulth6o?.jsonBody ?? ''),
                                                                )== true) {
                                                                  _model.selectedproduct = true;
                                                                  setState(() {});
                                                                  _model.selectedproductslugvale = getJsonField(
                                                                    productDetailsItem,
                                                                    r'''$.slug_value''',
                                                                  ).toString();
                                                                  _model.producttitle = getJsonField(
                                                                    productDetailsItem,
                                                                    r'''$.name''',
                                                                  ).toString();
                                                                  context.pushNamed(
                                                                    'MainProducts',
                                                                    queryParameters: {
                                                                      'productType': serializeParam(
                                                                        'PujaMainCategory',
                                                                        //_model.choiceChipsValue,
                                                                        ParamType.String,
                                                                      ),
                                                                      'productslugvalue': serializeParam(
                                                                        _model.selectedproductslugvale,
                                                                        ParamType.String,
                                                                      ),
                                                                      'producttitle': serializeParam(
                                                                        _model.producttitle,
                                                                        ParamType.String,
                                                                      ),
                                                                    }.withoutNulls,
                                                                  );
                                                                  /*    ScaffoldMessenger.of(context).showSnackBar(
                                                                  SnackBar(
                                                                    content: Text(
                                                                      'Navigate to puja product sceen',
                                                                      style: TextStyle(
                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                      ),
                                                                    ),
                                                                    duration: Duration(milliseconds: 4000),
                                                                    backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                  ),
                                                                );*/
                                                                } else {
                                                                  _model.selectedproduct = false;
                                                                  _model.apicall = 'puja Sub Cat listing';
                                                                  setState(() {});
                                                                  _model.selectedproductslugvale = getJsonField(
                                                                    productDetailsItem,
                                                                    r'''$.slug_value''',
                                                                  ).toString();
                                                                  setState(() {});
                                                                }
                                                              } else if (SlugSearchCall.datalevel(
                                                                (_model.apiResulth6o?.jsonBody ?? ''),
                                                              ) ==
                                                                  3) {
                                                                if (SlugSearchCall.dataproductlist(
                                                                  (_model.apiResulth6o?.jsonBody ?? ''),
                                                                )== true) {
                                                                  _model.selectedproduct = true;
                                                                  _model.apicall = 'Puja product list sub Cat ';
                                                                  print('_model.apicall ${_model.apicall }');
                                                                  setState(() {});
                                                                  _model.selectedproductslugvale = getJsonField(
                                                                    productDetailsItem,
                                                                    r'''$.slug_value''',
                                                                  ).toString();
                                                                  _model.producttitle = getJsonField(
                                                                    productDetailsItem,
                                                                    r'''$.name''',
                                                                  ).toString();
                                                                  context.pushNamed(
                                                                    'MainProducts',
                                                                    queryParameters: {
                                                                      'productType': serializeParam(
                                                                        'PujaSubCategory',
                                                                        //_model.choiceChipsValue,
                                                                        ParamType.String,
                                                                      ),
                                                                      'productslugvalue': serializeParam(
                                                                        _model.selectedproductslugvale,
                                                                        ParamType.String,
                                                                      ),
                                                                      'producttitle': serializeParam(
                                                                        _model.producttitle,
                                                                        ParamType.String,
                                                                      ),
                                                                    }.withoutNulls,
                                                                  );
                                                                  setState(() {});
                                                                }
                                                              } else {
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                  SnackBar(
                                                                    content: Text(
                                                                      'Failed',
                                                                      style: TextStyle(
                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                      ),
                                                                    ),
                                                                    duration: Duration(milliseconds: 4000),
                                                                    backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                  ),
                                                                );
                                                              }
                                                            } else if (SlugSearchCall.datamainprodtype(
                                                              (_model.apiResulth6o?.jsonBody ?? ''),
                                                            ) ==
                                                                2) {
                                                              if (SlugSearchCall.datalevel(
                                                                (_model.apiResulth6o?.jsonBody ?? ''),
                                                              ) ==
                                                                  2) {
                                                                if (SlugSearchCall.dataproductlist(
                                                                  (_model.apiResulth6o?.jsonBody ?? ''),
                                                                )== true) {
                                                                  _model.apicall = 'Gemstone product list main cat';
                                                                  setState(() {});
                                                                } else {
                                                                  _model.selectedproduct = false;
                                                                  _model.apicall = 'Gemstone Sub Cat listing';
                                                                  setState(() {});
                                                                  _model.selectedproductslugvale = getJsonField(
                                                                    productDetailsItem,
                                                                    r'''$.slug_value''',
                                                                  ).toString();
                                                                  setState(() {});
                                                                }
                                                              } else if (SlugSearchCall.datalevel(
                                                                (_model.apiResulth6o?.jsonBody ?? ''),
                                                              ) ==
                                                                  3) {
                                                                if (SlugSearchCall.dataproductlist(
                                                                  (_model.apiResulth6o?.jsonBody ?? ''),
                                                                )==true) {
                                                                  _model.selectedproductslugvale = getJsonField(
                                                                    productDetailsItem,
                                                                    r'''$.slug_value''',
                                                                  ).toString();
                                                                  _model.apicall = 'Gemstone product list sub Cat listing';
                                                                  setState(() {});
                                                                }
                                                              } else {
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                  SnackBar(
                                                                    content: Text(
                                                                      'Failed',
                                                                      style: TextStyle(
                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                      ),
                                                                    ),
                                                                    duration: Duration(milliseconds: 4000),
                                                                    backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                  ),
                                                                );
                                                              }
                                                            } else if (SlugSearchCall.datamainprodtype(
                                                              (_model.apiResulth6o?.jsonBody ?? ''),
                                                            ) ==
                                                                3) {
                                                              if (SlugSearchCall.datalevel(
                                                                (_model.apiResulth6o?.jsonBody ?? ''),
                                                              ) ==
                                                                  2) {
                                                                if (SlugSearchCall.dataproductlist(
                                                                  (_model.apiResulth6o?.jsonBody ?? ''),
                                                                )==true) {
                                                                  _model.apicall = 'Rudraksha product list main cat';
                                                                  setState(() {});
                                                                } else {
                                                                  _model.apicall = 'Rudraksha Sub Cat listing';
                                                                  _model.selectedproduct = false;
                                                                  setState(() {});
                                                                  _model.selectedproductslugvale = getJsonField(
                                                                    productDetailsItem,
                                                                    r'''$.slug_value''',
                                                                  ).toString();
                                                                  setState(() {});
                                                                }
                                                              } else if (SlugSearchCall.datalevel(
                                                                (_model.apiResulth6o?.jsonBody ?? ''),
                                                              ) ==
                                                                  3) {
                                                                if (SlugSearchCall.dataproductlist(
                                                                  (_model.apiResulth6o?.jsonBody ?? ''),
                                                                )== true) {
                                                                  _model.apicall = 'Rudraksha product list sub Cat listing';
                                                                  setState(() {});
                                                                }
                                                              } else {
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                  SnackBar(
                                                                    content: Text(
                                                                      'Failed',
                                                                      style: TextStyle(
                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                      ),
                                                                    ),
                                                                    duration: Duration(milliseconds: 4000),
                                                                    backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                  ),
                                                                );
                                                              }
                                                            } else if (SlugSearchCall.datamainprodtype(
                                                              (_model.apiResulth6o?.jsonBody ?? ''),
                                                            ) ==
                                                                4) {
                                                              if (SlugSearchCall.datalevel(
                                                                (_model.apiResulth6o?.jsonBody ?? ''),
                                                              ) ==
                                                                  2) {
                                                                if (SlugSearchCall.dataproductlist(
                                                                  (_model.apiResulth6o?.jsonBody ?? ''),
                                                                ) ==
                                                                    true){
                                                                  _model.selectedproduct = true;
                                                                  _model.selectedproductslugvale = getJsonField(
                                                                    productDetailsItem,
                                                                    r'''$.slug_value''',
                                                                  ).toString();
                                                                  _model.producttitle = getJsonField(
                                                                    productDetailsItem,
                                                                    r'''$.name''',
                                                                  ).toString();
                                                                  context.pushNamed(
                                                                    'MainProducts',
                                                                    queryParameters: {
                                                                      'productType': serializeParam(
                                                                        'Yantras',

                                                                        // _model.choiceChipsValue,
                                                                        ParamType.String,
                                                                      ),
                                                                      'productslugvalue': serializeParam(
                                                                        _model.selectedproductslugvale,
                                                                        ParamType.String,
                                                                      ),
                                                                      'producttitle': serializeParam(
                                                                        _model.producttitle,
                                                                        ParamType.String,
                                                                      ),
                                                                    }.withoutNulls,
                                                                  );
                                                                  _model.apicall = 'Yantras product list main cat';
                                                                  setState(() {});
                                                                  /* ScaffoldMessenger.of(context).showSnackBar(
                                                                  SnackBar(
                                                                    content: Text(
                                                                      'Navigate to Yantras product sceen',
                                                                      style: TextStyle(
                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                      ),
                                                                    ),
                                                                    duration: Duration(milliseconds: 4000),
                                                                    backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                  ),
                                                                );*/
                                                                } else {
                                                                  _model.apicall = 'Yantras Sub Cat listing';
                                                                  setState(() {});
                                                                  _model.selectedproductslugvale = getJsonField(
                                                                    productDetailsItem,
                                                                    r'''$.slug_value''',
                                                                  ).toString();
                                                                  setState(() {});
                                                                }
                                                              } else if (SlugSearchCall.datalevel(
                                                                (_model.apiResulth6o?.jsonBody ?? ''),
                                                              ) ==
                                                                  3) {
                                                                if (SlugSearchCall.dataproductlist(
                                                                  (_model.apiResulth6o?.jsonBody ?? ''),
                                                                )== true) {
                                                                  _model.apicall = 'Yantras product list sub Cat listing';
                                                                  setState(() {});
                                                                }
                                                              } else {
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                  SnackBar(
                                                                    content: Text(
                                                                      'Failed',
                                                                      style: TextStyle(
                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                      ),
                                                                    ),
                                                                    duration: Duration(milliseconds: 4000),
                                                                    backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                  ),
                                                                );
                                                              }
                                                            } else if (SlugSearchCall.datamainprodtype(
                                                              (_model.apiResulth6o?.jsonBody ?? ''),
                                                            ) ==
                                                                5) {
                                                              if (SlugSearchCall.datalevel(
                                                                (_model.apiResulth6o?.jsonBody ?? ''),
                                                              ) ==
                                                                  1) {
                                                                if (SlugSearchCall.dataproductlist(
                                                                  (_model.apiResulth6o?.jsonBody ?? ''),
                                                                )== true) {
                                                                  _model.apicall = 'other Main cat listing';
                                                                  setState(() {});
                                                                  _model.selectedproductslugvale = getJsonField(
                                                                    productDetailsItem,
                                                                    r'''$.slug_value''',
                                                                  ).toString();
                                                                  setState(() {});
                                                                } else {
                                                                  _model.selectedproduct = false;
                                                                  _model.apicall = 'other Main cat listing';
                                                                  setState(() {});
                                                                  _model.selectedproductslugvale = getJsonField(
                                                                    productDetailsItem,
                                                                    r'''$.slug_value''',
                                                                  ).toString();
                                                                  setState(() {});
                                                                }
                                                              } else if (SlugSearchCall.datalevel(
                                                                (_model.apiResulth6o?.jsonBody ?? ''),
                                                              ) ==
                                                                  2) {
                                                                if (SlugSearchCall.dataproductlist(
                                                                  (_model.apiResulth6o?.jsonBody ?? ''),
                                                                ) == true) {
                                                                  _model.selectedproduct = true;
                                                                  _model.apicall = 'other product list main cat';
                                                                  _model.producttype = 'OthersMainCategory';
                                                                  setState(() {});
                                                                  setState(() {});
                                                                  _model.selectedproductslugvale = getJsonField(
                                                                    productDetailsItem,
                                                                    r'''$.slug_value''',
                                                                  ).toString();
                                                                  _model.producttitle = getJsonField(
                                                                    productDetailsItem,
                                                                    r'''$.name''',
                                                                  ).toString();
                                                                  context.pushNamed(
                                                                    'MainProducts',
                                                                    queryParameters: {
                                                                      'productType': serializeParam(
                                                                        _model.producttype,
                                                                        ParamType.String,
                                                                      ),
                                                                      'productslugvalue': serializeParam(
                                                                        _model.selectedproductslugvale,
                                                                        ParamType.String,
                                                                      ),
                                                                      'producttitle': serializeParam(
                                                                        _model.producttitle,
                                                                        ParamType.String,
                                                                      ),
                                                                    }.withoutNulls,
                                                                  );

                                                                } else {
                                                                  _model.selectedproduct = false;
                                                                  _model.apicall = 'other Sub Cat listing';
                                                                  print(_model.apicall);

                                                                  setState(() {});
                                                                  _model.selectedproductslugvale = getJsonField(
                                                                    productDetailsItem,
                                                                    r'''$.slug_value''',
                                                                  ).toString();
                                                                  print(_model.selectedproductslugvale);
                                                                  setState(() {});
                                                                }
                                                              } else if (SlugSearchCall.datalevel(
                                                                (_model.apiResulth6o?.jsonBody ?? ''),
                                                              ) ==
                                                                  3) {
                                                                if (SlugSearchCall.dataproductlist(
                                                                  (_model.apiResulth6o?.jsonBody ?? ''),
                                                                )==true) {
                                                                  _model.selectedproduct = false;
                                                                  _model.apicall = 'other product list sub Cat listing';
                                                                  setState(() {});
                                                                }
                                                              } else {
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                  SnackBar(
                                                                    content: Text(
                                                                      'Failed',
                                                                      style: TextStyle(
                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                      ),
                                                                    ),
                                                                    duration: Duration(milliseconds: 4000),
                                                                    backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                  ),
                                                                );
                                                              }
                                                            } else {
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Failed',
                                                                    style: TextStyle(
                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                    ),
                                                                  ),
                                                                  duration: Duration(milliseconds: 4000),
                                                                  backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                ),
                                                              );
                                                            }
                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            width: double.infinity,
                                                            height: 72,
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: Color(0xFFE7E7E8),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                                                              child: Row(
                                                                mainAxisSize: MainAxisSize.max,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                                                                    child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(5),
                                                                      child: Image.network(
                                                                        getJsonField(
                                                                          productDetailsItem,
                                                                          r'''$.image''',
                                                                        ).toString(),
                                                                        width: 50,
                                                                        height: 50,
                                                                        fit: BoxFit.cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Column(
                                                                    mainAxisSize: MainAxisSize.max,
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Container(
                                                                        width: 181,
                                                                        decoration: BoxDecoration(),
                                                                        child: Text(
                                                                          getJsonField(
                                                                            productDetailsItem,
                                                                            r'''$.name''',
                                                                          ).toString(),
                                                                          textAlign: TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            fontFamily: 'Montserrat',
                                                                            fontSize: 14,
                                                                            letterSpacing: 0,
                                                                            fontWeight: FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );


                                                    }),
                                              );
                                          },
                                        ),
                                      );
                                    } else {
                                      return FutureBuilder<ApiCallResponse>(
                                        future: SubProductHeirarchyCall.call(
                                          sanityurl: FFAppConstants.sanityurl,
                                          slugValue: widget.isSelected ? widget.subproductslugvalue : _model.selectedproductslugvale,//_model.selectedproductslugvale,
                                          subcategory: () {
                                            print("_model.choiceChipsValue Start ${_model.choiceChipsValue}");
                                            // print("_model.choiceChipsValue Vastu ${_model.choiceChipsValue} ${_model.mainprodtype} ${_model.level} ${_model.productlist}");
                                            if (_model.choiceChipsValue == 'Rudraksha') {
                                              if(widget.isSelected==true && widget.subproductslugvalue=="p/rudraksha-kantha-rudraksha-mala" )
                                              {
                                                _model.mainprodtype=5 ;
                                                _model.level=2 ;
                                                _model.productlist=false;
                                              }
                                              if(_model.mainprodtype==5 && _model.level==2 && _model.productlist==false)
                                              {  return 'other-dependent-sub-category';}
                                              /* else if (_model.mainprodtype==5 && _model.level==2 && _model.productlist==true)
                                              {return 'other-product-basedon-maincategory';
                                              print("_model.choiceChipsValue Vastu ${_model.choiceChipsValue} ${_model.mainprodtype} ${_model.level} ${_model.productlist}");
                                              }*/
                                              else

                                                return 'rudraksha-dependent-sub-category';
                                            }else if(_model.choiceChipsValue == 'Idols') {
                                              return 'other-dependent-sub-category';
                                            } else if (_model.choiceChipsValue == 'Gemstone') {
                                              if(_model.mainprodtype==5 && _model.level==2 && _model.productlist==false)
                                              { return 'other-dependent-sub-category';}
                                              else if (_model.mainprodtype==2 && _model.level==3 && _model.productlist==true) {
                                                return 'gemstone-product-basedon-subcategory';
                                              } else
                                              {return 'gemstone-dependent-sub-category';}
                                            }  else if (_model.choiceChipsValue ==
                                                'Yantras') {
                                              if(_model.mainprodtype==5 && _model.level==2 && _model.productlist==false)
                                              {      return 'other-dependent-sub-category';}
                                              else
                                                return 'yantra-dependent-sub-category';
                                            } else if (_model.choiceChipsValue ==
                                                'Others') {
                                              return 'other-dependent-maincategory';
                                            }  else if (_model.choiceChipsValue ==
                                                'Jewellery') {
                                              print("_model.choiceChipsValue Jewellary ${_model.choiceChipsValue}");
                                              return 'other-dependent-sub-category';
                                            }  else if (_model.choiceChipsValue ==
                                                'Vastu') {

                                              print("_model.choiceChipsValue Vastu ${_model.choiceChipsValue}");
                                              return 'other-dependent-sub-category';
                                            }  else if (_model.choiceChipsValue ==
                                                'Puja') {
                                              return //'puja-product-basedon-maincategory';
                                                'puja-dependent-sub-category';
                                            } else {
                                              //return '';
                                              return 'rudraksha-dependent-sub-category';
                                            }
                                            print("_model.choiceChipsValue ${_model.choiceChipsValue}");
                                          }(),

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
                                          final subProductSubProductHeirarchyResponse =
                                          snapshot.data!;
                                          return Builder(
                                            builder: (context) {
                                              final subProducts =
                                                  SubProductHeirarchyCall
                                                      .productDataList(
                                                    subProductSubProductHeirarchyResponse
                                                        .jsonBody,
                                                  )?.toList() ??
                                                      [];
                                              widget.isSelected=!widget.isSelected;
                                              return SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: List.generate(
                                                      subProducts.length,
                                                          (subProductsIndex) {
                                                        final subProductsItem =
                                                        subProducts[
                                                        subProductsIndex];
                                                        return
                                                          // Generated code for this Container Widget...
                                                          InkWell(
                                                            splashColor: Colors.transparent,
                                                            focusColor: Colors.transparent,
                                                            hoverColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () async {
                                                              print("_model.mainprodtype${_model.mainprodtype} _model.level${_model.level }  _model.productlist:${_model.productlist}");
                                                              _model.slugSearchSubProduct = await SlugSearchCall.call(
                                                                hosturl: FFAppConstants.hosturl,
                                                                slugValue: getJsonField(
                                                                  subProductsItem,
                                                                  r'''$.slug_value''',
                                                                ).toString(),
                                                              );
                                                              _model.mainprodtype = SlugSearchCall.datamainprodtype(
                                                                (_model.slugSearchSubProduct?.jsonBody ?? ''),
                                                              );
                                                              _model.level = SlugSearchCall.datalevel(
                                                                (_model.slugSearchSubProduct?.jsonBody ?? ''),
                                                              );
                                                              _model.productlist = SlugSearchCall.dataproductlist(
                                                                (_model.slugSearchSubProduct?.jsonBody ?? ''),
                                                              )!;
                                                              print("_model.mainprodtype${_model.mainprodtype} _model.level${_model.level }  _model.productlist:${_model.productlist}");
                                                              if (_model.mainprodtype==5 && _model.level==2 && _model.productlist==true) {
                                                                _model.producttype = 'OthersMainCategory';
                                                              } else if (_model.mainprodtype==1 && _model.level==2 && _model.productlist==true){
                                                                _model.producttype = 'PujaSubCategory'; // Default value or other logic
                                                              }else if (_model.mainprodtype==1 && _model.level==3 && _model.productlist==true){
                                                                _model.producttype = 'PujaSubCategory'; // Default value or other logic
                                                              }else if (_model.mainprodtype==5 && _model.level==2 && _model.productlist==false){
                                                                _model.producttype = 'OthersMainCategory'; // Default value or other logic
                                                              }else if (_model.mainprodtype==5 && _model.level==3 && _model.productlist==true){
                                                                _model.producttype = 'OthersSubCategory'; // Default value or other logic
                                                              }else if (_model.mainprodtype==4 && _model.level==2 && _model.productlist==true){
                                                                _model.producttype = 'Yantras'; // Default value or other logic
                                                              }else
                                                              {
                                                                _model.producttype = _model.choiceChipsValue;
                                                              }
                                                              print("_model.mainprodtype${_model.mainprodtype} _model.level${_model.level }  _model.productlist:${_model.productlist}");
                                                              _model.selectedproduct = true;
                                                              _model.producttitle = getJsonField(
                                                                subProductsItem,
                                                                r'''$.name''',
                                                              ).toString();
                                                              print("_model.producttitle:${_model.producttitle}");
                                                              context.pushNamed(
                                                                'MainProducts',
                                                                queryParameters: {
                                                                  'productType': serializeParam(
                                                                    _model.producttype,

                                                                    //  'PujaSubCategory',
                                                                    //  'OthersMainCategory',

                                                                    //_model.choiceChipsValue,

                                                                    ParamType.String,
                                                                  ), 'productslugvalue': serializeParam(
                                                                    getJsonField(
                                                                      subProductsItem,

                                                                      r'''$.slug_value''',

                                                                    ).toString(),
                                                                    ParamType.String,
                                                                  ),
                                                                  'producttitle': serializeParam(
                                                                    _model.producttitle,
                                                                    ParamType.String,
                                                                  ),
                                                                  /* 'productType': serializeParam(
                                                                    getJsonField(
                                                                      subProductsItem,
                                                                      r'''$.slug_value''',
                                                                    ).toString(),
                                                                    ParamType.String,
                                                                  ),*/
                                                                }.withoutNulls,
                                                              );
                                                            },
                                                            child: Container(
                                                              width: double.infinity,
                                                              height: 72,
                                                              decoration: BoxDecoration(
                                                                border: Border.all(
                                                                  color: Color(0xFFE7E7E8),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                                                                      child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(8),
                                                                        child:
                                                                        _getImageWidget(subProductsItem),
                                                                        /* Image.network(
                                                                          getJsonField(
                                                                            subProductsItem,
                                                                            r'''$.image''',
                                                                          ).toString(),
                                                                          width: 50,
                                                                          height: 50,
                                                                          fit: BoxFit.cover,
                                                                        ),*/
                                                                      ),
                                                                    ),
                                                                    Column(
                                                                      mainAxisSize: MainAxisSize.max,
                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Container(
                                                                          width: 181,
                                                                          decoration: BoxDecoration(),
                                                                          child: Text(
                                                                            getJsonField(
                                                                              subProductsItem,
                                                                              r'''$.name''',
                                                                            ).toString(),
                                                                            textAlign: TextAlign.start,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                              fontFamily: 'Montserrat',
                                                                              fontSize: 10,
                                                                              letterSpacing: 0,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ;
                                                        /* Container(
                                                          width: double.infinity,
                                                          height: 72,
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color: FlutterFlowTheme.of(context).BorderAllcolor,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                24, 12, 24, 12),
                                                            child: Row(
                                                              mainAxisSize:
                                                              MainAxisSize.max,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(0,
                                                                      0, 16, 0),
                                                                  child: ClipRRect(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        8),
                                                                    child:
                                                                    Image.network(
                                                                      getJsonField(
                                                                        subProductsItem,
                                                                        r'''$.image''',
                                                                      ).toString(),
                                                                      width: 50,
                                                                      height: 50,
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Column(
                                                                  mainAxisSize:
                                                                  MainAxisSize.max,
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Container(
                                                                      width: 181,
                                                                      decoration:
                                                                      BoxDecoration(),
                                                                      child: Text(
                                                                        getJsonField(
                                                                          subProductsItem,
                                                                          r'''$.name''',
                                                                        ).toString(),
                                                                        textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                        style: FlutterFlowTheme.of(
                                                                            context)
                                                                            .bodyMedium
                                                                            .override(
                                                                          fontFamily:
                                                                          'Montserrat',
                                                                          fontSize:
                                                                          10,
                                                                          letterSpacing:
                                                                          0,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );*/
                                                      }),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                          // Generated code for this Container Widget...


                    /* Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 65,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(color: FlutterFlowTheme.of(context).Bordercolor),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15), // Shadow color with opacity
                              offset: Offset(0, -4), // Move shadow upwards by 4 pixels
                              blurRadius: 6, // Blur radius for a softer shadow
                              spreadRadius: 1, // Spread radius for shadow expansion
                            ),
                          ],
                          color: FlutterFlowTheme.of(context).secondaryBackground
                      ),
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                          child: FutureBuilder<ApiCallResponse>(
                            future: MobileMenuCategoriesCall.call(
                              sanityurl: FFAppConstants.sanityurl,
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
                              final choiceChipsMobileMenuCategoriesResponse = snapshot.data!;
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: FlutterFlowChoiceChips(
                                  options: MobileMenuCategoriesCall.menuItems(
                                    choiceChipsMobileMenuCategoriesResponse.jsonBody,
                                  )!
                                      .map((label) => ChipData(label))
                                      .toList(),
                                  onChanged: (val) async {
                                    setState(() => _model.choiceChipsValue = val?.firstOrNull);
                                    _model.refername = valueOrDefault<String>(
                                      functions.mobilemenurefername(
                                          _model.choiceChipsValue,
                                          getJsonField(
                                            choiceChipsMobileMenuCategoriesResponse.jsonBody,
                                            r'''$''',
                                          )),
                                      'xxxxx',
                                    );
                                    setState(() {});
                                    print("isSelected : ${widget.isSelected}");
                                    if (widget.isSelected == true) {
                                      print("isSelected : ${widget.isSelected}");
                                      _model.selectedproduct = false;

                                      print("isSelected : ${widget.isSelected}");
                                    } else {
                                      _model.selectedproduct = true;
                                    }

                                    setState(() {});
                                  },
                                  selectedChipStyle: ChipStyle(
                                    backgroundColor:
                                    FlutterFlowTheme.of(context).secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context).primary,
                                      fontSize: 16,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    iconColor: FlutterFlowTheme.of(context).primaryText,
                                    iconSize: 18,
                                    elevation: 0,
                                    borderColor: FlutterFlowTheme.of(context).primary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  unselectedChipStyle: ChipStyle(
                                    backgroundColor:
                                    FlutterFlowTheme.of(context).secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      fontSize: 16,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    iconColor: FlutterFlowTheme.of(context).secondaryText,
                                    iconSize: 0,
                                    elevation: 0,
                                    borderColor: FlutterFlowTheme.of(context).Bordercolor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  chipSpacing: 12,
                                  rowSpacing: 12,
                                  multiselect: false,
                                  initialized: _model.choiceChipsValue != null,
                                  alignment: WrapAlignment.start,
                                  controller: _model.choiceChipsValueController ??=
                                      FormFieldController<List<String>>(
                                        [widget.defaultcategories],
                                      ),
                                  wrapped: false,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )*/

                    /*Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 65,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: FlutterFlowTheme.of(context).Bordercolor),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15), // Shadow color with opacity
                            offset: Offset(0, -4), // Move shadow upwards by 4 pixels
                            blurRadius: 6, // Blur radius for a softer shadow
                            spreadRadius: 1, // Spread radius for shadow expansion
                          ),
                        ],
                        color: FlutterFlowTheme.of(context).secondaryBackground
                      ),
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                          child: FutureBuilder<ApiCallResponse>(
                            future: MobileMenuCategoriesCall.call(
                              sanityurl: FFAppConstants.sanityurl,
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
                              final choiceChipsMobileMenuCategoriesResponse = snapshot.data!;
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: FlutterFlowChoiceChips(
                                  options: MobileMenuCategoriesCall.menuItems(
                                    choiceChipsMobileMenuCategoriesResponse.jsonBody,
                                  )!
                                      .map((label) => ChipData(label))
                                      .toList(),
                                  onChanged: (val) async {
                                    setState(() => _model.choiceChipsValue = val?.firstOrNull);
                                    _model.refername = valueOrDefault<String>(
                                      functions.mobilemenurefername(
                                          _model.choiceChipsValue,
                                          getJsonField(
                                            choiceChipsMobileMenuCategoriesResponse.jsonBody,
                                            r'''$''',
                                          )),
                                      'xxxxx',
                                    );
                                    setState(() {});
                                    print("isSelected : ${widget.isSelected}");
                                    if (widget.isSelected == true) {
                                      print("isSelected : ${widget.isSelected}");
                                      _model.selectedproduct = false;

                                      print("isSelected : ${widget.isSelected}");
                                    } else {
                                      _model.selectedproduct = true;
                                    }

                                    setState(() {});
                                  },
                                  selectedChipStyle: ChipStyle(
                                    backgroundColor:
                                    FlutterFlowTheme.of(context).secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context).primary,
                                      fontSize: 16,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    iconColor: FlutterFlowTheme.of(context).primaryText,
                                    iconSize: 18,
                                    elevation: 0,
                                    borderColor: FlutterFlowTheme.of(context).primary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  unselectedChipStyle: ChipStyle(
                                    backgroundColor:
                                    FlutterFlowTheme.of(context).secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      fontSize: 16,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    iconColor: FlutterFlowTheme.of(context).secondaryText,
                                    iconSize: 0,
                                    elevation: 0,
                                    borderColor: FlutterFlowTheme.of(context).Bordercolor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  chipSpacing: 12,
                                  rowSpacing: 12,
                                  multiselect: false,
                                  initialized: _model.choiceChipsValue != null,
                                  alignment: WrapAlignment.start,
                                  controller: _model.choiceChipsValueController ??=
                                      FormFieldController<List<String>>(
                                        [widget.defaultcategories],
                                      ),
                                  wrapped: false,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )*/

                  ],
                ),
              ),
            ),
            /*Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: 65,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: FlutterFlowTheme.of(context).Bordercolor),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15), // Shadow color with opacity
                        offset: Offset(0, -4), // Move shadow upwards by 4 pixels
                        blurRadius: 6, // Blur radius for a softer shadow
                        spreadRadius: 1, // Spread radius for shadow expansion
                      ),
                    ],
                    color: FlutterFlowTheme.of(context).secondaryBackground
                ),
                child: Container(
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                    child: FutureBuilder<ApiCallResponse>(
                      future: MobileMenuCategoriesCall.call(
                        sanityurl: FFAppConstants.sanityurl,
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
                        final choiceChipsMobileMenuCategoriesResponse = snapshot.data!;
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: FlutterFlowChoiceChips(
                            options: MobileMenuCategoriesCall.menuItems(
                              choiceChipsMobileMenuCategoriesResponse.jsonBody,
                            )!
                                .map((label) => ChipData(label))
                                .toList(),
                            onChanged: (val) async {
                              setState(() => _model.choiceChipsValue = val?.firstOrNull);
                              _model.refername = valueOrDefault<String>(
                                functions.mobilemenurefername(
                                    _model.choiceChipsValue,
                                    getJsonField(
                                      choiceChipsMobileMenuCategoriesResponse.jsonBody,
                                      r'''$''',
                                    )),
                                'xxxxx',
                              );
                              setState(() {});
                              print("isSelected : ${widget.isSelected}");
                              if (widget.isSelected == true) {
                                print("isSelected : ${widget.isSelected}");
                                _model.selectedproduct = false;

                                print("isSelected : ${widget.isSelected}");
                              } else {
                                _model.selectedproduct = true;
                              }

                              setState(() {});
                            },
                            selectedChipStyle: ChipStyle(
                              backgroundColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                              textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                color: FlutterFlowTheme.of(context).primary,
                                fontSize: 16,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,
                              ),
                              iconColor: FlutterFlowTheme.of(context).primaryText,
                              iconSize: 18,
                              elevation: 0,
                              borderColor: FlutterFlowTheme.of(context).primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            unselectedChipStyle: ChipStyle(
                              backgroundColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                              textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 16,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,
                              ),
                              iconColor: FlutterFlowTheme.of(context).secondaryText,
                              iconSize: 0,
                              elevation: 0,
                              borderColor: FlutterFlowTheme.of(context).Bordercolor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            chipSpacing: 12,
                            rowSpacing: 12,
                            multiselect: false,
                            initialized: _model.choiceChipsValue != null,
                            alignment: WrapAlignment.start,
                            controller: _model.choiceChipsValueController ??=
                                FormFieldController<List<String>>(
                                  [widget.defaultcategories],
                                ),
                            wrapped: false,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            )*/
          ],
        ),
        /*bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,  // Ensures the Column only takes as much space as needed
          children: [
            // Your Positioned widget converted into a normal Container
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 65,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: FlutterFlowTheme.of(context).Bordercolor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    offset: Offset(0, -4),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                child: FutureBuilder<ApiCallResponse>(
                  future: MobileMenuCategoriesCall.call(
                    sanityurl: FFAppConstants.sanityurl,
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
                    final choiceChipsMobileMenuCategoriesResponse = snapshot.data!;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FlutterFlowChoiceChips(
                        options: MobileMenuCategoriesCall.menuItems(
                          choiceChipsMobileMenuCategoriesResponse.jsonBody,
                        )!.map((label) => ChipData(label)).toList(),
                        onChanged: (val) async {
                          setState(() => _model.choiceChipsValue = val?.firstOrNull);
                          _model.refername = valueOrDefault<String>(
                            functions.mobilemenurefername(
                                _model.choiceChipsValue,
                                getJsonField(
                                  choiceChipsMobileMenuCategoriesResponse.jsonBody,
                                  r'''$''',)),
                            'xxxxx',
                          );
                          setState(() {});
                          print("isSelected : ${widget.isSelected}");
                          if (widget.isSelected == true) {
                            print("isSelected : ${widget.isSelected}");
                            _model.selectedproduct = false;

                            print("isSelected : ${widget.isSelected}");
                          } else {
                            _model.selectedproduct = true;
                          }

                          setState(() {});
                        },
                        selectedChipStyle: ChipStyle(
                          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).primary,
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                          ),
                          iconColor: FlutterFlowTheme.of(context).primaryText,
                          iconSize: 18,
                          elevation: 0,
                          borderColor: FlutterFlowTheme.of(context).primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        unselectedChipStyle: ChipStyle(
                          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                          ),
                          iconColor: FlutterFlowTheme.of(context).secondaryText,
                          iconSize: 0,
                          elevation: 0,
                          borderColor: FlutterFlowTheme.of(context).Bordercolor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        chipSpacing: 12,
                        rowSpacing: 12,
                        multiselect: false,
                        initialized: _model.choiceChipsValue != null,
                        alignment: WrapAlignment.start,
                        controller: _model.choiceChipsValueController ??=
                            FormFieldController<List<String>>(
                              [widget.defaultcategories],
                            ),
                        wrapped: false,
                      ),
                    );
                  },
                ),
              ),
            ),
            CustomNavBarWidget(),
          ],
        ),*/
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 65,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: FlutterFlowTheme.of(context).Bordercolor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      offset: Offset(0, -4),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                  color: FlutterFlowTheme.of(context).secondaryBackground
              ),
              child: Container(
                decoration: BoxDecoration(),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                  child: FutureBuilder<ApiCallResponse>(
                    future: MobileMenuCategoriesCall.call(
                      sanityurl: FFAppConstants.sanityurl,
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
                      final choiceChipsMobileMenuCategoriesResponse = snapshot.data!;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: FlutterFlowChoiceChips(
                          options: MobileMenuCategoriesCall.menuItems(
                            choiceChipsMobileMenuCategoriesResponse.jsonBody,
                          )!
                              .map((label) => ChipData(label))
                              .toList(),
                          onChanged: (val) async {
                            setState(() => _model.choiceChipsValue = val?.firstOrNull);
                            _model.refername = valueOrDefault<String>(
                              functions.mobilemenurefername(
                                  _model.choiceChipsValue,
                                  getJsonField(
                                    choiceChipsMobileMenuCategoriesResponse.jsonBody,
                                    r'''$''',
                                  )),
                              'xxxxx',
                            );
                            setState(() {});
                            print("isSelected : ${widget.isSelected}");
                            if (widget.isSelected == true) {
                              print("isSelected : ${widget.isSelected}");
                              _model.selectedproduct = false;

                              print("isSelected : ${widget.isSelected}");
                            } else {
                              _model.selectedproduct = true;
                            }

                            setState(() {});
                          },
                          selectedChipStyle: ChipStyle(
                            backgroundColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                            textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).primary,
                              fontSize: 16,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500,
                            ),
                            iconColor: FlutterFlowTheme.of(context).primaryText,
                            iconSize: 18,
                            elevation: 0,
                            borderColor: FlutterFlowTheme.of(context).primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          unselectedChipStyle: ChipStyle(
                            backgroundColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                            textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 16,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500,
                            ),
                            iconColor: FlutterFlowTheme.of(context).secondaryText,
                            iconSize: 0,
                            elevation: 0,
                            borderColor: FlutterFlowTheme.of(context).Bordercolor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          chipSpacing: 12,
                          rowSpacing: 12,
                          multiselect: false,
                          initialized: _model.choiceChipsValue != null,
                          alignment: WrapAlignment.start,
                          controller: _model.choiceChipsValueController ??=
                              FormFieldController<List<String>>(
                                [widget.defaultcategories],
                              ),
                          wrapped: false,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            CustomNavBarWidget(),
          ],
        ),
      ),
    );
  }
}
