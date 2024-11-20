import 'dart:convert';
import 'package:flutter_svg/svg.dart';
import '../auth/custom_auth/auth_util.dart';
import '../components/delete_dialog.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';
export 'cart_model.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  late CartModel _model;
  final CartWidgetscaffoldKeys = GlobalKey<ScaffoldState>();
  dynamic cartData;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CartModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _fetchCartData() async {
    _model.apiResultiltCopy = await CartCall.call(
        hosturl: FFAppConstants.hosturl,
        token: currentAuthenticationToken
    );
    setState(() {
      cartData = _model.apiResultiltCopy?.jsonBody;
      FFAppState().updatedCartTotal = getJsonField(cartData, r'''$.cart_total''');
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    // Check authentication token
    if (currentAuthenticationToken == null || currentAuthenticationToken!.isEmpty) {
      // Navigate to login page or show login prompt
      Navigator.of(context).pushNamed('/loginPage');
      return Container();
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: CartWidgetscaffoldKeys,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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

                  /*context.pushNamed(
                    'Homepage',
                    extra: <String, dynamic>{
                      kTransitionInfoKey: TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 400),
                      ),
                    },
                  );*/
                },
              ),
              title: Text(
                'Shopping cart',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: FlutterFlowTheme.of(context).primaryText,
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
        body: FutureBuilder<ApiCallResponse>(
          future: CartCall.call(
            hosturl: FFAppConstants.hosturl,
            token: currentAuthenticationToken
          ),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(FlutterFlowTheme.of(context).primary,),
                  ),
                ),
              );
            }
            final stackCartResponse = snapshot.data!;
            final cartData = getJsonField(stackCartResponse.jsonBody, r'''$.data''');
            print("cartData :${cartData}");

            // Check if cartData is a List
            final cartList = cartData is List ? cartData : [];

            if (cartList.isEmpty) {
              // Display image when cart is empty
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Your cart is empty',
                        style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Montserrat',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 24,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 31,),
                      Padding(padding: EdgeInsetsDirectional.fromSTEB(108, 0, 108, 0),
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
                            borderSide: BorderSide(color: Colors.transparent,),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Render cart items when cart is not empty
            return Stack(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height,
                  decoration: BoxDecoration(),
                  child: Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 130),
                    child: Builder(builder: (context) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(cartList.length, (cartListIndex) {
                            final cartListItem = cartList[cartListIndex];
                            return Container(
                              width: MediaQuery.of(context).size.width,

                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                border: Border.all(color: Color(0xFFE7E7E8),),
                              ),
                              child: Padding(padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.network(
                                              getJsonField(cartListItem, r'''$.thumbnail_image''',).toString(),
                                              width: MediaQuery.of(context).size.width * 0.25,
                                              height: 115,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          //SizedBox(height: MediaQuery.of(context).size.height * 0.18)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: 230,
                                                          decoration: BoxDecoration(),
                                                          child: Align(alignment: AlignmentDirectional(-1, -1),
                                                            child: Text(getJsonField(cartListItem, r'''$.product_name''',).toString(),
                                                              maxLines: 2,
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                fontFamily: 'Montserrat',
                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                fontSize: 16,
                                                                letterSpacing: 0,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: AlignmentDirectional(0.898, -1.1),
                                                          child: GestureDetector(
                                                            onTap: () async {
                                                              setState(() {});
                                                              await showModalBottomSheet(
                                                                isScrollControlled: true,
                                                                backgroundColor: Colors.transparent,
                                                                enableDrag: false,
                                                                context: context,
                                                                builder: (context) {
                                                                  return GestureDetector(
                                                                    onTap: () => _model.unfocusNode.canRequestFocus
                                                                        ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                                        : FocusScope.of(context).unfocus(),
                                                                    child: Padding(
                                                                      padding: MediaQuery.viewInsetsOf(context),
                                                                      //child: const DeleteWishlistWidget(),
                                                                      child: DeleteItemDialog(
                                                                        deletionId: FFAppState().wishlistItemId.toString(),
                                                                        title: 'Are you sure you want to remove the product from the cart?',
                                                                        deleteButtonText: 'Delete',
                                                                        deleteApiCall: (id) async {
                                                                          return await RemovefromCartlistCall.call(
                                                                            token: currentAuthenticationToken,
                                                                            hosturl: FFAppConstants.hosturl,
                                                                            cartId: getJsonField(cartListItem, r'''$.cart_id'''),
                                                                          );
                                                                        },
                                                                        successMessageField: r'''$.msg''',
                                                                        errorMessageField: r'''$.status''',
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) => safeSetState(() {}));
                                                            },
                                                            child: SvgPicture.asset(
                                                              'assets/images/bin_1.svg',
                                                              width: 20,
                                                              height: 20,
                                                            ),
                                                          ),
                                                        )
                                                        /*Align(
                                                          alignment: AlignmentDirectional(0.9, -1.07),
                                                          child: InkWell(
                                                            splashColor: Colors.transparent,
                                                            focusColor: Colors.transparent,
                                                            hoverColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () async {
                                                              var _shouldSetState = false;
                                                              _model.apiResult5ep = await RemovefromCartlistCall.call(
                                                                token: currentAuthenticationToken,
                                                                hosturl: FFAppConstants.hosturl,
                                                                cartId: getJsonField(cartListItem, r'''$.cart_id''',),
                                                              );
                                                              _shouldSetState = true;
                                                              if ((_model.apiResult5ep?.succeeded ?? true)) {
                                                                FFAppState().statusFailed = getJsonField(cartListItem, r'''$.status''',).toString();
                                                                setState(() {});
                                                                ScaffoldMessenger.of(context).clearSnackBars();
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                  SnackBar(content:
                                                                  Text(getJsonField((_model.apiResult5ep?.jsonBody ?? ''), r'''$.msg''',).toString(),
                                                                    style: TextStyle(
                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 16,
                                                                    ),

                                                                  ),
                                                                    duration: Duration(milliseconds: 4000),
                                                                    backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                    //backgroundColor: FFAppState().statusFailed == 'success' ? Color(0xFF4BB543) : Color(0xFFFC100D),
                                                                  ),
                                                                );
                                                                if (FFAppState().statusFailed == 'success') {
                                                                  context.pushNamed(
                                                                    'Cart',
                                                                    extra: <String, dynamic>{
                                                                      kTransitionInfoKey: TransitionInfo(
                                                                        hasTransition: true,
                                                                        transitionType: PageTransitionType.fade,
                                                                        duration: Duration(milliseconds: 0),
                                                                      ),
                                                                    },
                                                                  );
                                                                } else {
                                                                  if (_shouldSetState) setState(() {});
                                                                  return;
                                                                }
                                                              } else {
                                                                if (_shouldSetState) setState(() {});
                                                                return;
                                                              }

                                                              if (_shouldSetState)
                                                                setState(() {});
                                                            },
                                                            child: SvgPicture.asset(
                                                              'assets/images/bin_1.svg',
                                                              width: 20,
                                                              height: 20,
                                                            ),
                                                          ),
                                                        ),*/
                                                      ],
                                                    ),
                                                  ),

                                                  if(getJsonField(cartListItem, r'''$.selling_price''',).toString()!="null" && getJsonField(cartListItem, r'''$.selling_price''',).toString()!="" )
                                                    Container(
                                                      width:260,
                                                      child: RichText(
                                                        textScaler: MediaQuery.of(context).textScaler,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: 'Base Price: ',
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                fontFamily: 'Montserrat',
                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                letterSpacing: 0,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),

                                                            TextSpan(
                                                              text: "${valueOrDefault<String>(FFAppState().currencyName, 'INR',
                                                              )} ${formatNumber(functions.currencyConversion(FFAppState().currencyRate,
                                                                  getJsonField(cartListItem, r'''$.selling_price''',).toString()),
                                                                formatType: FormatType.decimal,
                                                                decimalType: DecimalType.automatic,
                                                              )}",

                                                              style: const TextStyle(
                                                                color: Color(0xFF696969),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14,
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
                                                  if(getJsonField(cartListItem, r'''$.design_type''',).toString()!="")
                                                    RichText(
                                                      textScaler: MediaQuery.of(context).textScaler,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: 'Design Type: ',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Montserrat',
                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                              letterSpacing: 0,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: getJsonField(cartListItem, r'''$.design_type''',).toString(),
                                                            style: const TextStyle(
                                                              color: Color(0xFF696969),
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 14,
                                                            ),
                                                          )
                                                        ],
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Montserrat',
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                    ),

                                                  if(getJsonField(cartListItem, r'''$.variant_name''',).toString()!="null" || getJsonField(cartListItem, r'''$.variant_status''',).toString()==false)
                                                    Container(
                                                      width:240,
                                                      child: RichText(
                                                        textScaler: MediaQuery.of(context).textScaler,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: 'Variant: ',
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                fontFamily: 'Montserrat',
                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                letterSpacing: 0,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                              utf8.decode(getJsonField(cartListItem, r'''$.variant_name''').toString().codeUnits),
                                                              //text: getJsonField(cartListItem, r'''$.variant_name''',).toString(),
                                                              style: const TextStyle(
                                                                color: Color(0xFF696969),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14,
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

                                                  if(getJsonField(cartListItem, r'''$.design_name''',).toString()!="null" && getJsonField(cartListItem, r'''$.design_name''',).toString()!="" )
                                                    Container(
                                                      width:260,
                                                      child: RichText(
                                                        textScaler: MediaQuery.of(context).textScaler,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: 'Design: ',
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                fontFamily: 'Montserrat',
                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                letterSpacing: 0,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: getJsonField(cartListItem, r'''$.design_name''',).toString(),
                                                              style: const TextStyle(
                                                                color: Color(0xFF696969),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: "-",
                                                              style: const TextStyle(
                                                                color: Color(0xFF696969),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14,
                                                              ),
                                                            ),

                                                            TextSpan(
                                                              text: "${valueOrDefault<String>(FFAppState().currencyName, 'INR',
                                                              )} ${formatNumber(functions.currencyConversion(FFAppState().currencyRate,
                                                                  getJsonField(cartListItem, r'''$.design_price''',).toString()),
                                                                formatType: FormatType.decimal,
                                                                decimalType: DecimalType.automatic,
                                                              )}",

                                                              style: const TextStyle(
                                                                color: Color(0xFF696969),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14,
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

                                                  if(getJsonField(cartListItem, r'''$.wrist_size''',).toString() != "" && getJsonField(cartListItem, r'''$.wrist_size''',).toString() != "null")
                                                    Container(
                                                      width:240,
                                                      child: RichText(
                                                        textScaler: MediaQuery.of(context).textScaler,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: 'Upper Arm / Wrist Size: ',
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                fontFamily: 'Montserrat',
                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                letterSpacing: 0,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: '${getJsonField(cartListItem, r'''$.wrist_size''').toString().replaceAll('inches', '').trim()}"',
                                                              style: const TextStyle(
                                                                color: Color(0xFF696969),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14,
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

                                                  if(getJsonField(cartListItem, r'''$.ring_size_system''',).toString() != "" && getJsonField(cartListItem, r'''$.ring_size_system''',).toString() != 'null')
                                                    Container(
                                                      width:240,
                                                      child: RichText(
                                                        textScaler: MediaQuery.of(context).textScaler,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: 'Ring Size System: ',
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                fontFamily: 'Montserrat',
                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                letterSpacing: 0,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: getJsonField(cartListItem, r'''$.ring_size_system''').toString().replaceAll(' Ring Size System', '-system'),
                                                              style: const TextStyle(
                                                                color: Color(0xFF696969),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14,
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

                                                  if(getJsonField(cartListItem, r'''$.ring_size''',).toString() != "" && getJsonField(cartListItem, r'''$.ring_size''',).toString() != "null")
                                                    Container(
                                                      width:240,
                                                      child: RichText(
                                                        textScaler: MediaQuery.of(context).textScaler,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: 'Ring Size: ',
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                fontFamily: 'Montserrat',
                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                letterSpacing: 0,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: getJsonField(cartListItem, r'''$.ring_size''',).toString(),
                                                              style: const TextStyle(
                                                                color: Color(0xFF696969),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14,
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

                                                  if(getJsonField(cartListItem, r'''$.certification_name''',).toString()!="")
                                                    Container(
                                                      width: 260,
                                                      child: RichText(
                                                        textScaler: MediaQuery.of(context).textScaler,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(text: 'Certification: ',
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                fontFamily: 'Montserrat',
                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                letterSpacing: 0,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: getJsonField(cartListItem, r'''$.certification_name''',).toString(),
                                                              style: const TextStyle(
                                                                color: Color(0xFF696969),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: "-",
                                                              style: const TextStyle(
                                                                color: Color(0xFF696969),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: "${valueOrDefault<String>(FFAppState().currencyName, 'INR',
                                                              )} ${formatNumber(functions.currencyConversion(FFAppState().currencyRate,
                                                                  getJsonField(cartListItem, r'''$.certification_price''',).toString()),
                                                                formatType: FormatType.decimal,
                                                                decimalType: DecimalType.automatic,
                                                              )}",

                                                              style: const TextStyle(
                                                                color: Color(0xFF696969),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14,
                                                              ),
                                                            )
                                                           /* TextSpan(
                                                              text: "-(${getJsonField(cartListItem, r'''$.certification_price''',).toString()})",
                                                              style: const TextStyle(
                                                                color: Color(0xFF696969),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14,
                                                              ),
                                                            )*/
                                                          ],
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Montserrat',
                                                            letterSpacing: 0,
                                                          ),
                                                        ),
                                                      ),
                                                    ), if(getJsonField(cartListItem, r'''$.energization_name''',).toString()!="" && (getJsonField(cartListItem, r'''$.mainprodtype''',).toString()=="3" ||getJsonField(cartListItem, r'''$.mainprodtype''',).toString()=="4" ))
                                                    Container(
                                                      width: 260,
                                                      child: RichText(
                                                        textScaler: MediaQuery.of(context).textScaler,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(text: 'Energization: ',
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                fontFamily: 'Montserrat',
                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                letterSpacing: 0,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: getJsonField(cartListItem, r'''$.energization_name''',).toString(),
                                                              style: const TextStyle(
                                                                color: Color(0xFF696969),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: "-",
                                                              style: const TextStyle(
                                                                color: Color(0xFF696969),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14,
                                                              ),
                                                            ),TextSpan(
                                                              text: "${valueOrDefault<String>(FFAppState().currencyName, 'INR',
                                                              )} ${formatNumber(functions.currencyConversion(FFAppState().currencyRate,
                                                                  getJsonField(cartListItem, r'''$.energization_price''',).toString()),
                                                                formatType: FormatType.decimal,
                                                                decimalType: DecimalType.automatic,
                                                              )}",

                                                              style: const TextStyle(
                                                                color: Color(0xFF696969),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14,
                                                              ),
                                                            )
                                                          /*  TextSpan(
                                                              text: "-(${getJsonField(cartListItem, r'''$.energization_price''',).toString()})",
                                                              style: const TextStyle(
                                                                color: Color(0xFF696969),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14,
                                                              ),
                                                            )*/
                                                          ],
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Montserrat',
                                                            letterSpacing: 0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 139,
                                                        decoration: BoxDecoration(),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 38, 0),
                                                          child: Align(alignment: AlignmentDirectional(-1, 0),
                                                            child: Text(
                                                              '${valueOrDefault<String>(FFAppState().currencyName, 'INR',)} '
                                                                '${formatNumber(functions.currencyConversion(FFAppState().currencyRate, getJsonField(cartListItem, r'''$.productsubtotal''',).toString()),
                                                              formatType: FormatType.decimal,
                                                              decimalType: DecimalType.automatic,
                                                            )}',
                                                              textAlign: TextAlign.start,
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                fontFamily: 'Montserrat',
                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                fontSize: 18,
                                                                letterSpacing: 0,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      FFButtonWidget(
                                                        onPressed: () async {
                                                          setState(() {
                                                            final currentQuantity = getJsonField(
                                                              cartListItem,
                                                              r'''$.quantity''',
                                                            );
                                                            if (currentQuantity > 1) {
                                                              updateCartQuantity(context,cartListItem, currentQuantity - 1);
                                                            }
                                                          });
                                                        },
                                                        text: '-',
                                                        options: FFButtonOptions(
                                                          width: 35,
                                                          height: 35,
                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                          elevation: 0,
                                                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                            fontFamily: 'Montserrat',
                                                            color: getJsonField(cartListItem, r'''$.quantity''') > 1
                                                                ? FlutterFlowTheme.of(context).primaryText
                                                                : Colors.grey, // Set color to grey if quantity is 1
                                                            fontSize: 25,
                                                            letterSpacing: 0,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                          borderSide: BorderSide(
                                                            color: Color(0xFFE7E7E8),
                                                            width: 1,
                                                          ),
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsetsDirectional.fromSTEB(3, 0, 3, 0),
                                                        child: Container(
                                                          width: 35,
                                                          height: 35,
                                                          decoration: BoxDecoration(),
                                                          alignment: AlignmentDirectional(0, 0),
                                                          child: Text(
                                                            getJsonField(cartListItem, r'''$.quantity''').toString(),
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Montserrat',
                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            setState(() {
                                                              final currentQuantity = getJsonField(
                                                                cartListItem,
                                                                r'''$.quantity''',
                                                              );
                                                              updateCartQuantity(context, cartListItem, currentQuantity + 1);
                                                            });
                                                          },
                                                          text: '+',
                                                          options: FFButtonOptions(
                                                            width: 40,
                                                            height: 40,
                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                            elevation: 0,
                                                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                              fontFamily: 'Montserrat',
                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                              fontSize: 25,
                                                              letterSpacing: 0,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                            borderSide: BorderSide(
                                                              color: Color(0xFFE7E7E8),
                                                              width: 1,
                                                            ),
                                                            borderRadius: BorderRadius.circular(10),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ].divide(const SizedBox(height: 13)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).divide(const SizedBox(height: 0)).addToStart(const SizedBox(height: 0)),
                        ),
                      );
                    },
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 68,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          border: Border.all(color: Color(0xFFE7E7E8),),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(24, 8, 24, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(textScaler: MediaQuery.of(context).textScaler,
                                text: TextSpan(
                                  children: [
                                    TextSpan(text: 'Cart Total',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        fontSize: 16,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(text: ' (Inc all taxes)',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Text(
                                  '${valueOrDefault<String>(FFAppState().currencyName, 'INR',
                                  )} ${formatNumber(functions.currencyConversion(FFAppState().currencyRate,
                                      getJsonField(stackCartResponse.jsonBody, r'''$.cart_total''',).toString()),
                                    formatType: FormatType.decimal,
                                    decimalType: DecimalType.automatic,
                                  )}',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    fontSize: 18,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          border: Border.all(color: Color(0xFFE7E7E8),),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                          child: FFButtonWidget(
                            onPressed: () async {
                              print('Selected Pendent for preselected: ${FFAppState().selectedSizeSystem}');
                              print('Selected Pendent for preselected: ${FFAppState().selectedSize}');
                              print('Selected Pendent for preselected: ${FFAppState().selectedRingSize}');
                              FFAppState().buynow = false;


                              FFAppState().cartTotal = getJsonField(
                                stackCartResponse.jsonBody,
                                r'''$.cart_total''',
                              ).toInt();
                              FFAppState().orderTotal = getJsonField(
                                stackCartResponse.jsonBody,
                                r'''$.total_reward_price''',
                              ).toInt();
                              FFAppState().courierTotal = getJsonField(
                                stackCartResponse.jsonBody,
                                r'''$.courier_total''',
                              ).toInt();
                              setState(() {});
                              /*context.pushNamed(
                                'DeliveryAddress',
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.bottomToTop,
                                    duration: Duration(milliseconds: 400),
                                  ),
                                },
                              );*/
                              context.pushNamed(
                                'DeliveryAddress',
                                queryParameters: {
                                  'fromScreen': serializeParam('Cart', ParamType.String),
                                }.withoutNulls,
                              );
                            },
                            text: 'Proceed to Select address',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 48,
                              padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                letterSpacing: 0,
                              ),
                              elevation: 0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                  ],
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: const CustomNavBarWidget(),
      ),
    );
  }
  Future<void> updateCartQuantity(BuildContext context, dynamic cartListItem, int newQuantity) async {
    final cartId = getJsonField(cartListItem, r'''$.cart_id''').toString();

    final response = await UpdateCartCall.call(
      token: currentAuthenticationToken,
      hosturl: FFAppConstants.hosturl,
      cartId: cartId,
      quantity: newQuantity,
    );

    // Extract status and message from response using getJsonField
    final status = getJsonField(response?.jsonBody, r'''$.status''').toString();
    final msg = getJsonField(response?.jsonBody, r'''$.msg''').toString();

    if (status == 'failed' && msg.isNotEmpty) {
      // Show snackbar with the API response message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          duration: Duration(seconds: 3),
          backgroundColor: FlutterFlowTheme.of(context).primary
        ),
      );
    } else {
      // Refresh cart data and update total
      _fetchCartData();
    }
  }
}