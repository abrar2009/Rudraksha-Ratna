import 'package:rudraksha_cart/flutter_flow/flutter_flow_widgets.dart';
import '../../custom_code/widgets/order_tracking_bar.dart';
import '../../flutter_flow/custom_functions.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'order_tracking_model.dart';
export 'order_tracking_model.dart';

class OrderTrackingWidget extends StatefulWidget {
  const OrderTrackingWidget({
    super.key,
    required this.orderId,
    required this.productIndex,
    required this.invoiceNo,
  });

  final int? orderId;
  final int productIndex;
  final String? invoiceNo;

  @override
  State<OrderTrackingWidget> createState() => _OrderTrackingWidgetState();
}

class _OrderTrackingWidgetState extends State<OrderTrackingWidget> {
  late OrderTrackingModel _model;

  final OrderTrackingWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OrderTrackingModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: OrderTrackingWidgetscaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(0, 4), // Move shadow downwards by 4 pixels
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
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 30,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Text(
                'Order Tracking',
                //'${widget.orderId}',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: const [],
              centerTitle: true,
              elevation: 0,
            ),
          ),
        ),
        body: FutureBuilder<ApiCallResponse>(
          future: OrderDetailCall.call(
            hosturl: FFAppConstants.hosturl,
            orderId: widget.orderId,
            //orderId: 12130,
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
            final columnOrderDetailResponse = snapshot.data!;
            final orderDetails = columnOrderDetailResponse.jsonBody['data'][0];
            print("API Response: ${columnOrderDetailResponse.jsonBody}");
            debugPrint("API Response long response: ${columnOrderDetailResponse.jsonBody}");

            // Extracting product details
            final List<dynamic> products = orderDetails['order_product_data'];

            // Extract values and print them for debugging
            final confirmedDate = columnOrderDetailResponse.jsonBody['data'][0]['orderConfirmedDate'] != null
                ? DateTime.parse(columnOrderDetailResponse.jsonBody['data'][0]['orderConfirmedDate'])
                : null;
            final confirmedStatus = columnOrderDetailResponse.jsonBody['data'][0]['orderConfirmed'] == true;
            final inProcessDate = columnOrderDetailResponse.jsonBody['data'][0]['orderInprocessDate'] != null
                ? DateTime.parse(columnOrderDetailResponse.jsonBody['data'][0]['orderInprocessDate'])
                : null;
            final inProcess = columnOrderDetailResponse.jsonBody['data'][0]['orderInprocess'] == true;

            final readyToShipDate = columnOrderDetailResponse.jsonBody['data'][0]['orderreadytoshipDate'] != null
                ? DateTime.parse(columnOrderDetailResponse.jsonBody['data'][0]['orderreadytoshipDate'])
                : null;
            final readyToShipStatus = columnOrderDetailResponse.jsonBody['data'][0]['orderreadytoship'] == true;

            final dispatchedDate = columnOrderDetailResponse.jsonBody['data'][0]['orderDispatchedDate'] != null
                ? DateTime.parse(columnOrderDetailResponse.jsonBody['data'][0]['orderDispatchedDate'])
                : null;
            final dispatchedStatus = columnOrderDetailResponse.jsonBody['data'][0]['orderDispatched'] == true;

            final deliveredDate = columnOrderDetailResponse.jsonBody['data'][0]['orderDeliveredDate'] != null
                ? DateTime.parse(columnOrderDetailResponse.jsonBody['data'][0]['orderDeliveredDate'])
                : null;
            final deliveredStatus = columnOrderDetailResponse.jsonBody['data'][0]['orderDelivered'] == true;
            final shippingID = getJsonField(columnOrderDetailResponse.jsonBody, r'''$.data[:].shipment_detail.trackingId''',);
            // Create steps list based on the extracted values
            final steps = [
              {
                'title': 'Confirmed',
                'date': confirmedDate != null ? DateFormat('dd/MM/yyyy').format(confirmedDate) : '',
                'isCompleted': confirmedStatus,
              },
              {
                'title': 'In-process',
                'date': inProcessDate != null ? DateFormat('dd/MM/yyyy').format(inProcessDate) : '',
                'isCompleted': inProcess,
              },
              {
                'title': 'Ready to Ship',
                'date': readyToShipDate != null ? DateFormat('dd/MM/yyyy').format(readyToShipDate) : '',
                'isCompleted': readyToShipStatus,
              },
              {
                'title': 'Shipped',
                'date': dispatchedDate != null ? DateFormat('dd/MM/yyyy').format(dispatchedDate) : '',
                'isCompleted': dispatchedStatus,
                'trackingid': shippingID,
              },
              {
                'title': 'Delivered',
                'date': deliveredDate != null ? DateFormat('dd/MM/yyyy').format(deliveredDate) : '',
                'isCompleted': deliveredStatus,
              },
            ];

            // Print extracted values for debugging
            print("Confirmed Date: $confirmedDate");
            print("Confirmed Status: $confirmedStatus");
            print("Ready to Ship Date: $readyToShipDate");
            print("Ready to Ship Status: $readyToShipStatus");
            print("Dispatched Date: $dispatchedDate");
            print("Dispatched Status: $dispatchedStatus");
            print("Delivered Date: $deliveredDate");
            print("Delivered Status: $deliveredStatus");

            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 1,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).borderColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(19, 16, 19, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order ID: ${getJsonField(
                            columnOrderDetailResponse.jsonBody,
                            r'''$.data[:].invoiceNumber''',
                          ).toString()}',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Column(
                      children: products.map((product) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: const BoxDecoration(),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      product['img'].toString(),
                                      width: 58,
                                      //height: 58,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product['productname'].toString(),
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            color: Colors.black,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4,),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Product Code: ',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: product['productcode'].toString(),
                                                  style: const TextStyle(),
                                                ),
                                              ],
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Montserrat',
                                                color: FlutterFlowTheme.of(context).Productnamecolor,
                                                fontSize: 12,
                                                letterSpacing: 0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4,),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Quantity: ',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: product['quantity'].toString(),
                                                  style: const TextStyle(),
                                                ),
                                              ],
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Montserrat',
                                                color: FlutterFlowTheme.of(context).Productnamecolor,
                                                fontSize: 12,
                                                letterSpacing: 0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        if(product['design_type'] != null && product['design_type'] != '')
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4,),
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Design Type: ',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: product['design_type'].toString(),
                                                    style: const TextStyle(),
                                                  ),
                                                ],
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  color: FlutterFlowTheme.of(context).Productnamecolor,
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        if(product['designText'] != null && product['designText'] != '')
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4,),
                                            child: RichText(
                                              textScaler: MediaQuery.of(context).textScaler,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Design: ',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      color:Colors.black,
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: product['designText'].toString(),
                                                    style: TextStyle(
                                                      color: FlutterFlowTheme.of(context).Productnamecolor,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: "-",
                                                    style: TextStyle(
                                                      color: FlutterFlowTheme.of(context).Productnamecolor,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12,
                                                    ),
                                                  ),

                                                  TextSpan(
                                                    text: "${valueOrDefault<String>(FFAppState().currencyName, 'INR',
                                                    )} ${formatNumber(currencyConversion(FFAppState().currencyRate,
                                                        product['designPrice'].toString()),
                                                      formatType: FormatType.decimal,
                                                      decimalType: DecimalType.automatic,
                                                    )}",

                                                    style: TextStyle(
                                                      color: FlutterFlowTheme.of(context).Productnamecolor,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12,
                                                    ),
                                                  )
                                                ],
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  color: const Color(0xFF6E6E70),
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        if(product['wrist_size'] != null && product['wrist_size'] != '')
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4,),
                                            child: RichText(
                                              textScaler: MediaQuery.of(context).textScaler,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Upper Arm / Wrist Size: ',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      color:Colors.black,
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: '${product['wrist_size'].toString().replaceAll('inches', '').trim()}"',
                                                    style: TextStyle(
                                                      color: FlutterFlowTheme.of(context).Productnamecolor,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  color: const Color(0xFF6E6E70),
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        if(product['ring_size_system'] != null && product['ring_size_system'] != '')
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4,),
                                            child: RichText(
                                              textScaler: MediaQuery.of(context).textScaler,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Ring Size System: ',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      color:Colors.black,
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: product['ring_size_system'].toString().replaceAll(' Ring Size System', '-system'),
                                                    style: TextStyle(
                                                      color: FlutterFlowTheme.of(context).Productnamecolor,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  color: const Color(0xFF6E6E70),
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        if(product['ring_size'] != null && product['ring_size'] != '')
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4,),
                                            child: RichText(
                                              textScaler: MediaQuery.of(context).textScaler,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Ring Size: ',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      color:Colors.black,
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: product['ring_size'].toString(),
                                                    style: TextStyle(
                                                      color: FlutterFlowTheme.of(context).Productnamecolor,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  color: const Color(0xFF6E6E70),
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        if(product['certificationText'] != null && product['certificationText'] != '')
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4,),
                                            child: RichText(
                                              textScaler: MediaQuery.of(context).textScaler,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Certification: ',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: product['certificationText'].toString(),
                                                    style: TextStyle(
                                                      color: FlutterFlowTheme.of(context).Productnamecolor,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: "-",
                                                    style: TextStyle(
                                                      color: FlutterFlowTheme.of(context).Productnamecolor,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12,
                                                    ),
                                                  ),

                                                  TextSpan(
                                                    text: "${valueOrDefault<String>(FFAppState().currencyName, 'INR',
                                                    )} ${formatNumber(currencyConversion(FFAppState().currencyRate,
                                                        product['certificationPrice'].toString()),
                                                      formatType: FormatType.decimal,
                                                      decimalType: DecimalType.automatic,
                                                    )}",

                                                    style: TextStyle(
                                                      color: FlutterFlowTheme.of(context).Productnamecolor,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12,
                                                    ),
                                                  )
                                                ],
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  letterSpacing: 0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        if(product['energizationText'] != null && product['energizationText'] != '')
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4,),
                                            child: RichText(
                                              textScaler: MediaQuery.of(context).textScaler,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Energization: ',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: product['energizationText'].toString(),
                                                    style: TextStyle(
                                                      color: FlutterFlowTheme.of(context).Productnamecolor,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: "-",
                                                    style: TextStyle(
                                                      color: FlutterFlowTheme.of(context).Productnamecolor,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12,
                                                    ),
                                                  ),

                                                  TextSpan(
                                                    text: "${valueOrDefault<String>(FFAppState().currencyName, 'INR',
                                                    )} ${formatNumber(currencyConversion(FFAppState().currencyRate,
                                                        product['energizationPrice'].toString()),
                                                      formatType: FormatType.decimal,
                                                      decimalType: DecimalType.automatic,
                                                    )}",

                                                    style: TextStyle(
                                                      color: FlutterFlowTheme.of(context).Productnamecolor,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12,
                                                    ),
                                                  )
                                                ],
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  letterSpacing: 0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Base Price: ',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  //text: product['sellingprice'].toString(),
                                                  text: "${valueOrDefault<String>(FFAppState().currencyName, 'INR',
                                                  )} ${formatNumber(currencyConversion(FFAppState().currencyRate,
                                                      product['sellingprice'].toString()),
                                                    formatType: FormatType.decimal,
                                                    decimalType: DecimalType.automatic,
                                                  )}",
                                                  style: const TextStyle(),
                                                ),
                                              ],
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Montserrat',
                                                color: FlutterFlowTheme.of(context).Productnamecolor,
                                                fontSize: 12,
                                                letterSpacing: 0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4,),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Subtotal: ',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  //text: product['subtotal_price'].toString(),
                                                  text: "${valueOrDefault<String>(FFAppState().currencyName, 'INR',
                                                  )} ${formatNumber(currencyConversion(FFAppState().currencyRate,
                                                      product['subtotal_price'].toString()),
                                                    formatType: FormatType.decimal,
                                                    decimalType: DecimalType.automatic,
                                                  )}",
                                                  style: const TextStyle(),
                                                ),
                                              ],
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xFF6E6E70),
                                                fontSize: 12,
                                                letterSpacing: 0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8,),
                                        Divider(
                                          height: 2,
                                          thickness: 1,
                                          color: FlutterFlowTheme.of(context).borderColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  if(getJsonField(orderDetails, r'''$.invoiceurl''') != null)
                  Center(
                    child: FFButtonWidget(
                      text: 'View Invoice',
                      onPressed: () {
                        print("Print Invoice: ${getJsonField(orderDetails, r'''$.invoiceurl''').toString()}");
                        final invoiceUrl = getJsonField(orderDetails, r'''$.invoiceurl''').toString();
                        if (invoiceUrl.isNotEmpty) {
                          launchURL(invoiceUrl);
                        }
                      },
                      options: FFButtonOptions(
                      padding: const EdgeInsetsDirectional.fromSTEB(45, 0, 45, 0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Montserrat',
                        color:FlutterFlowTheme.of(context).primary,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                        fontSize: 12
                      ),
                      elevation: 0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primary,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(19, 10, 19, 0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Track Order',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 22),
                          SizedBox(
                            width: double.infinity,
                            //height: MediaQuery.sizeOf(context).height * 0.23,
                            child: OrderTrackingBar(
                              width: double.infinity,
                           height: MediaQuery.sizeOf(context).height * 0.34,
                              steps: steps,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 15),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFF4FA),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(24, 13, 24, 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Subtotal (Inc of all taxes)',
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} '
                                      '${formatNumber(currencyConversion(FFAppState().currencyRate, getJsonField(columnOrderDetailResponse.jsonBody, r'''$.data[:].amount''').toString()), formatType: FormatType.decimal, decimalType: DecimalType.automatic)}',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Shipping Charges',
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} '
                                      '${formatNumber(currencyConversion(FFAppState().currencyRate, getJsonField(columnOrderDetailResponse.jsonBody, r'''$.data[0].deliveryCharges''').toString()), formatType: FormatType.decimal, decimalType: DecimalType.automatic)}',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Discount',
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} '
                                      '${formatNumber(currencyConversion(FFAppState().currencyRate, getJsonField(columnOrderDetailResponse.jsonBody, r'''$.data[0].coupenAmount''').toString()), formatType: FormatType.decimal, decimalType: DecimalType.automatic)}',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            // Calculate if rewards are used
                            if (currencyConversion(
                                FFAppState().currencyRate,
                                getJsonField(columnOrderDetailResponse.jsonBody,
                                    r'''$.data[:].totalAmount''').toString())! <
                                currencyConversion(
                                    FFAppState().currencyRate,
                                    getJsonField(columnOrderDetailResponse.jsonBody,
                                        r'''$.data[:].amount''').toString())! +
                                    currencyConversion(
                                        FFAppState().currencyRate,
                                        getJsonField(columnOrderDetailResponse.jsonBody,
                                            r'''$.data[0].deliveryCharges''').toString())!)
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Rewards Used',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green
                                    ),
                                  ),
                                  Text(
                                    '- ${valueOrDefault<String>(FFAppState().currencyName, 'INR')} '
                                        '${formatNumber(currencyConversion(
                                        FFAppState().currencyRate,
                                        (currencyConversion(
                                            FFAppState().currencyRate,
                                            getJsonField(columnOrderDetailResponse.jsonBody, r'''$.data[:].deliveryCharges''').toString())! +
                                            currencyConversion(
                                                FFAppState().currencyRate,
                                                getJsonField(columnOrderDetailResponse.jsonBody, r'''$.data[:].amount''').toString())! -
                                            currencyConversion(
                                                FFAppState().currencyRate,
                                                getJsonField(columnOrderDetailResponse.jsonBody, r'''$.data[0].totalAmount''').toString())!
                                        ).toStringAsFixed(2) // Ensures the result is a String
                                    ),
                                        formatType: FormatType.decimal,
                                        decimalType: DecimalType.automatic
                                    )}',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green
                                    ),
                                  ),
                                ],
                              ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      fontSize: 20,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    '${valueOrDefault<String>(FFAppState().currencyName, 'INR')} '
                                        '${formatNumber(currencyConversion(FFAppState().currencyRate, getJsonField(columnOrderDetailResponse.jsonBody, r'''$.data[:].totalAmount''').toString()), formatType: FormatType.decimal, decimalType: DecimalType.automatic)}',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      fontSize: 20,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ].divide(const SizedBox(height: 16)),
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
    );
  }
}
