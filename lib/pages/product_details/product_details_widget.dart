import 'package:cached_network_image/cached_network_image.dart';
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

import 'product_details_model.dart';
export 'product_details_model.dart';

class ProductDetailsWidget extends StatefulWidget {
  const ProductDetailsWidget({
    super.key,
    this.productSlugValue,
  });

  final String? productSlugValue;

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  late ProductDetailsModel _model;

  final ProductDetailsWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProductDetailsModel());

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
        key: ProductDetailsWidgetscaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
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
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24,
                        ),
                        onPressed: () async {
                          context.safePop();
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Image.asset(
                          'assets/images/Buy.png',
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder<ApiCallResponse>(
                future: ProductDetailsCall.call(
                  sanityurl: FFAppConstants.sanityurl,
                  producttype: FFAppConstants.RudrakshaMasterProductDetailsApi,
                  rudrakshproductslugvalue: widget.productSlugValue,
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
                  final containerProductDetailsResponse = snapshot.data!;
                  //final containerOtherProductsDetailsResponse = snapshot.data!;
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
                                  color: FlutterFlowTheme.of(context).BorderAllcolor,
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
                                                  containerProductDetailsResponse.jsonBody,
                                                  r'''$.data.image_url[:].path''',
                                                ).toString(),
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey: TransitionInfo(
                                                hasTransition: true,
                                                transitionType: PageTransitionType.fade,
                                                duration: Duration(milliseconds: 0),
                                              ),
                                            },
                                          );*/
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: CachedNetworkImage(
                                            fadeInDuration: Duration(milliseconds: 500),
                                            fadeOutDuration: Duration(milliseconds: 500),
                                            imageUrl:

                                            getJsonField(
                                              containerProductDetailsResponse.jsonBody,
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
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              _model.wishlistlikedislike =
                                              !_model.wishlistlikedislike;
                                              setState(() {});
                                              HapticFeedback.lightImpact();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                                borderRadius:
                                                BorderRadius.circular(24),
                                              ),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                Colors.transparent,
                                                onTap: () async {
                                                  _model.wishlistlikedislike =
                                                  !_model
                                                      .wishlistlikedislike;
                                                  setState(() {});
                                                  HapticFeedback.lightImpact();
                                                },
                                                child: Builder(
                                                  builder: (context) {
                                                    if (_model
                                                        .wishlistlikedislike) {
                                                      return Padding(
                                                        padding:
                                                        EdgeInsets.all(5),
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
                                                      );
                                                    } else {
                                                      return Padding(
                                                        padding:
                                                        EdgeInsets.all(5),
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
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
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
                                      ProductDetailsCall.productname(
                                        containerProductDetailsResponse
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
                                            ProductDetailsCall.productcode(
                                              containerProductDetailsResponse
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
                                            color: FlutterFlowTheme.of(context).Ratingcolor,
                                          ),
                                          direction: Axis.horizontal,
                                          rating:
                                          ProductDetailsCall.productrating(
                                            containerProductDetailsResponse
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
                                        ProductDetailsCall.productcount(
                                          containerProductDetailsResponse
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
                              color: FlutterFlowTheme.of(context).BorderAllcolor,
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
                                            _model.choiceChipsValue,
                                            'Loose Bead',
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
                                        child: Builder(
                                          builder: (context) {
                                            if (!(OtherProductsDetailsCall
                                                .productRingData(
                                              containerProductDetailsResponse
                                                  .jsonBody,
                                            ) !=
                                                null &&
                                                (OtherProductsDetailsCall
                                                    .productRingData(
                                                  containerProductDetailsResponse
                                                      .jsonBody,
                                                ))!
                                                    .isNotEmpty)) {
                                              return FlutterFlowChoiceChips(
                                                options: [
                                                  ChipData('Loose Bead'),
                                                  ChipData('Pendent'),
                                                  ChipData('Bracelet')
                                                ],
                                                onChanged: (val) => setState(() =>
                                                _model.choiceChipsValue =
                                                    val?.firstOrNull),
                                                selectedChipStyle: ChipStyle(
                                                  backgroundColor: Color(0x1A740074),
                                                  textStyle: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .primaryText,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  iconColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                                  iconSize: 18,
                                                  labelPadding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                      10, 5, 10, 5),
                                                  elevation: 0,
                                                  borderColor: FlutterFlowTheme.of(context).primary,
                                                  borderRadius:
                                                  BorderRadius.circular(5),
                                                ),
                                                unselectedChipStyle: ChipStyle(
                                                  backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                                  textStyle: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .primaryText,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  iconColor: Color(0x00000000),
                                                  iconSize: 18,
                                                  labelPadding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                      10, 5, 10, 5),
                                                  elevation: 0,
                                                  borderColor: FlutterFlowTheme.of(context).primary,
                                                  borderRadius:
                                                  BorderRadius.circular(5),
                                                ),
                                                chipSpacing: 0,
                                                rowSpacing: 12,
                                                multiselect: false,
                                                initialized:
                                                _model.choiceChipsValue != null,
                                                alignment: WrapAlignment.spaceBetween,
                                                controller: _model
                                                    .choiceChipsValueController ??=
                                                    FormFieldController<List<String>>(
                                                      ['Pendent'],
                                                    ),
                                                wrapped: true,
                                              );
                                            } else {
                                              return FlutterFlowChoiceChips(
                                                options: [
                                                  ChipData('Loose Bead'),
                                                  ChipData('Pendent'),
                                                  ChipData('Bracelet'),
                                                  ChipData('Ring')
                                                ],
                                                onChanged: (val) => setState(
                                                        () => _model
                                                        .choiceChipsValue2 =
                                                        val?.firstOrNull),
                                                selectedChipStyle: ChipStyle(
                                                  backgroundColor:
                                                  Color(0x1A740074),
                                                  textStyle: FlutterFlowTheme
                                                      .of(context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Montserrat',
                                                    color:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .primaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                  ),
                                                  iconColor:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .primaryText,
                                                  iconSize: 18.0,
                                                  labelPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(10.0, 5.0,
                                                      10.0, 5.0),
                                                  elevation: 0.0,
                                                  borderColor:
                                                  Color(0xFF740074),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      5.0),
                                                ),
                                                unselectedChipStyle: ChipStyle(
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
                                                    color:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .primaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                  iconColor: Color(0x00000000),
                                                  iconSize: 18.0,
                                                  labelPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(10.0, 5.0,
                                                      10.0, 5.0),
                                                  elevation: 0.0,
                                                  borderColor:
                                                  Color(0xFFE7E7E8),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      5.0),
                                                ),
                                                chipSpacing: 0.0,
                                                rowSpacing: 12.0,
                                                multiselect: false,
                                                initialized:
                                                _model.choiceChipsValue2 !=
                                                    null,
                                                alignment:
                                                WrapAlignment.spaceBetween,
                                                controller: _model
                                                    .choiceChipsValueController2 ??=
                                                    FormFieldController<
                                                        List<String>>(
                                                      ['Pendent'],
                                                    ),
                                                wrapped: true,
                                              );
                                            }
                                          },
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
                              color: FlutterFlowTheme.of(context).BorderAllcolor,
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              child: Container(
                                decoration: BoxDecoration(),
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
                                                  text: ' In Thread',
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
                                              if (_model.choiceChipsValue == 'Pendent') {
                                                return Builder(
                                                  builder: (context) {
                                                    final selectDesgn = ProductDetailsCall.pendentgroup(
                                                      containerProductDetailsResponse.jsonBody,
                                                    )?.toList() ??
                                                        [];
                                                    return SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal,
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        children:
                                                        List.generate(selectDesgn.length, (selectDesgnIndex) {
                                                          final selectDesgnItem = selectDesgn[selectDesgnIndex];
                                                          return InkWell(
                                                            splashColor: Colors.transparent,
                                                            focusColor: Colors.transparent,
                                                            hoverColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () async {
                                                              _model.selecteddesign = !_model.selecteddesign;
                                                              setState(() {});
                                                              if (_model.selecteddesign == true) {
                                                                _model.updateSelectedDesingAtIndex(
                                                                  0,
                                                                      (_) => selectDesgnIndex,
                                                                );
                                                                setState(() {});
                                                              } else {
                                                                _model.updateSelectedDesingAtIndex(
                                                                  0,
                                                                      (_) => selectDesgnIndex,
                                                                );
                                                                setState(() {});
                                                              }
                                                            },
                                                            child: Container(
                                                              width: 114,
                                                              height: 222,
                                                              decoration: BoxDecoration(
                                                                color: _model.selectedDesing
                                                                    .contains(selectDesgnIndex)
                                                                    ? Color(0x26740074)
                                                                    : FlutterFlowTheme.of(context)
                                                                    .secondaryBackground,
                                                                borderRadius: BorderRadius.circular(5),
                                                                border: Border.all(
                                                                  color: _model.selectedDesing
                                                                      .contains(selectDesgnIndex)
                                                                      ? Color(0xFF740074)
                                                                      : FlutterFlowTheme.of(context)
                                                                      .secondaryBackground,
                                                                ),
                                                              ),
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.max,
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                                        7, 4, 7, 4),
                                                                    child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(8),
                                                                      child: CachedNetworkImage(
                                                                        fadeInDuration: Duration(milliseconds: 500),
                                                                        fadeOutDuration: Duration(milliseconds: 500),
                                                                        imageUrl:
                                                                        getJsonField(
                                                                          selectDesgnItem,
                                                                          r'''$.image''',
                                                                        ).toString(),
                                                                        width: 100,
                                                                        height: 120,
                                                                        fit: BoxFit.contain,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                                        7, 0, 0, 0),
                                                                    child: Container(
                                                                      width: double.infinity,
                                                                      height: 42,
                                                                      decoration: BoxDecoration(),
                                                                      child: AutoSizeText(
                                                                        getJsonField(
                                                                          selectDesgnItem,
                                                                          r'''$.name''',
                                                                        ).toString(),
                                                                        maxLines: 2,
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
                                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                                        7, 0, 0, 7),
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
                                                                              fontSize: 14,
                                                                              letterSpacing: 0,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                          TextSpan(
                                                                            text: getJsonField(
                                                                              selectDesgnItem,
                                                                              r'''$.price''',
                                                                            ).toString(),
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
                                              else if (_model.choiceChipsValue == 'Bracelet') {
                                                return Builder(
                                                  builder: (context) {
                                                    final selectBraceletDesign = ProductDetailsCall.braceletgroup(
                                                      containerProductDetailsResponse.jsonBody,
                                                    )?.toList() ??
                                                        [];
                                                    return SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal,
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        children: List.generate(selectBraceletDesign.length,
                                                                (selectBraceletDesignIndex) {
                                                              final selectBraceletDesignItem =
                                                              selectBraceletDesign[selectBraceletDesignIndex];
                                                              return InkWell(
                                                                splashColor: Colors.transparent,
                                                                focusColor: Colors.transparent,
                                                                hoverColor: Colors.transparent,
                                                                highlightColor: Colors.transparent,
                                                                onTap: () async {
                                                                  _model.selecteddesign = !_model.selecteddesign;
                                                                  setState(() {});
                                                                },
                                                                child: Container(
                                                                  width: 114,
                                                                  height: 222,
                                                                  decoration: BoxDecoration(
                                                                    color: !_model.selecteddesign
                                                                        ? Color(0x26740074)
                                                                        : FlutterFlowTheme.of(context)
                                                                        .secondaryBackground,
                                                                    borderRadius: BorderRadius.circular(5),
                                                                    border: Border.all(
                                                                      color: !_model.selecteddesign
                                                                          ? Color(0xFF740074)
                                                                          : FlutterFlowTheme.of(context)
                                                                          .secondaryBackground,
                                                                    ),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisSize: MainAxisSize.max,
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7, 4, 7, 4),
                                                                        child: ClipRRect(
                                                                          borderRadius: BorderRadius.circular(8),
                                                                          child: CachedNetworkImage(
                                                                            fadeInDuration: Duration(milliseconds: 500),
                                                                            fadeOutDuration: Duration(milliseconds: 500),
                                                                            imageUrl:
                                                                            getJsonField(
                                                                              selectBraceletDesignItem,
                                                                              r'''$.image''',
                                                                            ).toString(),
                                                                            width: 100,
                                                                            height: 120,
                                                                            fit: BoxFit.contain,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7, 0, 0, 0),
                                                                        child: Container(
                                                                          width: double.infinity,
                                                                          height: 42,
                                                                          decoration: BoxDecoration(),
                                                                          child: AutoSizeText(
                                                                            getJsonField(
                                                                              selectBraceletDesignItem,
                                                                              r'''$.name''',
                                                                            ).toString(),
                                                                            maxLines: 2,
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
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7, 0, 0, 7),
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
                                                                                  fontSize: 14,
                                                                                  letterSpacing: 0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                ),
                                                                              ),
                                                                              TextSpan(
                                                                                text: getJsonField(
                                                                                  selectBraceletDesignItem,
                                                                                  r'''$.price''',
                                                                                ).toString(),
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
                                                return Container(
                                                  width: 375,
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
                              color: FlutterFlowTheme.of(context).BorderAllcolor,
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
                              color: FlutterFlowTheme.of(context).BorderAllcolor,
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
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              fontSize: 18,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text: formatNumber(
                                              valueOrDefault<int>(
                                                ProductDetailsCall.productsellingprice(containerProductDetailsResponse.jsonBody,
                                                ), 00000,) *
                                                  (_model.countControllerValue!),
                                              formatType: FormatType.decimal,
                                              decimalType: DecimalType.periodDecimal,
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
                              color: FlutterFlowTheme.of(context).BorderAllcolor,
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
                                                : FocusScope.of(context)
                                                .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: MyCartWidget(),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
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
                                        color: FlutterFlowTheme.of(context).primary,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      elevation: 0,
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).primary,
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
                                      color: FlutterFlowTheme.of(context).primary,
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
                                        color: FlutterFlowTheme.of(context).primary,
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
                              color: FlutterFlowTheme.of(context).BorderAllcolor,
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
                                          ProductDetailsCall.longdescription(
                                            containerProductDetailsResponse
                                                .jsonBody,
                                          ),
                                          'Description',
                                        ),
                                        onLinkTap: (url, _, __, ___) =>
                                            launchURL(url!),
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
                              color: FlutterFlowTheme.of(context).BorderAllcolor,
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
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
                                                              ProductDetailsCall
                                                                  .productrating(
                                                                containerProductDetailsResponse
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
                                                                ProductDetailsCall
                                                                    .productcount(
                                                                  containerProductDetailsResponse
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
                                                text: 'Rate Now',
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
                                                    FlutterFlowTheme.of(context).primary,
                                                    fontSize: 12,
                                                    letterSpacing: 0,
                                                  ),
                                                  elevation: 0,
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(context).primary,
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
                                                      color: FlutterFlowTheme.of(context).Ratingcolor,
                                                    ),
                                                direction: Axis.horizontal,
                                                rating: ProductDetailsCall
                                                    .productrating(
                                                  containerProductDetailsResponse
                                                      .jsonBody,
                                                )!,
                                                unratedColor: FlutterFlowTheme.of(context).unRatingcolor,
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
                                                  color: FlutterFlowTheme.of(context).Productnamecolor,
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
                                                  color: FlutterFlowTheme.of(context).Productnamecolor,
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
                              color: FlutterFlowTheme.of(context).BorderAllcolor,
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
                                        0, 0, 0, 16),
                                    child: Builder(
                                      builder: (context) {
                                        final relatedProduct =
                                            ProductDetailsCall.relatedproduct(
                                              containerProductDetailsResponse
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
                                                    highlightColor: Colors.transparent,
                                                    onTap: () async {
                                                      context.pushNamed(
                                                        'ProductDetails',
                                                        queryParameters: {
                                                          'productslugvalue': serializeParam(
                                                            getJsonField(
                                                              relatedProductItem,
                                                              r'''$.slug_value''',
                                                            ).toString(),
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
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                            child: CachedNetworkImage(
                                                              fadeInDuration: Duration(milliseconds: 500),
                                                              fadeOutDuration: Duration(milliseconds: 500),
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
                                                                color: FlutterFlowTheme.of(context).Productnamecolor,
                                                                fontSize: 14,
                                                                letterSpacing: 0,
                                                                fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                                lineHeight: 1.5,
                                                              ),
                                                            ),
                                                          ),
                                                          RichText(
                                                            textScaler:
                                                            MediaQuery.of(context)
                                                                .textScaler,
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: 'INR ',
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    fontFamily: 'Montserrat',
                                                                    fontSize: 14,
                                                                    letterSpacing: 0,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: getJsonField(
                                                                    relatedProductItem,
                                                                    r'''$.selling_price''',
                                                                  ).toString(),
                                                                  style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.w600,
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
                                                                      text: '4.4',
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Montserrat',
                                                                        letterSpacing: 0,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text: ' (412)',
                                                                      style:
                                                                      TextStyle(
                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                      ),
                                                                    )
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
                              color: FlutterFlowTheme.of(context).BorderAllcolor,
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
