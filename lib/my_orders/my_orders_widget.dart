
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

  final scaffoldKey = GlobalKey<ScaffoldState>();

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
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
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 50.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FlutterFlowChoiceChips(
                              options: [
                                ChipData('Last 30 Days', FontAwesomeIcons.windowClose)
                              ],
                              onChanged: (val) => setState(
                                      () => _model.choiceChipsValue = val?.firstOrNull),
                              selectedChipStyle: ChipStyle(
                                backgroundColor: Colors.white,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                iconColor: Color(0xFF272728),
                                iconSize: 18.0,
                                labelPadding: EdgeInsetsDirectional.fromSTEB(10.0, 4.0, 10.0, 4.0),
                                elevation: 0.0,
                                borderColor: Color(0xFF740074),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              unselectedChipStyle: ChipStyle(
                                backgroundColor: FlutterFlowTheme.of(context).alternate,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                iconColor: FlutterFlowTheme.of(context).secondaryText,
                                iconSize: 18.0,
                                labelPadding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 4.0),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              chipSpacing: 12.0,
                              rowSpacing: 12.0,
                              multiselect: false,
                              alignment: WrapAlignment.start,
                              controller: _model.choiceChipsValueController ??= FormFieldController<List<String>>([]),
                              wrapped: true,
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Container(
                                width: 90.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F6FA),
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: Color(0xFFE7E7E8),
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
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 12),
                        child: Container(
                          width: double.infinity,
                          height: 44.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFE7E7E8),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Last 30 Days',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      /*Expanded(
                        child: ListView.builder(
                          itemCount: orderList.length,
                          itemBuilder: (context, orderListIndex) {
                            final orderListItem = orderList[orderListIndex];
                            final productList = getJsonField(orderListItem, r'''$.product''').toList();
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: productList.map<Widget>((productListItem) {
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  child: InkWell(
                                    onTap: () async {
                                      int productIndex = productList.indexOf(productListItem);
                                      if (productIndex != -1) {
                                        context.pushNamed(
                                          'OrderTracking',
                                          queryParameters: {
                                            'orderId': serializeParam(
                                              getJsonField(orderListItem, r'''$.id'''),
                                              ParamType.int,
                                            ),
                                            'productIndex': productIndex.toString(),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: TransitionInfo(
                                              hasTransition: true,
                                              transitionType: PageTransitionType.rightToLeft,
                                              duration: Duration(milliseconds: 400),
                                            ),
                                          },
                                        );
                                      } else {
                                        // Handle case where productListItem is not found in productList
                                        print('Product item not found in productList.');
                                      }
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
                                                getJsonField(productListItem, r'''$.thumbnail_image''').toString(),
                                                width: 48,
                                                height: 58,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.68,
                                                    child: Text(
                                                      getJsonField(productListItem, r'''$.product_name''').toString(),
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
                                                        color: Color(0xFF313131),
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
                                                  InkWell(
                                                    onTap: () async {
                                                      int productIndex = productList.indexOf(productListItem);
                                                      if (productIndex != -1) {
                                                        context.pushNamed(
                                                          'OrderTracking',
                                                          queryParameters: {
                                                            'orderId': serializeParam(
                                                              getJsonField(orderListItem, r'''$.id'''),
                                                              ParamType.int,
                                                            ),
                                                            'productIndex': productIndex.toString(),
                                                          }.withoutNulls,
                                                          extra: <String, dynamic>{
                                                            kTransitionInfoKey: TransitionInfo(
                                                              hasTransition: true,
                                                              transitionType: PageTransitionType.rightToLeft,
                                                              duration: Duration(milliseconds: 400),
                                                            ),
                                                          },
                                                        );
                                                      } else {
                                                        // Handle case where productListItem is not found in productList
                                                        print('Product item not found in productList.');
                                                      }
                                                    },
                                                    child: Text(
                                                      'View Order',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
                                                        color: Color(0xFF740074),
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),

                                                ].divide(SizedBox(height: 5)),
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 16)),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList().cast<Widget>(),
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
                                                            Text(
                                                              getJsonField(orderListItem, r'''$.orderDate''').toString(),
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                fontFamily: 'Montserrat',
                                                                color: FlutterFlowTheme.of(context).primary,
                                                                letterSpacing: 0,
                                                                fontWeight: FontWeight.w500,
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
                      ),
                      /*Expanded(
                        child: ListView.builder(
                          itemCount: orderList.length,
                          itemBuilder: (context, orderListIndex) {
                            final orderListItem = orderList[orderListIndex];
                            final productList = getJsonField(orderListItem, r'''$.product''').toList();
                            final firstProduct = productList.isNotEmpty ? productList[0] : null;

                            return Container(
                              width: MediaQuery.sizeOf(context).width * 0.75,
                              decoration: BoxDecoration(),
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
                                                    width: 48,
                                                    height: 58,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
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
                                                      *//*InkWell(
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
                                                            color: Color(0xFF740074),
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),*//*
                                                      // Generated code for this Row Widget...
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
                                                                    getJsonField(
                                                                      orderListItem,
                                                                      r'''$.id''',
                                                                    ),
                                                                    ParamType.int,
                                                                  ),
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
                                                                color: Color(0xFF740074),
                                                                letterSpacing: 0,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            getJsonField(
                                                              orderListItem,
                                                              r'''$.orderDate''',
                                                            ).toString(),
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Montserrat',
                                                              color: Color(0xFF740074),
                                                              letterSpacing: 0,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ]
                                                      )
                                                    ].divide(SizedBox(height: 5)),
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

