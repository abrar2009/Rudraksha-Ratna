import 'package:cached_network_image/cached_network_image.dart';

import '../../auth/custom_auth/auth_util.dart';
import '../../components/shimmer_widget.dart';
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
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'diamond_product_details_model.dart';
export 'diamond_product_details_model.dart';

class DiamondProductDetailsWidget extends StatefulWidget {
  const DiamondProductDetailsWidget({
    super.key,
    String? productSlugValue,
    this.producttype,
  }) : this.productSlugValue =
            productSlugValue ?? 'buy/1-mukhi-from-java-indonesia-large-xviii';

  final String productSlugValue;
  final String? producttype;

  @override
  State<DiamondProductDetailsWidget> createState() =>
      _DiamondProductDetailsWidgetState();
}

class _DiamondProductDetailsWidgetState
    extends State<DiamondProductDetailsWidget> {
  late DiamondProductDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

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
                  final containerOtherProductsDetailsResponse = snapshot.data!;
                  return Container(
                    height: MediaQuery.sizeOf(context).height * 0.885,
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
                                      // Generated code for this Image Widget...
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
                                            imageUrl: widget.producttype ==
                                                    FFAppConstants
                                                        .YantraMasterProductDetailsApi
                                                ? OtherProductsDetailsCall
                                                        .otherproductimageurlpath(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
                                                  )!
                                                    .first
                                                : getJsonField(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
                                                    r'''$.data.image_url[0].path''',
                                                  ).toString(),
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
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            child: Builder(
                                              builder: (context) {
                                                if (_model
                                                    .wishlistlikedislike) {
                                                  return
                                                      // Generated code for this CircleImage Widget...
                                                      Padding(
                                                    padding: EdgeInsets.all(5),
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
                                                                  .rudrakshaProductid(
                                                            containerOtherProductsDetailsResponse
                                                                .jsonBody,
                                                          ),
                                                          productType:
                                                              OtherProductsDetailsCall
                                                                  .rudrakshaMainProductType(
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
                                                              content: Text(
                                                               "Product added in wishlist",
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .containerFillColor,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                            ),
                                                          );
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                getJsonField(
                                                                  (_model.addtoWishlist
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                  r'''$.status''',
                                                                ).toString(),
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .containerFillColor,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
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
                                                    ),
                                                  );
                                                } else {
                                                  return Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: InkWell(
                                                      onTap: () async
                                                      {
                                                        var _shouldSetState = false;
                                                        _model.apiResult5ep = await RemovefromWishlistCall.call(
                                                          token: currentAuthenticationToken,
                                                          hosturl: FFAppConstants.hosturl,
                                                          productId:
                                                          OtherProductsDetailsCall
                                                              .rudrakshaProductid(
                                                            containerOtherProductsDetailsResponse
                                                                .jsonBody,
                                                          ),
                                                          productType:
                                                          OtherProductsDetailsCall
                                                              .rudrakshaMainProductType(
                                                            containerOtherProductsDetailsResponse
                                                                .jsonBody,
                                                          ),
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
                                                                style:
                                                                TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                      context)
                                                                      .containerFillColor,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                  4000),
                                                              backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                  context)
                                                                  .primary,
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
                                          ),
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
                                      OtherProductsDetailsCall.productname(
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
                                                .productcode(
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
                            Divider(
                              height: 5,
                              thickness: 3,
                              color: Color(0xFFE7E7E8),
                            ),
                            if (OtherProductsDetailsCall.pujaenergizationlist(
                                      containerOtherProductsDetailsResponse
                                          .jsonBody,
                                    ) !=
                                    null &&
                                (OtherProductsDetailsCall.pujaenergizationlist(
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
                                        final selectVariation =
                                            OtherProductsDetailsCall
                                                    .pujaenergizationlist(
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
                                                      selectVariationItem,
                                                      r'''$.price''',
                                                    );
                                                    setState(() {});
                                                    if (_model.selecteddesign ==
                                                        true) {
                                                      _model.selectedEnergizationlist =
                                                          selectVariationIndex;
                                                      setState(() {});
                                                    } else {
                                                      _model.selectedEnergizationlist =
                                                          selectVariationIndex;
                                                      setState(() {});
                                                    }

                                                    _model.selectedEnergization =
                                                        getJsonField(
                                                      selectVariationItem,
                                                      r'''$.name''',
                                                    ).toString();
                                                    _model.selectedEnergizationIndex =
                                                        selectVariationIndex;
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    width: 224,
                                                    height: 44,
                                                    decoration: BoxDecoration(
                                                      color: _model
                                                                  .selectedEnergizationlist ==
                                                              selectVariationIndex
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
                                                                selectVariationIndex
                                                            ? Color(0xFF740074)
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(5),
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
                            if (OtherProductsDetailsCall.pujaenergizationlist(
                                      containerOtherProductsDetailsResponse
                                          .jsonBody,
                                    ) !=
                                    null &&
                                (OtherProductsDetailsCall.pujaenergizationlist(
                                  containerOtherProductsDetailsResponse
                                      .jsonBody,
                                ))!
                                    .isNotEmpty)
                              Divider(
                                height: 5,
                                thickness: 3,
                                color: Color(0xFFE7E7E8),
                              ),
                            if (OtherProductsDetailsCall.certificationlist(
                                      containerOtherProductsDetailsResponse
                                          .jsonBody,
                                    ) !=
                                    null &&
                                (OtherProductsDetailsCall.certificationlist(
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
                                            text: 'Certificat : ',
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
                                              _model.selectedCertification,
                                              'xxxx',
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
                                                    _model.selectedcertificateprice =
                                                        getJsonField(
                                                      selectVariationItem,
                                                      r'''$.price''',
                                                    );
                                                    setState(() {});
                                                    if (_model.selecteddesign ==
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
                                                    width: 224,
                                                    height: 44,
                                                    decoration: BoxDecoration(
                                                      color: _model
                                                                  .selectedCertificationindex ==
                                                              selectVariationIndex
                                                          ? Color(0x26740074)
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                        color: _model
                                                                    .selectedCertificationindex ==
                                                                selectVariationIndex
                                                            ? Color(0xFF740074)
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(5),
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
                            if (OtherProductsDetailsCall.certificationlist(
                                      containerOtherProductsDetailsResponse
                                          .jsonBody,
                                    ) !=
                                    null &&
                                (OtherProductsDetailsCall.certificationlist(
                                  containerOtherProductsDetailsResponse
                                      .jsonBody,
                                ))!
                                    .isNotEmpty)
                              Divider(
                                height: 5,
                                thickness: 3,
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
                                                              .jsonBody,
                                                        ) !=
                                                        null &&
                                                    (OtherProductsDetailsCall
                                                            .productRingData(
                                                      containerOtherProductsDetailsResponse
                                                          .jsonBody,
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
                                            _model.designprice = 0;
                                            setState(() {});
                                          },
                                          child: Builder(
                                            builder: (context) {
                                              if (!(OtherProductsDetailsCall
                                                          .productRingData(
                                                        containerOtherProductsDetailsResponse
                                                            .jsonBody,
                                                      ) !=
                                                      null &&
                                                  (OtherProductsDetailsCall
                                                          .productRingData(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
                                                  ))!
                                                      .isNotEmpty)) {
                                                return FlutterFlowChoiceChips(
                                                  options: [
                                                    ChipData('Loose Bead'),
                                                    ChipData('Pendent'),
                                                    ChipData('Bracelet')
                                                  ],
                                                  onChanged: (val) async {
                                                    setState(() => _model
                                                            .choiceChipsValue1 =
                                                        val?.firstOrNull);
                                                    _model.designprice = 0;
                                                    setState(() {});
                                                  },
                                                  selectedChipStyle: ChipStyle(
                                                    backgroundColor:
                                                        Color(0x1A740074),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
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
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                                  alignment: WrapAlignment
                                                      .spaceBetween,
                                                  controller: _model
                                                          .choiceChipsValueController1 ??=
                                                      FormFieldController<
                                                          List<String>>(
                                                    ['Pendent'],
                                                  ),
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
                                                          ChipData('Bracelet'),
                                                          ChipData('Ring')
                                                        ],
                                                        onChanged: (val) async {
                                                          setState(() => _model
                                                                  .choiceChipsValue2 =
                                                              val?.firstOrNull);
                                                          _model.designprice =
                                                              0;
                                                          setState(() {});
                                                        },
                                                        selectedChipStyle:
                                                            ChipStyle(
                                                          backgroundColor:
                                                              Color(0x1A740074),
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
                                                                            .w600,
                                                                  ),
                                                          iconColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                          iconSize: 18,
                                                          labelPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(10,
                                                                      5, 10, 5),
                                                          elevation: 0,
                                                          borderColor:
                                                              Color(0xFF740074),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
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
                                                                  .fromSTEB(10,
                                                                      5, 10, 5),
                                                          elevation: 0,
                                                          borderColor:
                                                              Color(0xFFE7E7E8),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        chipSpacing: 16,
                                                        rowSpacing: 12,
                                                        multiselect: false,
                                                        initialized: _model
                                                                .choiceChipsValue2 !=
                                                            null,
                                                        alignment: WrapAlignment
                                                            .spaceBetween,
                                                        controller: _model
                                                                .choiceChipsValueController2 ??=
                                                            FormFieldController<
                                                                List<String>>(
                                                          ['Pendent'],
                                                        ),
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
                            Divider(
                              height: 5,
                              thickness: 2,
                              color: Color(0xFFE7E7E8),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
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
                                            textScaler: MediaQuery.of(context)
                                                .textScaler,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Select Designs:',
                                                  style: FlutterFlowTheme.of(
                                                          context)
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
                                                  text: valueOrDefault<String>(
                                                    !(OtherProductsDetailsCall
                                                                    .productRingData(
                                                                  containerOtherProductsDetailsResponse
                                                                      .jsonBody,
                                                                ) !=
                                                                null &&
                                                            (OtherProductsDetailsCall
                                                                    .productRingData(
                                                              containerOtherProductsDetailsResponse
                                                                  .jsonBody,
                                                            ))!
                                                                .isNotEmpty)
                                                        ? _model
                                                            .choiceChipsValue1
                                                        : _model
                                                            .choiceChipsValue2,
                                                    'Design',
                                                  ),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                  ),
                                                )
                                              ],
                                              style:
                                                  FlutterFlowTheme.of(context)
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
                                                                  .jsonBody,
                                                            )?.toList() ??
                                                            [];
                                                    return SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: List.generate(
                                                            selectDesgn.length,
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
                                                            onTap: () async {
                                                              _model.selecteddesign =
                                                                  !_model
                                                                      .selecteddesign;
                                                              setState(() {});
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
                                                              setState(() {});
                                                            },
                                                            child: Container(
                                                              width: 114,
                                                              height: 222,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: _model
                                                                            .selectedpendentdesign ==
                                                                        selectDesgnIndex
                                                                    ? Color(
                                                                        0x26740074)
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border:
                                                                    Border.all(
                                                                  color: _model
                                                                              .selectedpendentdesign ==
                                                                          selectDesgnIndex
                                                                      ? Color(
                                                                          0xFF740074)
                                                                      : FlutterFlowTheme.of(
                                                                              context)
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
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            7,
                                                                            4,
                                                                            7,
                                                                            4),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      child: Image
                                                                          .network(
                                                                        getJsonField(
                                                                          selectDesgnItem,
                                                                          r'''$.image''',
                                                                        ).toString(),
                                                                        width:
                                                                            100,
                                                                        height:
                                                                            120,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
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
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
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
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            7),
                                                                    child:
                                                                        RichText(
                                                                      textScaler:
                                                                          MediaQuery.of(context)
                                                                              .textScaler,
                                                                      text:
                                                                          TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                'INR ',
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Montserrat',
                                                                                  fontSize: 14,
                                                                                  letterSpacing: 0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                ),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                getJsonField(
                                                                              selectDesgnItem,
                                                                              r'''$.price''',
                                                                            ).toString(),
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 14,
                                                                            ),
                                                                          )
                                                                        ],
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
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
                                                                ].divide(
                                                                    SizedBox(
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
                                                                  .jsonBody,
                                                            )?.toList() ??
                                                            [];
                                                    return SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
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
                                                            onTap: () async {
                                                              _model.selecteddesign =
                                                                  !_model
                                                                      .selecteddesign;
                                                              setState(() {});
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
                                                              setState(() {});
                                                            },
                                                            child: Container(
                                                              width: 114,
                                                              height: 222,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: _model
                                                                            .selectedbraceletdesign ==
                                                                        selectBraceletDesignIndex
                                                                    ? Color(
                                                                        0x26740074)
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border:
                                                                    Border.all(
                                                                  color: _model
                                                                              .selectedbraceletdesign ==
                                                                          selectBraceletDesignIndex
                                                                      ? Color(
                                                                          0xFF740074)
                                                                      : FlutterFlowTheme.of(
                                                                              context)
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
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            7,
                                                                            4,
                                                                            7,
                                                                            4),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      child: Image
                                                                          .network(
                                                                        getJsonField(
                                                                          selectBraceletDesignItem,
                                                                          r'''$.image''',
                                                                        ).toString(),
                                                                        width:
                                                                            100,
                                                                        height:
                                                                            120,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
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
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
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
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            7),
                                                                    child:
                                                                        RichText(
                                                                      textScaler:
                                                                          MediaQuery.of(context)
                                                                              .textScaler,
                                                                      text:
                                                                          TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                '+ INR ',
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Montserrat',
                                                                                  fontSize: 14,
                                                                                  letterSpacing: 0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                ),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                getJsonField(
                                                                              selectBraceletDesignItem,
                                                                              r'''$.price''',
                                                                            ).toString(),
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 14,
                                                                            ),
                                                                          )
                                                                        ],
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
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
                                                                ].divide(
                                                                    SizedBox(
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
                                                                  .jsonBody,
                                                            )?.toList() ??
                                                            [];
                                                    return SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: List.generate(
                                                            ringDesign.length,
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
                                                            onTap: () async {
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
                                                              setState(() {});
                                                            },
                                                            child: Container(
                                                              width: 114,
                                                              height: 222,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: _model
                                                                            .selectedringdesign ==
                                                                        ringDesignIndex
                                                                    ? Color(
                                                                        0x26740074)
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border:
                                                                    Border.all(
                                                                  color: _model
                                                                              .selectedringdesign ==
                                                                          ringDesignIndex
                                                                      ? Color(
                                                                          0xFF740074)
                                                                      : FlutterFlowTheme.of(
                                                                              context)
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
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            7,
                                                                            4,
                                                                            7,
                                                                            4),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      child: Image
                                                                          .network(
                                                                        getJsonField(
                                                                          ringDesignItem,
                                                                          r'''$.image''',
                                                                        ).toString(),
                                                                        width:
                                                                            100,
                                                                        height:
                                                                            120,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
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
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
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
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            7),
                                                                    child:
                                                                        RichText(
                                                                      textScaler:
                                                                          MediaQuery.of(context)
                                                                              .textScaler,
                                                                      text:
                                                                          TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                '+ INR ',
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Montserrat',
                                                                                  fontSize: 14,
                                                                                  letterSpacing: 0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                ),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                getJsonField(
                                                                              ringDesignItem,
                                                                              r'''$.price''',
                                                                            ).toString(),
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 14,
                                                                            ),
                                                                          )
                                                                        ],
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
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
                                                                ].divide(
                                                                    SizedBox(
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
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
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 10, 0),
                                    child: RichText(
                                      textScaler:
                                          MediaQuery.of(context).textScaler,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'INR ',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 18,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          TextSpan(
                                            text: formatNumber(
                                              (valueOrDefault<int>(
                                                        OtherProductsDetailsCall
                                                            .productsellingprice(
                                                          containerOtherProductsDetailsResponse
                                                              .jsonBody,
                                                        ),
                                                        00000,
                                                      ) +
                                                      (_model.designprice!) +
                                                      (_model
                                                          .energizationprice!) +
                                                      (_model
                                                          .selectedcertificateprice!)) *
                                                  (_model
                                                      .countControllerValue!),
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
                                        style: FlutterFlowTheme.of(context)
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
                                  // Generated code for this Button Widget...
                                  // Generated code for this Button Widget...
                                  // Generated code for this Button Widget...
                                  FFButtonWidget(
                                    onPressed: () async {
                                      if (currentAuthenticationToken != null &&
                                          currentAuthenticationToken != '') {
                                        if (widget.producttype ==
                                            FFAppConstants
                                                .RudrakshaMasterProductDetailsApi) {
                                          var _shouldSetState = false;
                                          _model.apiResultj7i =
                                              await AddToCartCall.call(
                                            hosturl: FFAppConstants.sanityurl,
                                            token: currentAuthenticationToken,
                                            productid: OtherProductsDetailsCall
                                                .rudrakshaProductid(
                                              containerOtherProductsDetailsResponse
                                                  .jsonBody,
                                            )?.toString(),
                                            productType:
                                                OtherProductsDetailsCall
                                                    .rudrakshaMainProductType(
                                              containerOtherProductsDetailsResponse
                                                  .jsonBody,
                                            )?.toString(),
                                            productvariation:
                                                OtherProductsDetailsCall
                                                    .productVariantStatus(
                                              containerOtherProductsDetailsResponse
                                                  .jsonBody,
                                            ),
                                            productvariationId: 2,
                                            quantity: _model
                                                .countControllerValue
                                                ?.toString(),
                                            energization:
                                                OtherProductsDetailsCall
                                                    .pujaenergizationlistid(
                                              containerOtherProductsDetailsResponse
                                                  .jsonBody,
                                            )?[_model
                                                    .selectedEnergizationIndex!],
                                            certification:
                                                (OtherProductsDetailsCall
                                                        .certificationlistid(
                                              containerOtherProductsDetailsResponse
                                                  .jsonBody,
                                            )?[_model.selectedCertificationindex!])
                                                    ?.toString(),
                                            design: _model.selecteddesignid,
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
                                            if( getJsonField(
                                              (_model.apiResultj7i?.jsonBody ?? ''), r'''$.status''',).toString() !="failed")
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
                                            if (_shouldSetState)
                                              setState(() {});
                                            return;
                                          }
                                          _model.productid =
                                              OtherProductsDetailsCall
                                                  .rudrakshaProductid(
                                            containerOtherProductsDetailsResponse
                                                .jsonBody,
                                          );
                                          _model.productmaintypee =
                                              OtherProductsDetailsCall
                                                  .rudrakshaMainProductType(
                                            containerOtherProductsDetailsResponse
                                                .jsonBody,
                                          );
                                          _model.productvarient =
                                              OtherProductsDetailsCall
                                                  .productVariantStatus(
                                            containerOtherProductsDetailsResponse
                                                .jsonBody,
                                          )!;
                                          setState(() {});
                                          if (_shouldSetState) setState(() {});
                                        } else {
                                          var _shouldSetState = false;
                                          _model.apiResultj7i =
                                              await AddToCartCall.call(
                                            hosturl: FFAppConstants.sanityurl,
                                            token: currentAuthenticationToken,
                                            productid: OtherProductsDetailsCall
                                                .rudrakshaProductid(
                                              containerOtherProductsDetailsResponse
                                                  .jsonBody,
                                            )?.toString(),
                                            productType:
                                                OtherProductsDetailsCall
                                                    .rudrakshaMainProductType(
                                              containerOtherProductsDetailsResponse
                                                  .jsonBody,
                                            )?.toString(),
                                            productvariation:
                                                OtherProductsDetailsCall
                                                    .productVariantStatus(
                                              containerOtherProductsDetailsResponse
                                                  .jsonBody,
                                            ),
                                            productvariationId: 2,
                                            quantity: _model
                                                .countControllerValue
                                                ?.toString(),
                                            energization:
                                                OtherProductsDetailsCall
                                                    .pujaenergizationlistid(
                                              containerOtherProductsDetailsResponse
                                                  .jsonBody,
                                            )?[_model
                                                    .selectedEnergizationIndex!],
                                            /*   certification:
                                              (OtherProductsDetailsCall
                                                      .certificationlistid(
                                            containerOtherProductsDetailsResponse
                                                .jsonBody,
                                          )?[_model.selectedCertificationindex!])
                                                  ?.toString(),*/
                                            design: _model.selecteddesignid,
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
                                            if (_shouldSetState)
                                              setState(() {});
                                            return;
                                          }
                                          _model.productid =
                                              OtherProductsDetailsCall
                                                  .rudrakshaProductid(
                                            containerOtherProductsDetailsResponse
                                                .jsonBody,
                                          );
                                          _model.productmaintypee =
                                              OtherProductsDetailsCall
                                                  .rudrakshaMainProductType(
                                            containerOtherProductsDetailsResponse
                                                .jsonBody,
                                          );
                                          _model.productvarient =
                                              OtherProductsDetailsCall
                                                  .productVariantStatus(
                                            containerOtherProductsDetailsResponse
                                                .jsonBody,
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
                                    onPressed: () {
                                      print('Button pressed ...');
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
                                        _model.expandableExpandableController2,
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
                                              .longdescription(
                                            containerOtherProductsDetailsResponse
                                                .jsonBody,
                                          ),
                                          'Description',
                                        ),
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
                                child:
                                    // Generated code for this Expandable Widget...
                                    Container(
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: ExpandableNotifier(
                                    controller:
                                        _model.expandableExpandableController3,
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
                                          if (OtherProductsDetailsCall
                                                      .reviewdata(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
                                                  ) !=
                                                  null &&
                                              (OtherProductsDetailsCall
                                                      .reviewdata(
                                                containerOtherProductsDetailsResponse
                                                    .jsonBody,
                                              ))!
                                                  .isNotEmpty)
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RatingBarIndicator(
                                                  itemBuilder:
                                                      (context, index) => Icon(
                                                    Icons.star_rounded,
                                                    color: Color(0xFFF59E0B),
                                                  ),
                                                  direction: Axis.horizontal,
                                                  rating:
                                                      OtherProductsDetailsCall
                                                          .productrating(
                                                    containerOtherProductsDetailsResponse
                                                        .jsonBody,
                                                  )!,
                                                  unratedColor:
                                                      Color(0x69F59E0B),
                                                  itemCount: 5,
                                                  itemSize: 20,
                                                ),
                                                Text(
                                                  'Truly impressed!',
                                                  style: FlutterFlowTheme.of(
                                                          context)
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
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            Color(0xFF696969),
                                                        fontSize: 16,
                                                        letterSpacing: 0,
                                                      ),
                                                ),
                                                Row(
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
                                                ),
                                                Text(
                                                  'David Johnson, 1st Jan 2023',
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
                                                Row(
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
                                                          TextSpan(
                                                            text: '6,461',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
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
                                                    .relatedproduct(
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

                                                    return;
                                                  }
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
                                                            r'''$.thumbnail_image''',
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
                                                            r'''$.product_name''',
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
