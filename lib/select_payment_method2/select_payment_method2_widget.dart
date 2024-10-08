import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rudraksha_cart/index.dart';
import '../auth/custom_auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../components/shimmer_widget.dart';
import '../pages/BankInfoScreen/PaymentBankInfoWidget.dart';
import '../payment_successful/payment_successful_widget.dart';
import '/components/custom_nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'select_payment_method2_model.dart';
export 'select_payment_method2_model.dart';

class SelectPaymentMethod2Widget extends StatefulWidget {
  const SelectPaymentMethod2Widget({
    super.key,
    this.currencyName,
    this.orderTotalAmount,
    this.totalAmount,
    this.invoiceNumber,
    this.productlist,
    this.checkbox1,
    this.checkbox2,
  });

  final String? currencyName;
  final int? orderTotalAmount;
  final double? totalAmount;
  final String? invoiceNumber;
  final List<Product>? productlist;
  final bool? checkbox1;
  final bool? checkbox2;


  @override
  State<SelectPaymentMethod2Widget> createState() =>
      _SelectPaymentMethod2WidgetState();
}

class _SelectPaymentMethod2WidgetState extends State<SelectPaymentMethod2Widget> {
  late SelectPaymentMethod2Model _model;
  late Razorpay _razorpay;
  bool _isButtonEnabled = false;
  late int paymentmode=2;
  bool _isLoading = false;

  final SelectPaymentMethod2WidgetscaffoldKeyy = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    print('Razorpay event listeners initialized');
    print('Total Amount: ${widget.totalAmount}');
    print('productlist: ${widget.productlist}');
    print('Invoice Number: ${FFAppState().invoiceNumber}');

    super.initState();
    // Set loading state to true
    setState(() {
      _isLoading = true;
    });

    // Call the API and then hide the loader
    apicallforproduct().then((_) {
      setState(() {
        _isLoading = false;
      });
    });

    _model = createModel(context, () => SelectPaymentMethod2Model());
    _razorpay = Razorpay();


