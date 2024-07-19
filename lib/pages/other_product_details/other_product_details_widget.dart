import 'package:cached_network_image/cached_network_image.dart';

import '../../auth/custom_auth/auth_util.dart';
import '../../components/shimmer_widget.dart';
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
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'other_product_details_model.dart';
export 'other_product_details_model.dart';

class OtherProductDetailsWidget extends StatefulWidget {
  const OtherProductDetailsWidget({
    super.key,
    this.productSlugValue,
  });

  final String? productSlugValue;

  @override
  State<OtherProductDetailsWidget> createState() =>
      _OtherProductDetailsWidgetState();
}

class _OtherProductDetailsWidgetState extends State<OtherProductDetailsWidget> {
  late OtherProductDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OtherProductDetailsModel());

    _model.expandableExpandableController1 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController2 =
        ExpandableController(initialExpanded: false);
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 4),
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
                      InkWell(
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
                      ),
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
                  final containerOtherProductsDetailsResponse = snapshot.data!;
                  return Container(
                    height: MediaQuery.sizeOf(context).height * 0.88,
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
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
                                          /*  context.pushNamed(
                                            'ProductImage',
                                            queryParameters: {
                                              'productimage': serializeParam(
                                                getJsonField(
                                                  containerOtherProductsDetailsResponse
                                                      .jsonBody,
                                                  r'''$.data.image_url[:].path''',
                                                ).toString(),
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.fade,
                                                duration:
                                                    Duration(milliseconds: 0),
                                              ),
                                            },
                                          );*/
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                                Duration(milliseconds: 100),
                                            fadeOutDuration:
                                                Duration(milliseconds: 100),
                                            imageUrl: valueOrDefault<String>(
                                              OtherProductsDetailsCall
                                                              .otherproductvariantdata(
                                                            containerOtherProductsDetailsResponse
                                                                .jsonBody,
                                                          ) !=
                                                          null &&
                                                      (OtherProductsDetailsCall
                                                              .otherproductvariantdata(
                                                        containerOtherProductsDetailsResponse
                                                            .jsonBody,
                                                      ))!
                                                          .isNotEmpty
                                                  ? (OtherProductsDetailsCall
                                                      .productvariantdataimageurlpath(
                                                      containerOtherProductsDetailsResponse
                                                          .jsonBody,
                                                    )?[_model
                                                      .selectedVariatoinindex!])
                                                  : OtherProductsDetailsCall
                                                      .otherproductimageurlpath(
                                                      containerOtherProductsDetailsResponse
                                                          .jsonBody,
                                                    )?.first,
                                              'xxxx',
                                            ),
                                            width: double.infinity,
                                            height: 288,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.99, 1),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 22),
                                          child: FutureBuilder<ApiCallResponse>(
                                              future: WishListCall.call(
                                                hosturl:
                                                    FFAppConstants.sanityurl,
                                                token: currentAuthenticationToken
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
                                                final containerWishlistResponse =
                                                    snapshot.data!;

                                                return Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24),
                                                  ),
                                                  child: Builder(
                                                    builder: (context) {
                                                      print(WishListCall.id(
                                                          containerWishlistResponse
                                                              .jsonBody));
                                                      print(OtherProductsDetailsCall
                                                          .rudrakshaProductid(
                                                              containerOtherProductsDetailsResponse
                                                                  .jsonBody));
                                                      if (!WishListCall.id(
                                                        containerWishlistResponse
                                                            .jsonBody,
                                                      )!
                                                          .contains(
                                                              OtherProductsDetailsCall
                                                                  .productid(
                                                        containerOtherProductsDetailsResponse
                                                            .jsonBody,
                                                      ))) {
                                                        return

                                                            // Generated code for this CircleImage Widget...
                                                            Padding(
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
                                                              _model.addtoWishlist =
                                                                  await AddToWishlistCall
                                                                      .call(
                                                                hosturl:
                                                                    FFAppConstants
                                                                        .sanityurl,
                                                                token:
                                                                    currentAuthenticationToken,
                                                                productid:
                                                                    OtherProductsDetailsCall
                                                                        .productid(
                                                                  containerOtherProductsDetailsResponse
                                                                      .jsonBody,
                                                                ),
                                                                productType:
                                                                    OtherProductsDetailsCall
                                                                        .productMainType(
                                                                  containerOtherProductsDetailsResponse
                                                                      .jsonBody,
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
                                                              }
                                                              setState(() {});
                                                              _model.wishlistlikedislike =
                                                                  !_model
                                                                      .wishlistlikedislike;
                                                              setState(() {});
                                                              HapticFeedback
                                                                  .lightImpact();
                                                            },
                                                            child: Container(
                                                              width: 28,
                                                              height: 28,
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
                                                                    OtherProductsDetailsCall
                                                                        .productid(
                                                                  containerOtherProductsDetailsResponse
                                                                      .jsonBody,
                                                                ),
                                                                productType:
                                                                    OtherProductsDetailsCall
                                                                        .productMainType(
                                                                  containerOtherProductsDetailsResponse
                                                                      .jsonBody,
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
                                                              setState(() {});
                                                              _model.wishlistlikedislike =
                                                                  !_model
                                                                      .wishlistlikedislike;
                                                              setState(() {});
                                                              HapticFeedback
                                                                  .lightImpact();
                                                            },
                                                            child: Container(
                                                              width: 28,
                                                              height: 28,
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
                                                );
                                              }),
                                        ),
                                      ),
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
                                            .jsonBody,
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
                                          text: 'Product Code : ',
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
                                                  .jsonBody,
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
                                      Padding(
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
                                                .jsonBody,
                                          )!,
                                          unratedColor:
                                              FlutterFlowTheme.of(context)
                                                  .accent3,
                                          itemCount: 5,
                                          itemSize: 18,
                                        ),
                                      ),
                                      Text(
                                        OtherProductsDetailsCall.productcount(
                                          containerOtherProductsDetailsResponse
                                              .jsonBody,
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
                            if (OtherProductsDetailsCall
                                        .otherproductvariantdata(
                                      containerOtherProductsDetailsResponse
                                          .jsonBody,
                                    ) !=
                                    null &&
                                (OtherProductsDetailsCall
                                        .otherproductvariantdata(
                                  containerOtherProductsDetailsResponse
                                      .jsonBody,
                                ))!
                                    .isNotEmpty)
                              Divider(
                                height: 5,
                                thickness: 3,
                                color: Color(0xFFE7E7E8),
                              ),
                            if (OtherProductsDetailsCall
                                        .otherproductvariantdata(
                                      containerOtherProductsDetailsResponse
                                          .jsonBody,
                                    ) !=
                                    null &&
                                (OtherProductsDetailsCall
                                        .otherproductvariantdata(
                                  containerOtherProductsDetailsResponse
                                      .jsonBody,
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
                                            text: 'Select Variation : ',
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
                                              _model.selectedvariation,
                                              'Variation',
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
                                                    .otherproductvariantdata(
                                                  containerOtherProductsDetailsResponse
                                                      .jsonBody,
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
                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.selecteddesign =
                                                      !_model.selecteddesign;
                                                  setState(() {});
                                                  if (_model.selecteddesign ==
                                                      true) {
                                                    _model
                                                        .updateSelectedDesingAtIndex(
                                                      0,
                                                      (_) =>
                                                          selectVariationIndex,
                                                    );
                                                    setState(() {});
                                                  } else {
                                                    _model
                                                        .updateSelectedDesingAtIndex(
                                                      0,
                                                      (_) =>
                                                          selectVariationIndex,
                                                    );
                                                    setState(() {});
                                                  }

                                                  _model.selectedvariation =
                                                      getJsonField(
                                                    selectVariationItem,
                                                    r'''$.variant_name''',
                                                  ).toString();
                                                  _model.selectedVariatoinindex =
                                                      selectVariationIndex;
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  width: 224,
                                                  height: 44,
                                                  decoration: BoxDecoration(
                                                    color: _model.selectedDesing
                                                            .contains(
                                                                selectVariationIndex)
                                                        ? Color(0x26740074)
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                      color: _model
                                                              .selectedDesing
                                                              .contains(
                                                                  selectVariationIndex)
                                                          ? Color(0xFF740074)
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryBackground,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 15, right: 15),
                                                    child: Center(
                                                      child: AutoSizeText(
                                                        getJsonField(
                                                          selectVariationItem,
                                                          r'''$.variant_name''',
                                                        ).toString(),
                                                        maxLines: 2,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: 13,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                                                    .jsonBody,
                                              ) !=
                                              null &&
                                          (OtherProductsDetailsCall
                                                  .otherproductvariantdata(
                                            containerOtherProductsDetailsResponse
                                                .jsonBody,
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
                                                  text: 'INR ',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 18,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                                TextSpan(
                                                  text: formatNumber(
                                                    valueOrDefault<int>(
                                                          OtherProductsDetailsCall
                                                              .productvariantdatasellingprice(
                                                            containerOtherProductsDetailsResponse
                                                                .jsonBody,
                                                          )?[_model
                                                              .selectedVariatoinindex!],
                                                          00000,
                                                        ) *
                                                        (_model
                                                            .countControllerValue!),
                                                    formatType:
                                                        FormatType.decimal,
                                                    decimalType: DecimalType
                                                        .periodDecimal,
                                                  ),
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
                                                  text: 'INR ',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 18,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                                TextSpan(
                                                  text: ((functions.stringtoIntFunction(
                                                              OtherProductsDetailsCall
                                                                  .otherProductsellingprice(
                                                            containerOtherProductsDetailsResponse
                                                                .jsonBody,
                                                          ))!) *
                                                          (_model
                                                              .countControllerValue!))
                                                      .toString(),
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
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
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
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
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
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
                                          /*    energization:
                                          OtherProductsDetailsCall
                                              .pujaenergizationlistid(
                                            containerOtherProductsDetailsResponse
                                                .jsonBody,
                                          )?[_model.selectedEnergizationIndex!];
                                          certification:
                                          (OtherProductsDetailsCall
                                                  .certificationlistid(
                                            containerOtherProductsDetailsResponse
                                                .jsonBody,
                                          )?[_model
                                                  .selectedCertificationindex!])
                                              ?.toString();
                                          design:
                                          _model.selecteddesignid;*/
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
                            Divider(
                              height: 4,
                              thickness: 2,
                              color: Color(0xFFE7E7E8),
                            ),
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
                                          style: FlutterFlowTheme.of(context)
                                              .displaySmall
                                              .override(
                                                fontFamily: 'Outfit',
                                                color: Colors.black,
                                                fontSize: 16,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                      ),
                                      collapsed: Container(),
                                      expanded: Html(
                                        data: valueOrDefault<String>(
                                          OtherProductsDetailsCall
                                                          .otherproductvariantdata(
                                                        containerOtherProductsDetailsResponse
                                                            .jsonBody,
                                                      ) !=
                                                      null &&
                                                  (OtherProductsDetailsCall
                                                          .otherproductvariantdata(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
                                                  ))!
                                                      .isNotEmpty
                                              ? valueOrDefault<String>(
                                                  OtherProductsDetailsCall
                                                      .productvariantdatadescription(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
                                                  )?[_model
                                                      .selectedVariatoinindex!],
                                                  '0',
                                                )
                                              : OtherProductsDetailsCall
                                                  .otherProductlongDescription(
                                                  containerOtherProductsDetailsResponse
                                                      .jsonBody,
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
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              child: Container(
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
                                      header: Text(
                                        'Ratings & Reviews',
                                        style: FlutterFlowTheme.of(context)
                                            .displaySmall
                                            .override(
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
                                                  Padding(
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
                                                            text:
                                                                valueOrDefault<
                                                                    String>(
                                                              OtherProductsDetailsCall
                                                                  .productrating(
                                                                containerOtherProductsDetailsResponse
                                                                    .jsonBody,
                                                              )?.toString(),
                                                              '0.0',
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
                                                          TextSpan(
                                                            text: '/',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 24,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: '5',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 24,
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
                                                              text:
                                                                  valueOrDefault<
                                                                      String>(
                                                                OtherProductsDetailsCall
                                                                    .productcount(
                                                                  containerOtherProductsDetailsResponse
                                                                      .jsonBody,
                                                                ).toString(),
                                                                '0.0',
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
                                                  ),
                                                ],
                                              ),
                                              FFButtonWidget(
                                                onPressed: () {
                                                  print('Button pressed ...');
                                                },
                                                text: 'Rate',
                                                options: FFButtonOptions(
                                                  height: 40,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(24, 0, 24, 0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0, 0, 0, 0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            Color(0xFF740074),
                                                        fontSize: 12,
                                                        letterSpacing: 0,
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
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RatingBarIndicator(
                                                itemBuilder: (context, index) =>
                                                    Icon(
                                                  Icons.star_rounded,
                                                  color: Color(0xFFF59E0B),
                                                ),
                                                direction: Axis.horizontal,
                                                rating: OtherProductsDetailsCall
                                                    .productrating(
                                                  containerOtherProductsDetailsResponse
                                                      .jsonBody,
                                                )!,
                                                unratedColor: Color(0x69F59E0B),
                                                itemCount: 5,
                                                itemSize: 20,
                                              ),
                                              Text(
                                                'Truly impressed!',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontSize: 16,
                                                          letterSpacing: 0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                              ),
                                              Text(
                                                'I was amazed at how accurately he could describe my personality, current situation of my life and problem areas just by analyzing my birth chart.',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF696969),
                                                      fontSize: 16,
                                                      letterSpacing: 0,
                                                    ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
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
                                              ),
                                              Text(
                                                'David Johnson, 1st Jan 2023',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF696969),
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
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
                                                        TextSpan(
                                                          text: '6,461',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: ' Reviews',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
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
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ),
                                                  FlutterFlowIconButton(
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
                                                  ),
                                                ],
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 16, 0, 0),
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
                                                    .otherProductsimilarcategoryproduct(
                                                  containerOtherProductsDetailsResponse
                                                      .jsonBody,
                                                )?.toList() ??
                                                [];
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
                                                child: Container(
                                                  width: 148,
                                                  height: 220,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
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
                                                                .circular(10),
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
                                                            r'''$.thumbnail''',
                                                          ).toString(),
                                                          width: 152,
                                                          height: 104,
                                                          fit: BoxFit.fitWidth,
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
                                                            r'''$.name''',
                                                          ).toString(),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Color(
                                                                    0xFF696969),
                                                                fontSize: 14,
                                                                letterSpacing:
                                                                    0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                lineHeight: 1.5,
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
                                                              style: FlutterFlowTheme
                                                                      .of(context)
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
                                                            TextSpan(
                                                              text:
                                                                  getJsonField(
                                                                relatedProductItem,
                                                                r'''$.selling_price''',
                                                              ).toString(),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14,
                                                              ),
                                                            )
                                                          ],
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
                                                                        .w600,
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
                                                                TextSpan(
                                                                  text:
                                                                      ' (412)',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
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
                                                                  ),
                                                            ),
                                                          ),
                                                        ].divide(
                                                            SizedBox(width: 5)),
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
        ),
      ),
    );
  }
}
