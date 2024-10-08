
import 'package:url_launcher/url_launcher.dart';

import '../auth/custom_auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/api_requests/api_manager.dart';
import '../flutter_flow/custom_functions.dart';
import '/components/custom_nav_bar_widget.dart';
import '/components/filter_component_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'my_orders_model.dart';
export 'my_orders_model.dart';

class MyOrdersWidget extends StatefulWidget {
  const MyOrdersWidget({super.key});

  @override
  State<MyOrdersWidget> createState() => _MyOrdersWidgetState();
}

class _MyOrdersWidgetState extends State<MyOrdersWidget> {
  late MyOrdersModel _model;

  final MyOrdersWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyOrdersModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  String formatOrderDate(String dateString) {
    try {
      // Parse the date string to a DateTime object
      DateTime parsedDate = DateTime.parse(dateString);

      // Format the DateTime object to the desired format
      return DateFormat('dd-MMM-yyyy').format(parsedDate);
    } catch (e) {
      // Handle any parsing errors or invalid date strings
      return dateString;
    }
  }


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: MyOrdersWidgetscaffoldKey,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
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
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Color(0xFF272728),
                  size: 30.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Text(
                'My Orders',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Color(0xFF272728),
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [],
              centerTitle: true,
              elevation: 0.0,
            ),
          ),
        ),
        body: FutureBuilder<ApiCallResponse>(
          future: CustomerOrderListCall.call(
            hosturl: FFAppConstants.hosturl,
            token: currentAuthenticationToken,
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
            final columnCustomerOrderListResponse = snapshot.data!;
            final orderList = getJsonField(
              columnCustomerOrderListResponse.jsonBody,
              r'''$.data''',
            ).toList();
            print("orderList : ${orderList}");

            if (orderList.isEmpty) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration (
                  image: DecorationImage(
                    image: AssetImage('assets/images/empty_cart_image.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You haven\'t placed any orders yet.',
                          style: FlutterFlowTheme.of(context).headlineMedium.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 24,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 31,),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(108, 0, 108, 0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              context.pushNamed(
                                'Homepage',
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.scale,
                                    alignment: Alignment.bottomCenter,
                                    duration: Duration(milliseconds: 400),
                                  ),
                                },
                              );
                            },
                            text: 'HOME',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 48,
                              padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600,
                              ),
                              elevation: 0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return Stack(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 50.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      /*Expanded(
                        child: ListView.builder(
                          itemCount: orderList.length,
                          itemBuilder: (context, orderListIndex) {
                            final orderListItem = orderList[orderListIndex];
                            final productList = getJsonField(orderListItem, r'''$.product''').toList();
                            final firstProduct = productList.isNotEmpty ? productList[0] : null;

                            return Container(
                              width: double.infinity,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (firstProduct != null)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                      child: InkWell(
                                        onTap: () async {
                                          context.pushNamed(
                                            'OrderTracking',
                                            queryParameters: {
                                              'orderId': serializeParam(
                                                getJsonField(orderListItem, r'''$.invoiceNumber''').toInt(),
                                                ParamType.int,
                                              ),
                                              'invoiceNo': serializeParam(
                                                getJsonField(
                                                  orderListItem,
                                                  r'''$.invoiceNumber''',
                                                ).toString(),
                                                ParamType.String,
                                              ),
                                              'productIndex': '0', // Since we are using the first product
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey: TransitionInfo(
                                                hasTransition: true,
                                                transitionType: PageTransitionType.rightToLeft,
                                                duration: Duration(milliseconds: 400),
                                              ),
                                            },
                                          );
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 90,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                            border: Border(
                                              bottom: BorderSide(
                                                color: FlutterFlowTheme.of(context).borderColor,
                                              ),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(8),
                                                  child: Image.network(
                                                    getJsonField(firstProduct, r'''$.thumbnail_image''').toString(),
                                                    width: 58,
                                                    height: 58,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width - 128, // Adjust the width as needed
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: 'Order ID - ',
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Montserrat',
                                                                  color: Color(0xFF313131),
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: getJsonField(orderListItem, r'''$.invoiceNumber''').toString(),
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Montserrat',
                                                                  color: Color(0xFF313131),
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Text(
                                                          getJsonField(orderListItem, r'''$.orderDate''').toString(),
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Montserrat',
                                                            color: FlutterFlowTheme.of(context).primary,
                                                            letterSpacing: 0,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisSize: MainAxisSize.max,
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            InkWell(
                                                              splashColor: Colors.transparent,
                                                              focusColor: Colors.transparent,
                                                              hoverColor: Colors.transparent,
                                                              highlightColor: Colors.transparent,
                                                              onTap: () async {
                                                                context.pushNamed(
                                                                  'OrderTracking',
                                                                  queryParameters: {
                                                                    'orderId': serializeParam(
                                                                      getJsonField(orderListItem, r'''$.id'''),
                                                                      ParamType.int,
                                                                    ),
                                                                    'productIndex': '0', // Since we are using the first product
                                                                  }.withoutNulls,
                                                                  extra: <String, dynamic>{
                                                                    kTransitionInfoKey: TransitionInfo(
                                                                      hasTransition: true,
                                                                      transitionType: PageTransitionType.rightToLeft,
                                                                      duration: Duration(milliseconds: 400),
                                                                    ),
                                                                  },
                                                                );
                                                              },
                                                              child: Text(
                                                                'View Order',
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Montserrat',
                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                  letterSpacing: 0,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                            if(getJsonField(orderListItem, r'''$.invoiceurl''') != null && getJsonField(orderListItem, r'''$.invoiceurl''') != '')
                                                              InkWell(
                                                                onTap: () {
                                                                  final invoiceUrl = getJsonField(orderListItem, r'''$.invoiceurl''').toString();
                                                                  if (invoiceUrl.isNotEmpty) {
                                                                    launchURL(invoiceUrl);
                                                                  }
                                                                },
                                                                child: Text(
                                                                  'View Invoice',
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    fontFamily: 'Montserrat',
                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                    letterSpacing: 0,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text: 'Status - ',
                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                      fontFamily: 'Montserrat',
                                                                      color: Color(0xFF272728),
                                                                      fontSize: 13,
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                    text: getJsonField(orderListItem, r'''$.orderstatus''').toString(),
                                                                    style: TextStyle(
                                                                      color: Color(0xFF0EB45A),
                                                                      fontSize: 13,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ].divide(SizedBox(height: 5)),
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 16)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),*/

                      Expanded(
                        child: ListView.builder(
                          itemCount: orderList.length,
                          itemBuilder: (context, orderListIndex) {
                            final orderListItem = orderList[orderListIndex];
                            final productList = getJsonField(orderListItem, r'''$.product''').toList();
                            final firstProduct = productList.isNotEmpty ? productList[0] : null;

                            return Container(
                              width: double.infinity,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (firstProduct != null)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                      child: InkWell(
                                        onTap: () async {
                                          context.pushNamed(
                                            'OrderTracking',
                                            queryParameters: {
                                              'orderId': serializeParam(
                                                getJsonField(orderListItem, r'''$.id''').toInt(),
                                                ParamType.int,
                                              ),
                                              'invoiceNo': serializeParam(
                                                getJsonField(
                                                  orderListItem,
                                                  r'''$.invoiceNumber''',
                                                ).toString(),
                                                ParamType.String,
                                              ),
                                              'productIndex': '0', // Since we are using the first product
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey: TransitionInfo(
                                                hasTransition: true,
                                                transitionType: PageTransitionType.rightToLeft,
                                                duration: Duration(milliseconds: 400),
                                              ),
                                            },
                                          );
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 90,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                            border: Border(
                                              bottom: BorderSide(
                                                color: FlutterFlowTheme.of(context).borderColor,
                                              ),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(8),
                                                  child: Image.network(
                                                    getJsonField(firstProduct, r'''$.thumbnail_image''').toString(),
                                                    width: 58,
                                                    height: 58,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width - 160, // Adjust the width as needed
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: getJsonField(firstProduct, r'''$.product_name''').toString(),
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Montserrat',
                                                                  color: Color(0xFF313131),
                                                                  fontSize: 15,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        /*if(getJsonField(orderListItem, r'''$.orderstatus''').toString() != 'Delivered')
                                                        Row(
                                                          mainAxisSize: MainAxisSize.max,
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            InkWell(
                                                              splashColor: Colors.transparent,
                                                              focusColor: Colors.transparent,
                                                              hoverColor: Colors.transparent,
                                                              highlightColor: Colors.transparent,
                                                              onTap: () async {
                                                                context.pushNamed(
                                                                  'OrderTracking',
                                                                  queryParameters: {
                                                                    'orderId': serializeParam(
                                                                      getJsonField(orderListItem, r'''$.id'''),
                                                                      ParamType.int,
                                                                    ),
                                                                    'productIndex': '0', // Since we are using the first product
                                                                  }.withoutNulls,
                                                                  extra: <String, dynamic>{
                                                                    kTransitionInfoKey: TransitionInfo(
                                                                      hasTransition: true,
                                                                      transitionType: PageTransitionType.rightToLeft,
                                                                      duration: Duration(milliseconds: 400),
                                                                    ),
                                                                  },
                                                                );
                                                              },
                                                              child: Text(
                                                                'View Order',
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Montserrat',
                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                  letterSpacing: 0,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                            if (getJsonField(orderListItem, r'''$.invoiceurl''') != null &&
                                                                getJsonField(orderListItem, r'''$.invoiceurl''') != '')
                                                              InkWell(
                                                                onTap: () {
                                                                  final invoiceUrl = getJsonField(orderListItem, r'''$.invoiceurl''').toString();
                                                                  if (invoiceUrl.isNotEmpty) {
                                                                    launchURL(invoiceUrl);
                                                                  }
                                                                },
                                                                child: Text(
                                                                  'View Invoice',
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    fontFamily: 'Montserrat',
                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                    letterSpacing: 0,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text: 'Status - ',
                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Montserrat',
                                                                        color: Color(0xFF272728),
                                                                        fontSize: 13,
                                                                        fontWeight: FontWeight.w400
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                    text: getJsonField(orderListItem, r'''$.orderstatus''').toString(),
                                                                    style: TextStyle(
                                                                        color: Color(0xFF0EB45A),
                                                                        fontSize: 13,
                                                                        fontWeight: FontWeight.w400
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),*/
                                                        if(getJsonField(orderListItem, r'''$.orderstatus''').toString() == 'Delivered')
                                                          Text(
                                                            'Delivered on ${formatOrderDate(getJsonField(orderListItem, r'''$.orderDate''').toString())}',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Montserrat',
                                                              color: Color(0xff6E6E70),
                                                              letterSpacing: 0,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        if(getJsonField(orderListItem, r'''$.orderstatus''').toString() == 'Confirmed')
                                                          Text(
                                                            'Ordered on ${formatOrderDate(getJsonField(orderListItem, r'''$.orderDate''').toString())}',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Montserrat',
                                                              color: Color(0xff6E6E70),
                                                              letterSpacing: 0,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        if(getJsonField(orderListItem, r'''$.orderstatus''').toString() == 'Shipped')
                                                          Text(
                                                            'Shipped on ${formatOrderDate(getJsonField(orderListItem, r'''$.orderDate''').toString())}',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Montserrat',
                                                              color: Color(0xff6E6E70),
                                                              letterSpacing: 0,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                      ].divide(SizedBox(height: 5)),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  splashColor: Colors.transparent,
                                                  focusColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  onTap: () async {
                                                    context.pushNamed(
                                                      'OrderTracking',
                                                      queryParameters: {
                                                        'orderId': serializeParam(
                                                          getJsonField(orderListItem, r'''$.id'''),
                                                          ParamType.int,
                                                        ),
                                                        'productIndex': '0', // Since we are using the first product
                                                      }.withoutNulls,
                                                      extra: <String, dynamic>{
                                                        kTransitionInfoKey: TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType: PageTransitionType.rightToLeft,
                                                          duration: Duration(milliseconds: 400),
                                                        ),
                                                      },
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                    size: 20,
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 16)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: wrapWithModel(
                    model: _model.customNavBarModel,
                    updateCallback: () => setState(() {}),
                    child: CustomNavBarWidget(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