    print('Razorpay event listeners initialized');
    print('Total Amount: ${widget.totalAmount}');
    print('Invoice Number: ${FFAppState().invoiceNumber}');
  }


  @override
  void dispose() {
    _model.dispose();
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }
Future<void>  apicallforproduct () async {
  ApiCallResponse apiResponse = await AddOrderCall.call(
    hosturl: FFAppConstants.hosturl,
    token: currentAuthenticationToken,
    deliveryAddress: FFAppState().shippingAddressID,
    billingAddress: widget.checkbox1 == true
        ? FFAppState().shippingAddressID
        : FFAppState().billingAddressID,
    paymentMode: paymentmode,
    currencyType: FFAppState().currencyName,
    coupenCode: FFAppState().couponCode,
    giftId:FFAppState().selectedGiftId?.toString(),
    rewardUsed:widget.checkbox2,
    products:FFAppState().products, // Pass the List<Product> directly
    customerInstructions: '',
    shippingType: 'Fedex/DHL',
    digitalSource: 'not sponsored',
    source: 'app'
  );

  _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  print('API Call Result:');
  if (apiResponse == null) {
    print('API response is null');
  } else {
    print(
        'Raw Response: ${apiResponse.jsonBody}');
    print(
        'Response Data: ${apiResponse.response}');
    print(
        'Response Headers: ${apiResponse.headers}');
    print(
        'Status Code: ${apiResponse.statusCode}');
  }

  if (apiResponse != null &&
      apiResponse.statusCode == 200) {
    FFAppState().invoiceNumber =
    AddOrderCall.invoiceNo(
      (apiResponse.jsonBody),
    )!;

    print('Invoice Number: ${FFAppState().invoiceNumber}');
    print('data data: ${AddOrderCall.getData(apiResponse.jsonBody)}');
    print('DataBody: ${AddOrderCall.DataBody(apiResponse.jsonBody)}');
    print('Cart Amount: ${FFAppState().cartAmount}');
    print('Final Amount: ${FFAppState().finalAmount}');
    //setState(() {});
    if (AddOrderCall.getData(
        apiResponse.jsonBody) ==
        ""  && widget.totalAmount! > 500000 )
      Navigator.of(context).push(
        PageTransition(
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 300),
          child: PaymentBankInfoWidget(),
        ),
      );
    /* context.pushNamed(
                                      'PaymentBankInfoWidget',

                                    );*/
    // Navigate to the next page and pass the invoiceNumber
    if (widget.totalAmount == 0.0) {

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const PaymentSuccessfulWidget(),
        ),
      );


    }
  }
}
  void showAlertDialog(BuildContext context, String title, String message){
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed:  () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Extracting details from the response
    String razorpayOrderId = response.orderId!;
    String razorpayPaymentId = response.paymentId!;
    String razorpaySignature = response.signature!;

    // Assuming success based on receiving a valid payment ID and order ID
    String paymentStatus = 'success';

    // Print the details for debugging
    print('Invoice Number: ${FFAppState().invoiceNumber}');
    print('Cart Amount: ${FFAppState().finalAmount}');
    print('Razorpay Order ID: $razorpayOrderId');
    print('Razorpay Payment ID: $razorpayPaymentId');
    print('Razorpay Signature: $razorpaySignature');
    print('Payment Status: $paymentStatus');

    // Log the request body before making the API call
    var requestBody = {
      'invoiceNumber': FFAppState().invoiceNumber,
      'amount': FFAppState().finalAmount.toInt(),
      'razorpay_order_id': razorpayOrderId,
      'razorpay_payment_id': razorpayPaymentId,
      'razorpay_signature': razorpaySignature,
      'paymentStatus': paymentStatus
    };
    print('Request Body: ${jsonEncode(requestBody)}');


      // Call the OrderPaymentStatusCall API
      ApiCallResponse apiResponse = await OrderPaymentStatusCall.call(
        hosturl: FFAppConstants.hosturl,
        token: currentAuthenticationToken,
        invoiceNumber: FFAppState().invoiceNumber,
        amount: FFAppState().finalAmount.toInt(),
        razorpayOrderId: razorpayOrderId,
        razorpayPaymentId: razorpayPaymentId,
        razorpaySignature: razorpaySignature,
        paymentStatus: paymentStatus,
      );

      // Print the API response for debugging
      print('OrderPaymentStatusCall API Response:');
      print('Response Body: ${apiResponse.jsonBody}');
      print('Response Headers: ${apiResponse.headers}');
      print('Status Code: ${apiResponse.statusCode}');
      print('razorpayOrderId: ${apiResponse.statusCode}');

      // Handle the API response if needed
    //if (razorpayOrderId.isNotEmpty && paymentStatus.isNotEmpty && razorpayPaymentId.isNotEmpty)
      //if (apiResponse != null && apiResponse.statusCode == 200) {
      if (apiResponse.statusCode == 200) {
        print('payment succesfull');
        // API call was successful, navigate to the success page

    Navigator.of(context).push(
    MaterialPageRoute(
    builder: (context) => const PaymentSuccessfulWidget(),
    ),
    );
      /*  context.pushNamed(
          'Homepage',
          extra: <String, dynamic>{
            kTransitionInfoKey: TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 0),
            ),
          },
        );*/
       /* Navigator.pushAndRemoveUntil(
            context,       MaterialPageRoute(
            builder: (context) => HomepageWidget()
        ),
            ModalRoute.withName("/Homepage")
        );*/
       /* Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) =>
            HomepageWidget()
              ));*/
       /* Navigator.pushAndRemoveUntil<dynamic>(
          context,        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => PaymentSuccessfulWidget(),
        ),
              (route) => false,//if you want to disable back feature set to false
        );*/
        /*Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>  HomepageWidget(),
          ),
        );*/
      } else {
        // Handle API call failure
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to update payment status. Status Code: ${apiResponse.statusCode}"),
          backgroundColor:
          FlutterFlowTheme.of(context)
              .primary,
        ));
      }

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment error
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Payment failed please try again!"),
      backgroundColor:
      FlutterFlowTheme.of(context)
          .primary,
    ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("External wallet selected: ${response.walletName}"),
      backgroundColor:
      FlutterFlowTheme.of(context)
          .primary,
    ));
  }

  void _openCheckout() async {
    String keyId;
    String secretKey;
    String currency = FFAppState().currencyName!;

    // Determine keyId and secretKey based on currency or any other criteria
    if (currency == 'INR') {
      keyId = 'rzp_test_vaSJsZ7qj0XwOL';
      secretKey = '9JfcXfNgiC0jsqc28DBunyoS';
      paymentmode=2;
    } else if(currency == 'EURO'){
      keyId = 'rzp_test_Ddp0GJ4U5Ifby3';
      secretKey = 'NmE9Vs1UwylM7CwWVnht6S2H';
      paymentmode=3;
      currency = 'EUR';
    } else{
      keyId = 'rzp_test_Ddp0GJ4U5Ifby3';
      secretKey = 'NmE9Vs1UwylM7CwWVnht6S2H';
      paymentmode=3;
    }

    var amountInPaise = ((FFAppState().finalAmount) * 100).toInt();
    var orderOptions = {
      'amount': amountInPaise,
      'currency': currency,
      'receipt': 'receipt#1',
      'payment_capture': 1,
    };

    var client = http.Client();
    try {
      var response = await client.post(
        Uri.parse('https://api.razorpay.com/v1/orders'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Basic ${base64Encode(utf8.encode('$keyId:$secretKey'))}'
        },
        body: jsonEncode(orderOptions),
      );

      print('Order creation response: ${response.body}');

      var orderData = jsonDecode(response.body);
      if (response.statusCode == 200 && orderData['id'] != null) {
        var options = {
          'key': keyId,
          'amount': orderData['amount'],
          'currency': orderData['currency'],
          'name': 'Rudraksha-Ratna',
          'description': 'Payment for order',
          'order_id': orderData['id'],
          'prefill': {
            'contact': '8888888888',
            'email': 'test@razorpay.com',
          },
          'external': {
            'wallets': ['paytm']
          }
        };

        try {
          print('Opening Razorpay checkout with options: $options');
          _razorpay.open(options);
        } catch (e) {
          debugPrint(e.toString());
        }
      } else {
        print('Error in order creation: ${response.body}');
      }
    } catch (e) {
      print('Error creating order: $e');
    } finally {
      client.close();
    }
  }

  void _showPayPalSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Unfortunately, PayPal is not an available option."),
    ));
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          if (!_isLoading)
          Scaffold(
            //key: scaffoldKeyy,
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
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
                    'Select Payment method',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      color: Color(0xFF272728),
                      fontSize: 16,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  actions: [],
                  centerTitle: true,
                  elevation: 0,
                ),
              ),
            ),
            body: SafeArea(
              top: true,
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFE7E7E8),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24, 16, 24, 16),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Select payment method',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF272728),
                                          fontSize: 16,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 10),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              FlutterFlowRadioButton(
                                                options: [
                                                  '    Razorpay',
                                                  '    Paypal'
                                                ].toList(),
                                                onChanged: (val) async {
                                                  setState(() {
                                                    _model.isSelected = val ==
                                                        '    Razorpay';
                                                    _isButtonEnabled = _model.isSelected;
                                                    if (val == '    Paypal') {
                                                      _showPayPalSnackbar();
                                                    }
                                                  });
                                                },
                                                controller: _model
                                                    .radioButtonValueController ??=
                                                    FormFieldController<String>(
                                                        null),
                                                optionHeight: 42,
                                                textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                  fontFamily:
                                                  'Montserrat',
                                                  color:
                                                  Color(0xFF272728),
                                                  fontSize: 16,
                                                  letterSpacing: 0,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                                buttonPosition:
                                                RadioButtonPosition.left,
                                                direction: Axis.vertical,
                                                radioButtonColor:
                                                Color(0xFF740074),
                                                inactiveRadioButtonColor:
                                                Color(0xFF3E3E40),
                                                toggleable: false,
                                                horizontalAlignment:
                                                WrapAlignment.start,
                                                verticalAlignment:
                                                WrapCrossAlignment.start,
                                              ),
                                              Column(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8),
                                                    child: Image.asset(
                                                      'assets/images/Group.png',
                                                      width: 79,
                                                      height: 17,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8),
                                                    child: Image.asset(
                                                      'assets/images/paypal_1.png',
                                                      width: 64,
                                                      height: 20,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ].divide(SizedBox(height: 25)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 1,
                            decoration: BoxDecoration(
                              color: Color(0xFFE7E7E8),
                              border: Border.all(
                                color: Color(0xFFE7E7E8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFFE7E7E8),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                            child: FFButtonWidget(
                              onPressed: !_isButtonEnabled ? null
                                  : () async {
                                print('RazorPay amount: ${FFAppState().cartAmount}');
                                print('Currency Type: ${FFAppState().currencyName}');
                                print('FFAppState().products ${FFAppState().products}');
                                print('widget.productlist ${jsonEncode(widget.productlist)}');
                                _openCheckout();
                                 /* context.pushNamed(
              'Homepage',
              extra: <String, dynamic>{
                kTransitionInfoKey: TransitionInfo(
                  hasTransition: true,
                  transitionType: PageTransitionType.fade,
                  duration: Duration(milliseconds: 0),
                ),
              },
            );*/

                              },
                              text: 'Confirm & Pay',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 48,
                                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: _isButtonEnabled ? Color(0xFF740074) : Color(0xFFF3F3F3),
                                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Montserrat',
                                  color: _isButtonEnabled ? Colors.white : Color(0xFFB7B7B8),
                                  letterSpacing: 0,
                                ),
                                elevation: 0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                disabledColor: Color(0xFFF3F3F3),
                                disabledTextColor: Color(0xFFB7B7B8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            bottomNavigationBar: const CustomNavBarWidget(),
          ),
          if (_isLoading)
            Scaffold(
              body: Center(
                 child: SizedBox(
                   width: 50,
                   height: 50,
                   child: CircularProgressIndicator(
                     valueColor: AlwaysStoppedAnimation<Color>(
                       FlutterFlowTheme.of(context).primary,
                     ),
                   ),
                 ),
               ),
            )
        ],
      ),
    );
  }
}
