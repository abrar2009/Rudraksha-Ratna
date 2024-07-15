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
  });

  final int? orderId;
  final int productIndex;

  @override
  State<OrderTrackingWidget> createState() => _OrderTrackingWidgetState();
}

class _OrderTrackingWidgetState extends State<OrderTrackingWidget> {
  late OrderTrackingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

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
    /*List<TrackingStep> steps = [
      TrackingStep(title: 'Confirmed', date: '10/06/2024', isCompleted: true),
      TrackingStep(title: 'Ready to ship', date: '11/06/2024', isCompleted: true),
      TrackingStep(title: 'Dispatched', date: '11/06/2024', isCompleted: true),
      TrackingStep(title: 'Delivered', date: '', isCompleted: false),
    ];*/

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF272728),
              size: 30,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Order Tracking',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Outfit',
              color: Color(0xFF272728),
              fontSize: 16.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          /*Text(
            valueOrDefault<String>(
              widget.orderId?.toString(),
              '7',
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Outfit',
              color: Color(0xFF272728),
              fontSize: 16,
              letterSpacing: 0,
            ),
          ),*/
          actions: const [],
          centerTitle: true,
          elevation: 0,
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

            // Extracting product details
            final List<dynamic> products = orderDetails['order_product_data'];

            // Extract values and print them for debugging
            final confirmedDate = columnOrderDetailResponse.jsonBody['data'][0]['orderConfirmedDate'] != null
                ? DateTime.parse(columnOrderDetailResponse.jsonBody['data'][0]['orderConfirmedDate'])
                : null;
            final confirmedStatus = columnOrderDetailResponse.jsonBody['data'][0]['orderConfirmed'] == true;

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

            // Create steps list based on the extracted values
            final steps = [
              {
                'title': 'Confirmed',
                'date': confirmedDate != null ? DateFormat('dd/MM/yyyy').format(confirmedDate) : '',
                'isCompleted': confirmedStatus,
              },
              {
                'title': 'Ready to Ship',
                'date': readyToShipDate != null ? DateFormat('dd/MM/yyyy').format(readyToShipDate) : '',
                'isCompleted': readyToShipStatus,
              },
              {
                'title': 'Dispatched',
                'date': dispatchedDate != null ? DateFormat('dd/MM/yyyy').format(dispatchedDate) : '',
                'isCompleted': dispatchedStatus,
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
                        color: Color(0xFFE7E7E8),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(products[widget.productIndex]['img'].toString(),
                          width: 104,
                          height: 126,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(36, 0, 36, 0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Text(products[widget.productIndex]['productname'].toString(),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Montserrat',
                                fontSize: 20,
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      RichText(
                        textScaler: MediaQuery.of(context).textScaler,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Product Code: ',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF6E6E70),
                                fontSize: 12,
                                letterSpacing: 0,
                              ),
                            ),
                            TextSpan(
                              text: /*getJsonField(
                                columnOrderDetailResponse.jsonBody,
                                r'''$.data[:].order_product_data[:].productcode''',
                              ).toString(),*/
                              products[widget.productIndex]['productcode'].toString(),
                              style: TextStyle(),
                            )
                          ],
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF6E6E70),
                            fontSize: 12,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      if(products[widget.productIndex]['order_product_data'].toString() != 'null')
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(36, 0, 36, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(),
                            child: RichText(
                              textScaler: MediaQuery.of(context).textScaler,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Variant: ',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF6E6E70),
                                      fontSize: 12,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: products[widget.productIndex]['productvariationname'].toString(),
                                    style: TextStyle(),
                                  )
                                ],
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF6E6E70),
                                  fontSize: 12,
                                  letterSpacing: 0,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      RichText(
                        textScaler: MediaQuery.of(context).textScaler,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Quantity: ',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF6E6E70),
                                fontSize: 12,
                                letterSpacing: 0,
                              ),
                            ),
                            TextSpan(
                              text: /*getJsonField(
                                columnOrderDetailResponse.jsonBody,
                                r'''$.data[:].order_product_data[:].quantity''',
                              ).toString(),*/
                              products[widget.productIndex]['quantity'].toString(),
                              style: TextStyle(),
                            )
                          ],
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF6E6E70),
                            fontSize: 12,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      // Generated code for this RichText Widget...
                      RichText(
                        textScaler: MediaQuery.of(context).textScaler,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Price: ',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF6E6E70),
                                fontSize: 12,
                                letterSpacing: 0,
                              ),
                            ),
                            TextSpan(
                              text: FFAppState().currencyName,
                              style: TextStyle(),
                            ),
                            TextSpan(
                              text: ' ',
                              style: TextStyle(),
                            ),
                            TextSpan(
                              text: /*getJsonField(
                                columnOrderDetailResponse.jsonBody,
                                r'''$.data[:].order_product_data[:].sellingprice''',
                              ).toString(),*/
                              products[widget.productIndex]['sellingprice'].toString(),
                              style: TextStyle(),
                            )
                          ],
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF6E6E70),
                            fontSize: 12,
                            letterSpacing: 0,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(36, 0, 36, 0),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Order Id ',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF6E6E70),
                                      letterSpacing: 0,
                                    ),
                                  ),
                                  SizedBox(height: 4,),
                                  Text(
                                    getJsonField(
                                      columnOrderDetailResponse.jsonBody,
                                      r'''$.data[:].payment_list[:].order_no''',
                                    ).toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF6E6E70),
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              VerticalDivider(
                                thickness: 1,
                                color: Color(0xFF6E6E70),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Date',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF6E6E70),
                                      letterSpacing: 0,
                                    ),
                                  ),
                                  SizedBox(height: 4,),
                                  Text(
                                    getJsonField(
                                      columnOrderDetailResponse.jsonBody,
                                      r'''$.data[:].orderDate''',
                                    ).toString(),
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF6E6E70),
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 8)),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(19, 40, 19, 0),
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
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Montserrat',
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 22),
                          Container(
                            width: double.infinity,
                            //height: MediaQuery.sizeOf(context).height * 0.23,
                            child: OrderTrackingBar(
                              width: double.infinity,
                              height: MediaQuery.sizeOf(context).height * 0.25,
                              steps: steps,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 15),
                    child: Container(
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF4FA),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24, 13, 24, 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Subtotal (Inc of all taxes)',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                // Generated code for this RichText Widget...
                                RichText(
                                  textScaler: MediaQuery.of(context).textScaler,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: FFAppState().currencyName,
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' ',
                                        style: TextStyle(),
                                      ),
                                      TextSpan(
                                        text: products[widget.productIndex]['subtotal_price'].toString(),
                                        style: TextStyle(),
                                      )
                                    ],
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Shipping Charges',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                // Generated code for this RichText Widget...
                                RichText(
                                  textScaler: MediaQuery.of(context).textScaler,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: FFAppState().currencyName,
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' ',
                                        style: TextStyle(),
                                      ),
                                      TextSpan(
                                        text: getJsonField(
                                          columnOrderDetailResponse.jsonBody,
                                          r'''$.data[0].deliveryCharges''',
                                        ).toString(),
                                        style: TextStyle(),
                                      )
                                    ],
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      fontSize: 20,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  // Generated code for this RichText Widget...
                                  RichText(
                                    textScaler: MediaQuery.of(context).textScaler,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: FFAppState().currencyName,
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            fontSize: 20,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                        TextSpan(
                                          text: getJsonField(
                                            columnOrderDetailResponse.jsonBody,
                                            r'''$.data[:].totalAmount''',
                                          ).toString(),
                                          style: TextStyle(),
                                        )
                                      ],
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 20,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ].divide(SizedBox(height: 16)),
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
